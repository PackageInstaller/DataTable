-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/TravelGoStatHelper.lua

module("modules.logic.versionactivity3_7.travelgo.controller.TravelGoStatHelper", package.seeall)

local TravelGoStatHelper = class("TravelGoStatHelper")

function TravelGoStatHelper:ctor()
	self.episodeId = "0"
end

function TravelGoStatHelper:enterGame()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function TravelGoStatHelper:selectSkill(selectSkillId, selectableSkillIdList)
	local mapId = TravelGoModel.instance.gameId
	local day = TravelGoModel.instance.day
	local level = TravelGoModel.instance.level
	local skillList = TravelGoStatHelper:getSkills()

	StatController.instance:track(StatEnum.EventName.TravelGame, {
		[StatEnum.EventProperties.OperationType] = "选取技能",
		[StatEnum.EventProperties.ActTravelMapId] = tostring(mapId),
		[StatEnum.EventProperties.Day] = day,
		[StatEnum.EventProperties.AfterLevel] = level,
		[StatEnum.EventProperties.ActTravelSkillId] = selectSkillId,
		[StatEnum.EventProperties.ActTravelSelectableSkills] = selectableSkillIdList,
		[StatEnum.EventProperties.ActTravelSkillList] = skillList
	})
end

function TravelGoStatHelper:sendGameAbort()
	self:endGame("手动退出")
end

function TravelGoStatHelper:sendGameSettle()
	self:endGame("关卡结算")
end

function TravelGoStatHelper:endGame(operationType)
	local mapId = TravelGoModel.instance.gameId
	local isWin = TravelGoModel.instance.isWin
	local day = TravelGoModel.instance.day
	local level = TravelGoModel.instance.level
	local useTime = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	local skillList = TravelGoStatHelper:getSkills()
	local attrInfo = TravelGoStatHelper:getAttrInfo()

	StatController.instance:track(StatEnum.EventName.TravelGame, {
		[StatEnum.EventProperties.OperationType] = operationType,
		[StatEnum.EventProperties.ActTravelMapId] = tostring(mapId),
		[StatEnum.EventProperties.IsWin] = isWin,
		[StatEnum.EventProperties.Day] = day,
		[StatEnum.EventProperties.AfterLevel] = level,
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.ActTravelSkillList] = skillList,
		[StatEnum.EventProperties.ActTravelAttrInfo] = attrInfo
	})
end

function TravelGoStatHelper:getSkills()
	local skillIdList = {}
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	if not playerEntity then
		return skillIdList
	end

	local skills = playerEntity.skill.skills

	for i, v in ipairs(skills) do
		if v.cfgId ~= TravelGoConst.UltimateSkillId and v.cfgId ~= TravelGoConst.FrozenSkillId then
			table.insert(skillIdList, v.cfgId)
		end
	end

	return skillIdList
end

function TravelGoStatHelper:getAttrInfo()
	local attrInfoArray = {}
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	if not playerEntity then
		return attrInfoArray
	end

	local attrs = playerEntity.attributes

	for _, attrId in pairs(TravelGoBattleEnum.AttrType) do
		local attrInfo = {
			id = attrId,
			value = attrs:getAttr(attrId)
		}

		table.insert(attrInfoArray, attrInfo)
	end

	return attrInfoArray
end

TravelGoStatHelper.instance = TravelGoStatHelper.New()

return TravelGoStatHelper
