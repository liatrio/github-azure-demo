import Chance from "chance";

import articleListReducer from "../../reducers/articleList";
import {
    SET_PAGE,
    ARTICLE_FAVORITED,
    ARTICLE_UNFAVORITED,
} from "../../constants/actionTypes";

const chance = new Chance();

const createRandomArticle = (
    favorited = chance.bool(),
    favoritesCount = chance.natural({ min: 0, max: 100 })
) => ({
    slug: chance.guid(),
    favorited,
    favoritesCount,
    [chance.word()]: chance.word(),
});

test("loading the article list page", () => {
    const randomArticles = chance.n(createRandomArticle, chance.d6());

    const stateAfterInitialLoad = articleListReducer(
        {},
        {
            type: SET_PAGE,
            payload: {
                articles: randomArticles,
                articlesCount: randomArticles.length,
                currentPage: 1,
            },
        }
    );

    expect(stateAfterInitialLoad.articles).toEqual(randomArticles);
    expect(stateAfterInitialLoad.articlesCount).toEqual(randomArticles.length);
});

test("favoriting an article", () => {
    const randomArticles = chance.n(createRandomArticle, chance.d6());
    const articleToFavorite =
        randomArticles[
            chance.natural({ min: 0, max: randomArticles.length - 1 })
        ];
    const initialState = {
        articles: randomArticles,
        articlesCount: randomArticles.length,
        currentPage: 1,
    };

    const newState = articleListReducer(initialState, {
        type: ARTICLE_FAVORITED,
        payload: {
            article: {
                slug: articleToFavorite.slug,
                favorited: true,
                favoritesCount: articleToFavorite.favoritesCount + 1,
            },
        },
    });

    newState.articles.forEach((article, index) => {
        if (article.slug === articleToFavorite.slug) {
            expect(article.favorited).toBeTruthy();
            expect(article.favoritesCount).toEqual(
                articleToFavorite.favoritesCount + 1
            );
        } else {
            expect(article).toEqual(randomArticles[index]);
        }
    });
});

test("unfavoriting an article", () => {
    const randomArticles = chance.n(createRandomArticle, chance.d6());
    const articleToFavorite =
        randomArticles[
            chance.natural({ min: 0, max: randomArticles.length - 1 })
        ];
    const initialState = {
        articles: randomArticles,
        articlesCount: randomArticles.length,
        currentPage: 1,
    };

    const newState = articleListReducer(initialState, {
        type: ARTICLE_UNFAVORITED,
        payload: {
            article: {
                slug: articleToFavorite.slug,
                favorited: false,
                favoritesCount: articleToFavorite.favoritesCount - 1,
            },
        },
    });

    newState.articles.forEach((article, index) => {
        if (article.slug === articleToFavorite.slug) {
            expect(article.favorited).toBeFalsy();
            expect(article.favoritesCount).toEqual(
                articleToFavorite.favoritesCount - 1
            );
        } else {
            expect(article).toEqual(randomArticles[index]);
        }
    });
});
