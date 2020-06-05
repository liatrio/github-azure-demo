import Chance from "chance";

import commonReducer from "../../reducers/common";
import {
    ARTICLE_PAGE_UNLOADED,
    EDITOR_PAGE_UNLOADED,
    HOME_PAGE_UNLOADED,
    PROFILE_PAGE_UNLOADED,
    PROFILE_FAVORITES_PAGE_UNLOADED,
    SETTINGS_PAGE_UNLOADED,
    LOGIN_PAGE_UNLOADED,
    REGISTER_PAGE_UNLOADED,
} from "../../constants/actionTypes";

const chance = new Chance();

test("unloading a page should increase view counter", () => {
    const unloadActions = [
        ARTICLE_PAGE_UNLOADED,
        EDITOR_PAGE_UNLOADED,
        HOME_PAGE_UNLOADED,
        PROFILE_PAGE_UNLOADED,
        PROFILE_FAVORITES_PAGE_UNLOADED,
        SETTINGS_PAGE_UNLOADED,
        LOGIN_PAGE_UNLOADED,
        REGISTER_PAGE_UNLOADED,
    ];

    unloadActions.forEach((unloadAction) => {
        const randomNumberOfViews = chance.d20();

        const initialState = {
            viewChangeCounter: randomNumberOfViews,
        };
        const newState = commonReducer(initialState, {
            type: unloadAction,
        });
        expect(newState.viewChangeCounter).toEqual(randomNumberOfViews + 1);
    });
});
