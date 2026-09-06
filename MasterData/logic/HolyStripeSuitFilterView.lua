-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitFilterView", package.seeall)

local HolyStripeSuitFilterView = class("HolyStripeSuitFilterView", ViewComponent)

function HolyStripeSuitFilterView:buildUI()
	HolyStripeSuitFilterView.super.buildUI(self)

	self._cellGo = self:getGo("suitFitlerRoot/tablecell")
	self._rootGo = self:getGo("suitFitlerRoot/tableview")
	self._selectAllBtn = self:getBtn("suitFitlerRoot/selectAll/btn")
	self._customInput = UICustomInput.Get(self:getGo("suitFitlerRoot"))
	self._selectAllUIChange = goutil.findChildComponent(self.mainGO, "suitFitlerRoot/selectAll", "UIChangeGroup")
end

function HolyStripeSuitFilterView:bindEvents()
	HolyStripeSuitFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._selectAllBtn:AddClickListener(self._onSelectAllBtnClick, self)
end

function HolyStripeSuitFilterView:unbindEvents()
	HolyStripeSuitFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._selectAllBtn:RemoveClickListener()
end

function HolyStripeSuitFilterView:onEnter()
	HolyStripeSuitFilterView.super.onEnter(self)

	self._tableview = ScrollerList.create(self._rootGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._params = self:getFirstParam()

	local list = HolyStripeModel.instance:getAllSuitList()

	if self._params then
		self._selectAllUIChange:SetState(0)
	else
		self._selectAllUIChange:SetState(1)
	end

	self._totalDoc = {}

	self:_updateList(list)
end

function HolyStripeSuitFilterView:onExit()
	HolyStripeSuitFilterView.super.onExit()

	for i, v in pairs(self._totalDoc) do
		v:dispose()
	end

	self._tableview:dispose()
end

function HolyStripeSuitFilterView:_updateList(list)
	self._tableview:reloadData(list)
end

function HolyStripeSuitFilterView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChange = go:GetComponent("UIChangeGroup")
	local con = goutil.findChild(go, "con")
	local icon = goutil.findChild(go, "icon")
	local txt = goutil.findChildTextComponent(go, "txt")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local btnGo = goutil.findChild(go, "raycast")
	local btn = GameUtil.asBtn(btnGo)
	local iconCfg = HolyStripeConfig.instance:getSuitInfo(data.type)
	local txtCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(data.type)
	local suitType1 = goutil.findChildTextComponent(go, "suitview/suititem/suitType")
	local suitdoc1 = goutil.findChildTextComponent(go, "suitview/suititem/doc")
	local suitType2 = goutil.findChildTextComponent(go, "suitview/suititem1/suitType")
	local suitdoc2 = goutil.findChildTextComponent(go, "suitview/suititem1/doc")

	if data.type == self._params then
		uiChange:SetState(1)
	else
		uiChange:SetState(0)
	end

	if iconCfg.cfg then
		MaterialMgr.setIcon(icon, MatType.HolyStripe, iconCfg.cfg.id)
	end

	txtName.text = iconCfg.name
	suitType1.text = langPara("x%s:", txtCfg[1].num)
	suitdoc1.text = lang(txtCfg[1].doc)
	suitType2.text = langPara("x%s:", txtCfg[2].num)
	suitdoc2.text = lang(txtCfg[2].doc)

	local suitDesc = ""

	for i, v in ipairs(txtCfg) do
		if not string.nilorempty(suitDesc) then
			suitDesc = string.format("%s\n", suitDesc)
		end

		suitDesc = string.format("%sx%s：%s", suitDesc, v.num, v.doc)
	end

	txt.text = suitDesc

	btn:AddClickListener(function()
		self:_onItemClick(data.type)
	end)
end

function HolyStripeSuitFilterView:_clearCell(cell)
	local go = cell.gameObject
	local btnGo = goutil.findChild(go, "raycast")
	local btn = GameUtil.asBtn(btnGo)
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
	btn:RemoveClickListener()
end

function HolyStripeSuitFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyStripeSuitFilterView:_onItemClick(itemType)
	GlobalDispatcher:dispatch(HolyStripeController.On_Select_FilterSuit, itemType)
	self:close()
end

function HolyStripeSuitFilterView:_onSelectAllBtnClick()
	self:_onItemClick(nil)
end

return HolyStripeSuitFilterView
