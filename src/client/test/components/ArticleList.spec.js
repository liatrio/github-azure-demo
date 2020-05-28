import React from "react";
import { Provider } from "react-redux";
import { ConnectedRouter } from "connected-react-router";
import { render } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";
import Chance from "chance";

import { store, history } from "../../store";
import ArticleList from "../../components/ArticleList";

const chance = new Chance();

const createRandomArticle = (favorited = chance.bool()) => ({
    slug: chance.guid(),
    favorited,
    author: {
        username: chance.word(),
        image: chance.url()
    },
    createdAt: chance.date(),
    favoritesCount: chance.d6(),
    title: chance.sentence(),
    description: chance.paragraph(),
    tagList: chance.n(chance.word, chance.d6())
});

describe("article list", () => {
    let randomArticles;

    beforeEach(() => {
        randomArticles = chance.shuffle([
            createRandomArticle(true),
            createRandomArticle(false),
            ...chance.n(createRandomArticle, chance.d4())
        ]);
    });

    test("renders a loading div when no articles are loaded", () => {
        const { queryAllByText } = render(<ArticleList/>);
        const query = queryAllByText("Loading...");

        expect(query).toHaveLength(1);
    });

    test("renders each article list", () => {
        const { queryAllByText } = render(
            <Provider store={store}>
                <ConnectedRouter history={history}>
                    <ArticleList articles={randomArticles}/>
                </ConnectedRouter>
            </Provider>
        );

        randomArticles.forEach((article) => {
            expect(queryAllByText(article.title)).toHaveLength(1);
        });
    });
});

