-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/multiplayer/BattleTeamInfoMO.lua

module("logic.battle.battleflow.component.model.multiplayer.BattleTeamInfoMO", package.seeall)

local BattleTeamInfoMO = class("BattleTeamInfoMO", AbstractGlobalReusable)

function BattleTeamInfoMO.findTeamInfoMO(teamId)
	local settingModel = BattleMgr.instance:getSettingModel()
	local teamInfoMOList = settingModel:getTeamInfoMOList()

	for _, teamInfoMO in ipairs(teamInfoMOList) do
		if teamInfoMO.teamId == teamId then
			return teamInfoMO
		end
	end

	return false
end

function BattleTeamInfoMO:createFromTeamNO(teamNO)
	local teamInfoMO = BattleTeamInfoMO:createInstance()

	teamInfoMO.teamId = teamNO.teamId

	for _, memberNO in ipairs(teamNO.members) do
		teamInfoMO:addUserInfoMO(BattleUserInfoMO:createFromMemberNO(memberNO))
	end

	return teamInfoMO
end

function BattleTeamInfoMO:ctor()
	self.teamId = false
	self._userInfoMOList = {}
end

function BattleTeamInfoMO:reset()
	self.teamId = false

	BattleTableUtil.clearReusableTable(self._userInfoMOList)
end

function BattleTeamInfoMO:destroy()
	self:reset()
end

function BattleTeamInfoMO:addUserInfoMO(userInfoMO)
	userInfoMO.teamId = self.teamId

	table.insert(self._userInfoMOList, userInfoMO)
end

function BattleTeamInfoMO:getLeaderUserInfoMO()
	return self._userInfoMOList[1]
end

function BattleTeamInfoMO:getUserInfoMOList()
	return self._userInfoMOList
end

function BattleTeamInfoMO:getUserInfoMO(userId)
	for _, userInfoMO in ipairs(userInfoMOList) do
		if userInfoMO.userId == userId then
			return userInfoMO
		end
	end

	return false
end

return BattleTeamInfoMO
