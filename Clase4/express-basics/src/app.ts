import express, { application } from "express";
import router from "./routes/api-route";

export class App{
    private app = application;

    constructor(){
        this.app = express();
        this.settings();
        this.middlewares();
        this.routes();
    }


    middlewares(){
        this.app.use(express.urlencoded({extended:false}));
        this.app.use(express.json())
    }


    routes(){
        this.app.use("/api", router);

    }
    
    settings(){
        this.app.set("port", process.env.PORT ?? 3000);
    }

    async listen(){
        await this.app.listen(this.app.get('port'));
        console.log(`Server running in port ${this.app.get("port")}`)
    }
}