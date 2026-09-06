-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelmainView.lua

module("logic.extensions.goodfeel.view.GoodfeelmainView", package.seeall)

local GoodfeelmainView = class("GoodfeelmainView", ViewComponent)

GoodfeelmainView.TabType = {
	AdressList = 2,
	Temp = 3,
	Chat = 1
}

function GoodfeelmainView:ctor()
	GoodfeelmainView.super.ctor(self)
end

function GoodfeelmainView:buildUI()
	GoodfeelmainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._chatTab = self:getBtn("tabCon/chatTab")
	self._adressListTab = self:getBtn("tabCon/adressListTab")
	self._tempTab = self:getBtn("tabCon/tempTab")
	self._adressListTabDot = self:getGo("tabCon/adressListTab/dot")
	self._chatTabChange = self._chatTab.gameObject:GetComponent(typeof(UIChangeGroup))
	self._adressListTabChange = self._adressListTab.gameObject:GetComponent(typeof(UIChangeGroup))
	self._tempTabChange = self._tempTab.gameObject:GetComponent(typeof(UIChangeGroup))
	self._subCon = self:getGo("subCon")
	self._effectGo = self:getGo("effect")
	self._txtDefendNum = self:getTxt("Attribute/defend/txtNum")
	self._txtMagicNum = self:getTxt("Attribute/magic/txtNum")
	self._txtAttackNum = self:getTxt("Attribute/attack/txtNum")
	self._txtHpNum = self:getTxt("Attribute/life/txtNum")
end

function GoodfeelmainView:bindEvents()
	GoodfeelmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._chatTab:AddClickListener(self._onClickChatTab, self)
	self._adressListTab:AddClickListener(self._onClickAdressListTab, self)
	self._tempTab:AddClickListener(self._onClickTempTab, self)
	RedPointController.instance:regRedPoint(self._adressListTabDot, RedPointModel.ID_GOODFEEL)
end

function GoodfeelmainView:unbindEvents()
	GoodfeelmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._chatTab:RemoveClickListener()
	self._adressListTab:RemoveClickListener()
	self._tempTab:RemoveClickListener()
	RedPointController.instance:unregRedPoint(self._adressListTabDot)
end

function GoodfeelmainView:destroyUI()
	GoodfeelmainView.super.destroyUI(self)
end

function GoodfeelmainView:onEnter()
	GoodfeelmainView.super.onEnter(self)

	local openTab = self:getFirstParam() or GoodFeelModel.instance:getJumpMainViewTab() or GoodfeelmainView.TabType.AdressList

	self:_switchTab(openTab, true)
	self:_setEffect()
	self:_setAttrs()
end

function GoodfeelmainView:onEnterFinished()
	GoodfeelmainView.super.onEnterFinished(self)
end

function GoodfeelmainView:onExit()
	GoodfeelmainView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandle)
end

function GoodfeelmainView:onExitFinished()
	GoodfeelmainView.super.onExitFinished(self)
end

function GoodfeelmainView:_onClickChatTab()
	self:_switchTab(GoodfeelmainView.TabType.Chat)
end

function GoodfeelmainView:_onClickAdressListTab()
	self:_switchTab(GoodfeelmainView.TabType.AdressList)
end

function GoodfeelmainView:_onClickTempTab()
	self:_switchTab(GoodfeelmainView.TabType.Temp)
end

function GoodfeelmainView:_switchTab(tab, force)
	if tab == GoodfeelmainView.TabType.Temp then
		FloatWordMgr.instance:show("敬请期待")

		return
	end

	if tab == self._currTabType and not force then
		return
	end

	self._currTabType = tab

	self:_updateTabState(tab)
	self:_updateView(tab)
end

function GoodfeelmainView:_updateTabState(tab)
	self._chatTabChange:SetState(tab == GoodfeelmainView.TabType.Chat and 1 or 0)
	self._adressListTabChange:SetState(tab == GoodfeelmainView.TabType.AdressList and 1 or 0)
	self._tempTabChange:SetState(tab == GoodfeelmainView.TabType.Temp and 1 or 0)
end

function GoodfeelmainView:_updateView(tab)
	local viewName = ""

	if tab == GoodfeelmainView.TabType.Chat then
		viewName = ViewName.GoodfeelchatView
	elseif tab == GoodfeelmainView.TabType.AdressList then
		viewName = ViewName.GoodfeeladdressbookView
	end

	if not string.nilorempty(viewName) then
		self:showTabAt(self._subCon, viewName)
	end
end

function GoodfeelmainView:_checkRedDot()
	return
end

function GoodfeelmainView:_onClickClose()
	GoodFeelModel.instance:setJumpMainViewTab()
	self:close()
end

function GoodfeelmainView:_setEffect()
	self._effectHandle = UIEffectManager.instance:playEffect(self, "fx_ui_haogandu/fx_ui_haogandu_dian.prefab", nil, nil, nil, true)

	self._effectHandle:setParent(self._effectGo.transform)
	self._effectHandle:setScale(1)
	self._effectHandle:setLocalPos(0, 0, 0)
end

function GoodfeelmainView:_setAttrs()
	self._txtDefendNum.text = GoodFeelModel.instance:getLvAttrValueByAttrType(GameEnum.AttrType.DefensePhysical)
	self._txtMagicNum.text = GoodFeelModel.instance:getLvAttrValueByAttrType(GameEnum.AttrType.DefenseMagic)
	self._txtAttackNum.text = GoodFeelModel.instance:getLvAttrValueByAttrType(GameEnum.AttrType.Attack)
	self._txtHpNum.text = GoodFeelModel.instance:getLvAttrValueByAttrType(GameEnum.AttrType.Hp)
end

return GoodfeelmainView
