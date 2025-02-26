import { Request, Response } from "express";

export class ApiController{
    sayHello(req: Request, res:Response){
        try{
            const response = {
                status: 200,
                message: "Hola!"
            }
            res.status(200).json(response);
        }catch(err:any){
            console.log("🚀 ~ Controller ~ sayHello ~ err:", err)

        }
    }
}