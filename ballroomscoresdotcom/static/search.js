let currentSortColumn = null;
let currentSortOrder = 'asc';
let isJudgeSearch = false; // Track if we're searching for a specific judge

// Listen for input to suggest competitors
input.addEventListener("input", suggestCompetitors);

document.addEventListener("DOMContentLoaded", async () => {
    const competitionSelect = document.getElementById("competitionSelect");
    const selectAllButton = document.getElementById("selectAllButton");

    try {
        // Fetch competitions
        const response = await fetch("fetchCompetitions.php");
        console.log("Response Status:", response.status);
        const competitions = await response.json();
        console.log("Competitions Data:", competitions);

        // Populate dropdown with competitions
        competitions.forEach(comp => {
            const option = document.createElement("option");
            option.value = comp.name;
            option.textContent = comp.name;
            competitionSelect.appendChild(option);
        });

        // "Select All" functionality
        selectAllButton.addEventListener("click", () => {
            for (let i = 0; i < competitionSelect.options.length; i++) {
                competitionSelect.options[i].selected = true;
            }
        });

    } catch (error) {
        console.error("Error fetching competitions:", error);
    }
});

// Function to get selected competition values
function getSelectedCompetitions() {
    const competitionSelect = document.getElementById("competitionSelect");
    const selectedValues = Array.from(competitionSelect.selectedOptions).map(option => option.value);
    return selectedValues;
}

// Use getSelectedCompetitions() in your searchDatabase function or wherever you need the selected values
async function searchDatabase() {
    const competitionSelect = document.getElementById('competitionSelect');
    const selectedCompetitions = Array.from(competitionSelect.selectedOptions).map(option => option.value); // Extract values
    const competitor = document.getElementById("competitorNameInput").value.trim();
    const style = document.getElementById("styleInput").value.trim();
    const judge = document.getElementById("judgeNameInput").value.trim();
    const placement = document.getElementById("scoreInput").value.trim();

    // Validation: Ensure at least one competition is selected
    if (selectedCompetitions.length === 0) {
        alert("Please select a competition.");
        return;
    }

    // Build query parameters
    const queryParams = new URLSearchParams({
        competitor,
        style,
        judge,
        score: placement,
    });

    // Append competitions as a comma-separated string
    queryParams.append('competition', selectedCompetitions.join(','));

    console.log("Query Parameters:", queryParams.toString()); // Debugging

    try {
        const response = await fetch(`fetchData.php?${queryParams.toString()}`);
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        let data = await response.json();

        // Sort the data if a column is selected for sorting
        if (currentSortColumn) {
            data = sortData(data, currentSortColumn, currentSortOrder);
        }

        renderTable(data);
    } catch (error) {
        console.error("Error fetching data:", error);

        // Display an error message in the results container
        const resultsContainer = document.getElementById("results");
        resultsContainer.innerHTML = `<p style="color: red;">Error occurred while fetching data: ${error.message}</p>`;
    }
}

function toggleSort(column) {
    if (currentSortColumn === column) {
        currentSortOrder = currentSortOrder === 'asc' ? 'desc' : 'asc';
    } else {
        currentSortColumn = column;
        currentSortOrder = 'asc';
    }

    // Call searchDatabase to fetch and sort the data
    searchDatabase();
}

function sortData(data, column, order) {
    return data.sort((a, b) => {
        const valueA = a[column];
        const valueB = b[column];
        
        if (order === 'asc') {
            return valueA > valueB ? 1 : valueA < valueB ? -1 : 0;
        } else {
            return valueA < valueB ? 1 : valueA > valueB ? -1 : 0;
        }
    });
}

function renderTable(data) {
    const resultsContainer = document.getElementById("results");
    const tableContainer = document.querySelector(".results-table-container");

    // Clear existing rows and headers
    tableContainer.innerHTML = ""; 

    // Create the table element and add class
    const table = document.createElement("table");
    table.classList.add("results-table");

    // Build the table header based on isJudgeSearch flag
    const thead = document.createElement("thead");
    thead.innerHTML = `
        <tr>
            <th onclick="toggleSort('placement')">Placement</th>
            <th onclick="toggleSort('person_name')">Competitor</th>
            <th onclick="toggleSort('style_name')">Style</th>
            <th onclick="toggleSort('comp_name')">Competition</th>
            ${isJudgeSearch ? '<th onclick="toggleSort(\'judge_score\')">Judge Score</th>' : ''}
        </tr>
    `;
    table.appendChild(thead);

    // Create a new tbody element and populate rows based on data
    const tbody = document.createElement("tbody");

    // Populate rows in the table body
    data.forEach((item, index) => {
        const row = document.createElement("tr");
        row.setAttribute("onclick", `toggleRow(${index}, ${item.people_id}, ${item.style_id}, ${item.comp_id})`);
        
        row.innerHTML = `
            <td>${isJudgeSearch ? item.judge_score : item.placement}</td>
            <td>${item.person_name}</td>
            <td>${item.style_name}</td>
            <td>${item.comp_name}</td>
            ${isJudgeSearch ? `<td>${item.judge_name}</td>` : ''}
        `;

        // Create a details row for judge ratings that will be shown when expanded
        const detailsRow = document.createElement("tr");
        detailsRow.id = `details-${index}`;
        detailsRow.classList.add("details-row");
        detailsRow.style.display = "none";
        tbody.appendChild(row);
        tbody.appendChild(detailsRow);
    });

    table.appendChild(tbody);
    tableContainer.appendChild(table);
}

async function toggleRow(index, people_id, style_id, comp_id) {
    const detailsRow = document.getElementById(`details-${index}`);
    const isExpanded = detailsRow.style.display === "table-row";
    
    // Toggle visibility using style.display
    detailsRow.style.display = isExpanded ? "none" : "table-row";
    
    if (!isExpanded) {
        try {
            const response = await fetch(`fetchJudgeRatings.php?people_id=${people_id}&style_id=${style_id}&comp_id=${comp_id}`);
            const judgeRatings = await response.json();
            
            const judgeNames = judgeRatings.map(rating => `<th>${rating.judge_name}</th>`).join('');
            const judgeScores = judgeRatings.map(rating => `<td>${rating.judge_score}</td>`).join('');
            
            detailsRow.innerHTML = `
                <td colspan="4" class="centered-details">
                    <div style="width: 100%;">
                        <table class="judge-ratings-table">
                            <thead>
                                <tr>${judgeNames}</tr>
                            </thead>
                            <tbody>
                                <tr>${judgeScores}</tr>
                            </tbody>
                        </table>
                    </div>
                </td>
            `;
        } catch (error) {
            detailsRow.innerHTML = `<td colspan="4"><p>Error loading ratings.</p></td>`;
            console.error("Error fetching judge ratings:", error);
        }
    }
}

// Sorting logic for table columns
function sortTable(column) {
    if (currentSortColumn === column) {
        currentSortOrder = currentSortOrder === 'asc' ? 'desc' : 'asc';
    } else {
        currentSortColumn = column;
        currentSortOrder = 'asc';
    }

    // Call searchDatabase to fetch and sort the data
    searchDatabase();
}

// Function to trigger search on Enter key press
function handleEnterKey(event) {
    if (event.key === "Enter") {
        searchDatabase();
    }
}

// Attach handleEnterKey and click event listeners to input fields and button
["competitorNameInput", "styleInput", "scoreInput", "judgeNameInput"].forEach(id => {
    document.getElementById(id).addEventListener("keydown", handleEnterKey);
});
document.getElementById("searchButton").addEventListener("click", searchDatabase);
