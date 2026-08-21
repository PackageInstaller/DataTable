-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackD6FilterTabView2.lua

module("logic.extensions.backpack.view.BackpackD6FilterTabView2", package.seeall)

local M = class("BackpackD6FilterTabView2")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._btnNormal = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "normal"))
	self._btnSelect = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "select"))
	self._txtNormal = goutil.findChildTextComponent(self._mainGo, "normal/Text")
	self._txtSelect = goutil.findChildTextComponent(self._mainGo, "select/Text")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
end

function M:_unbindEvents()
	self._btnNormal:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
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

function M:setTextStr(str)
	self._txtNormal.text = str
	self._txtSelect.text = str
end

function M:setIsNormal(isNormal)
	self._btnNormal.gameObject:SetActive(isNormal)
end

function M:setIsSelect(isSelect)
	self._btnSelect.gameObject:SetActive(isSelect)
end

return M
