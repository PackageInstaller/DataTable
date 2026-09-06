-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/model/InstructionMo.lua

module("logic.extensions.shenjichallenge.model.InstructionMo", package.seeall)

local InstructionMo = class("InstructionMo")

function InstructionMo:ctor()
	self.name = ""
	self.desc = ""
	self.iconPath = ""
	self.posGo = nil
end

return InstructionMo
