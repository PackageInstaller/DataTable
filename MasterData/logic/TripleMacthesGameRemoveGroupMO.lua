-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/model/TripleMacthesGameRemoveGroupMO.lua

module("logic.extensions.triplemacthesgame.model.TripleMacthesGameRemoveGroupMO", package.seeall)

local TripleMacthesGameRemoveGroupMO = class("TripleMacthesGameRemoveGroupMO")

function TripleMacthesGameRemoveGroupMO:ctor()
	self.totalNum = 0
	self.maxCount1 = 0
	self.maxCount2 = 0
	self.mos = {}
	self.hasMatx = false
end

function TripleMacthesGameRemoveGroupMO:hasSpecial()
	return (self.hasMatx or self.maxCount1 > 3 or self.maxCount2 > 3 or self.totalNum >= 5) and #self.mos > 0
end

return TripleMacthesGameRemoveGroupMO
