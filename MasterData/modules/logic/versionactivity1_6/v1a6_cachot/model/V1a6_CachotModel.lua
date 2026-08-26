-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotModel", package.seeall)

local V1a6_CachotModel = class("V1a6_CachotModel", BaseModel)

function V1a6_CachotModel:onInit()
	self._rogueStateInfo = nil
	self._rogueInfo = nil
	self._goodsInfos = nil
	self._rogueEndingInfo = nil
end

function V1a6_CachotModel:reInit()
	self:onInit()
end

function V1a6_CachotModel:getRogueStateInfo()
	return self._rogueStateInfo
end

function V1a6_CachotModel:getRogueInfo()
	return self._rogueInfo
end

function V1a6_CachotModel:getGoodsInfos()
	return self._goodsInfos
end

function V1a6_CachotModel:getTeamInfo()
	if not self._rogueInfo then
		return
	end

	return self._rogueInfo.teamInfo
end

function V1a6_CachotModel:getRogueEndingInfo()
	return self._rogueEndingInfo
end

function V1a6_CachotModel:clearRogueInfo()
	self._rogueInfo = nil

	V1a6_CachotRoomModel.instance:clear()
end

function V1a6_CachotModel:updateRogueStateInfo(info)
	self._rogueStateInfo = self._rogueStateInfo or RogueStateInfoMO.New()

	self._rogueStateInfo:init(info)
	V1a6_CachotStatController.instance:recordInitHeroGroup()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueStateInfo)
end

function V1a6_CachotModel:isInRogue()
	if self._rogueInfo then
		return not self._rogueInfo.isFinish
	end

	return self._rogueStateInfo and self._rogueStateInfo.start
end

function V1a6_CachotModel:updateRogueInfo(info)
	self._rogueInfo = self._rogueInfo or RogueInfoMO.New()

	self._rogueInfo:init(info)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueInfo)
end

function V1a6_CachotModel:updateTeamInfo(teamInfo)
	self._rogueInfo:updateTeamInfo(teamInfo)
end

function V1a6_CachotModel:updateGroupBoxStar(groupBoxStar)
	self._rogueInfo.teamInfo:updateGroupBoxStar(groupBoxStar)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGroupBoxStar)
end

function V1a6_CachotModel:updateGoodsInfos(list)
	if not list then
		return
	end

	self._goodsInfos = {}

	for i, v in ipairs(list) do
		local info = RogueGoodsInfoMO.New()

		info:init(v)
		table.insert(self._goodsInfos, info)
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function V1a6_CachotModel:updateCollectionsInfos(collectionsInfo)
	if not collectionsInfo then
		return
	end

	self._rogueInfo = self._rogueInfo or RogueInfoMO.New()

	self._rogueInfo:updateCollections(collectionsInfo)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCollectionsInfo)
end

function V1a6_CachotModel:updateRogueEndingInfo(msg)
	self._rogueEndingInfo = self._rogueEndingInfo or RogueEndingInfoMO.New()

	self._rogueEndingInfo:init(msg)
end

function V1a6_CachotModel:clearRogueEndingInfo()
	self._rogueEndingInfo = nil
end

function V1a6_CachotModel:setChangeLifes(lifes)
	self._changeLifes = {}

	for i, v in ipairs(lifes) do
		local lifeInfo = RogueHeroLifeMO.New()

		lifeInfo:init(v)
		table.insert(self._changeLifes, lifeInfo)
	end
end

function V1a6_CachotModel:getChangeLifes()
	return self._changeLifes
end

function V1a6_CachotModel:isReallyOpen()
	local actMo = ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId)
	local isOpen = actMo:isOpen()

	if isOpen then
		local actCo = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId)
		local openId = actCo.openId

		return openId and openId ~= 0 and OpenModel.instance:isFunctionUnlock(openId)
	end
end

function V1a6_CachotModel:isOnline()
	local actMo = ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId)

	return actMo and ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId, true) == ActivityEnum.ActivityStatus.Normal
end

V1a6_CachotModel.instance = V1a6_CachotModel.New()

return V1a6_CachotModel
