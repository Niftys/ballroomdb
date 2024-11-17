document.addEventListener("DOMContentLoaded", function () {
    populateCompetitionSelect();
    
    // Apply autocomplete to each input field
    autocomplete(document.getElementById("competitorNameInput"), "fetchCompetitors.php");
    autocomplete(document.getElementById("styleInput"), "fetchStyles.php");
    autocomplete(document.getElementById("judgeNameInput"), "fetchJudges.php");

    // Select All button functionality
    document.getElementById("selectAllButton").addEventListener("click", function() {
        const competitionSelect = document.getElementById("competitionSelect");
        for (let i = 0; i < competitionSelect.options.length; i++) {
            competitionSelect.options[i].selected = true;
        }
    });

    // Add Enter key search functionality and close dropdown for each search input field
    ["competitorNameInput", "styleInput", "scoreInput", "judgeNameInput"].forEach(inputId => {
        const inputElement = document.getElementById(inputId);
        inputElement.addEventListener("keydown", function (e) {
            if (e.keyCode === 13) {  // Enter key
                e.preventDefault(); // Prevent default Enter key behavior
                closeAllLists();    // Close the dropdown
                searchDatabase();    // Trigger search
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function () {
        // Function to toggle dark mode
        function toggleDarkMode() {
            // Toggle the 'dark-mode' class on the body
            document.body.classList.toggle('dark-mode');

            // Save the current theme to localStorage
            if (document.body.classList.contains('dark-mode')) {
                localStorage.setItem('theme', 'dark');
            } else {
                localStorage.setItem('theme', 'light');
            }
        }

        // Set up event listener on the dark mode toggle switch
        const darkModeToggle = document.getElementById('darkModeToggle');
        darkModeToggle.addEventListener('change', toggleDarkMode);

        // Check localStorage for a saved theme on page load
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            document.body.classList.add('dark-mode');
            darkModeToggle.checked = true; // Ensure the toggle switch is in the "on" state
        }
    });
});

function populateCompetitionSelect() {
    const competitionSelect = document.getElementById("competitionSelect");
    fetch("fetchCompetitions.php")
        .then(response => response.json())
        .then(competitions => {
            competitions.forEach(comp => {
                const option = document.createElement("option");
                option.value = comp.name;
                option.textContent = comp.name;
                competitionSelect.appendChild(option);
            });
        })
        .catch(error => console.error("Error fetching competitions:", error));
}

function autocomplete(inputElement, apiUrl) {
    let currentFocus;
    inputElement.addEventListener("input", async function () {
        const query = this.value.trim();
        closeAllLists();
        if (!query) return false;
        currentFocus = -1;

        const listContainer = document.createElement("DIV");
        listContainer.setAttribute("id", this.id + "autocomplete-list");
        listContainer.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(listContainer);

        try {
            const response = await fetch(`${apiUrl}?query=${encodeURIComponent(query)}`);
            const data = await response.json();
            data.forEach(item => {
                const itemElement = document.createElement("DIV");
                itemElement.innerHTML = `<strong>${item.substr(0, query.length)}</strong>${item.substr(query.length)}`;
                itemElement.innerHTML += `<input type='hidden' value='${item}'>`;
                itemElement.addEventListener("click", function () {
                    inputElement.value = this.getElementsByTagName("input")[0].value;
                    closeAllLists();
                });
                listContainer.appendChild(itemElement);
            });
        } catch (error) {
            console.error(`Error fetching suggestions for ${inputElement.id}:`, error);
        }
    });

    inputElement.addEventListener("keydown", function (e) {
        const list = document.getElementById(this.id + "autocomplete-list");
        if (list) listItems = list.getElementsByTagName("div");
        if (e.keyCode === 40) { currentFocus++; addActive(listItems); }
        else if (e.keyCode === 38) { currentFocus--; addActive(listItems); }
        else if (e.keyCode === 13) { e.preventDefault(); if (currentFocus > -1) listItems[currentFocus].click(); }
    });

    function addActive(listItems) {
        if (!listItems) return false;
        removeActive(listItems);
        if (currentFocus >= listItems.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = listItems.length - 1;
        listItems[currentFocus].classList.add("autocomplete-active");
    }

    function removeActive(listItems) {
        for (let item of listItems) item.classList.remove("autocomplete-active");
    }

    function closeAllLists(elmnt) {
        const items = document.getElementsByClassName("autocomplete-items");
        for (let item of items) {
            if (elmnt !== item && elmnt !== inputElement) item.parentNode.removeChild(item);
        }
    }

    document.addEventListener("click", function (e) { closeAllLists(e.target); });
}

function searchDatabase() {
    const selectedCompetitions = Array.from(document.getElementById("competitionSelect").selectedOptions).map(option => option.value);
    const competitor = document.getElementById("competitorNameInput").value;
    const style = document.getElementById("styleInput").value;
    const score = document.getElementById("scoreInput").value;
    const judge = document.getElementById("judgeNameInput").value;

    const queryParams = new URLSearchParams({
        competitor,
        style,
        score,
        judge,
        competitions: selectedCompetitions.join(',')
    });

    fetch(`fetchData.php?${queryParams.toString()}`)
        .then(response => response.json())
        .then(data => renderTable(data))
        .catch(error => console.error("Error fetching data:", error));
}

function closeAllLists(elmnt) {
    const items = document.getElementsByClassName("autocomplete-items");
    for (let item of items) {
        if (elmnt !== item) {
            item.parentNode.removeChild(item);
        }
    }
}

function renderTable(data) {
    const resultsContainer = document.getElementById("results");
    resultsContainer.innerHTML = ""; // Clear previous results

    data.forEach(item => {
        const row = `<tr>
                        <td>${item.score}</td>
                        <td>${item.competitor}</td>
                        <td>${item.style}</td>
                        <td>${item.competition}</td>
                        <td>${item.judge}</td>
                     </tr>`;
        resultsContainer.innerHTML += row;
    });
}

function debounce(func, delay) {
    let timer;
    return function(...args) {
        clearTimeout(timer);
        timer = setTimeout(() => func.apply(this, args), delay);
    };
}
