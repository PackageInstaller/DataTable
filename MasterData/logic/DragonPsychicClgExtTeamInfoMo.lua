-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/data/DragonPsychicClgExtTeamInfoMo.lua

module("logic.extensions.dragonpsychicclg.data.DragonPsychicClgExtTeamInfoMo", package.seeall)

local DragonPsychicClgExtTeamInfoMo = class("DragonPsychicClgExtTeamInfoMo")

function DragonPsychicClgExtTeamInfoMo:ctor(stageId, teamId)
	self._stageId = stageId
	self._teamId = teamId
	self._isPass = false
	self._lockRaceIds = {}
	self._isFirstPass = false
end

function DragonPsychicClgExtTeamInfoMo:updateMsg(msg)
	self._isPass = checkbool(msg.pass)

	table.clear(self._lockRaceIds)
	table.insertto(self._lockRaceIds, msg.lockRaceIds)

	self._isFirstPass = checkbool(msg.firstPass)
end

function DragonPsychicClgExtTeamInfoMo:isPass()
	return self._isPass
end

function DragonPsychicClgExtTeamInfoMo:getLockRaceIds()
	return self._lockRaceIds
end

function DragonPsychicClgExtTeamInfoMo:isFirstPass()
	return self._isFirstPass
end

return DragonPsychicClgExtTeamInfoMo
