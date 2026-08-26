-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NewWelfareProgressPointItem.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NewWelfareProgressPointItem", package.seeall)

local VersionActivity3_8NewWelfareProgressPointItem = class("VersionActivity3_8NewWelfareProgressPointItem", LuaCompBase)

function VersionActivity3_8NewWelfareProgressPointItem:init(go, index)
	self._go = go
	self._index = index
	self._godark = gohelper.findChild(go, "dark")
	self._golight = gohelper.findChild(go, "light")

	self:_initItem()
	self:_addEvents()
end

function VersionActivity3_8NewWelfareProgressPointItem:_initItem()
	self._actId = ActivityEnum.Activity.NewWelfare
end

function VersionActivity3_8NewWelfareProgressPointItem:_addEvents()
	return
end

function VersionActivity3_8NewWelfareProgressPointItem:_removeEvents()
	return
end

function VersionActivity3_8NewWelfareProgressPointItem:refresh(co)
	self._co = co
	self.id = co.id

	self:_refreshItem()
end

function VersionActivity3_8NewWelfareProgressPointItem:_refreshItem()
	local isFinish = Activity160Model.instance:isMissionFinish(self._actId, self.id)
	local canGet = Activity160Model.instance:isMissionCanGet(self._actId, self.id)
	local show = isFinish or canGet

	gohelper.setActive(self._godark, not show)
	gohelper.setActive(self._golight, show)
end

function VersionActivity3_8NewWelfareProgressPointItem:destroy()
	self:_removeEvents()
end

return VersionActivity3_8NewWelfareProgressPointItem
