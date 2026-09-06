-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/model/GroupRechargeTeamInfo.lua

module("logic.extensions.grouprecharge.model.GroupRechargeTeamInfo", package.seeall)

local GroupRechargeTeamInfo = class("GroupRechargeTeamInfo")

function GroupRechargeTeamInfo:ctor()
	self._captainUserId = nil
	self._totalRecharge = 0
	self._memberMap = {}
end

function GroupRechargeTeamInfo:updateInfo(params)
	self._captainUserId = params.captainUserId

	if self._captainUserId == 0 then
		self._captainUserId = nil
	end

	self._totalRecharge = params.totalRecharge

	local members = GameUtil.pbToTable(params.member) or {}
	local configs = GroupRechargeConfig.instance:getPositionConfigs()

	self.maxLocationCount = #configs
	self._memberMap = {}

	for i, v in ipairs(members) do
		self._memberMap[v.posId] = v
	end
end

function GroupRechargeTeamInfo:isInTeam()
	return not string.nilorempty(self._captainUserId)
end

function GroupRechargeTeamInfo:isCaptain()
	return self._captainUserId == tostring(RoleModel.instance:getUserId())
end

function GroupRechargeTeamInfo:isFull()
	local configs = GroupRechargeConfig.instance:getPositionConfigs()

	for i, config in ipairs(configs) do
		if config.type == GroupRechargeConfig.LT_Friend and not self:getMemberByPosId(config.posId) then
			return false
		end
	end

	return true
end

function GroupRechargeTeamInfo:getTotalRecharge()
	return self._totalRecharge or "0"
end

function GroupRechargeTeamInfo:getMemberByPosId(posId)
	return self._memberMap[posId]
end

function GroupRechargeTeamInfo:getLocationReadyByType(type)
	local configs = GroupRechargeConfig.instance:getPositionConfigs()
	local maxNum = 0
	local readyNum = 0

	for i, config in ipairs(configs) do
		if config.type == type then
			maxNum = maxNum + 1

			if self._memberMap[config.posId] then
				readyNum = readyNum + 1
			end
		end
	end

	return readyNum, maxNum
end

return GroupRechargeTeamInfo
