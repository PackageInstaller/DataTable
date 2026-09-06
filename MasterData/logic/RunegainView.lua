-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunegainView.lua

module("logic.extensions.rune.view.RunegainView", package.seeall)

local RunegainView = class("RunegainView", ViewComponent)

function RunegainView:ctor()
	RunegainView.super.ctor(self)
end

function RunegainView:buildUI()
	RunegainView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.txtTitle = self:getTxt("txtTitle")
	self.txtTip = self:getTxt("txtTip")
	self.scrollerList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self.upateCell, self))
end

function RunegainView:bindEvents()
	RunegainView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function RunegainView:unbindEvents()
	RunegainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function RunegainView:destroyUI()
	RunegainView.super.destroyUI(self)
end

function RunegainView:onEnter()
	RunegainView.super.onEnter(self)

	local param = self:getOpenParam()

	self.suitMo = param[1]
	self.isOtherView = param[2]

	self:refresh()
end

function RunegainView:onEnterFinished()
	RunegainView.super.onEnterFinished(self)
end

function RunegainView:onExit()
	RunegainView.super.onExit(self)

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	self.scrollerList:dispose()
end

function RunegainView:onExitFinished()
	RunegainView.super.onExitFinished(self)
end

function RunegainView:refresh()
	local mo = self.suitMo

	self.currSuitId = self.suitMo:getDefineId()

	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, self.currSuitId)

	self.txtTitle.text = cfg.name .. lang("增益")
	self.curCfg = nil

	local isOpen = FuncOpenModel.instance:getFuncIsOpen(cfg.unlockCondition)

	if not isOpen and not self.isOtherView then
		local openCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.unlockCondition)

		self.txtTip.text = FuncOpenController.instance:getLockTips(openCfg)
	elseif mo then
		local lvl, curCfg, star = mo:getCurLvl()

		self.curCfg = curCfg
		self.txtTip.text = lvl > 0 and "当前镶嵌星辉总等级为<color='#eb4642'>" .. star .. "级</color>，激活了<color='#eb4642'>" .. curCfg.name .. "</color>" or "当前镶嵌星辉总等级为<color='#eb4642'>" .. star .. "级</color>，未达到激活增益等级"
	end

	local list = RuneConfig.instance:getSuitEffById(self.currSuitId)

	self.scrollerList:reloadData(list)

	if self.curCfg then
		local idx = table.indexof(list, self.curCfg)

		if idx ~= false then
			self.scrollerList:MoveCellInView(idx - 1)
		end
	end
end

function RunegainView:upateCell(view, cell, data)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local col1 = goutil.findChild(cell, "txtName"):GetComponent("UITextColorChange")
	local col2 = goutil.findChild(cell, "txtLevel"):GetComponent("UITextColorChange")
	local col3 = goutil.findChild(cell, "txtDesc"):GetComponent("UITextColorChange")

	col1:SetState(0)
	col2:SetState(0)
	col3:SetState(0)

	txtName.text = data.name
	txtLevel.text = langPara("总等级<color='#eb4642'>%s级</color>后激活增益", data.needLevel)

	local arr = GameUtil.propToList({
		data.propertyApp
	})
	local str = ""

	for k, v in pairs(arr) do
		local tem = GameUtil.getValueOrPercent(v.value)

		str = str .. v.name .. ":<color=#00994d>+" .. tem .. "</color>\t"
	end

	txtDesc.text = str .. "\n" .. data.buff_desc

	GameUtil.SetActive(imgSelected, false)

	if self.curCfg then
		if data.needLevel == self.curCfg.needLevel then
			GameUtil.SetGray(cell, false)
			GameUtil.SetActive(imgSelected, true)
			col1:SetState(1)
			col2:SetState(1)
			col3:SetState(1)
			self:addEffect(cell)
		elseif data.needLevel < self.curCfg.needLevel then
			-- block empty
		end
	end
end

function RunegainView:addEffect(go)
	if self._fingerEff and self._fingerEff.parent ~= go.transform then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	if self._fingerEff == nil then
		local name = "fx_ui_runeview/fx_ui_runegainview_activationeffects.prefab"
		local light = UIEffectManager.instance:playEffect(self, name, go, 0, 0, true, nil, function()
			return
		end, function(ta, eff)
			eff:setScrollRectClipping(self.tableview:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		end)

		light:setParent(go.transform)
		light:setScale(1)

		self._fingerEff = light
	end
end

return RunegainView
