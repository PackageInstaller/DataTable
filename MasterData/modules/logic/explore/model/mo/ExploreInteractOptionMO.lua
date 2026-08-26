-- chunkname: @modules/logic/explore/model/mo/ExploreInteractOptionMO.lua

module("modules.logic.explore.model.mo.ExploreInteractOptionMO", package.seeall)

local ExploreInteractOptionMO = class("ExploreInteractOptionMO")

function ExploreInteractOptionMO:ctor(optionTxt, optionCallBack, optionCallObj, unit, isClient)
	self.optionTxt = optionTxt
	self.optionCallBack = optionCallBack
	self.optionCallObj = optionCallObj
	self.unit = unit
	self.isClient = isClient
end

return ExploreInteractOptionMO
