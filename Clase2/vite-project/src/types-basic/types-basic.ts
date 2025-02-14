export let name: string = "alejo";
export const id:number = 1;
export const age:number = 33;
export const isValid:boolean = true;
export const message:string = `
Esto es un template string
puede usar ' simples
" dobles
tener expresiones ${1+1}
inyectar valores ${name}`;

console.log(message);