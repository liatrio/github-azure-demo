import { applyMiddleware, createStore } from "redux";
import { createLogger } from "redux-logger";
import { composeWithDevTools } from "redux-devtools-extension/developmentOnly";
import { promiseMiddleware, localStorageMiddleware } from "./middleware";
import reducer from "./reducer";

import { routerMiddleware } from "connected-react-router";
import { createHashHistory } from "history";

export const history = createHashHistory();

// Build the middleware for intercepting and dispatching navigation actions
const myRouterMiddleware = routerMiddleware(history);

const getMiddleware = () => {
    if (
        process.env.NODE_ENV === "production" ||
        process.env.NODE_ENV === "test"
    ) {
        return applyMiddleware(
            myRouterMiddleware,
            promiseMiddleware,
            localStorageMiddleware
        );
    } else {
        // Enable additional logging in non-production environments.
        return applyMiddleware(
            myRouterMiddleware,
            promiseMiddleware,
            localStorageMiddleware,
            createLogger()
        );
    }
};

export const store = createStore(
    reducer(history),
    composeWithDevTools(getMiddleware())
);
