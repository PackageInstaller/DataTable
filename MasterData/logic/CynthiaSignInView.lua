-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/CynthiaSignInView.lua

module("logic.extensions.operationsignin.view.CynthiaSignInView", package.seeall)

local CynthiaSignInView = class("CynthiaSignInView", ViewComponent)

function CynthiaSignInView:ctor()
	CynthiaSignInView.super.ctor(self)

	self.activityId = 18014
	self.cfg_checkin = OperationSignInConfig.instance:getSignInCfgList(self.activityId)
	self.cfg_show = OperationSignInConfig.instance:getSignInShowCfgsByActId(self.activityId)
end

function CynthiaSignInView:buildUI()
	CynthiaSignInView.super.buildUI(self)

	self.signinCells = self:getGo("signinCells")
	self.btnClose = self:getBtn("btnClose")
	self.time = self:getGo("txtLeftTime")
	self.timeText = self:getTxt("txtLeftTime")
	self.maskBlock = self:getGo("MaskBlock")
	self.effectGo = self:getGo("effect")

	goutil.setActive(self.signinCells, true)
	goutil.setActive(self.time, true)
	goutil.setActive(self.effectGo, true)
	goutil.setActive(self.maskBlock, false)

	self.signCellList = {}
	self.signCellNum = 8
	self.curDay = nil
	self.effect = nil

	self:_buildAllSignCell()
end

function CynthiaSignInView:bindEvents()
	CynthiaSignInView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self._onClickBtnClose, self)

	for _, data in ipairs(self.cfg_checkin) do
		local cell = self.signCellList[data.day]

		if cell ~= nil then
			GameUtil.addClickHandler(cell.btnSignin, GameUtil.handler(self._onClickBtnSignInReward, self, cell, data))
		end
	end
end

function CynthiaSignInView:unbindEvents()
	CynthiaSignInView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)

	for _, cell in pairs(self.signCellList) do
		GameUtil.rmClickHandler(cell.btnSignin)
	end
end

function CynthiaSignInView:destroyUI()
	CynthiaSignInView.super.destroyUI(self)
	MaterialMgr.resetAll(self.mainGo)

	for _, cell in pairs(self.signCellList) do
		UIEffectManager.instance:stopEffect(cell.eff)
	end

	UIEffectManager.instance:stopEffect(self.effect)
end

function CynthiaSignInView:onEnter()
	CynthiaSignInView.super.onEnter(self)
	OperationSignInModel.instance:setActivityId(self.activityId)
	self:_setPanelUI()
	GlobalDispatcher:addListener(GlobalNotify.OperationSignIn, self._updateAllSignCell, self)
	OperationSignInController.instance:getInfo()
	self:_updateAllSignCell()
end

function CynthiaSignInView:onExit()
	CynthiaSignInView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OperationSignIn, self._updateAllSignCell, self)
end

function CynthiaSignInView:_buildAllSignCell()
	for _, data in ipairs(self.cfg_checkin) do
		self.signCellList[data.day] = self:_buildSignCell(data.day) or print("test+ nil day:" .. data.day)
	end
end

function CynthiaSignInView:_buildSignCell(day)
	local cell = {}

	cell.mainGo = goutil.findChild(self.signinCells, "cell" .. day)

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
	cell.day = day
	cell.eff = nil

	cell.effGo.transform:SetParent(cell.item.transform)
	GameUtil.setLocalPos(cell.effGo, 0, 0, 0)
	goutil.setActive(cell.bg, true)
	goutil.setActive(cell.item, true)
	goutil.setActive(cell.txt1.gameObject, true)
	goutil.setActive(cell.txt2.gameObject, true)
	goutil.setActive(cell.txtDay.gameObject, true)
	goutil.setActive(cell.txtNum.gameObject, true)
	goutil.setActive(cell.btnSignin, false)
	goutil.setActive(cell.effGo, false)

	return cell
end

function CynthiaSignInView:_setPanelUI()
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
end

function CynthiaSignInView:_updateAllSignCell()
	for _, data in ipairs(self.cfg_checkin) do
		local cell = self.signCellList[data.day]

		self:_updateSignCell(cell, data)
	end
end

function CynthiaSignInView:_updateSignCell(cell, data)
	if cell == nil then
		return
	end

	local arr = string.split(data.reward, ":")
	local mayType = checknumber(arr[1])
	local defineId = checknumber(arr[2])
	local rewardNum = checknumber(arr[3])
	local cfgStr = mayType .. ":" .. defineId .. ":" .. "0"

	MaterialMgr.setCellByCfg(cfgStr, cell.item)

	cell.txtNum.text = "X" .. rewardNum
	cell.txtDay.text = data.day

	local onlineDay = OperationSignInModel.instance:getOnlineDay() or -1
	local daysList = OperationSignInModel.instance:getDaysList()
	local isCanGain = not daysList[data.day] and onlineDay >= data.day
	local isHasGain = daysList[data.day]

	goutil.setActive(cell.markHasGain, isHasGain)
	goutil.setActive(cell.btnSignin, isCanGain)
	goutil.setActive(cell.effGo, false)

	if isCanGain then
		UIEffectManager.instance:stopEffect(cell.eff)

		local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			goutil.setHeight(cell.effGo:GetComponent(goutil.Type_RectTransform), 115)
			goutil.setWidth(cell.effGo:GetComponent(goutil.Type_RectTransform), 115)
			eff:setParent(cell.effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScaleXYZ(1.2, 1, 1.2)
			eff:setClipping(cell.effGo:GetComponent(goutil.Type_RectTransform))
		end

		self.signCellList[data.day].eff = UIEffectManager.instance:playEffect(self, path, cell.effGo, 0, 0, true, false, nil, func)

		goutil.setActive(cell.effGo, true)
	end
end

function CynthiaSignInView:_popShow()
	local cfg = self.cfg_checkin[self.curDay]

	self.bubbleTxt.text = cfg.dayText
end

function CynthiaSignInView:_onClickBtnSignInReward(cell, data)
	local function func(msg)
		MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
	end

	OperationSignInController.instance:gainPrize(data.day, func)

	self.curDay = cell.day

	OperationSignInController.instance:getInfo()
end

function CynthiaSignInView:_onClickBtnClose()
	self:close()
end

return CynthiaSignInView
