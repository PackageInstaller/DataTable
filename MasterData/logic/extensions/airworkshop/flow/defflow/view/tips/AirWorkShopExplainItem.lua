-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/AirWorkShopExplainItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.AirWorkShopExplainItem", package.seeall)

local M = class("AirWorkShopExplainItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "normal"))
	self._goSelect = goutil.findChild(self.mainGO, "select")
	self._name1Txt = goutil.findChildTextComponent(self.mainGO, "select/layout/txtTitle")
	self._name2Txt = goutil.findChildTextComponent(self.mainGO, "normal/layout/txtTitle")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:setData(content, index)
	self._index = index
	self._content = content

	self:_updateView()
end

function M:_updateView()
	self._name1Txt.text = self._content
	self._name2Txt.text = self._content
end

function M:setSeleted(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._index)
	end
end

return M
