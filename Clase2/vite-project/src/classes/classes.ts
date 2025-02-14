import { gustavo } from "../objects/objects";

export class Student{
    id: number;
    name: string;
    age: number;
    // get getAge(): number{
    //     return this.age;
    // }
    // set setAge(setage: number){
    //     this.age = setage;
    // }
    constructor(id:number, name:string, age:number){
        this.id = id;
        this.name = name;
        this.age = age;
    }

    joinClass(){
        console.log(`The student ${this.name} now is in the clase`)
    }
}


export const student = new Student(1, "Alejandro", 20);


student.joinClass();