"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const response_1 = require("./response");
const AWS = __importStar(require("aws-sdk"));
const bcrypt = __importStar(require("bcrypt"));
const dynamodb = new AWS.DynamoDB.DocumentClient();
const handler = async (event) => {
    if (!event.body) {
        return (0, response_1.makeResponse)(400, { message: 'Missing params' });
    }
    const { cpf, password } = JSON.parse(event.body);
    if (!cpf || !password) {
        return (0, response_1.makeResponse)(400, { message: 'Required fields: [cpf, password]' });
    }
    try {
        const params = {
            TableName: process.env.TABLE_USERS,
            Key: {
                cpf
            }
        };
        const data = await dynamodb.get(params).promise();
        if (data.Item) {
            const isValidPassword = await bcrypt.compare(password, data.Item?.password);
            if (isValidPassword) {
                return (0, response_1.makeResponse)(200, { userId: data.Item.id });
            }
        }
        return (0, response_1.makeResponse)(401, { message: 'Unauthorized' });
    }
    catch (error) {
        console.log('Error', error);
        return (0, response_1.makeResponse)(500, { Error: 'Internal server error' });
    }
};
exports.handler = handler;
