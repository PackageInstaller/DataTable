-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storyprize/controller/StoryPrizeController.lua

module("logic.extensions.storyprize.controller.StoryPrizeController", package.seeall)

local StoryPrizeController = class("StoryPrizeController", BaseController)

function StoryPrizeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
end

function StoryPrizeController:onReset()
	self._hasGetTotalInfo = false
	self._prizeStack = {}
	self._storyMap = {}
	self._tempStoryIdList = {}
end

function StoryPrizeController:getPrizeStack()
	if #self._prizeStack > 0 then
		return table.remove(self._prizeStack, #self._prizeStack)
	end
end

function StoryPrizeController:setPrizeStack(prizeStr)
	table.insert(self._prizeStack, prizeStr)
end

function StoryPrizeController:hasGetedTotalInfo()
	return self._hasGetTotalInfo
end

function StoryPrizeController:sendPM_StoryPrizeInfoReq(storyId)
	StoryPrizeAgent.instance:sendPM_StoryPrizeInfoReq(storyId)
end

function StoryPrizeController:handlePM_StoryPrizeInfoRes(msg)
	StoryPrizeModel.instance:handlePM_StoryPrizeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StoryPrizeInfoRes, msg.storyId, msg.hasGain)
end

function StoryPrizeController:sendPM_StoryPrizeGainPrizeReq(storyId)
	StoryPrizeAgent.instance:sendPM_StoryPrizeGainPrizeReq(storyId)
end

function StoryPrizeController:handlePM_StoryPrizeGainPrizeRes(msg)
	local storyId = msg.storyId
	local prizeCfg = StoryPrizeConfig.instance:getStoryPrizeCfg(storyId)
	local prizeStr = prizeCfg.prize

	StoryPrizeController.instance:setPrizeStack(prizeStr)
	self:saveChangesetId(storyId, msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StoryPrizeGainPrizeRes)
end

function StoryPrizeController:sendPM_StoryPrizeTotalInfoReq()
	StoryPrizeAgent.instance:sendPM_StoryPrizeTotalInfoReq()
end

function StoryPrizeController:handlePM_StoryPrizeTotalInfoRes(msg)
	StoryPrizeModel.instance:handlePM_StoryPrizeTotalInfoRes(msg)

	self._hasGetTotalInfo = true

	for storyId, v in ipairs(self._tempStoryIdList) do
		local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(storyId)

		if not hasGainPrize then
			self:sendPM_StoryPrizeGainPrizeReq(storyId)
		end
	end

	self._tempStoryIdList = {}

	GlobalDispatcher:dispatch(GlobalNotify.PM_StoryPrizeTotalInfoRes)
end

function StoryPrizeController:canGetStoryPrize(petId)
	local petMo = BagModel.instance:getPet(petId)

	if petMo == nil then
		return false
	end

	local list = PetSkinConfig.instance:getPetSkinListBySkinId(petMo.curFaceId)
	local canGetPrize = false

	if list then
		for k, v in pairs(list) do
			local skinId = v.skinId
			local storyId = PetSkinConfig.instance:getStoryId(skinId)

			if storyId > 0 then
				local hasGain = StoryPrizeModel.instance:storyHasGainPrize(storyId)

				if not hasGain then
					canGetPrize = true

					break
				end
			end
		end
	end

	return canGetPrize
end

function StoryPrizeController:canGetStoryPrizeBySkinId(skinId)
	local storyId = PetSkinConfig.instance:getStoryId(skinId)

	if storyId > 0 then
		local hasGain = StoryPrizeModel.instance:storyHasGainPrize(storyId)

		return not hasGain
	end

	return false
end

function StoryPrizeController:updateStoryPrizeStateBySkinId(skinId)
	local storyId = PetSkinConfig.instance:getStoryId(skinId)
	local canGetPrize = storyId > 0

	if canGetPrize then
		StoryPrizeModel.instance:setStoryHasGainPrize(storyId, false)
	end
end

function StoryPrizeController:playStroyAndGetPrize(storyId)
	if self._hasGetTotalInfo then
		local storyHasPrize = StoryPrizeConfig.instance:getStoryPrizeCfg(storyId)
		local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(storyId)

		if storyHasPrize and not hasGainPrize then
			self:sendPM_StoryPrizeGainPrizeReq(storyId)
		end
	else
		table.insert(self._tempStoryIdList, storyId)
		StoryPrizeController.instance:sendPM_StoryPrizeTotalInfoReq()
	end

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function StoryPrizeController:saveChangesetId(storyId, changeSetId)
	MaterialController.instance:saveChangeSetToTemp(changeSetId)

	self._storyMap[storyId] = changeSetId
end

function StoryPrizeController:_onEndStory(storyId)
	local changeSetId = checknumber(self._storyMap[storyId])

	if changeSetId > 0 then
		self._storyMap[storyId] = nil

		MaterialController.instance:showChangeSetInTemp(changeSetId)
		StoryPrizeModel.instance:setStoryHasGainPrize(storyId, true)
	end
end

StoryPrizeController.instance = StoryPrizeController.New()

return StoryPrizeController
