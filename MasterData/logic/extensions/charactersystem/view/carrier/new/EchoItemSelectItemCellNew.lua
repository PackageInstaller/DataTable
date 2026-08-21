-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemSelectItemCellNew.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemSelectItemCellNew", package.seeall)

local M = class("EchoItemSelectItemCellNew", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._goSelect3 = goutil.findChild(compContainer.gameObject, "imgSelect3").gameObject
end

function M:OnDestroy()
	M.super.OnDestroy(self)

	self._dealSelectFunc = nil
	self._dealSelectHandler = nil
	self._goSelect3 = nil
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("echo", EchoItemCellComponet)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("operate", BackpackOperateComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("sign", ItemSignComponent)
	self:_addComponent("preset", PresetComponent)
end

function M:setVisible(visible)
	goutil.setActive(self._go, visible)
end

function M:setSign(sign)
	local comp = self:getComponent("sign")

	if comp then
		comp:showSingle(sign)
	end
end

function M:setDealSelectFunc(func, handler)
	self._dealSelectFunc = func
	self._dealSelectHandler = handler
end

function M:dealSelect()
	if self._dealSelectFunc then
		if self._dealSelectHandler then
			self._dealSelectFunc(self._dealSelectHandler, self._data)
		else
			self._dealSelectFunc(self._data)
		end
	end
end

function M:onSelect(isSelected, pageTyp)
	local operateComp = self:getComponent("operate")

	goutil.setActive(self._goSelect3, isSelected)
	operateComp:setCountGoVisible(false)

	if pageTyp == EchoItemMainViewNew.SubViewType.Change then
		operateComp:setImgOperateGoVisible(false)
		operateComp:setBtnCutGoVisible(false)
	else
		operateComp:setImgOperateGoVisible(isSelected)
		operateComp:setBtnCutGoVisible(isSelected)
	end
end

function M:unSelect()
	self:dealSelect()
end

return M
