import markdownUtils from '@joplin/lib/markdownUtils';

export default {
	getMessage: () => {
		const title = markdownUtils.titleFromBody('# This is a title\n\nThis is not a title.');
		return `Hey there! \nHere's when it is: \n\t${Date()}\nAnd here's what it is: \n\t${title}`;
	},
};
