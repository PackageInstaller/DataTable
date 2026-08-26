-- chunkname: @modules/logic/versionactivity1_6/act148/model/Activity148Model.lua

module("modules.logic.versionactivity1_6.act148.model.Activity148Model", package.seeall)

local skillTypeNum = 4
local Activity148Model = class("Activity148Model", BaseModel)

function Activity148Model:onInit()
	self:initActivity148Mo()
end

function Activity148Model:reInit()
	self:initActivity148Mo()
end

function Activity148Model:initActivity148Mo()
	self._act148MoDict = {}

	for i = 1, skillTypeNum do
		local skillType = i
		local level = 0
		local skillMo = Activity148Mo.New()

		skillMo:init(skillType, level)

		self._act148MoDict[skillType] = skillMo
	end
end

function Activity148Model:getAct148SkillMo(skillType)
	if not self._act148MoDict then
		self:initActivity148Mo()
	end

	return self._act148MoDict[skillType]
end

function Activity148Model:getTotalGotSkillPointNum()
	return (self._totalSkillPoint or nil) and (self._totalSkillPoint or 0)
end

function Activity148Model:onReceiveInfos(msg)
	if not self._act148MoDict then
		self:initActivity148Mo()
	end

	self._actId = msg.activityId
	self._totalSkillPoint = msg.totalSkillPoint

	local skillTrees = msg.skillTrees

	if #skillTrees > 0 then
		for i = 1, #skillTrees do
			local skillInfo = skillTrees[i]

			self:updateAct148Mo(skillInfo)
		end
	else
		self:initActivity148Mo()
	end
end

function Activity148Model:onReceiveLevelUpReply(msg)
	local skillInfo = msg.skillTree

	self:updateAct148Mo(skillInfo)
end

function Activity148Model:onReceiveLevelDownReply(msg)
	local skillInfo = msg.skillTree

	self:updateAct148Mo(skillInfo)
end

function Activity148Model:onResetSkillInfos(msg)
	self._act148MoDict = {}

	for i = 1, skillTypeNum do
		local skillType = i
		local level = 0
		local skillMo = Activity148Mo.New()

		skillMo:init(skillType, level)

		self._act148MoDict[skillType] = skillMo
	end
end

function Activity148Model:updateAct148Mo(skillInfo)
	local skillType = skillInfo.type
	local level = skillInfo.level
	local skillMo = self._act148MoDict[skillType]

	if not skillMo then
		skillMo = Activity148Mo.New()

		skillMo:init(skillType, level)

		self._act148MoDict[skillType] = skillMo
	end

	skillMo:updateByServerData(skillInfo)
end

function Activity148Model:getAllSkillPoint()
	local result = 0

	if not self._act148MoDict then
		return result
	end

	for i = 1, skillTypeNum do
		local skillType = i
		local skillMo = self._act148MoDict[skillType]
		local lv = skillMo and skillMo:getLevel() or 0
		local curTypeSkillCostPoint = lv > 0 and Activity148Config.instance:getAct148SkillPointCost(skillType, lv) or 0

		result = result + curTypeSkillCostPoint
	end

	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	if currencyMO then
		if not currencyMO.quantity then
			local curSkillPointNum = 0

			return result + curSkillPointNum
		end
	end
end

Activity148Model.instance = Activity148Model.New()

return Activity148Model
