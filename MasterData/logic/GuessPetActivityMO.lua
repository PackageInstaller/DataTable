-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/model/GuessPetActivityMO.lua

module("logic.extensions.guesspets.model.GuessPetActivityMO", package.seeall)

local GuessPetActivityMO = class("GuessPetActivityMO")

function GuessPetActivityMO:ctor()
	self.activityId = 0
	self.myScores = 0
	self.curPlayTimes = 0
	self.curWorldScores = 0
	self.gainPersonPrizeIds = nil
	self.gainWorldPrizeIds = nil
end

return GuessPetActivityMO
