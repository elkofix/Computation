export const studentsIds: number[] = [1, 23, 14, 54];
studentsIds.push(+"Juan");

interface Student {
  id: number;
  name: string;
  age: number;
}

export const gustavo: Student = {
  id: 1,
  name: "Gustavo",
  age: 33,
};

export const juan: Student = {
  id: 2,
  name: "Juan",
  age: 23,
};

export const pedro: Student = {
  id: 3,
  name: "Pedro",
  age: 43,
};

export const students: Student[] = [gustavo, juan, pedro];

console.log("🚀 ~ students:", students);
