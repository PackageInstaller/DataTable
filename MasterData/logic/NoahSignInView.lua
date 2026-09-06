-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/NoahSignInView.lua

module("logic.extensions.operationsignin.view.NoahSignInView", package.seeall)

local NoahSignInView = class("NoahSignInView", ViewComponent)

function NoahSignInView:ctor()
	NoahSignInView.super.ctor(self)

	self.activityId = 18016
	self.cfg_checkin = OperationSignInConfig.instance:getSignInCfgList(self.activityId)
	self.cfg_show = OperationSignInConfig.instance:getSignInShowCfgsByActId(self.activityId)
end

function NoahSignInView:buildUI()
	NoahSignInView.super.buildUI(self)

	self.signinCells = self:getGo("signinCells")
	self.btnClose = self:getBtn("btnClose")
	self.time = self:getGo("txtLeftTime")
	self.timeText = self:getTxt("txtLeftTime")
	self.maskBlock = self:getGo("MaskBlock")
	self.effectGo = self:getGo("effect")
	self.signCellList = {}
	self.signCellNum = 8
	self.effect = nil

	self:_buildAllSignCell()
end

function NoahSignInView:bindEvents()
	NoahSignInView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self._onClickBtnClose, self)

	for _, data in ipairs(self.cfg_checkin) do
		local cell = self.signCellList[data.day]

		if cell ~= nil then
			GameUtil.addClickHandler(cell.btnSignin, GameUtil.handler(self._onClickBtnSignInReward, self, cell, data))
		end
	end
end

function NoahSignInView:unbindEvents()
	NoahSignInView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)

	for _, cell in pairs(self.signCellList) do
		GameUtil.rmClickHandler(cell.btnSignin)
	end
end

function NoahSignInView:destroyUI()
	NoahSignInView.super.destroyUI(self)
	MaterialMgr.resetAll(self.mainGo)

	for _, cell in pairs(self.signCellList) do
		UIEffectManager.instance:stopEffect(cell.eff)
	end

	UIEffectManager.instance:stopEffect(self.effect)
end

function NoahSignInView:onEnter()
	NoahSignInView.super.onEnter(self)
	OperationSignInModel.instance:setActivityId(self.activityId)
	self:_setPanelUI()
	GlobalDispatcher:addListener(GlobalNotify.OperationSignIn, self._updateAllSignCell, self)
	OperationSignInController.instance:getInfo()
	self:_updateAllSignCell()
end

function NoahSignInView:onExit()
	NoahSignInView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OperationSignIn, self._updateAllSignCell, self)

	for _, cell in pairs(self.signCellList) do
		uGuiUtil.clearImage(cell.item)
	end
end

function NoahSignInView:_buildAllSignCell()
	for _, data in ipairs(self.cfg_checkin) do
		self.signCellList[data.day] = self:_buildSignCell(data) or printError("exceed cell num, day is:" .. data.day)
	end
end

function NoahSignInView:_buildSignCell(data)
	local cell = {}

	cell.mainGo = goutil.findChild(self.signinCells, "cell" .. data.day)

	if cell.mainGo == nil then
		return nil
	end

	cell.bg = goutil.findChild(cell.mainGo, "bg")
	cell.item = goutil.findChild(cell.mainGo, "itemCell")
	cell.btnSignin = goutil.findChild(cell.mainGo, "btnSignin")
	cell.markHasGain = goutil.findChild(cell.mainGo, "markHasGain")
	cell.txt1 = goutil.findChildTextComponent(cell.mainGo, "txt1")
	cell.txt2 = goutil.findChildTextComponent(cell.mainGo, "txt2")
	cell.txtDay = goutil.findChildTextComponent(cell.mainGo, "txtDay")
	cell.txtNum = goutil.findChildTextComponent(cell.mainGo, "txtNum")
	cell.effGo = goutil.findChild(cell.mainGo, "eff")
	cell.data = data
	cell.eff = nil

	return cell
end

function NoahSignInView:_setPanelUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn, self.activityId)
	local startT, endT = os.date("*t", startTime), os.date("*t", endTime)

	self.timeText.text = string.format("活动时间:%d月%d日%02d:%02d - %d月%d日%02d:%02d", startT.month, startT.day, startT.hour, startT.min, endT.month, endT.day, endT.hour, endT.min)

	UIEffectManager.instance:stopEffect(self.effect)

	local path = "fx_ui_yaoqinghan/fx_ui_yaoqinghan.prefab"
	local eff = UIEffectManager.instance:playEffect(self, path, self.effectGo, 0, 0, true, false, nil, nil)

	eff:setParent(self.effectGo.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)

	self.effect = eff

	for _, cell in pairs(self.signCellList) do
		self:_setCell(cell)
	end
end

function NoahSignInView:_setCell(cell)
	local data = cell.data

	if not string.nilorempty(data.entranceBgName) then
		local bgUrl = string.format("ui/bigbg/operationsignin/%s.png", data.entranceBgName)

		uGuiUtil.setSpriteToImage(cell.item, uGuiUtil.SpriteType.BigBg, bgUrl)
	else
		printError("缺失签到入口背景底图配置")
	end
end

function NoahSignInView:_updateAllSignCell()
	for _, cell in pairs(self.signCellList) do
		self:_updateSignCell(cell)
	end
end

function NoahSignInView:_updateSignCell(cell)
	if cell == nil then
		printError("cell is nil")

		return
	end

	local data = cell.data
	local onlineDay = OperationSignInModel.instance:getOnlineDay() or -1
	local daysList = OperationSignInModel.instance:getDaysList()
	local isCanGain = not daysList[data.day] and onlineDay >= data.day
	local isHasGain = daysList[data.day]

	goutil.setActive(cell.markHasGain, isHasGain)
	goutil.setActive(cell.effGo, false)
	UIEffectManager.instance:stopEffect(cell.eff)

	if isCanGain then
		local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setParent(cell.effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScaleXYZ(2, 1.05, 1)
			eff:setClipping(cell.effGo:GetComponent(goutil.Type_RectTransform))
		end

		self.signCellList[data.day].eff = UIEffectManager.instance:playEffect(self, path, cell.effGo, 0, 0, true, false, nil, func, nil)

		goutil.setActive(cell.effGo, true)
	end
end

function NoahSignInView:_onClickBtnSignInReward(cell, data)
	UIStateManager.instance:push(ViewName.NoahSignInPopupView, data)
end

function NoahSignInView:_onClickBtnClose()
	self:close()
end

return NoahSignInView
