-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswTierReportDetailInfoMo.lua

module("logic.extensions.godstatueswar.data.GswTierReportDetailInfoMo", package.seeall)

local GswTierReportDetailInfoMo = class("GswTierReportDetailInfoMo")

function GswTierReportDetailInfoMo:ctor()
	self._battleId = ""
	self._wins = {}
	self._zdls = {}
	self._posLists = {}
end

function GswTierReportDetailInfoMo:onReset()
	self._battleId = ""

	table.clear(self._wins)
	table.clear(self._zdls)
	table.clear(self._posLists)
end

function GswTierReportDetailInfoMo:initData(msg)
	self:onReset()

	self._battleId = msg.battleId

	local winMsgList = {
		checkbool(msg.isWin),
		not checkbool(msg.isWin)
	}
	local zdlMsgList = {
		msg.myZdl,
		msg.enemyZdl
	}
	local posMsgList = {
		msg.myPets,
		msg.enemyPets
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._wins[teamId] = checkbool(winMsgList[idx])
	end

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._zdls[teamId] = zdlMsgList[idx]
	end

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._posLists[teamId] = {}

		for _, v in ipairs(posMsgList[idx]) do
			self._posLists[teamId][v.posId] = v
		end
	end

	for posId = 1, 9 do
		for idx, teamId in ipairs(GameEnum.BattleTeamList) do
			if self._posLists[teamId][posId] == nil then
				self._posLists[teamId][posId] = {}
			end
		end
	end
end

function GswTierReportDetailInfoMo:getBattleId()
	return self._battleId
end

function GswTierReportDetailInfoMo:isWin(teamId)
	return checkbool(self._wins[teamId])
end

function GswTierReportDetailInfoMo:getZdl(teamId)
	return checknumber(self._zdls[teamId])
end

function GswTierReportDetailInfoMo:getSkinId(teamId, posId)
	local info = self:getPosInfo(teamId, posId)

	return (info or nil) and (info.faceId or 0)
end

function GswTierReportDetailInfoMo:getPosList(teamId)
	return self._posLists[teamId]
end

function GswTierReportDetailInfoMo:getPosInfo(teamId, posId)
	if self._posLists[teamId] then
		return self._posLists[teamId][posId]
	end
end

return GswTierReportDetailInfoMo
