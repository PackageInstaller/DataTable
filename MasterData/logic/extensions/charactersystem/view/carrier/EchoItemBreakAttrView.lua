-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoItemBreakAttrView.lua

module("logic.extensions.charactersystem.view.carrier.EchoItemBreakAttrView", package.seeall)

local M = class("EchoItemBreakAttrView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._index = nil
	self._data = nil
end

function M:_buildUI()
	self._attr = goutil.findChildTextComponent(self._mainGo, "txtBreakAttribute")

	local breakPointGo = goutil.findChild(self._mainGo, "break_point")

	self._breakPointView = Astral.LuaComponentContainer.Add(breakPointGo, EchoItemBreakPointView)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(data, echoMaxLv)
	self._data = data
	self._attr.text = data.desc

	local isBreak = data.level >= self._index

	self._breakPointView:setEchoItemLevel(self._index, echoMaxLv)
end

function M:setIndex(index)
	self._index = index
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._attr = nil
end

return M
