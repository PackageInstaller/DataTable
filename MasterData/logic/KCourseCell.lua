-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KCourseCell.lua

module("logic.extensions.kindergarten.view.KCourseCell", package.seeall)

local KCourseCell = class("KCourseCell")

function KCourseCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	self._txtNomal = goutil.findChildTextComponent(go, "txtNomal")
	self._txtTalent = goutil.findChildTextComponent(go, "txtTalent")
	self._txtNum = goutil.findChildTextComponent(go, "txtNum")
	self._icon = goutil.findChild(go, "icon")
	self._infoBg = goutil.findChild(go, "infoBg")
	self._itemList = {}

	for i = 1, 3 do
		local element = {}
		local itemGo = goutil.findChild(go, "item" .. i)

		element.go = itemGo
		element.txtName = goutil.findChildTextComponent(itemGo, "txtName")
		element.txtNum = goutil.findChildTextComponent(itemGo, "txt")
		element.btnMinus = goutil.findChild(itemGo, "btnMs")
		element.btnAdd = goutil.findChild(itemGo, "btnAdd")
		element.longPressAdd = element.btnAdd:GetComponent("UILongPressed")
		element.longPressReduce = element.btnMinus:GetComponent("UILongPressed")

		table.insert(self._itemList, element)
	end

	self._btnInfo = goutil.findChild(go, "btnInfo")
	self._txtPointNum = goutil.findChildTextComponent(go, "txtNum")
	self._lockGo = goutil.findChild(go, "lock")
	self._txtLock = goutil.findChildTextComponent(go, "lock/txtDesc")
	self._startCourse = goutil.findChild(go, "startCourse")
	self._btnStart = goutil.findChild(go, "startCourse/btnStart")
	self._txtLeftCourseNum = goutil.findChildTextComponent(go, "startCourse/txt")
	self._courseCountdown = goutil.findChild(go, "courseCountdown")
	self._txtCountdown = goutil.findChildTextComponent(go, "courseCountdown/txtCountdown")
	self._btnLook = goutil.findChild(go, "btnLook")

	GameUtil.addClickHandler(self._btnInfo, GameUtil.handler(self._onClickInfo, self))
	GameUtil.addClickHandler(self._btnStart, GameUtil.handler(self._onClickStart, self))
	GameUtil.addClickHandler(self._btnLook, GameUtil.handler(self._onClickLook, self))

	for i, v in ipairs(self._itemList) do
		GameUtil.addClickHandler(v.btnMinus, GameUtil.handler(self._onClickMinus, self, i))
		GameUtil.addClickHandler(v.btnAdd, GameUtil.handler(self._onClickAdd, self, i))
		v.longPressAdd:AddListener(function(tar, isUp)
			self:_onLongPressAdd(isUp, i)
		end, self)
		v.longPressReduce:AddListener(function(tar, isUp)
			self:_onLongPressReduce(isUp, i)
		end, self)
	end

	self._strengthNum = 0
	self._artNum = 0
	self._intellectNum = 0
end

function KCourseCell:_onClickInfo()
	local isShowJobTendency = false

	UIStateManager.instance:push(ViewName.KindergartenCourseResultView, self._activityId, self._classId, isShowJobTendency)
end

function KCourseCell:_onClickStart()
	local courseState = KindergartenModel.instance:getClassCourseState(self._activityId, self._classId)

	if courseState ~= KindergartenModel.BeforeCourse then
		FloatWordMgr.instance:show("已开始课程")

		return
	end

	local totalSelectPoint = self:_getTotalSelectPointNum()
	local minSelectPoint = self._cfgLevel.pointMinLimit

	if totalSelectPoint < minSelectPoint then
		FloatWordMgr.instance:show(string.format("开课最少需要分配%d品质点", minSelectPoint))

		return
	end

	local leftPointDic = KindergartenModel.instance:getLeftQualityPointToday(self._activityId)
	local pointScheduleList = {}

	for i, v in ipairs(self._data.optionNums) do
		if v > leftPointDic[i - 1] then
			FloatWordMgr.instance:show("点数不足")

			return
		end

		local info = {}

		info.pointType = i - 1
		info.value = v

		table.insert(pointScheduleList, info)
	end

	local normalNum, talentNum = KindergartenModel.instance:getStudentNum(self._activityId, self._classId)

	if normalNum <= 0 and talentNum <= 0 then
		FloatWordMgr.instance:show("无学生")

		return
	end

	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._level)

	if cfgLevel.dailyClassTimes <= KindergartenModel.instance:getTodayClassTimes(self._activityId, self._classId) then
		FloatWordMgr.instance:show("已无上课次数")

		return
	end

	local info = KindergartenModel.instance:getInfo(self._activityId)

	if info.isAuto == true then
		FloatWordMgr.instance:show(lang("自动上课中无法开课"))

		return
	end

	KindergartenAgent.instance:sendPM_KindergartenOpenClassReq(self._activityId, self._classId, pointScheduleList)
end

function KCourseCell:_onClickLook()
	local isShowJobTendency = true
	local info = KindergartenModel.instance:getInfo(self._activityId)

	if info.isAuto == true then
		FloatWordMgr.instance:show(lang("自动上课中无法查看结果"))

		return
	else
		UIStateManager.instance:push(ViewName.KindergartenCourseResultView, self._activityId, self._classId, isShowJobTendency)
	end
end

function KCourseCell:_onClickMinus(index, num)
	local courseState = KindergartenModel.instance:getClassCourseState(self._activityId, self._classId)

	if courseState == KindergartenModel.DoingCourse or courseState == KindergartenModel.AfterCourse then
		FloatWordMgr.instance:show(lang("上课中"))

		return
	end

	local minusNum = num or 1

	if self._data.optionNums[index] - minusNum >= 0 then
		self._data.optionNums[index] = self._data.optionNums[index] - minusNum

		self:_updateItems()

		self._txtNum.text = self:_getPointNumDesc()
	elseif minusNum > 1 then
		self._data.optionNums[index] = 0

		self:_updateItems()

		self._txtNum.text = self:_getPointNumDesc()
	else
		FloatWordMgr.instance:show("点数不可为负")
	end
end

function KCourseCell:_onClickAdd(index, num)
	local courseState = KindergartenModel.instance:getClassCourseState(self._activityId, self._classId)

	if courseState == KindergartenModel.DoingCourse or courseState == KindergartenModel.AfterCourse then
		FloatWordMgr.instance:show(lang("上课中"))

		return
	end

	local pointType = index - 1
	local addNum = num or 1
	local leftPointDic = KindergartenModel.instance:getLeftQualityPointToday(self._activityId)
	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._level)
	local maxNum = cfgLevel.pointMaxLimit
	local totalNum = 0

	for i, v in pairs(self._data.optionNums) do
		totalNum = totalNum + v
	end

	if maxNum < totalNum + addNum then
		addNum = maxNum - totalNum
	end

	if addNum <= 0 then
		FloatWordMgr.instance:show("无可用点数")
	elseif self._data.optionNums[index] + addNum <= leftPointDic[pointType] then
		self._data.optionNums[index] = self._data.optionNums[index] + addNum

		self:_updateItems()

		self._txtNum.text = self:_getPointNumDesc()
	else
		self._data.optionNums[index] = leftPointDic[pointType]

		self:_updateItems()

		self._txtNum.text = self:_getPointNumDesc()
	end
end

function KCourseCell:_onLongPressAdd(isUp, type)
	if isUp == true then
		self._longPressNum = 0

		removetimer(self._onLongPressAddOnTime, self)
	else
		self._longPressType = type
		self._longPressNum = 0

		settimer(0.2, self._onLongPressAddOnTime, self, true)
	end
end

function KCourseCell:_onLongPressReduce(isUp, type)
	if isUp == true then
		self._longPressNum = 0

		removetimer(self._onLongPressReduceOnTime, self)
	else
		self._longPressType = type
		self._longPressNum = 0

		settimer(0.2, self._onLongPressReduceOnTime, self, true)
	end
end

function KCourseCell:_onLongPressAddOnTime()
	self._longPressNum = self._longPressNum + 1

	self:_onClickAdd(self._longPressType, self._longPressNum)
end

function KCourseCell:_onLongPressReduceOnTime()
	self._longPressNum = self._longPressNum + 1

	self:_onClickMinus(self._longPressType, self._longPressNum)
end

function KCourseCell:OnEnable()
	settimer(1, self._onSecond, self)
end

function KCourseCell:OnDisable()
	removetimer(self._onSecond, self)
end

function KCourseCell:init(activityId, kindergartenLevel, data)
	self._activityId = activityId
	self._level = kindergartenLevel
	self._cfgClass = data.cfgClass
	self._classId = self._cfgClass.classId
	self._data = data
	self._cfgLevel = KindergartenConfig.instance:getLevelData(activityId, kindergartenLevel)
	self._isUnlock = self._classId <= self._cfgLevel.classCount
	self._maxCourseNums = self._cfgLevel.dailyClassTimes
	self._txtTitle.text = self._cfgClass.desc

	local normalNum, talentNum = KindergartenModel.instance:getStudentNum(self._activityId, self._classId)

	self._txtNomal.text = langPara("普通学生：<color=#A4433DFF>%d</color>", normalNum)
	self._txtTalent.text = langPara("天才学生：<color=#A4433DFF>%d</color>", talentNum)
	self._txtNum.text = self:_getPointNumDesc()
	self._txtLock.text = string.format("幼儿园等级升至%d级\n即可解锁本班级", KindergartenController.instance:getUnlockKindergartenLevel(self._activityId, self._classId))

	uGuiUtil.setSpriteToImage(self._icon, nil, string.format("%s.png", self._cfgClass.icon))
	self:_updateItems()
	self:_updateCourseState()
end

function KCourseCell:reset()
	removetimer(self._onSecond, self)
	removetimer(self._onLongPressReduceOnTime, self)
	removetimer(self._onLongPressAddOnTime, self)
	uGuiUtil.clearImage(self._icon)
end

function KCourseCell:_onSecond()
	self:_updateCourseState()
end

function KCourseCell:_getPointNumDesc()
	local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._level)
	local maxNum = cfgLevel.pointMaxLimit
	local curLeftNum = KindergartenModel.instance:getLeftSumQualityPointToday(self._activityId)
	local totalNum = 0

	for i, v in pairs(self._data.optionNums) do
		totalNum = totalNum + v
	end

	return string.format("剩余可分配点数：%d/%d", math.min(curLeftNum, maxNum - totalNum), maxNum)
end

function KCourseCell:_updateItems()
	for i, v in ipairs(self._itemList) do
		GameUtil.SetActive(v.go, self._isUnlock)

		v.txtName.text = self:_getName(i)
		v.txtNum.text = self._data.optionNums[i]
	end
end

function KCourseCell:_getName(index)
	local typeNum = index - 1

	if typeNum == KindergartenModel.STRENGTH then
		return "体力"
	elseif typeNum == KindergartenModel.ART then
		return "艺术"
	elseif typeNum == KindergartenModel.INTELLECT then
		return "智力"
	end

	return "nil"
end

function KCourseCell:_updateCourseState()
	if self._isUnlock then
		local courseState = KindergartenModel.instance:getClassCourseState(self._activityId, self._classId)

		GameUtil.SetActive(self._lockGo, false)
		GameUtil.SetActive(self._startCourse, courseState == KindergartenModel.BeforeCourse)
		GameUtil.SetActive(self._courseCountdown, courseState == KindergartenModel.DoingCourse)
		GameUtil.SetActive(self._btnLook, courseState == KindergartenModel.AfterCourse)

		local cfgLevel = KindergartenConfig.instance:getLevelData(self._activityId, self._level)

		if courseState == KindergartenModel.BeforeCourse then
			self._txtLeftCourseNum.text = string.format("剩余开课次数：%d", cfgLevel.dailyClassTimes - KindergartenModel.instance:getTodayClassTimes(self._activityId, self._classId))
		elseif courseState == KindergartenModel.DoingCourse then
			local finishTime = KindergartenModel.instance:getClassCourseFinshTime(self._activityId, self._classId)
			local countdown = Mathf.Max(0, finishTime - ServerTime.now())
			local str = GameUtil.FormatTimeSymbol(countdown)

			self._txtCountdown.text = string.format("%s后结课", str)
		elseif courseState == KindergartenModel.AfterCourse then
			-- block empty
		end
	else
		GameUtil.SetActive(self._lockGo, true)
		GameUtil.SetActive(self._startCourse, false)
		GameUtil.SetActive(self._courseCountdown, false)
		GameUtil.SetActive(self._btnLook, false)
	end

	GameUtil.SetActive(self._txtNum, self._isUnlock)
	GameUtil.SetActive(self._infoBg, self._isUnlock)
	GameUtil.SetActive(self._txtTalent, self._isUnlock)
	GameUtil.SetActive(self._txtNomal, self._isUnlock)
	GameUtil.SetActive(self._icon, self._isUnlock)
	GameUtil.SetActive(self._btnInfo, self._isUnlock)
end

function KCourseCell:_getTotalSelectPointNum()
	local num = 0

	for i, v in ipairs(self._data.optionNums) do
		num = num + v
	end

	return num
end

return KCourseCell
