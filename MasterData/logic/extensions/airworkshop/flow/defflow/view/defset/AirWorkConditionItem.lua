-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkConditionItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkConditionItem", package.seeall)

local M = class("AirWorkConditionItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._contentTxt = goutil.findChild(self.mainGO, "txtContent")
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

function M:updateData(mo)
	self._mo = mo

	goutil.setActive(self._normalGo, self._mo.created)
	goutil.setActive(self._noneGo, not self._mo.created and self._mo.unLock)
	goutil.setActive(self._lockGo, not self._mo.unLock)

	if self._mo.created then
		goutil.setActive(self._passTestGo, self._mo.data:getPassTest())
		goutil.setActive(self._putOnGo, self._mo.data:getOnlineStatus())
	end
end

function M:setSeleted(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function M:_onClick()
	if self._mo.created then
		printWarn("=====已有关卡======")
	elseif self._mo.unLock then
		AirWorkShopDefMgr.instance:createMapAndEnter()
		printWarn("======这里打开创建界面======")
	else
		FloatWordMgr.instance:show(lang("tip_airwork_cannot_create_with_locked"))
	end

	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_MANAGER_RIGHT_UPDATE, self._mo)
end

return M
