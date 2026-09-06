-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/model/GuessPetActivityGameMO.lua

module("logic.extensions.guesspets.model.GuessPetActivityGameMO", package.seeall)

local GuessPetActivityGameMO = class("GuessPetActivityGameMO")

function GuessPetActivityGameMO:ctor()
	self.players = nil
	self.problemCount = 0
	self.currProblemSeq = 0
	self.curQuestion = nil
	self.guessGameResult = nil
end

function GuessPetActivityGameMO:getPlayer(userId)
	if not self.players then
		return
	end

	for k, v in pairs(self.players) do
		if v.playerHeadInfo and v.playerHeadInfo.userId == userId then
			return v
		end
	end
end

return GuessPetActivityGameMO
