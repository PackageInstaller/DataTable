-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkTextItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkTextItem", package.seeall)

local M = class("AirWorkTextItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._contentTxt = goutil.findChildComponent(self.mainGO, "txtContent", UIComponentType.TextMeshProUGUI)

	if not self._contentTxt then
		self._contentTxt = goutil.findChildTextComponent(self.mainGO, "txtContent")
	end

	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btnClick = Astral.ButtonAdapter.Get(self.mainGO)

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

function M:setContentAndIndex(content, idx)
	self._contentTxt.text = content
	self._idx = idx
end

function M:setSeleted(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._idx)
	end
end

return M
