function runTalespin() {
    const outputElement = document.getElementById("output");
    outputElement.textContent = '';  // Clear previous output

    const session = pl.create(1000);

    const query = `consult('tales.pl'), init(Tale).`;
    session.query(query);

    session.answer(result => {
        let tale = result.lookup('Tale');
        outputElement.textContent += tale + '\n';
    });
}
