"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.makeResponse = void 0;
const makeResponse = (statusCode, body) => {
    return {
        statusCode,
        body: JSON.stringify(body)
    };
};
exports.makeResponse = makeResponse;
