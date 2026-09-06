-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/controller/CardHotController.lua

module("logic.extensions.cardhot.controller.CardHotController", package.seeall)

local CardHotController = class("CardHotController", BaseController)

CardHotController.CardHotTaskStory = "cardhottaskstory"

function CardHotController:ctor()
	CardHotController.super.ctor(self)
end

function CardHotController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(CardHotController.CardHotTaskStory, self.onPlayStory, self)
end

function CardHotController:onReset()
	return
end

function CardHotController:sendGetAllTask(activityId)
	CardHotModel.instance:sendGetAllTask(activityId)
end

function CardHotController:sendGetPrize(summaryId, data)
	CardHotModel.instance:sendGetPrize(summaryId, data.id)
end

function CardHotController:sendGetTaskPrize(summaryId, data)
	CardHotModel.instance:sendGetTaskPrize(summaryId, data.id)
end

function CardHotController:onPlayStory(params)
	local summaryId = checknumber(params[1])
	local taskId = checknumber(params[2])
	local storyId = checknumber(params[3])

	CardHotModel.instance:sendPlayStory(summaryId, taskId)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

CardHotController.instance = CardHotController.New()

return CardHotController
