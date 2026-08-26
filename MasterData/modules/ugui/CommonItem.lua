-- chunkname: @modules/ugui/CommonItem.lua

module("modules.ugui.CommonItem", package.seeall)

local CommonItem = class("CommonItem", LuaCompBase)

function CommonItem:init(go)
	CommonItem.super.init(self, go)
	logNormal("CommonItem:init...")

	self._gameObj = go
end

function LuaCompBase:addEventListeners()
	logNormal("CommonItem:addEventListeners...")
end

function LuaCompBase:removeEventListeners()
	logNormal("CommonItem:removeEventListeners...")
end

function CommonItem:onStart()
	logNormal("CommonItem:onStart...")

	self._updateCount = 0
end

function CommonItem:onUpdate()
	self._updateCount = self._updateCount + 1

	logNormal("CommonItem:onUpdate... self._updateCount = " .. self._updateCount)

	if self._updateCount >= 10 then
		MonoHelper.removeLuaComFromGo(self._gameObj, CommonItem)
		logNormal("CommonItem:onUpdate remove CommonItem-----")
	end
end

function CommonItem:onDestroy()
	logNormal("CommonItem:onDestroy...")
end

return CommonItem
