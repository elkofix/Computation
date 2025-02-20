import { CountriesApiAxios, CountriesApiFetch } from '../api/coutries-api';
import { Countries } from '../interfaces/conuntries-responses.interface';

export interface HttpAdapter {
  getAllCountries(): Promise<Countries>;
}
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

  constructor(id: number, name: string, age: number, private http: HttpAdapter) {
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
      return await this.http.getAllCountries();
  }
}

export const countriesApi = new CountriesApiFetch();

export const gustavo = new Student(1, "Gustavo", 29, countriesApi);
gustavo.getAllCountries();
// gustavo.isValid;
// // console.log("🚀 ~ gustavo:", await gustavo.getScore());
// gustavo.getScore().then((score: number) => {
//   console.log("🚀 ~ score:", score);
// });
// gustavo.setAge = 30;
// console.log("🚀 ~ gustavo:", gustavo);
//gustavo.joinClass();
console.log(await gustavo.getAllCountries());
