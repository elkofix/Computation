import { student } from './classes/classes'
import './style.css'
// type.basic.ts
// document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
//   <h1>Hola mundo, mi nombre es ${name},
//   mi indentificación es ${id} 
//   y mi edad es ${age}</h1>
// `
//objects.ts
// document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
//   <h1>Hola mundo ${students}</h1>
// `

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <h1>Hola mundo ${student.name}</h1>
`