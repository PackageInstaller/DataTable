-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummonRecordMO.lua

module("logic.extensions.summontower.model.SummonRecordMO", package.seeall)

local SummonRecordMO = class("SummonRecordMO")

function SummonRecordMO:ctor()
	self.summonRaceId = 0
	self.maxLevel = 0
	self.maxScores = 0
end

return SummonRecordMO
