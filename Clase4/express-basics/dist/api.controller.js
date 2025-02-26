"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ApiController = void 0;
class ApiController {
    sayHello(req, res) {
        try {
            const response = {
                status: 200,
                message: "Hola!"
            };
            res.status(200).json(response);
        }
        catch (err) {
            console.log("🚀 ~ Controller ~ sayHello ~ err:", err);
        }
    }
}
exports.ApiController = ApiController;
