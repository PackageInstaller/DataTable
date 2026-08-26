-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/spine/TravelGoEntitySpine.lua

module("modules.logic.versionactivity3_7.travelgo.view.spine.TravelGoEntitySpine", package.seeall)

local TravelGoEntitySpine = class("TravelGoEntitySpine", TravelGoSpineComp)

function TravelGoEntitySpine:onSetData()
	self.cfg = self.entity.cfg
	self.dir = SpineLookDir.Left
	self.res = self.cfg.prefab
end

return TravelGoEntitySpine
