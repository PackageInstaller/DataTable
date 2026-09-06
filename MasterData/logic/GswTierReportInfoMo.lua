-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswTierReportInfoMo.lua

module("logic.extensions.godstatueswar.data.GswTierReportInfoMo", package.seeall)

local GswTierReportInfoMo = class("GswTierReportInfoMo")

function GswTierReportInfoMo:ctor()
	self._tierId = 0
	self._pillarId = 0
	self._time = ""
	self._reportDetailInfoMoList = {}
	self._wins = {}
	self._headInfos = {}
	self._familyIconIds = {}
	self._familyNames = {}
end

function GswTierReportInfoMo:onReset()
	self._tierId = 0
	self._pillarId = 0
	self._time = ""

	table.clear(self._reportDetailInfoMoList)
	table.clear(self._wins)
	table.clear(self._headInfos)
	table.clear(self._familyIconIds)
	table.clear(self._familyNames)
end

function GswTierReportInfoMo:initData(msg)
	self:onReset()

	self._tierId = msg.tier
	self._pillarId = msg.pillarId
	self._time = msg.time

	for _, v in ipairs(msg.reportList) do
		local mo = GswTierReportDetailInfoMo.New()

		mo:initData(v)
		table.insert(self._reportDetailInfoMoList, mo)
	end

	local winMsgList = {
		checkbool(msg.isWin),
		not checkbool(msg.isWin)
	}
	local headInfoMsgList = {
		msg.casterHeadInfo
	}
	local familyIconIds = {
		[2] = msg.familyIconId
	}
	local familyNameMsgList = {
		msg.casterFamilyName,
		msg.targetFamilyName
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._wins[teamId] = checkbool(winMsgList[idx])
	end

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._headInfos[teamId] = headInfoMsgList[idx]
	end

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._familyIconIds[teamId] = familyIconIds[idx]
	end

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		self._familyNames[teamId] = familyNameMsgList[idx]
	end
end

function GswTierReportInfoMo:getTierId()
	return self._tierId
end

function GswTierReportInfoMo:getPillarId()
	return self._pillarId
end

function GswTierReportInfoMo:getTime()
	return self._time
end

function GswTierReportInfoMo:getReportDetailInfoMoList()
	return self._reportDetailInfoMoList
end

function GswTierReportInfoMo:isWin(teamId)
	return checkbool(self._wins[teamId])
end

function GswTierReportInfoMo:getUserName(teamId)
	local headInfo = self:getHeadInfo(teamId)

	if headInfo then
		return headInfo.userName
	end

	return ""
end

function GswTierReportInfoMo:getHeadInfo(teamId)
	return self._headInfos[teamId]
end

function GswTierReportInfoMo:getFamilyIconId(teamId)
	return self._familyIconIds[teamId]
end

function GswTierReportInfoMo:getFamilyName(teamId)
	return self._familyNames[teamId]
end

return GswTierReportInfoMo
