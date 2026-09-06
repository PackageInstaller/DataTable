-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/model/SxGameSkillMO.lua

module("logic.extensions.sxgame.model.SxGameSkillMO", package.seeall)

local SxGameSkillMO = class("SxGameSkillMO")

function SxGameSkillMO:ctor()
	self._type = -1
	self._x = 0
	self._y = 0
end

return SxGameSkillMO
