export const name: string = "Gustavo";
export const id: number = 1;
export const age: number = 33;
export const isStudent: boolean = false;

export const message: string = `
    Esto es un template string
    puede usar ' simples
    tener expresiones ${1 + 1}
    inyectar variables ${name}
`;

console.log(message);
