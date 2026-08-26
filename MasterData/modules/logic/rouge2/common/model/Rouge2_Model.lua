-- chunkname: @modules/logic/rouge2/common/model/Rouge2_Model.lua

module("modules.logic.rouge2.common.model.Rouge2_Model", package.seeall)

local Rouge2_Model = class("Rouge2_Model", BaseModel)

function Rouge2_Model:onInit()
	self:reInit()
end

function Rouge2_Model:reInit()
	self._rougeInfo = nil
	self._rougeResult = nil
	self._curActId = nil
	self._isFirstGetInfo = false
end

function Rouge2_Model:isFirstGetInfo()
	return self._isFirstGetInfo
end

function Rouge2_Model:updateRougeInfo(info)
	self._isFirstGetInfo = true
	self._rougeInfo = self._rougeInfo or Rouge2_InfoMO.New()

	self._rougeInfo:init(info)

	if info:HasField("mapInfo") then
		self._mapModel = Rouge2_MapModel.instance

		self._mapModel:updateMapInfo(info.mapInfo)
	end

	Rouge2_BackpackController.instance:buildItemReddot()
	Rouge2_BackpackController.instance:buildBXSBoxReddot()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRougeInfo)
end

function Rouge2_Model:updateResultInfo(info)
	self._rougeResult = self._rougeResult or Rouge2_ResultMO.New()

	self._rougeResult:init(info)
end

function Rouge2_Model:updateLeaderInfo(leaderInfo)
	local rougeInfo = self:getRougeInfo()

	if rougeInfo then
		rougeInfo:updateLeaderInfo(leaderInfo)
	end
end

function Rouge2_Model:getOpenUnlockId()
	return Rouge2_Config.instance:getUnlockId()
end

function Rouge2_Model:setCurActId(actId)
	return
end

function Rouge2_Model:getCurActId()
	return Rouge2_Config.instance:getActId()
end

function Rouge2_Model:isRogueOpen()
	local actId = self:getCurActId()

	if actId == nil then
		return false
	end

	return ActivityModel.instance:isActOnLine(actId)
end

function Rouge2_Model:isUnlock()
	local openUnlockId = self:getOpenUnlockId()

	if openUnlockId == nil then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(openUnlockId)
end

function Rouge2_Model:getRougeInfo()
	return self._rougeInfo
end

function Rouge2_Model:getRougeResult()
	return self._rougeResult
end

function Rouge2_Model:getMapModel()
	return self._mapModel
end

function Rouge2_Model:getDifficulty()
	return (self._rougeInfo or nil) and (self._rougeInfo.difficulty or nil)
end

function Rouge2_Model:isContinueLast()
	if not self._rougeInfo then
		return false
	end

	return self._rougeInfo:isContinueLast()
end

function Rouge2_Model:clear()
	self._mapModel = nil
	self._rougeInfo = nil
	self._isAbort = nil
	self._rougeResult = nil
	self._initHeroDict = nil

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRougeInfo)
end

function Rouge2_Model:isFinishedDifficulty()
	return self._rougeInfo and self._rougeInfo.state == Rouge2_Enum.State.Difficulty
end

function Rouge2_Model:isStarted()
	return self._rougeInfo and self._rougeInfo.state == Rouge2_Enum.State.Start
end

function Rouge2_Model:isFinish()
	return self._rougeInfo and self._rougeInfo.state == Rouge2_Enum.State.isEnd
end

function Rouge2_Model:getState()
	return (self._rougeInfo or nil) and (self._rougeInfo.state or Rouge2_Enum.State.Empty)
end

function Rouge2_Model:inRouge()
	local state = self:getState()

	return state ~= Rouge2_Enum.State.Empty and state ~= Rouge2_Enum.State.isEnd
end

function Rouge2_Model:getEndId()
	return self._rougeInfo and self._rougeInfo.endId
end

function Rouge2_Model:updateFightResultMo(info)
	self.fightResultMo = self.fightResultMo or RougeFightResultMO.New()

	self.fightResultMo:init(info)
end

function Rouge2_Model:getFightResultInfo()
	return self.fightResultMo
end

function Rouge2_Model:isAbortRouge()
	return self._isAbort
end

function Rouge2_Model:onAbortRouge()
	self._isAbort = true
end

function Rouge2_Model:getLeaderInfo()
	local rougeInfo = self:getRougeInfo()

	return rougeInfo and rougeInfo:getLeaderInfo()
end

function Rouge2_Model:getCurAlchemyInfo()
	local rougeInfo = self:getRougeInfo()

	return rougeInfo and rougeInfo:getCurAlchemyInfo()
end

function Rouge2_Model:getCareerId()
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getCareerId()
end

function Rouge2_Model:getRevivalCoin()
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getRevivalCoin()
end

function Rouge2_Model:getCoin()
	local rougeInfo = self:getRougeInfo()

	return (rougeInfo or nil) and (rougeInfo.coin or 0)
end

function Rouge2_Model:updateRevivalCoin(revivalCoin)
	local leaderInfo = self:getLeaderInfo()

	if not leaderInfo then
		return
	end

	leaderInfo:updateRevivalCoin(revivalCoin)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRevivalCoin)
end

function Rouge2_Model:getAttrInfoList(attrType)
	local rougeInfo = self:getRougeInfo()
	local attrGroupInfo = rougeInfo and rougeInfo:getAttrGroupInfo()

	return attrGroupInfo and attrGroupInfo:getAttrInfoList(attrType)
end

function Rouge2_Model:getHeroAttrInfoList()
	local attrIdList = string.splitToNumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.HeroAttrIds].value, "#")
	local attrInfoList = {}

	for _, attrId in ipairs(attrIdList) do
		local attrInfo = self:getAttrMo(attrId)

		table.insert(attrInfoList, attrInfo)
	end

	return attrInfoList
end

function Rouge2_Model:getAttrMo(attrId)
	local rougeInfo = self:getRougeInfo()
	local attrGroupInfo = rougeInfo and rougeInfo:getAttrGroupInfo()

	return attrGroupInfo and attrGroupInfo:getAttrInfo(attrId)
end

function Rouge2_Model:getAttrValue(attrId)
	local attrMo = self:getAttrMo(attrId)

	return (attrMo or nil) and (attrMo.value or 0)
end

function Rouge2_Model:updateAttrInfoList(updates)
	local rougeInfo = self:getRougeInfo()

	if rougeInfo then
		rougeInfo:updateAttrInfoList(updates)
		Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateAttrInfo)
	end
end

function Rouge2_Model:isUseBXSCareer()
	local careerId = self:getCareerId()

	return careerId == Rouge2_Enum.BXSCareerId
end

function Rouge2_Model:isUseYBXCareer()
	local careerId = self:getCareerId()
	local ybxCareerId = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.YBXCareerId].value)

	return careerId == ybxCareerId
end

function Rouge2_Model:getCurTeamSystemId()
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getSystemTeamId()
end

function Rouge2_Model:getCurBattleConfig()
	local systemId = self:getCurTeamSystemId()

	if systemId and systemId ~= 0 then
		return Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(systemId)
	end
end

function Rouge2_Model:updateCurTeamSystemId(systemId)
	local leaderInfo = self:getLeaderInfo()

	leaderInfo:updateSystemTeamId(systemId)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateTeamSystem)
end

function Rouge2_Model:isGetAttrDrop(dropId)
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:isGetAttrDrop(dropId)
end

function Rouge2_Model:getAttrDropIdList(attrId)
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getAttrDropIdList(attrId)
end

function Rouge2_Model:getAttrDropItemList(dropId)
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getAttrDropItemList(dropId)
end

function Rouge2_Model:getItemDropIdMap(itemId)
	local leaderInfo = self:getLeaderInfo()

	return leaderInfo and leaderInfo:getItemDropIdMap(itemId)
end

Rouge2_Model.instance = Rouge2_Model.New()

return Rouge2_Model
