-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/model/WisdomAltarOneMo.lua

module("logic.extensions.wisdomaltar.model.WisdomAltarOneMo", package.seeall)

local WisdomAltarOneMo = class("WisdomAltarOneMo")

function WisdomAltarOneMo:ctor()
	self.petData = nil
	self.materials = nil
	self.goldCost = nil
end

return WisdomAltarOneMo
