-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskProgressItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskProgressItem", package.seeall)

local CruiseSelfTaskProgressItem = class("CruiseSelfTaskProgressItem", LuaCompBase)

function CruiseSelfTaskProgressItem:init(go)
	self.go = go
	self._gonormal = gohelper.findChild(go, "go_normal")
	self._golight = gohelper.findChild(go, "go_light")
end

function CruiseSelfTaskProgressItem:refresh(index)
	self._index = index

	local finishedCount = Activity216Model.instance:getAllFinishedTaskCount()

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._gonormal, finishedCount < index)
	gohelper.setActive(self._golight, index <= finishedCount)
end

function CruiseSelfTaskProgressItem:destroy()
	return
end

return CruiseSelfTaskProgressItem
