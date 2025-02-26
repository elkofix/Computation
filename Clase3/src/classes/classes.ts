import axios from "axios";

export class Student {
  id: number;
  name: string;
  age: number;
  private _isValid: boolean;

  get isValid(): boolean {
    return this._isValid;
  }

  set isValid(validation: boolean) {
    this._isValid = validation;
  }

  constructor(id: number, name: string, age: number) {
    //No mas de tres parametros. Caso contrario, mandar un lista
    this.id = id;
    this.name = name;
    this.age = age;
    this._isValid = true;
  }

  joinClass() {
    console.log(`${this.name} has joined the class`);
  }

  async getScore() {
    return 100;
  }

  async getAllCountries() {
    const { data } = await axios.get("https://restcountries.com/v3.1/all");
    return data;
  }
}

export const gustavo = new Student(1, "Gustavo", 29);
// gustavo.isValid;
// // console.log("🚀 ~ gustavo:", await gustavo.getScore());
// gustavo.getScore().then((score: number) => {
//   console.log("🚀 ~ score:", score);
// });
// gustavo.setAge = 30;
// console.log("🚀 ~ gustavo:", gustavo);
//gustavo.joinClass();
console.log(await gustavo.getAllCountries());
