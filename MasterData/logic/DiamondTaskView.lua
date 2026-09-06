-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/view/DiamondTaskView.lua

module("logic.extensions.diamondtask.view.DiamondTaskView", package.seeall)

local DiamondTaskView = class("DiamondTaskView", TableViewComponent)
local showPetId = 10278
local txtDaily = lang("diamondtask_daily")
local txtWeekly = lang("diamondtask_weekly")
local txtMain = lang("task_main")
local txtBranch = lang("task_branch")
local txtGuide = lang("task_guide")
local txtTimeLimit = lang("task_limittime")
local ROOT_TAB = {
	[GameEnum.TaskViewTab.Daily] = {
		redId = 4,
		sortIndex = 2,
		name = txtDaily
	},
	[GameEnum.TaskViewTab.Weekly] = {
		redId = 5,
		sortIndex = 3,
		name = txtWeekly
	},
	[GameEnum.TaskViewTab.Main] = {
		redId = 1,
		sortIndex = 4,
		name = txtMain
	},
	[GameEnum.TaskViewTab.Branch] = {
		redId = 2,
		sortIndex = 5,
		name = txtBranch
	},
	[GameEnum.TaskViewTab.Guide] = {
		redId = 3,
		sortIndex = 6,
		name = txtGuide
	},
	[GameEnum.TaskViewTab.TimeLimit] = {
		sortIndex = 1,
		name = txtTimeLimit
	},
	[GameEnum.TaskViewTab.Achievement] = {
		redId = 23,
		sortIndex = 7,
		name = lang("成就")
	}
}

function DiamondTaskView:_getPath()
	return {
		cellPath = "Diamond/TaskItem",
		viewPath = "Diamond/ScrollTask"
	}
end

function DiamondTaskView:ctor()
	DiamondTaskView.super.ctor(self)
end

function DiamondTaskView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnImgAct:AddClickListener(self._clickBtnImgAct, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "diamondtask")
	end, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)

	for i = 1, #self._giftObjs do
		local btn = Framework.ButtonAdapter.GetFrom(self._giftObjs[i], "Btn")

		btn:AddClickListener(function()
			self:_clickActiveGift(i, btn.gameObject)
		end, self)
	end

	GameUtil.addClickHandler(self._bigRwardTip, self.onClickTips, self)
	GameUtil.addClickHandler(self._bigRwardBox, self.onClickReward, self)
end

function DiamondTaskView:unbindEvents()
	self._btnHelp:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)

	for i = 1, #self._giftObjs do
		local btn = Framework.ButtonAdapter.GetFrom(self._giftObjs[i], "Btn")

		btn:RemoveClickListener()
	end

	self._btnImgAct:RemoveClickListener()
	GameUtil.rmClickHandler(self._bigRwardTip)
	GameUtil.rmClickHandler(self._bigRwardBox)
end

function DiamondTaskView:buildUI()
	DiamondTaskView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnImgAct = self:getBtn("Diamond/ImgActivity")
	self._activeTxt = self:getGo("Diamond/ImgActivity/TxtProg"):GetComponent("Text")
	self._activeProg = self:getGo("Diamond/Buttom/Prog"):GetComponent("Slider")
	self._diamond = self:getGo("Diamond")
	self._timeLimitGo = self:getGo("TimeLimit")
	self._rolePoint = goutil.findChild(self._diamond, "rolePoint")
	self._imgProg = goutil.findChildComponent(self._activeProg, "Fill Area/Fill", "UIImageSpriteChange")
	self._giftRoot = self:getGo("Diamond/Buttom/Grids")
	self._giftNum = 0
	self._giftObjs = {}
	self._giftStates = {}
	self._effectList = {}

	for i = 1, 5 do
		table.insert(self._giftObjs, self:getGo("Diamond/Grids/Reward" .. i))
	end

	self._bigRewardSlider = self:getSlider("Diamond/bigReward/slider")
	self._bigRwardDesc = self:getTxt("Diamond/bigReward/txt")
	self._bigRwardTip = self:getGo("Diamond/bigReward/btnTip")
	self._bigRwardBox = self:getGo("Diamond/bigReward/box")
	self.bigRewardGo = self:getGo("Diamond/bigReward")

	local bigRewardGo = self:getGo("Diamond/bigReward")

	self._doubleGo = goutil.findChild(bigRewardGo, "doubleGo")
	self._doubleTxt = goutil.findChildTextComponent(self._doubleGo, "doubleTxt")
	self._doubleTxt.text = ""

	GameUtil.SetActive(self._doubleGo, false)

	local titleShowGo = self:getGo("titleShowGo")
	local titleTxt = goutil.findChildTextComponent(titleShowGo, "titleTxt")
	local descTxt = goutil.findChildTextComponent(titleShowGo, "descTxt")

	self._tipsBtn = Framework.ButtonAdapter.GetFrom(titleShowGo, "tipsBtn")
	titleTxt.text = lang("task_title")
	descTxt.text = lang("task_title_desc")
	self._portionTaskView = PortionTaskView.New(self)

	self._portionTaskView:buildUI(self:getGo("Taskes"))

	self.goldBarCon = self:getGo("goldBarCon")
	self.tableview = self:getGo("tableview")
	self.rootCell = self:getGo("rootCell")
	self.leafCell = self:getGo("leafCell")
	self.scrollList = ScrollerList.create(self.tableview, {
		self.rootCell,
		self.leafCell
	}, GameUtil.handler(self._upateTabCell, self))

	self.scrollList:regGetTagByIdx(GameUtil.handler(self.getTagByData, self))
	self.scrollList:regGetCellSize(GameUtil.handler(self.getCellSize, self))

	self.diamondWeekGo = self:getGo("DiamondWeek")

	local weekScGo = self:getGo("DiamondWeek/ScrollTask")

	self.scrollWeek = ScrollerList.create(weekScGo, self:getGo("Diamond/TaskItem"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self.scrollWeek:regGetCellSize(GameUtil.handler(self._cellSize, self))

	self._descTipGo = self:getGo("descTip")

	self:initTabList()
end

function DiamondTaskView:_buildTaskButtons()
	self._btnImgChg = self:getGo("LeftBtns/BtnSelected")
	self._btnImgChgTxt = self:getGo("LeftBtns/BtnSelected/Text"):GetComponent("Text")
	self._btnImgChgPoint = self:getGo("LeftBtns/BtnSelected/imgPoint")

	local btnMainTask = self:getBtn("LeftBtns/BtnMain")
	local btnBranchTask = self:getBtn("LeftBtns/BtnBranch")
	local btnGrowTask = self:getBtn("LeftBtns/BtnGrow")
	local btnDailyTask = self:getBtn("LeftBtns/BtnDaily")
	local btnWeeklyTask = self:getBtn("LeftBtns/BtnWeekly")
	local btnTimeLimit = self:getBtn("LeftBtns/BtnTimeLimit")
	local btnMainTaskTxt = self:getGo("LeftBtns/BtnMain/Text"):GetComponent("Text")
	local btnBranchTaskTxt = self:getGo("LeftBtns/BtnBranch/Text"):GetComponent("Text")
	local btnGrowTaskTxt = self:getGo("LeftBtns/BtnGrow/Text"):GetComponent("Text")
	local btnDailyTaskTxt = self:getGo("LeftBtns/BtnDaily/Text"):GetComponent("Text")
	local btnWeeklyTaskTxt = self:getGo("LeftBtns/BtnWeekly/Text"):GetComponent("Text")
	local btnTimeLimitTxt = self:getGo("LeftBtns/BtnTimeLimit/Text"):GetComponent("Text")
	local btnMainTaskPoint = self:getGo("LeftBtns/BtnMain/imgPoint")
	local btnBranchTaskPoint = self:getGo("LeftBtns/BtnBranch/imgPoint")
	local btnGrowTaskPoint = self:getGo("LeftBtns/BtnGrow/imgPoint")
	local btnDailyTaskPoint = self:getGo("LeftBtns/BtnDaily/imgPoint")
	local btnWeeklyTaskPoint = self:getGo("LeftBtns/BtnWeekly/imgPoint")
	local btnTimeLimitTaskPoint = self:getGo("LeftBtns/BtnTimeLimit/imgPoint")
	local lockDailyTask = self:getGo("LeftBtns/BtnDaily/Lock")
	local lockWeeklyTask = self:getGo("LeftBtns/BtnWeekly/Lock")
	local txtDaily = lang("diamondtask_daily")
	local txtWeekly = lang("diamondtask_weekly")
	local txtMain = lang("task_main")
	local txtBranch = lang("task_branch")

	btnMainTaskTxt.text = txtMain
	btnBranchTaskTxt.text = txtBranch
	btnGrowTaskTxt.text = lang("task_guide")
	btnDailyTaskTxt.text = txtDaily
	btnWeeklyTaskTxt.text = txtWeekly
	btnTimeLimitTxt.text = lang("task_limittime")
end

function DiamondTaskView:destroyUI()
	self._giftObjs = {}
end

function DiamondTaskView:_reloadData()
	DiamondTaskController.instance:getDiamondTaskInfo()
end

function DiamondTaskView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.OnMofangLvUp, self._onMofangLvUp, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.DiamondTaskInfoGot, self._onDataRefreshed, self)
	GlobalDispatcher:addListener(GlobalNotify.CloseDiamondTask, self._onClickClose, self)
	AchievementController.instance:registerLocalNotify("LoadAllAchievement", self._updateRedPoint, self)
	AchievementController.instance:registerLocalNotify("GainAchievementPrize", self._updateRedPoint, self)
	AchievementController.instance:registerLocalNotify("GainAchievementLevelPrize", self._updateRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.AchievementOneKeySuccess, self._updateRedPoint, self)

	local showTips
	local period = checknumber(self._viewPresentor:getFirstParam())

	if period > 0 then
		showTips = true
	else
		period = GameEnum.TaskViewTab.Daily
	end

	if not self:_isUnLock(period) then
		if showTips then
			self:_showUnLockTips(period)
		end

		period = GameEnum.TaskViewTab.Main
	end

	DiamondTaskView.super.onEnter(self)
	self._portionTaskView:onEnter()

	self._actScore = 0
	self._maxActScore = 100
	self.rootIdx = period

	local params = self:getOpenParam()

	self.leafIdx = params and (params[2] or 1) or 1
	self.leafIdx = checknumber(self.leafIdx)

	self:updateTabList()
	self:_updateTaskState()
	self:_reloadData()
	self:_updateRedPoint()
	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor)
end

function DiamondTaskView:onEnterFinished()
	return
end

function DiamondTaskView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnMofangLvUp, self._onMofangLvUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.DiamondTaskInfoGot, self._onDataRefreshed, self)
	GlobalDispatcher:removeListener(GlobalNotify.CloseDiamondTask, self._onClickClose, self)
	AchievementController.instance:unregisterLocalNotify("LoadAllAchievement", self._updateRedPoint, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementPrize", self._updateRedPoint, self)
	AchievementController.instance:unregisterLocalNotify("GainAchievementLevelPrize", self._updateRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.AchievementOneKeySuccess, self._updateRedPoint, self)

	if self._nuo then
		RoleObjectPool.instance:removeRole(self._nuo)

		self._nuo = nil
	end

	DiamondTaskView.super.onExit(self)
	self._portionTaskView:onExit()
	self._tableview:Travel(self._clearTableview, self, true)

	self._curViewDatas = nil

	self.scrollList:dispose()
	self.scrollWeek:dispose()
	self:clearRewardEff()
end

function DiamondTaskView:onExitFinished()
	return
end

function DiamondTaskView:onClickTips()
	local tips = DiamondTaskConfig.instance:getTaskCommValue("ACTIVITY_REWARD_TIPS")

	TipsFacade.instance:openTipWindowNoX(lang("tip"), tips)
end

function DiamondTaskView:onClickReward()
	local info = DiamondTaskModel.instance:getTaskInfoByType(self._period) or {}
	local cost = checknumber(DiamondTaskConfig.instance:getTaskCommValue("ACTIVITY_PRZIE_COST_SCORE"))

	if cost <= checknumber(info.accumulateActivityScore) then
		DiamondTaskAgent.instance:sendGainAccumulateScoreGiftReq(self._period)
	else
		local item = DiamondTaskConfig.instance:getTaskCommValue("ACTIVITY_REWARD_ITEM")

		if not string.nilorempty(item) then
			CommonTipsMgr.instance:openTipsByConfStr(self._bigRwardBox, item)
		end
	end
end

function DiamondTaskView:clearRewardEff()
	if self._effSelect then
		UIEffectManager.instance:stopEffect(self._effSelect)

		self._effSelect = nil
	end
end

function DiamondTaskView:_onDataRefreshed()
	self:clearRewardEff()

	if self._period == GameEnum.TaskViewTab.Daily or self._period == GameEnum.TaskViewTab.Weekly then
		self:_refresheActiveScore()
		self:_refreshActiveGifts()

		self._curViewDatas = DiamondTaskModel.instance:getTasksData(self._period)

		self._tableview:ReloadData()

		if self._period == GameEnum.TaskViewTab.Daily then
			local info = DiamondTaskModel.instance:getTaskInfoByType(self._period)
			local total = checknumber(DiamondTaskConfig.instance:getTaskCommValue("ACTIVITY_TOTAL_SCORE"))

			total = total == 0 and 1 or total

			self._bigRewardSlider:SetValue(info.accumulateActivityScore / total)

			self._bigRwardDesc.text = info.accumulateActivityScore .. "/" .. total

			local cost = checknumber(DiamondTaskConfig.instance:getTaskCommValue("ACTIVITY_PRZIE_COST_SCORE"))

			if cost <= checknumber(info.accumulateActivityScore) then
				local path = "20220318/fx_ui_baoxianglingqu.prefab"
				local effect = UIEffectManager.instance:playEffect(self, path, self._bigRwardBox.transform, 0, 0, true)

				effect:setParent(self._bigRwardBox.transform)
				effect:setScale(1)
				effect:setLocalPos(0, 0, 0)

				self._effSelect = effect
			end
		end
	end
end

function DiamondTaskView:_isUnLock(taskType)
	return DiamondTaskModel.instance:isUnLock(taskType)
end

function DiamondTaskView:_showUnLockTips(taskType)
	if taskType == GameEnum.TaskViewTab.Daily then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(DiamondTaskModel.dailyFuncId)

		if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			FloatWordMgr.instance:show(cfg.lockedTips)

			return
		end
	elseif taskType == GameEnum.TaskViewTab.Weekly then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(DiamondTaskModel.weeklyFuncId)

		if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			FloatWordMgr.instance:show(cfg.lockedTips)

			return
		end
	end
end

function DiamondTaskView:_refresheActiveScore()
	self._actScore, self._maxActScore = DiamondTaskModel.instance:getTaskActivity(self._period)
	self._activeProg.value = self._actScore / self._maxActScore
	self._activeTxt.text = string.format("%s/%s", self._actScore, self._maxActScore)
end

function DiamondTaskView:_refreshActiveGifts()
	for k, v in pairs(self._effectList) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectList = {}

	local gifts = table.values(DiamondTaskModel.instance:getActiveGiftsData(self._period))

	self._giftNum = 0

	for i, v in ipairs(self._giftObjs) do
		v:SetActive(false)
	end

	for k, v in ipairs(gifts) do
		self._giftNum = self._giftNum + 1

		self:_showOneActiveGift(self._giftNum, v.score, v.gift, v.got, k == #gifts)
	end
end

function DiamondTaskView:_clickBtnImgAct()
	local cfgId = 1001

	if self._period == GameEnum.TaskViewTab.Daily then
		cfgId = 1001
	elseif self._period == GameEnum.TaskViewTab.Weekly then
		cfgId = 1002
	end

	local actStr = MatType.Item_Fake .. ":" .. cfgId .. ":0"

	CommonTipsMgr.instance:openTipsByConfStr(self._btnImgAct, actStr)
end

function DiamondTaskView:_showOneActiveGift(index, score, gift, got, isEnd)
	if not self._giftObjs[index] then
		self._giftObjs[index] = goutil.clone(self._giftObjs[1], "Reward" .. index)

		local btn = Framework.ButtonAdapter.GetFrom(self._giftObjs[index], "Btn")

		btn:AddClickListener(function()
			self:_clickActiveGift(index, self._giftObjs[index])
		end, self)
	end

	local obj = self._giftObjs[index]
	local pos = obj.transform.localPosition

	obj:SetActive(true)

	pos.x = -138 + 816 * score / self._maxActScore

	uGuiUtil.setLocalPosition(obj, pos)

	local icon = goutil.findChild(obj, "Icon")
	local iconImg = icon:GetComponent(goutil.Type_UIImage)
	local iconChange = icon:GetComponent("UIImageSpriteChange")
	local canOpen = goutil.findChild(obj, "CanOpen")
	local bgState = goutil.findChild(obj, "Bg"):GetComponent("UIImageSpriteChange")
	local progTxt = goutil.findChild(obj, "TxtProg"):GetComponent("Text")
	local effectNode = goutil.findChild(obj, "effect")
	local effectRectTrans = effectNode:GetComponent(goutil.Type_RectTransform)

	bgState:SetState(0)
	MaterialMgr.resetAll(icon)

	local giftStr = MaterialMgr.changeItemStr(gift)
	local list = string.split(giftStr, "#")

	if list and #list == 1 then
		if not list[1] then
			local mats = gift
			local str = BonusController.instance:getDayWeekTaskDoubleMats(mats, self._period)

			iconImg.enabled = false

			local proxy = MaterialMgr.setCellByCfg(str, icon)

			proxy.binder:SetGray(got)

			if got then
				progTxt.text = lang("mail_got")
				self._giftStates[index] = 2
			else
				progTxt.text = score
				self._giftStates[index] = 0

				if score <= self._actScore then
					if not isShowBox then
						local _effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", canOpen, 0, 0, true, nil, nil, function(self, uiEffect)
							uiEffect:setClipping(effectRectTrans)
						end)

						_effect:setParent(obj.transform)
						_effect:setScale(0.55)

						self._effectList[index] = _effect
					end

					bgState:SetState(1)

					self._giftStates[index] = 1
				end
			end

			iconChange:SetState(self._giftStates[index])

			if isShowBox then
				if self._giftStates[index] == 1 then
					goutil.setActive(icon, false)
					goutil.setActive(effectNode, true)

					if not self._effectList[index] then
						local effect = UIEffectManager.instance:playEffect(self, "fx_ui_renwu/fx_ui_kelingqubaoxiang.prefab", effectNode.transform, 0, 0, true)

						effect:setParent(effectNode.transform)
						effect:setScale(0.8)

						self._effectList[index] = effect
					end
				else
					goutil.setActive(icon, true)
					goutil.setActive(effectNode, false)
				end
			else
				goutil.setActive(icon, true)
			end
		end
	end
end

function DiamondTaskView:_updateRedPoint()
	self.scrollList:refresh()
end

function DiamondTaskView:_updateTaskState()
	self.scrollList:refresh()
end

function DiamondTaskView:_cellSize()
	return 1000, 157
end

function DiamondTaskView:_updateCell(view, cell, data)
	local imgDouble = goutil.findChild(cell.gameObject, "CanGrayObjs/ImgDouble")
	local taskName = goutil.findChildTextComponent(cell.gameObject, "TaskName")

	taskName.text = data.desc

	self:_fillCellState(cell, data)

	local cfgId = 1001

	if self._period == GameEnum.TaskViewTab.Daily then
		cfgId = 1001
	elseif self._period == GameEnum.TaskViewTab.Weekly then
		cfgId = 1002
	end

	local _go = goutil.findChild(cell, "CanGrayObjs/ItemGrid/Cell1")
	local _icon = goutil.findChild(_go, "Bg/Icon")

	_go:SetActive(true)

	local proxy = self:_updateItem(_icon, MatType.Item_Fake .. ":" .. cfgId .. ":" .. data.activityScore)
	local itemStrs = string.split(data.gift, "#")

	for i = 1, 3 do
		local item = {}

		item._go = goutil.findChild(cell, "CanGrayObjs/ItemGrid/Cell" .. tostring(i + 1))
		item._icon = goutil.findChild(item._go, "Bg/Icon")

		MaterialMgr.resetAll(item._icon)

		if i <= #itemStrs then
			local str = self._isDouble and BonusController.instance:getDayWeekTaskDoubleMats(itemStrs[i], self._period) or itemStrs[i]
			local proxy = self:_updateItem(item._icon, str)
		end
	end

	imgDouble:SetActive(self._isDouble or DiamondTaskModel.instance:isRecommendType(self._period, data.taskId))
end

function DiamondTaskView:_fillCellState(cell, data)
	local canGrayObjs = goutil.findChild(cell, "CanGrayObjs")
	local imgFinished = goutil.findChild(cell.gameObject, "ImgFinished")
	local reveive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Reveive")
	local gotoBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Goto")
	local gotoText = goutil.findChild(cell, "Goto/Text"):GetComponent("Text")
	local reveiveText = goutil.findChild(cell, "Reveive/Text"):GetComponent("Text")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "CanGrayObjs/TxtDesc")
	local txtInstruction = goutil.findChildTextComponent(cell.gameObject, "CanGrayObjs/TxtInstruction")
	local progress = goutil.findChildTextComponent(cell.gameObject, "Progress")

	progress.text = "<color=#0068b7>" .. data.progress .. "/" .. "</color>" .. data.maxProgerss
	gotoText.text = lang("jump_to")
	reveiveText.text = lang("spriteladder_get")

	imgFinished:SetActive(data.state == 3)

	if data.state == 1 then
		reveive.gameObject:SetActive(true)
		self:_enableJumpTo(gotoBtn.gameObject, gotoText, data, false, false)

		txtDesc.text = "<color=#7F84A3FF>" .. data.describe .. "</color>"

		Framework.TransformUtil.SetLocalPos(progress.transform, 861, -26, 0)
	elseif data.state == 2 then
		reveive.gameObject:SetActive(false)

		if not self:_enableJumpTo(gotoBtn.gameObject, gotoText, data, true, false) then
			Framework.TransformUtil.SetLocalPos(progress.transform, 861, -62, 0)
		else
			Framework.TransformUtil.SetLocalPos(progress.transform, 861, -26, 0)
		end

		txtDesc.text = "<color=#7F84A3FF>" .. data.describe .. "</color>"
	else
		progress.text = ""

		reveive.gameObject:SetActive(false)
		gotoBtn.gameObject:SetActive(false)
		uGuiUtil.setImageGrayStateRecursive(gotoBtn, true)

		if not self:_enableJumpTo(gotoBtn.gameObject, gotoText, data, true, true) then
			Framework.TransformUtil.SetLocalPos(progress.transform, 861, -62, 0)
		else
			Framework.TransformUtil.SetLocalPos(progress.transform, 861, -26, 0)
		end

		txtDesc.text = "<color=#7F84A3FF>" .. data.describe .. "</color>"

		gotoBtn.gameObject:SetActive(false)
	end

	gotoBtn:AddClickListener(function()
		self:_clickItemGo(data)
	end, self)
	reveive:AddClickListener(function()
		self:_clickItemGet(data)
	end, self)
end

function DiamondTaskView:_enableJumpTo(gotoBtn, text, data, active, gray)
	if active and data.jumpTo and #data.jumpTo > 0 then
		gotoBtn:SetActive(true)

		if gray then
			Game.TextUtil.SetColorRGBA(text, 0.34901960784313724, 0.34901960784313724, 0.34901960784313724, 1)
			uGuiUtil.setImageGrayStateRecursive(gotoBtn, true)
		else
			Game.TextUtil.SetColorRGBA(text, 1, 1, 1, 1)
			uGuiUtil.setImageGrayStateRecursive(gotoBtn, false)
		end

		return true
	else
		gotoBtn:SetActive(false)
	end
end

function DiamondTaskView:_updateItem(iconGo, itemStr)
	return MaterialMgr.setCellByCfg(itemStr, iconGo)
end

function DiamondTaskView:_clearTableview(cell)
	local buttonReveive = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Reveive")
	local buttonGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Goto")

	buttonReveive:RemoveClickListener()
	buttonGoto:RemoveClickListener()
end

function DiamondTaskView:_checkJumptoUnlock(data)
	return DiamondTaskModel.instance:checkJumptoUnlock(data)
end

function DiamondTaskView:_clickItemGo(data)
	if not self:_checkJumptoUnlock(data) then
		return
	end

	MainUIFacade.instance:setNeedCheckFunc(false)

	local params = string.split(data.jumpTo, "#")
	local key = table.remove(params, 1)

	if key ~= "ui" and key ~= "func" then
		UIStateManager.instance:clear(true)
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function DiamondTaskView:_clickItemGet(data)
	local tasks = DiamondTaskModel.instance:getCurCanGetTasks(self._period)

	if tasks then
		local taskIdList = {}

		for i, v in ipairs(tasks) do
			table.insert(taskIdList, v.taskId)
		end

		if #taskIdList > 0 then
			DiamondTaskController.instance:gainTaskGift(self._period, taskIdList)
		end
	end
end

function DiamondTaskView:_clickActiveGift(i, go)
	if self._giftStates[i] == 1 then
		local list = {}

		for index, v in pairs(self._giftStates) do
			if v == 1 then
				table.insert(list, index - 1)
			end
		end

		DiamondTaskController.instance:gainActiveGift(self._period, list)
	else
		local gifts = table.values(DiamondTaskModel.instance:getActiveGiftsData(self._period))
		local giftStr = MaterialMgr.changeItemStr(gifts[i].gift) or {}
		local list = string.split(giftStr, "#")
		local str = BonusController.instance:getDayWeekTaskDoubleMats(gifts[i].gift, self._period)
		local rewardType = checknumber(string.split(gifts[i].gift, ":")[1])

		if rewardType == MatType.DROP_ITEM and list then
			if #list > 1 then
				CommonTipsMgr.instance:openTipsByConfStr(go, gifts[i].gift)
			else
				CommonTipsMgr.instance:openTipsByConfStr(go, list[1])
			end
		else
			CommonTipsMgr.instance:openTipsByConfStr(go, str)
		end
	end
end

function DiamondTaskView:_onClickClose()
	self:close()
end

function DiamondTaskView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function DiamondTaskView:_onMofangLvUp()
	self:_updateTaskState()
end

function DiamondTaskView:_onClickBtnHelp()
	UIStateManager.instance:open(ViewName.PanelGuide, GameEnum.PanelGuideType.DiamondTask)
end

function DiamondTaskView:_onFirstOpenView()
	local name = RoleModel.instance:getUserId() .. "DiamondTask"
	local isGuide = UnityEngine.PlayerPrefs.GetInt(name)

	if isGuide == 0 then
		UnityEngine.PlayerPrefs.SetInt(name, 1)
		self:_onClickBtnHelp()
	end
end

function DiamondTaskView:initTabList()
	local list = {}
	local keyList = {}

	for key, v in pairs(ROOT_TAB) do
		local data = {}

		data.tag = 1
		data.idx = key
		data.name = v.name
		data.redId = v.redId
		data.sortIndex = v.sortIndex

		if key == GameEnum.TaskViewTab.Achievement then
			local content = AchievementConfig.instance:getAchiIndexs()
			local dataList = content.dataList
			local tempList = {}

			for j, vv in ipairs(dataList) do
				if vv.leaf == 0 then
					local tem = {}

					tem.tag = 2
					tem.idx = #tempList + 1
					tem.name = vv.name
					tem.cfg = vv

					table.insert(tempList, tem)
				end
			end

			data.leaf = tempList
		end

		table.insert(list, data)

		keyList[key] = data
	end

	table.sort(list, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	self.tabList = list
	self.keyList = keyList
end

function DiamondTaskView:_upateTabCell(view, cell, data, tag)
	if data.tag == 1 then
		self:updateRootCell(view, cell, data, tag)
	else
		self:updateLeafCell(view, cell, data, tag)
	end
end

function DiamondTaskView:updateRootCell(view, cell, data, tag)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local imgRedPoint = goutil.findChild(cell, "imgRedPoint")
	local Lock = goutil.findChild(cell, "Lock")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local idx = 0

	if data.idx == self.rootIdx then
		idx = 1
	end

	GameUtil.SetActive(imgRedPoint, false)

	if data.redId == nil then
		-- block empty
	else
		local isActivePoint = RedPointModel.instance:isActive(data.redId)

		GameUtil.SetActive(imgRedPoint, isActivePoint)
	end

	GameUtil.SetActive(Lock, not self:_isUnLock(data.idx))
	GameUtil.setUIImageSpriteIdx(imgSelected, idx)
	GameUtil.setUITextColorIdx(txtName, idx)

	txtName.text = data.name

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onRootClick, self, data))
end

function DiamondTaskView:updateLeafCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local imgRedPoint = goutil.findChild(cell, "imgRedPoint")

	txtName.text = data.name

	local isSelect = data.idx == self.leafIdx

	if data.cfg then
		local cfg = data.cfg

		GameUtil.SetActive(imgRedPoint, AchievementModel.instance:getIsRed(cfg.root, cfg.leaf))
	else
		GameUtil.SetActive(imgRedPoint, false)
	end

	GameUtil.SetActive(imgSelected, isSelect)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onLeafClick, self, data))
end

function DiamondTaskView:onRootClick(data)
	if not self:_isUnLock(data.idx) then
		self:_showUnLockTips(data.idx)

		return
	end

	if data.idx == self.rootIdx and self.leafIdx > 0 then
		-- block empty
	else
		self.rootIdx = data.idx
		self.leafIdx = 0

		if data.leaf and #data.leaf > 0 then
			self.leafIdx = 1
		end

		self:updateTabList()
	end
end

function DiamondTaskView:onLeafClick(data)
	self.leafIdx = data.idx

	self.scrollList:refresh()
	self:updateRightView()
end

function DiamondTaskView:updateTabList()
	local rootIdx = self.rootIdx
	local leafIdx = self.leafIdx
	local list = {}

	for i, v in ipairs(self.tabList) do
		local data = v

		table.insert(list, data)

		if data.idx == rootIdx and leafIdx > 0 and data.leaf then
			for ii, vv in ipairs(data.leaf) do
				table.insert(list, vv)
			end
		end
	end

	self.scrollList:reloadData(list)
	self:updateRightView()
end

function DiamondTaskView:updateRightView()
	local root = self.rootIdx
	local leaf = self.leafIdx

	self:_changePeriodByLeaf(root, leaf)
end

function DiamondTaskView:_changePeriodByLeaf(period, leaf)
	self._period = period

	self._descTipGo:SetActive(self._period == GameEnum.TaskViewTab.Weekly)
	self.diamondWeekGo:SetActive(false)
	self.bigRewardGo:SetActive(self._period == GameEnum.TaskViewTab.Daily)
	GameUtil.SetActive(self._doubleGo, false)

	self._isDouble = false

	if self._period == GameEnum.TaskViewTab.Daily or self._period == GameEnum.TaskViewTab.Weekly then
		self._diamond:SetActive(true)
		self._portionTaskView:setActive(false)
		self:showTabAt(self._timeLimitGo, nil)

		self._nuo = RoleObjectPool.instance:addRoleToParent(self._nuo, showPetId, self._rolePoint, 1)

		self._imgProg:SetState(self._period == GameEnum.TaskViewTab.Daily and 0 or 1)
		self._tableview:SetOffsetWithoutRefresh(0)

		local doubleCfg = BonusController.instance:isDoubleDayWeekTask(self._period)

		if doubleCfg and not string.nilorempty(doubleCfg.featureParam) then
			self._isDouble = true

			local params = string.split(doubleCfg.featureParam, "#")

			GameUtil.SetActive(self._doubleGo, true)

			self._doubleTxt.text = string.format("限时%s倍", GameUtil.getChineseNumber(checknumber(params[1])))
		end

		self:_onDataRefreshed()
	elseif self._period == GameEnum.TaskViewTab.TimeLimit then
		self._diamond:SetActive(false)
		self._portionTaskView:setActive(false)
		self:showTabAt(self._timeLimitGo, ViewName.TimeLimitTaskView)
	elseif self._period == GameEnum.TaskViewTab.Achievement then
		self._diamond:SetActive(false)
		self._portionTaskView:setActive(false)

		local rootData = self.keyList[self._period]
		local leafData

		if rootData then
			leafData = rootData.leaf[leaf]

			self:showTabAt(self._timeLimitGo, ViewName.AchievementrightView, rootData.leaf[leaf].cfg)
			GlobalDispatcher:dispatch(GlobalNotify.UpdateAchievementrightView, leafData.cfg)
		end
	else
		self._diamond:SetActive(false)
		self._portionTaskView:setActive(true)
		self:showTabAt(self._timeLimitGo, nil)

		if period == 3 then
			self._portionTaskView:showTask(GameEnum.TaskType.Main)
		elseif period == 4 then
			self._portionTaskView:showTask(GameEnum.TaskType.Branch)
		elseif period == 5 then
			self._portionTaskView:showTask(GameEnum.TaskType.Guide)
		end
	end
end

function DiamondTaskView:getTagByData(data, idx)
	return data.tag
end

function DiamondTaskView:getCellSize(view, idx)
	local list = self.scrollList:getData()
	local data = list[idx + 1]

	if data.tag == 1 then
		return 192, 70
	else
		return 192, 60
	end
end

return DiamondTaskView
