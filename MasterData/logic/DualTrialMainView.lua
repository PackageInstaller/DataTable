-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialMainView.lua

module("logic.extensions.dualtrial.view.DualTrialMainView", package.seeall)

local DualTrialMainView = class("DualTrialMainView", ViewComponent)

function DualTrialMainView:ctor()
	DualTrialMainView.super.ctor(self)
end

function DualTrialMainView:unbindEvents()
	DualTrialMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFight)
end

function DualTrialMainView:bindEvents()
	DualTrialMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickbtnFight, self)
end

function DualTrialMainView:buildUI()
	DualTrialMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")

	local goTableview = self:getGo("prize/tableview")
	local goCell = self:getGo("prize/cell")

	self._tableview = ScrollerList.create(goTableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumProgress = self:getTxt("prize/progress/txtNum")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtNumTimes = self:getTxt("times/txtNum")
	self._btnFight = self:getGo("btnFight")
end

function DualTrialMainView:onExit()
	DualTrialMainView.super.onExit(self)
	self._tableview:dispose()
end

function DualTrialMainView:onEnter()
	DualTrialMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DualTrialGetInfo, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.DualTrialGainPrize, self._updatePrize, self)
	DualTrialController.instance:getInfo(self._activityId)
end

function DualTrialMainView:_onClickbtnTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function DualTrialMainView:_onClickbtnFight()
	if #self._blockCfgs <= self._curProgressNum then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if self._curLeftTime > 0 then
		UIStateManager.instance:push(ViewName.DualTrialVisitView, self._activityId)
	else
		FloatWordMgr.instance:show("今日已无巡逻次数")
	end
end

function DualTrialMainView:_updateUIByCfg()
	self._actCfg = DualTrialConfig.instance:getActivityCfgById(self._activityId)
	self._prizeCfgs = DualTrialConfig.instance:getPrizeCfgs(self._activityId)
	self._blockCfgs = DualTrialConfig.instance:getBlockCfgsById(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DualTrialMainView:_handleGetInfo()
	local info = DualTrialModel.instance:getInfoByActId(self._activityId)

	self:_updatePrize()

	local useTime = info and info.todayFinishBlockTimes

	self._curLeftTime = self._actCfg.dailyVisitTimes - checknumber(useTime)
	self._txtNumTimes.text = langPara("今日剩余<color=#20b376ff>%s</color>次", self._curLeftTime)
end

function DualTrialMainView:_updatePrize()
	local info = DualTrialModel.instance:getInfoByActId(self._activityId)

	if not info.finishVisiteBlockIds then
		self._curProgressNum = #info.finishVisiteBlockIds
		self._gainPrizeIds = info.gainPrizeIds or {}

		self._tableview:reloadData(self._prizeCfgs)

		self._txtNumProgress.text = self._curProgressNum

		local scoreList = {}

		for i, v in ipairs(self._prizeCfgs) do
			table.insert(scoreList, checknumber(v.finishBlocks))
		end

		self._tableview:updateUnderSlider(self._progressBar, self._curProgressNum, scoreList)
	end
end

function DualTrialMainView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtNum.text = data.finishBlocks

	MaterialMgr.setCellByCfg(data.content, cell.item)

	local isGain = table.keyof(self._gainPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._curProgressNum >= checknumber(data.finishBlocks)

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect, self:getGo("prize/tableview/viewport"))
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
	end

	goutil.setActive(cell.geted, isGain)
end

function DualTrialMainView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function DualTrialMainView:_playCellEffect(effGo, viewPortGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function DualTrialMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function DualTrialMainView:_onClickGainPrize(id)
	DualTrialController.instance:gainPrize(self._activityId, id)
end

return DualTrialMainView
