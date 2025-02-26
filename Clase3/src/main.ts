import "./style.css";
//import { studentsIds, students } from "./objects/objects";
// import { name, age, id,  } from "./types-basic/type-basics";
import { gustavo } from "./classes/classes";
//import { gustavo } from "./classes/classes-minify";

//type-basics.ts
// document.querySelector<HTMLDivElement>("#app")!.innerHTML = `
//   <div>
//     <h1>Hello ${name}
//       ${age} ${id}
//       </h1>
//   </div>
// `;

//objects.ts
// document.querySelector<HTMLDivElement>("#app")!.innerHTML = `
//     <h1>Hello ${students}</h1> //object Object es la representacion de un objeto en string
// `;

document.querySelector<HTMLDivElement>("#app")!.innerHTML = `
    <h1>Hello ${gustavo.name}</h1>
`;
