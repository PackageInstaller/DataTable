-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialprimaryView.lua

module("logic.extensions.dragontrial.view.DragontrialprimaryView", package.seeall)

local DragontrialprimaryView = class("DragontrialprimaryView", ViewComponent)

function DragontrialprimaryView:ctor()
	DragontrialprimaryView.super.ctor(self)
end

function DragontrialprimaryView:unbindEvents()
	DragontrialprimaryView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnRaiders:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function DragontrialprimaryView:bindEvents()
	DragontrialprimaryView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRaiders:AddClickListener(self._onClickbtnRaiders, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DragontrialprimaryView:buildUI()
	DragontrialprimaryView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnRaiders = self:getBtn("btnRaiders")
	self._btnClose = self:getBtn("btnClose")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._goldBarConGo = self:getGo("goldBarCon")

	self:_buildItems()
end

function DragontrialprimaryView:_buildItems()
	local stageGo = self:getGo("stage")
	local stageCellGo = self:getGo("stage/btn")

	goutil.setActive(stageCellGo, false)

	self._stageItems = {}

	local activityId = DragontrialModel.instance:getCurrActivityId()
	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local stageCfgs = DragontrialConfig.instance:getStageCfgs(acfg.firstTrialId)

	for i = 1, #stageCfgs do
		local cell = goutil.cloneAndSetParent(stageCellGo, stageGo.transform)

		goutil.setActive(cell, true)
		Framework.TransformUtil.SetAnchoredPos(cell.transform, 250 * (i - 1) - 500, 0)

		local btn = Framework.ButtonAdapter.Get(cell)
		local goPass = goutil.findChild(cell, "pass")
		local goIcon = goutil.findChild(cell, "txtNum/icon")
		local txtName = goutil.findChildTextComponent(cell, "txtName")
		local txtNum = goutil.findChildTextComponent(cell, "txtNum")
		local bgChange = goutil.findChild(cell, "bg"):GetComponent(ComponentType.UIImageSpriteChange)

		self._stageItems[i] = {
			goPass = goPass,
			txtName = txtName,
			txtNum = txtNum,
			goIcon = goIcon,
			btn = btn,
			bgChange = bgChange
		}
	end
end

function DragontrialprimaryView:onExit()
	DragontrialprimaryView.super.onExit(self)

	for k, item in pairs(self._stageItems) do
		MaterialMgr.resetAll(item.goIcon)
	end

	removetimer(self._updateTimer, self)
end

function DragontrialprimaryView:onEnter()
	DragontrialprimaryView.super.onEnter(self)

	self._activityId = DragontrialModel.instance:getCurrActivityId()

	self:_setStageItems()
	self:_setActLeftTime()
	self:_setTopGoldBar()
end

function DragontrialprimaryView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("dragontrialprimary")
end

function DragontrialprimaryView:_onClickbtnRaiders()
	UIStateManager.instance:push(ViewName.DragontrailstrategyView, true)
end

function DragontrialprimaryView:_onClickbtnClose()
	self:close()
end

function DragontrialprimaryView:_setStageItems()
	local acfg = DragontrialConfig.instance:getActCfg(self._activityId)
	local stageCfgs = DragontrialConfig.instance:getStageCfgs(acfg.firstTrialId)

	for i, cfg in ipairs(stageCfgs) do
		local item = self._stageItems[i]
		local arr = string.split(cfg.firstPassPrize, ":")
		local matType = checkint(arr[1])
		local matId = checkint(arr[2])
		local matNum = checkint(arr[#arr])
		local isPass = DragontrialModel.instance:isFirstTrialPass(cfg.stage)

		goutil.setActive(item.goPass, isPass)
		MaterialMgr.setIcon(item.goIcon, matType, matId)

		item.txtName.text = cfg.showName
		item.txtNum.text = matNum

		item.bgChange:ChangeSprite(cfg.iconName)
		item.btn:AddClickListener(function()
			self:_onClickStageItem(cfg.planId, cfg.stage, acfg.firstTrialPetPlan)
		end)
	end
end

function DragontrialprimaryView:_onClickStageItem(planId, stageId, firstTrialPetPlan)
	DragontrialModel.instance:setFirstTrialStageId(stageId)
	UIStateManager.instance:push(ViewName.DragontrailMission, planId, stageId, firstTrialPetPlan)
end

function DragontrialprimaryView:_setActLeftTime()
	self._destTime = DragontrialModel.instance:getActEndTime()

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function DragontrialprimaryView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtTime.text = self._leftTime > 86400 and string.format("时间剩余：%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("时间剩余：%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function DragontrialprimaryView:_actEndOp()
	self._txtTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function DragontrialprimaryView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = "10:" .. self._activityId
	})
	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list, false)
end

return DragontrialprimaryView
