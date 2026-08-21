-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackFilterTabView.lua

module("logic.extensions.backpack.view.BackpackFilterTabView", package.seeall)

local M = class("BackpackFilterTabView")
local TabItemStatus = CommEnum.BackPackFilterItemStatus

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnNormal = self._registry:getBtn("backpack_filter_tab_1785765552")
	self._btnSelect = self._registry:getBtn("backpack_filter_tab_-422853842")
	self._btnSpecial = self._registry:getBtn("backpack_filter_tab_-2070274911")
	self._txtNormal = self._registry:getText("backpack_filter_tab_948426928")
	self._txtSelect = self._registry:getText("backpack_filter_tab_-1761907623")
	self._txtSpecial = self._registry:getText("backpack_filter_tab_585159075")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnSpecial:AddClickListener(self._onClickSpecial, self)
end

function M:_unbindEvents()
	self._btnNormal:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnSpecial:RemoveClickListener()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:setParam(param)
	self._param = param
end

function M:_onClickNormal()
	if self._param.normalCallback then
		self._param.normalCallback()
	end
end

function M:_onClickSelect()
	if self._param.selectCallback then
		self._param.selectCallback()
	end
end

function M:_onClickSpecial()
	if self._param.specialCallback then
		self._param.specialCallback()
	end
end

function M:setTextStr(str)
	self._txtNormal.text = str
	self._txtSelect.text = str
	self._txtSpecial.text = str
end

function M:setTabStatus(status)
	self._status = status

	self._btnNormal.gameObject:SetActive(status == TabItemStatus.Normal)
	self._btnSelect.gameObject:SetActive(status == TabItemStatus.Select)
	self._btnSpecial.gameObject:SetActive(status == TabItemStatus.Disable)
end

function M:getTabStatus()
	return self._status
end

return M
