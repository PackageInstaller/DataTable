-- chunkname: @modules/logic/help/view/HelpSelectItem.lua

module("modules.logic.help.view.HelpSelectItem", package.seeall)

local HelpSelectItem = class("HelpSelectItem", LuaCompBase)

function HelpSelectItem:ctor(propObj)
	return
end

function HelpSelectItem:init(param)
	self._go = param.go
	self._pageIndex = param.index
	self._config = param.config
	self._selectGos = {}

	for i = 1, 2 do
		local go = gohelper.findChild(self._go, "item" .. tostring(i))

		table.insert(self._selectGos, go)
	end

	transformhelper.setLocalPos(self._go.transform, param.pos, 0, 0)
end

function HelpSelectItem:updateItem()
	local isTarget = self._pageIndex == HelpModel.instance:getTargetPageIndex()

	gohelper.setActive(self._selectGos[1], isTarget)
	gohelper.setActive(self._selectGos[2], not isTarget)
end

function HelpSelectItem:addEventListeners()
	return
end

function HelpSelectItem:removeEventListeners()
	return
end

function HelpSelectItem:destroy()
	return
end

return HelpSelectItem
