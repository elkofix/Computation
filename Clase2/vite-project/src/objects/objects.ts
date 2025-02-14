export const studentIds:number[]= [1,23,14,54];
studentIds.push(+"5");

interface Student {
    id: number;
    name: string;
    age: number;
}

export const gustavo: Student = {
    id: 1,
    name: "Alejo",
    age: 20,
}

export const alejo: Student = {
    id: 3,
    name: "AlejoLon",
    age: 20,
}

export const richie: Student = {
    id: 2,
    name: "Kevin",
    age: 20,
}


export const students:Student[] = [gustavo, richie, alejo];
console.log("🚀 ~ students:", students)

