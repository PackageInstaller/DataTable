-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/RoleExperienceBattleFlow.lua

module("logic.extensions.dungeon.battleflow.RoleExperienceBattleFlow", package.seeall)

local RoleExperienceBattleFlow = class("RoleExperienceBattleFlow", DungeonBattleFlowBase)

function RoleExperienceBattleFlow:isEnableCampAdjustment()
	return false
end

function RoleExperienceBattleFlow:handleBattleStart()
	RoleExperienceBattleFlow.super.handleBattleStart(self)

	local dungeonId = self:getPassId()
	local imgGuidId = RoleExperienceConfig.instance:getImgGuidIdByDungeonId(dungeonId)

	if imgGuidId then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			imgGuidId
		})
	end
end

function RoleExperienceBattleFlow:createCalculateWork()
	ActivityAgent.instance:sendGetActivityInfoRequest()

	return RoleExperienceBattleFlow.super.createCalculateWork(self)
end

return RoleExperienceBattleFlow
