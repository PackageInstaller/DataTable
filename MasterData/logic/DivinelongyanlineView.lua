-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanlineView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanlineView", package.seeall)

local DivinelongyanlineView = class("DivinelongyanlineView", ViewComponent)

function DivinelongyanlineView:ctor()
	DivinelongyanlineView.super.ctor(self)
end

function DivinelongyanlineView:unbindEvents()
	DivinelongyanlineView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function DivinelongyanlineView:bindEvents()
	DivinelongyanlineView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivinelongyanlineView:buildUI()
	DivinelongyanlineView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtTip = self:getTxt("tipsCol/txt")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime/txt")
end

function DivinelongyanlineView:onExit()
	DivinelongyanlineView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinelongyanlineView:onEnter()
	DivinelongyanlineView.super.onEnter(self)

	self._activityId = DivinelongyanModel.instance:getActivityId()
	self._actCfg = DivinelongyanConfig.instance:getActCfg(self._activityId)

	local cfgs = DivinelongyanConfig.instance:getLineStageCfgs(self._activityId)

	self._stageId = DivinelongyanModel.instance:getCurLineStageId(self._activityId)

	self._scrollerList:reloadData(cfgs)
	self._scrollerList:MoveCellToBegin(self._stageId - 1)
	self:_setRule()
	self:_setActTime()
end

function DivinelongyanlineView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goMask = goutil.findChild(cell.gameObject, "mask")
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local itemcon = goutil.findChild(cell.gameObject, "reward/itemcon")
	local goGain = goutil.findChild(cell.gameObject, "reward/gain")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "mask/txtLock")
	local pass = goutil.findChildTextComponent(cell.gameObject, "mask/pass")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtPower = goutil.findChildTextComponent(cell.gameObject, "txtPower")
	local raceId = cfg.raceId
	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	if not modelCo then
		printError("t_model id not exist:", raceId)
	else
		uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	local isOpen = false

	if string.nilorempty(cfg.openTime) then
		isOpen = true
	else
		local time = GameUtil.string2time(cfg.openTime)

		isOpen = time <= ServerTime.now()
	end

	txtName.text = cfg.name
	txtPower.text = checknumber(cfg.zdlShow)

	MaterialMgr.resetAll(itemcon)
	MaterialMgr.setCellByCfg(cfg.prize, itemcon)

	local isPass = self._stageId >= cfg.stageId

	goutil.setActive(goMask, isPass or not isOpen)
	goutil.setActive(goGain, false)
	goutil.setActive(pass, isPass)

	txtLock.text = ""

	if not isOpen then
		local date = GameUtil.string2date(cfg.openTime)

		txtLock.text = string.format("%s年%s月%s日开启", date.year, date.month, date.day)
	end

	btn:AddClickListener(function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		if not isOpen then
			FloatWordMgr.instance:show(txtLock.text)

			return
		end

		if cfg.stageId > self._stageId + 1 then
			FloatWordMgr.instance:show(string.format("先通关第%s关", cfg.stageId - 1))

			return
		end

		DivinelongyanController.instance:enterMission(self._activityId, GameEnum.DivineLongyanClgType.Line, cfg.creepsMasterId)
	end)
end

function DivinelongyanlineView:_clearCell(cell)
	local itemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(itemcon)
end

function DivinelongyanlineView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("DivinelongyanlineView_rule")
end

function DivinelongyanlineView:_onClickbtnClose()
	self:close()
end

function DivinelongyanlineView:_setRule()
	self._txtTip.text = self._actCfg.lineStageRuleDesc
end

function DivinelongyanlineView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

return DivinelongyanlineView
