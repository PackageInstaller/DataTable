-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummonTowerActivityMO.lua

module("logic.extensions.summontower.model.SummonTowerActivityMO", package.seeall)

local SummonTowerActivityMO = class("SummonTowerActivityMO")

function SummonTowerActivityMO:ctor()
	self.activityId = 0
	self.record = nil
	self.currMasterId = 0
	self.currSeason = 0
	self.curStage = 0
	self.hasChooseSummomMaster = false
	self.gainedFirstPassPrizeIds = nil
	self.todayGameTimes = 0
	self.todayGameBuyTimes = 0
	self.everMaxPassStage = 0
	self.everMaxScore = 0
end

return SummonTowerActivityMO
