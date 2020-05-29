import Chance from "chance";

import articleReducer from "../../reducers/article";
import {
    ARTICLE_PAGE_LOADED,
    ADD_COMMENT,
    DELETE_COMMENT,
} from "../../constants/actionTypes";

const chance = new Chance();

const createRandomObject = () => ({
    id: chance.guid(),
    [chance.word()]: chance.word(),
});

test("loading the article page", () => {
    const randomArticle = createRandomObject();
    const randomComments = chance.n(createRandomObject, chance.d6());

    const stateAfterInitialLoad = articleReducer(
        {},
        {
            type: ARTICLE_PAGE_LOADED,
            payload: [
                {
                    article: randomArticle,
                },
                {
                    comments: randomComments,
                },
            ],
        }
    );

    expect(stateAfterInitialLoad.article).toEqual(randomArticle);
    expect(stateAfterInitialLoad.comments).toEqual(randomComments);
});

test("adding a comment", () => {
    const initialComments = chance.n(createRandomObject, chance.d6());
    const initialState = {
        comments: initialComments,
    };
    const newComment = createRandomObject();

    const newState = articleReducer(initialState, {
        type: ADD_COMMENT,
        payload: {
            comment: newComment,
        },
    });

    initialComments.forEach((comment) => {
        expect(newState.comments).toContain(comment);
    });

    expect(newState.comments).toContain(newComment);
});

test("deleting a comment", () => {
    const initialComments = chance.n(createRandomObject, chance.d6());
    const initialState = {
        comments: initialComments,
    };
    const deletedComment =
        initialComments[
            chance.natural({ min: 0, max: initialComments.length - 1 })
            ];

    const newState = articleReducer(initialState, {
        type: DELETE_COMMENT,
        commentId: deletedComment.id,
    });

    initialComments.forEach((comment) => {
        if (comment.id === deletedComment.id) {
            expect(newState.comments).not.toContain(comment);
        } else {
            expect(newState.comments).toContain(comment);
        }
    });
});