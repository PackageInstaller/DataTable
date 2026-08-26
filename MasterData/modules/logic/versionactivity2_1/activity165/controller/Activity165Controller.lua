-- chunkname: @modules/logic/versionactivity2_1/activity165/controller/Activity165Controller.lua

module("modules.logic.versionactivity2_1.activity165.controller.Activity165Controller", package.seeall)

local Activity165Controller = class("Activity165Controller", BaseController)

function Activity165Controller:addConstEvents()
	return
end

function Activity165Controller:openActivity165EnterView()
	Activity165Model.instance:onInitInfo()
	ViewMgr.instance:openView(ViewName.Activity165StoryEnterView)
end

function Activity165Controller:openActivity165ReviewView(storyId, view)
	ViewMgr.instance:openView(ViewName.Activity165StoryReviewView, {
		storyId = storyId,
		view = view
	})
end

function Activity165Controller:openActivity165EditView(storyId, reviewEnding)
	ViewMgr.instance:openView(ViewName.Activity165StoryEditView, {
		storyId = storyId,
		reviewEnding = reviewEnding
	})
end

Activity165Controller.instance = Activity165Controller.New()

return Activity165Controller
