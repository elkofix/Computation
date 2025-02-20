import axios from 'axios';
import { Countries } from '../interfaces/conuntries-responses.interface';
import { HttpAdapter } from '../classes/classes';

export class CountriesApiAxios implements HttpAdapter{
    URL:string ="https://restcountries.com/v3.1/all";

    
  async getAllCountries() {
    const { data } = await axios.get<Countries[]>("https://restcountries.com/v3.1/all");
    return data[0];
  }
}


export class CountriesApiFetch implements HttpAdapter{
    URL:string ="https://restcountries.com/v3.1/all";

    
  async getAllCountries() {
    const resp = await fetch(this.URL);
    const data = await resp.json() as Countries[];
    return data[0];
  }
}

