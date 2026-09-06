-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/HuaweialertView.lua

module("logic.extensions.systemsetting.view.HuaweialertView", package.seeall)

local HuaweialertView = class("HuaweialertView", ViewComponent)

function HuaweialertView:ctor()
	HuaweialertView.super.ctor(self)
end

function HuaweialertView:unbindEvents()
	HuaweialertView.super.unbindEvents(self)
	self._toggleAdapter:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._closeBtn)
end

function HuaweialertView:bindEvents()
	HuaweialertView.super.bindEvents(self)

	for i, btn in ipairs(self._btns) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onBtnClick, self, i))
	end

	GameUtil.addClickHandler(self._closeBtn, self.close, self)
	self._toggleAdapter:AddOnValueChanged(self._onToggleChange, self)
end

function HuaweialertView:buildUI()
	HuaweialertView.super.buildUI(self)

	self._closeBtn = self:getGo("Nego_Main/Btn_Close")
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "Nego_Main/ScrollView/Viewport/Content/Content")
	self._scrollviewImg = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("Image")
	self._scrollviewTr = goutil.findChild(self.mainGO, "Nego_Main/ScrollView").transform
	self._scroll = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("ScrollRect")
	self._titleTxt = goutil.findChild(self.mainGO, "Nego_Main/Txt_Title"):GetComponent("Text")
	self._btns = {}
	self._btnTexts = {}
	self._validX = false

	for i = 1, 3 do
		local go = self:getGo("Nego_Main/Btns/Btn" .. tostring(i))

		table.insert(self._btns, go)
	end

	self._toggleAdapter = self:getToggle("Nego_Main/ScrollView/Viewport/Content/tog/Toggle")
	self._toggle = goutil.findChild(self.mainGO, "Nego_Main/ScrollView/Viewport/Content/tog/Toggle"):GetComponent("Toggle")
	self._toggleTxt = goutil.findChild(self.mainGO, "Nego_Main/ScrollView/Viewport/Content/tog/Toggle/Label"):GetComponent("Text")
	self._toggleFunc = nil
end

function HuaweialertView:onExit()
	HuaweialertView.super.onExit(self)
end

function HuaweialertView:onEnter()
	HuaweialertView.super.onEnter(self)

	self._toggle.isOn = false
	self._txt.text = lang("zhuxiao_popup_2")

	self:_onToggleChange()

	self._scroll.verticalNormalizedPosition = 1
end

function HuaweialertView:_onToggleChange()
	GameUtil.SetGray(self._btns[1], not self._toggle.isOn)
end

function HuaweialertView:_onBtnClick(idx)
	if idx == 1 then
		if self._toggle.isOn then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("zhuxiao_popup_3"), function()
				RoleAgent.instance:sendPM_CloseUserReq()
				self:close()
			end)
		else
			TipsFacade.instance:openCommonTips("请仔细阅读完协议，并且勾选底部同意后继续此操作")
		end
	else
		self:close()
	end
end

return HuaweialertView
