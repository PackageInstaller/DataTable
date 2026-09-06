-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonBadgeModel.lua

module("logic.extensions.season.model.SeasonBadgeModel", package.seeall)

local SeasonBadgeModel = class("SeasonBadgeModel", BaseModel)

SeasonBadgeModel.SlotActive = 1
SeasonBadgeModel.SlotInActive = 2
SeasonBadgeModel.SlotLock = 3

function SeasonBadgeModel:ctor()
	return
end

function SeasonBadgeModel:onInit()
	self:onReset()
end

function SeasonBadgeModel:onReset()
	self._activeBadgeIds = {}
	self._gainBudgeMap = {}
	self._gainBudgeList = {}
	self._presetBudgeList = {}
end

function SeasonBadgeModel:setPresetBudgeList(medals)
	self._presetBudgeList = medals or {}
end

function SeasonBadgeModel:handleInit(msg)
	self._activeBadgeIds = {}
	self._activiteBudgeMap = {}

	for i, v in ipairs(msg.activiteBudgeIds) do
		self._activiteBudgeMap[v] = true

		table.insert(self._activeBadgeIds, v)
	end

	self._gainBudgeList = {}
	self._gainBudgeMap = {}

	for i, v in ipairs(msg.gainBudgeIds) do
		self._gainBudgeMap[v] = true

		table.insert(self._gainBudgeList, v)
	end
end

function SeasonBadgeModel:handleActiveBadgeIds(msg)
	self._activeBadgeIds = {}
	self._activeBadgeIds = msg.activiteBudgeIds
	self._activiteBudgeMap = {}

	for i, v in ipairs(msg.activiteBudgeIds) do
		self._activiteBudgeMap[v] = true
	end
end

function SeasonBadgeModel:getSlotStateById(slotId)
	if self._activiteBudgeMap[slotId] then
		return SeasonBadgeModel.SlotActive
	elseif self._gainBudgeMap[slotId] then
		return SeasonBadgeModel.SlotInActive
	else
		return SeasonBadgeModel.SlotLock
	end
end

function SeasonBadgeModel:getAttrs()
	local seasonId = SeasonModel.instance:getSeasonId()
	local res = {}

	for i, v in ipairs(self._activeBadgeIds) do
		local config = SeasonMainCampConfig.instance:getBadgeConfig(seasonId, v)
		local attrs = FightingPowerFormula.instance:parseAttrValues(config.propertyApp)

		res = AttrMo.addSameAttrs(attrs, res)
	end

	local activeBadgeNum = self:getActiveBadgeNum()
	local list = SeasonMainCampConfig.instance:getBadgeSuitConfig(seasonId)
	local len = #list

	for i = len, 1, -1 do
		local cfg = list[i]

		if activeBadgeNum >= cfg.num then
			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.propertyParam)

			res = AttrMo.addSameAttrs(attrs, res)

			break
		end
	end

	return res
end

function SeasonBadgeModel:getActiveBadgeNum()
	if self._gainBudgeList then
		return #self._gainBudgeList
	end

	return 0
end

function SeasonBadgeModel:getPresetActiveBadgeNum()
	if self._presetBudgeList then
		return #self._presetBudgeList
	end

	return 0
end

function SeasonBadgeModel:isBadgeCollectComplete()
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonMainCampConfig.instance:getBadgeConfigs(seasonId) or {}
	local needs = table.nums(config)

	return self:getActiveBadgeNum() == needs or self:getPresetActiveBadgeNum() == needs
end

SeasonBadgeModel.instance = SeasonBadgeModel.New()

return SeasonBadgeModel
