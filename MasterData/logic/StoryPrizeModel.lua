-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storyprize/model/StoryPrizeModel.lua

module("logic.extensions.storyprize.model.StoryPrizeModel", package.seeall)

local StoryPrizeModel = class("StoryPrizeModel", BaseModel)

function StoryPrizeModel:onInit()
	self:onReset()
end

function StoryPrizeModel:onReset()
	self._storyGainPrize = {}
end

function StoryPrizeModel:handlePM_StoryPrizeInfoRes(msg)
	self._storyGainPrize[msg.storyId] = msg.hasGain
end

function StoryPrizeModel:handlePM_StoryPrizeGainPrizeRes(msg)
	return
end

function StoryPrizeModel:handlePM_StoryPrizeTotalInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	for _, v in pairs(pb.totalInfos) do
		self._storyGainPrize[v.storyId] = v.hasGain
	end
end

function StoryPrizeModel:storyHasGainPrize(storyId)
	return self._storyGainPrize[storyId]
end

function StoryPrizeModel:setStoryHasGainPrize(storyId, hasGain)
	self._storyGainPrize[storyId] = hasGain
end

StoryPrizeModel.instance = StoryPrizeModel.New()

return StoryPrizeModel
