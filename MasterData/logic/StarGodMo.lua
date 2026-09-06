-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/model/StarGodMo.lua

module("logic.extensions.stargod.model.StarGodMo", package.seeall)

local StarGodMo = class("StarGodMo")

function StarGodMo:ctor()
	self.id = 0
	self.defineId = 0
	self.levelId = 1
	self.curExp = 0
	self.place = 0
end

function StarGodMo:getDefineId()
	return self.defineId
end

return StarGodMo
