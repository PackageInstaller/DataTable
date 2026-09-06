-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/model/GuessPetGamePlayerMO.lua

module("logic.extensions.guesspets.model.GuessPetGamePlayerMO", package.seeall)

local GuessPetGamePlayerMO = class("GuessPetGamePlayerMO")

function GuessPetGamePlayerMO:ctor()
	self.playerHeadInfo = nil
	self.scores = 0
	self.isOffline = false
end

return GuessPetGamePlayerMO
