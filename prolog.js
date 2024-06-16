const outputElement = document.getElementById("output");
outputElement.textContent = '';  // Clear previous output

const session = pl.create(1000);

const query = `consult('prolog_code.js'), init(Tale).`; 
//I moved prolog code to a js file for Github Pages to load it


session.query(query);

session.answer(result => {
    let tale = result.lookup('Tale');
    outputElement.textContent += tale + '\n';
});