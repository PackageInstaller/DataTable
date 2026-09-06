-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteemployView.lua

module("logic.extensions.kindergarten.view.KindergarteemployView", package.seeall)

local KindergarteemployView = class("KindergarteemployView", ViewComponent)

function KindergarteemployView:ctor()
	KindergarteemployView.super.ctor(self)
end

function KindergarteemployView:unbindEvents()
	KindergarteemployView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEmploy:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
end

function KindergarteemployView:bindEvents()
	KindergarteemployView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnEmploy:AddClickListener(self._onClickbtnEmploy, self)
	self._btnAuto:AddClickListener(self._onClickbtnAuto, self)
end

function KindergarteemployView:buildUI()
	KindergarteemployView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnEmploy = self:getBtn("employ/btnEmploy")
	self._employGo = self:getGo("employ")
	self._txtUnlockTip = self:getTxt("employ/txtUnlockTip")
	self._txtCost = self:getTxt("employ/txtCost")
	self._costCon = self:getGo("employ/con")
	self._autoconGo = self:getGo("autocon")
	self._txtAutoTipGo = self:getGo("autocon/txtAutoTip")
	self._btnAuto = self:getBtn("autocon/btnAuto")
	self._txtBtnAuto = self:getTxt("autocon/btnAuto/txt")
	self._txtDesc1 = self:getTxt("gartenInfo1/txtDesc1")
	self._txtDesc2 = self:getTxt("gartenInfo2/txtDesc2")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._viewport = self:getGo("tableView/viewport")
	self._tableRaycast = self._tableView:GetComponent(ComponentType.ScrollRect)
end

function KindergarteemployView:onExit()
	KindergarteemployView.super.onExit(self)
	removetimer(self._onLongPressAddOnTime, self)
	removetimer(self._onLongPressReduceOnTime, self)
	removetimer(self._onClock, self)
end

function KindergarteemployView:onEnter()
	KindergarteemployView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KindergartenSetAutoRes, self._PM_KindergartenSetAutoRes, self)
	self.addGEvent(self, GlobalNotify.KindergartenUnlockAutoFunctionRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.KindergartenGetInfoRes, self._updateUI, self)

	self._activityId = KindergartenModel.instance:getActivityId()
	self._actCfg = KindergartenConfig.instance:getActCfg(self._activityId)
	self._level = KindergartenController.instance:getGartenLevel(self._activityId)
	self._longPressNum = 0
	self._schedulePlanList = {}

	local info = KindergartenModel.instance:getInfo(self._activityId)

	if info and info.schedulePlanList then
		for i, v in ipairs(info.schedulePlanList) do
			self._schedulePlanList[i] = {}

			for j, pointInfo in ipairs(v.pointScheduleList) do
				self._schedulePlanList[i][pointInfo.pointType + 1] = pointInfo.value
			end
		end
	else
		for i = 1, self._actCfg.schedulePlanSize do
			self._schedulePlanList[i] = {}

			for j = 1, 3 do
				self._schedulePlanList[i][j] = 0
			end
		end
	end

	self._txtUnlockTip.text = langPara("幼儿园达到%d级后可招募", self._actCfg.autoUnlockLvLimit)

	self:_setCost()

	self._targetTime = 0

	settimer(1, self._onClock, self)
	KindergartenAgent.instance:sendPM_KindergartenGetInfoReq(self._activityId)
end

function KindergarteemployView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = langPara("方案%s", GameUtil.getChineseNumber(data))

	local totalPoint = 0

	for i = 1, 3 do
		local typeGo = goutil.findChild(go, "type" .. i)
		local txtNum = goutil.findChildTextComponent(typeGo, "txtNum")
		local btnAdd = goutil.findChild(typeGo, "btnAdd")
		local btnReduce = goutil.findChild(typeGo, "btnReduce")
		local longPressAdd = btnAdd:GetComponent("UILongPressed")
		local longPressReduce = btnReduce:GetComponent("UILongPressed")

		txtNum.text = self._schedulePlanList[data][i]

		GameUtil.rmClickHandler(btnAdd)
		GameUtil.addClickHandler(btnAdd, function()
			self:_onClickAddPoint(data, i, 1)
		end)
		GameUtil.rmClickHandler(btnReduce)
		GameUtil.addClickHandler(btnReduce, function()
			self:_onClickReducePoint(data, i, 1)
		end)

		totalPoint = totalPoint + self._schedulePlanList[data][i]

		if longPressAdd then
			longPressAdd:AddListener(function(tar, isUp)
				self:_onLongPressAdd(isUp, data, i)
			end, self)
		end

		if longPressReduce then
			longPressReduce:AddListener(function(tar, isUp)
				self:_onLongPressReduce(isUp, data, i)
			end, self)
		end
	end

	local txtPoint = goutil.findChildTextComponent(go, "txtPoint")

	txtPoint.text = langPara("可分配点数上限： %d/%d", self._totalPointPreClass - totalPoint, self._totalPointPreClass)
end

function KindergarteemployView:_clearCell(cell)
	local go = cell.gameObject

	for i = 1, 3 do
		local typeGo = goutil.findChild(go, "type" .. i)
		local btnAdd = goutil.findChild(typeGo, "btnAdd")
		local btnReduce = goutil.findChild(typeGo, "btnReduce")
		local longPressAdd = btnAdd:GetComponent("UILongPressed")
		local longPressReduce = btnReduce:GetComponent("UILongPressed")

		GameUtil.rmClickHandler(btnAdd)
		GameUtil.rmClickHandler(btnReduce)

		if longPressAdd then
			longPressAdd:RemoveListener()
		end

		if longPressReduce then
			longPressReduce:RemoveListener()
		end
	end
end

function KindergarteemployView:_onClickbtnClose()
	self:close()
end

function KindergarteemployView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("kindergarte_manager_rule")
end

function KindergarteemployView:_onClickAddPoint(planId, type, num)
	if self._info.isAuto == true then
		FloatWordMgr.instance:show(lang("自动上课中"))

		return
	end

	local totalPoint = 0

	for i = 1, 3 do
		totalPoint = totalPoint + self._schedulePlanList[planId][i]
	end

	local addNum = num

	if addNum > self._totalPointPreClass - totalPoint then
		addNum = self._totalPointPreClass - totalPoint
	end

	self._schedulePlanList[planId][type] = self._schedulePlanList[planId][type] + addNum

	self:_updateUI()
end

function KindergarteemployView:_onClickReducePoint(planId, type, num)
	if self._info.isAuto == true then
		FloatWordMgr.instance:show(lang("自动上课中"))

		return
	end

	self._schedulePlanList[planId][type] = self._schedulePlanList[planId][type] - num

	if self._schedulePlanList[planId][type] < 0 then
		self._schedulePlanList[planId][type] = 0
	end

	self:_updateUI()
end

function KindergarteemployView:_onLongPressAdd(isUp, planId, type)
	if isUp == true then
		self._longPressNum = 0

		removetimer(self._onLongPressAddOnTime, self)
	else
		self._longPressPlanId = planId
		self._longPressType = type

		settimer(0.2, self._onLongPressAddOnTime, self, true)
	end
end

function KindergarteemployView:_onLongPressReduce(isUp, planId, type)
	if isUp == true then
		self._longPressNum = 0

		removetimer(self._onLongPressReduceOnTime, self)
	else
		self._longPressPlanId = planId
		self._longPressType = type

		settimer(0.2, self._onLongPressReduceOnTime, self, true)
	end
end

function KindergarteemployView:_onLongPressAddOnTime()
	self._longPressNum = self._longPressNum + 1

	self:_onClickAddPoint(self._longPressPlanId, self._longPressType, self._longPressNum)
end

function KindergarteemployView:_onLongPressReduceOnTime()
	self._longPressNum = self._longPressNum + 1

	self:_onClickReducePoint(self._longPressPlanId, self._longPressType, self._longPressNum)
end

function KindergarteemployView:_onClickbtnAuto()
	if self._info.isAuto then
		local content = lang("现在取消，已经开始上课的班级将继续上课，但不会继续安排其他班级上课，是否立即取消自动？")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			KindergartenAgent.instance:sendPM_KindergartenSetAutoReq(self._activityId, nil, false)
		end)
	else
		if self._info.curStudentCount <= 0 then
			FloatWordMgr.instance:show(lang("无可上课的学生"))

			return
		end

		local totalClassTime = 0

		for i, v in ipairs(self._info.classList) do
			if v.studentList and #v.studentList > 0 then
				totalClassTime = totalClassTime + self._dailyClassTimes - v.todayClassTimes
			end
		end

		if totalClassTime == 0 then
			FloatWordMgr.instance:show(lang("已无上课次数"))

			return
		end

		local leftQualityPoint = KindergartenModel.instance:getLeftQualityPointToday(self._activityId)
		local isCanUse = false
		local activePlanCount = 0
		local pointScheduleList = {}

		for i = 1, self._actCfg.schedulePlanSize do
			local pointPlanPb = KindergartenExtension_pb.PM_KindergartenSchedulePointPlan()
			local totalPoint = 0
			local isMatchCur = true

			for j = 1, 3 do
				local pointSchedule = pointPlanPb.pointScheduleList:add()

				pointSchedule.pointType = j - 1
				pointSchedule.value = self._schedulePlanList[i][j]
				totalPoint = self._schedulePlanList[i][j] + totalPoint

				if leftQualityPoint[j - 1] < self._schedulePlanList[i][j] then
					isMatchCur = false
				end
			end

			if totalPoint > 0 then
				activePlanCount = activePlanCount + 1
			end

			table.insert(pointScheduleList, pointPlanPb)

			if isMatchCur == true and totalPoint > 0 then
				isCanUse = true
			end
		end

		if activePlanCount <= 0 then
			FloatWordMgr.instance:show(lang("当前未预设方案，请至少预设1个方案后再开启自动"))

			return
		end

		if isCanUse == false then
			FloatWordMgr.instance:show(lang("当前预设方案不满足自动开课条件哦，再调整一下吧~"))

			return
		end

		TipsFacade.instance:openPopupWindow(lang("提示"), (activePlanCount < self._actCfg.schedulePlanSize or nil) and langPara("当前预设的方案不足%d个\n是否确认立即开始上课", self._actCfg.schedulePlanSize), function()
			KindergartenAgent.instance:sendPM_KindergartenSetAutoReq(self._activityId, pointScheduleList, true)
		end)
	end
end

function KindergarteemployView:_onClickbtnEmploy()
	local matType, id, matNum = MaterialMgr.getMatParams(self._actCfg.autoUnlockCost)
	local hasNum = MaterialFacade.instance:getMatNumber(matType, id)

	if hasNum < matNum then
		FloatWordMgr.instance:show("招募材料不足")

		return
	end

	if self._actCfg.autoUnlockLvLimit > self._level then
		FloatWordMgr.instance:show(string.format("幼儿园达到%s级后可招募", self._actCfg.autoUnlockLvLimit))

		return
	end

	KindergartenAgent.instance:sendPM_KindergartenUnlockAutoFunctionReq(self._activityId)
end

function KindergarteemployView:_onClock()
	if self._targetTime ~= 0 and self._targetTime < ServerTime.now() then
		self._targetTime = 0

		KindergartenAgent.instance:sendPM_KindergartenGetInfoReq(self._activityId)
	end
end

function KindergarteemployView:_updateUI()
	self._info = KindergartenModel.instance:getInfo(self._activityId)

	local isUnlockAutoFunction = KindergartenModel.instance:isUnlockAutoFunction(self._activityId)

	goutil.setActive(self._employGo, not isUnlockAutoFunction)
	goutil.setActive(self._autoconGo, isUnlockAutoFunction)

	if isUnlockAutoFunction then
		self._txtBtnAuto.text = self._info.isAuto and "取消自动" or "开始自动"

		goutil.setActive(self._txtAutoTipGo, self._info.isAuto)
	end

	local cfg = KindergartenConfig.instance:getLevelData(self._activityId, KindergartenController.instance:getGartenLevel(self._activityId))

	self._totalPointPreClass = cfg.pointMaxLimit
	self._dailyClassTimes = cfg.dailyClassTimes

	local list = {}

	for i = 1, self._actCfg.schedulePlanSize do
		table.insert(list, i)
	end

	self._tableList:reloadData(list)
	self:_updateTextShow()

	self._targetTime = 0

	for i, v in ipairs(self._info.classList) do
		if checknumber(v.classFinishTime) / 1000 < self._targetTime or self._targetTime == 0 then
			self._targetTime = checknumber(v.classFinishTime) / 1000
		end
	end
end

function KindergarteemployView:_updateTextShow()
	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._level)
	local totalInfo = KindergartenModel.instance:getInfo(self._activityId)
	local maxPeopleNum = cfgLevel.classStudentCount
	local leftPointDic = KindergartenModel.instance:getLeftQualityPointToday(self._activityId)
	local strengthPoint = leftPointDic[KindergartenModel.STRENGTH]
	local artPoint = leftPointDic[KindergartenModel.ART]
	local intellectPoint = leftPointDic[KindergartenModel.INTELLECT]

	self._txtDesc1.text = string.format("当前幼儿园等级：%d，学生人数：%d/%d，每个班级最多可供 %d 名学生学习", self._level, totalInfo.curStudentCount, cfgLevel.studentLimit, maxPeopleNum)
	self._txtDesc2.text = string.format("今日可分配艺术点：<color=#FFC880FF>%d</color> 智力点：<color=#FFC880FF>%d</color> 体力点：<color=#FFC880FF>%d</color> 可分配的品质点数每日5点重置", artPoint, intellectPoint, strengthPoint)
end

function KindergarteemployView:_setCost()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.autoUnlockCost)

	self._txtCost.text = matNum

	MaterialMgr.setIcon(self._costCon, matType, matId)
end

function KindergarteemployView:_PM_KindergartenSetAutoRes()
	self._schedulePlanList = {}

	local info = KindergartenModel.instance:getInfo(self._activityId)

	if info and info.schedulePlanList then
		for i, v in ipairs(info.schedulePlanList) do
			self._schedulePlanList[i] = {}

			for j, pointInfo in ipairs(v.pointScheduleList) do
				self._schedulePlanList[i][pointInfo.pointType + 1] = pointInfo.value
			end
		end
	else
		for i = 1, self._actCfg.schedulePlanSize do
			self._schedulePlanList[i] = {}

			for j = 1, 3 do
				self._schedulePlanList[i][j] = 0
			end
		end
	end

	self:_updateUI()
end

return KindergarteemployView
