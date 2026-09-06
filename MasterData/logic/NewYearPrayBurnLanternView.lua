-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayBurnLanternView.lua

module("logic.extensions.newyearpray.view.NewYearPrayBurnLanternView", package.seeall)

local NewYearPrayBurnLanternView = class("NewYearPrayBurnLanternView", ViewComponent)

function NewYearPrayBurnLanternView:ctor()
	NewYearPrayBurnLanternView.super.ctor(self)

	self._txtAddScorePool = {}
end

function NewYearPrayBurnLanternView:buildUI()
	NewYearPrayBurnLanternView.super.buildUI(self)

	self._lanternCol = goutil.findChild(self.mainGO, "lanternCol")
	self._lanternCol_img = goutil.findChild(self.mainGO, "lanternCol/img")
	self._lanternCol_eff = goutil.findChild(self.mainGO, "lanternCol/eff")
	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._progressBar = goutil.findChild(self.mainGO, "progressCol/progressBar")
	self._gridView = goutil.findChild(self.mainGO, "progressCol/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "progressCol/gridCell")
	self._sliderComp = self:getSlider("progressCol/progressBar")
	self._btnBurn = goutil.findChild(self.mainGO, "btnBurn")
	self._btnBurn_btn = goutil.findChild(self.mainGO, "btnBurn/btn")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._floatWord = goutil.findChild(self.mainGO, "floatWord")
	self._floatWord_view = goutil.findChild(self.mainGO, "floatWord/view")
	self._floatWord_score = goutil.findChild(self.mainGO, "floatWord/score")

	GameUtil.SetActive(self._floatWord_score)
	GameUtil.SetActive(self._gridCell, false)
end

function NewYearPrayBurnLanternView:bindEvents()
	NewYearPrayBurnLanternView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBurn_btn, self._onClickBtnBurn, self)
	self._sliderComp:AddOnValueChanged(self._onSliderValueChange, self)
end

function NewYearPrayBurnLanternView:unbindEvents()
	NewYearPrayBurnLanternView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBurn_btn)
	self._sliderComp:RemoveOnValueChanged()
end

function NewYearPrayBurnLanternView:onEnter()
	NewYearPrayBurnLanternView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stepId = checknumber(params[2])

	if self._activityId <= 0 or self._stepId <= 0 then
		self:close()

		return
	end

	self._activityType = NewYearPrayController.instance:getActivityType()
	self._burnData = NewYearPrayConfig.instance:getNypBurnDataByAct(self._activityId)
	self._burnPointCfg = NewYearPrayConfig.instance:getNypBurnPointCfgByAct(self._activityId)
	self._playerMo = NewYearPrayController.instance:getNypPlayerMo(self._activityId)
	self._failProgress = self._burnData.failProgress
	self._addProgress = self._burnData.addProgress
	self._totalTime = self._burnData.time
	self._curProgress = 0
	self._curScore = 0

	self:_onSetUI()
	self:_onUpdate()
	self:_startTicking()
end

function NewYearPrayBurnLanternView:onExit()
	NewYearPrayBurnLanternView.super.onExit(self)
	self:_stopTicking()
	self:_clearAllTxtPools()
	self:_onClear()
	self:_stopLiangEffect()
	self:_stopYanhuaEffect()
end

function NewYearPrayBurnLanternView:_checkResult()
	local choiceId = 0
	local cfg = NewYearPrayConfig.instance:getNypBurnProgressCfgByAct(self._activityId)

	if #cfg > 0 then
		local data = cfg[1]

		choiceId = data.choiceId
	end

	for _, data in ipairs(cfg) do
		if self._curScore >= data.score then
			choiceId = data.choiceId
		else
			break
		end
	end

	if choiceId > 0 then
		self._playerMo:setChoiceId(self._stepId, choiceId)

		if choiceId > 1 then
			self:_playYanhuaEffect(function()
				GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfNextScene)
			end)
		else
			GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfNextScene)
		end
	else
		printError(string.format("没有找到合适的选择( curScore = %s | export_燃灯进度配置 )", self._curScore))
	end
end

function NewYearPrayBurnLanternView:_onSetUI()
	local lanternId = self._playerMo:getChoiceLanternId()
	local data = NewYearPrayConfig.instance:getNypWishingLanternData(lanternId)

	if data == nil then
		local tabId = self._playerMo:getTodayWishingTabId()
		local tabData = NewYearPrayConfig.instance:getNypWishingTabDataByAct(self._activityId, tabId)

		lanternId = tabData.lanternIdList[1]
		data = NewYearPrayConfig.instance:getNypWishingLanternData(tabData.lanternIdList[1])
	end

	self:_loadBigBg(self._lanternCol_img, data.iconPath, true)
	GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfSpineAnim, self._burnData.animName)
	GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfBubble, self._burnData.bubbleId)
end

function NewYearPrayBurnLanternView:_onUpdate()
	self:_onUpdateGridColUI()
end

function NewYearPrayBurnLanternView:_onClear()
	self:_onClearGridCol()
end

function NewYearPrayBurnLanternView:_startTicking()
	self._deltaTimeOfTicking = 0.01
	self._curLeftTime = self._totalTime
	self._curScore = 0
	self._lastCurScore = 0
	self._curProgress = 0
	self._deltaTime = 0
	self._isTiciking = true
	self._needRmTaskIds = {}

	local cfg = NewYearPrayConfig.instance:getNypBurnProgressCfgByAct(self._activityId)
	local maxData = cfg[#cfg]

	if maxData then
		self._maxScore = maxData.score or 0
	end

	self:_updateProgressUIOfTicking()
	self:_regTask(0, true, GameUtil.handler(self._updateProgressDataOfTicking, self))
	self:_regTask(0.5, true, GameUtil.handler(self._popScoreFloatWordOfTicking, self))
	settimer(0, self._onTicking, self)
end

function NewYearPrayBurnLanternView:_stopTicking()
	self._isTiciking = false

	removetimer(self._onTicking, self)
	self:_clearAllTask()
end

function NewYearPrayBurnLanternView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	for index = 0, self._taskList:GetSize() - 1 do
		local info = self._taskList:Get(index)

		info.curTime = info.curTime + self._deltaTime

		if info.curTime >= info.params.unitTime then
			GameUtil.callBack(info.params.callBack)

			info.curTime = 0

			if not info.params.isLoop then
				table.insert(self._needRmTaskIds, info.taskId)
				self:_unregTask(info.taskId)
			end
		end
	end

	if #self._needRmTaskIds > 0 then
		for _, taskId in ipairs(self._needRmTaskIds) do
			self:_unregTask(taskId)
		end

		table.clear(self._needRmTaskIds)
	end

	self._curLeftTime = self._curLeftTime - self._deltaTime

	if self._curLeftTime <= 0 or self._curScore >= self._maxScore then
		self._curLeftTime = 0

		self:_stopTicking()
		self:_checkResult()

		return
	end
end

function NewYearPrayBurnLanternView:_regTask(unitTime, isLoop, callBack)
	self._taskList = self._taskList or Array.New()

	local info = {}

	info.params = {}
	info.params.unitTime = checknumber(unitTime)
	info.params.isLoop = checkbool(isLoop)
	info.params.callBack = callBack
	info.curTime = 0
	info.taskId = self:_getTaskId()

	self._taskList:PushBack(info)

	return info.taskId
end

function NewYearPrayBurnLanternView:_unregTask(taskId)
	self:_returnTaskId(taskId)

	for index = 0, self._taskList:GetSize() - 1 do
		local info = self._taskList:Get(index)

		if info.taskId == taskId then
			self._taskList:Erase(index)
		end
	end
end

function NewYearPrayBurnLanternView:_clearAllTask()
	self._taskList:Clear()
end

function NewYearPrayBurnLanternView:_getTaskId()
	local taskId

	self._taskIdList = self._taskIdList or {}
	self._curMaxTaskId = self._curMaxTaskId or 0

	if #self._taskIdList > 0 then
		taskId = self._taskIdList[#self._taskIdList]
		self._taskIdList[#self._taskIdList] = nil
	else
		taskId = self._curMaxTaskId
		self._curMaxTaskId = self._curMaxTaskId + 1
	end

	return taskId
end

function NewYearPrayBurnLanternView:_returnTaskId(taskId)
	self._taskIdList = self._taskIdList or {}

	table.insert(self._taskIdList, taskId)
end

function NewYearPrayBurnLanternView:_clearAllTaskId()
	self._taskIdList = nil
	self._curMaxTaskId = 0
end

function NewYearPrayBurnLanternView:_updateProgressDataOfTicking()
	self._curProgress = Mathf.Max(self._curProgress - self._failProgress, 0)

	local index = 1

	for idx, v in ipairs(self._burnPointCfg) do
		if self._curProgress <= v.showRatio then
			index = idx

			break
		end
	end

	self._curGridIndex = index

	local data = self._burnPointCfg[self._curGridIndex]

	if data then
		self._curScore = self._curScore + data.score
	end

	if self._curGridIndex >= #self._burnPointCfg then
		self:_playLiangEffect()
	else
		self:_stopLiangEffect()
	end

	self:_updateProgressUIOfTicking()
end

function NewYearPrayBurnLanternView:_updateProgressUIOfTicking()
	self._sliderComp:SetValue(self._curProgress)

	self._txtTime.text = string.format("倒计时：<color=#FFB537FF>%s</color>秒", Mathf.Round(self._curLeftTime))
end

function NewYearPrayBurnLanternView:_onUpdateGridColUI()
	local parentTran = self._gridView.transform
	local children = GameUtil.getChildren(parentTran)
	local childGo = self._gridCell
	local cfg = self._burnPointCfg
	local height = GameUtil.getHeight(self._gridView)

	self._gridCellList = {}

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = children[idx]

					if mainGo == nil then
						mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
					end

					local posY = height * data.showRatio

					GameUtil.setLocalPos(mainGo, 0, posY, 0)

					local cell = {}

					cell._imgSelected = goutil.findChild(mainGo, "imgSelected")
					cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
					self._gridCellList[idx] = cell

					self:_updateGridCell(cell, idx, data)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearGridCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function NewYearPrayBurnLanternView:_onClearGridCol()
	local parentTran = self._gridView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearGridCell(mainGo)
	end
end

function NewYearPrayBurnLanternView:_updateGridCell(cell, gridIdx, data)
	GameUtil.SetActive(cell._imgSelected, false)

	cell._txtName.text = data.name
end

function NewYearPrayBurnLanternView:_clearGridCell(mainGo)
	return
end

function NewYearPrayBurnLanternView:_popScoreFloatWordOfTicking()
	local delta = self._curScore - self._lastCurScore

	self._lastCurScore = self._curScore

	if delta > 0 then
		self:_onCatchPropsAddScores(delta)
	end
end

function NewYearPrayBurnLanternView:_onCatchPropsAddScores(score)
	local addScore = self:_popTextItem(self._txtAddScorePool, self._floatWord_score)

	addScore:GetComponent(goutil.Type_UIText).text = string.format("+%d", score)

	addScore.transform:SetParent(self._floatWord_view.transform)
	Framework.TransformUtil.SetLocalScale(addScore.transform, 1, 1, 1)

	local startPosX, startPosY, startPosZ = Framework.TransformUtil.GetLocalPos(self._floatWord_score.transform, 0, 0, 0)

	UnityTweens.TweenPosition.StartTween(addScore, Vector3.New(startPosX, startPosY, startPosZ), Vector3.New(startPosX + Mathf.Random(-20, 20), startPosY + Mathf.Random(20, 50), startPosZ), 0.5, UnityTweens.EaseType.easeOutSine, 0.3):AddListener(function()
		self:_recycleTextItem(self._txtAddScorePool, addScore)

		self._movingAddScore[addScore] = nil
	end)

	self._movingAddScore = self._movingAddScore or {}
	self._movingAddScore[addScore] = addScore

	addScore:SetActive(true)
end

function NewYearPrayBurnLanternView:_popTextItem(pool, prefab)
	local go = pool[#pool]

	if goutil.isNil(go) then
		go = goutil.clone(prefab)
	else
		table.remove(pool, #pool)
	end

	return go
end

function NewYearPrayBurnLanternView:_recycleTextItem(pool, go)
	table.insert(pool, go)
	go:SetActive(false)
end

function NewYearPrayBurnLanternView:_clearAllTxtPools()
	for i = 1, #self._txtAddScorePool do
		goutil.destroy(self._txtAddScorePool[i])
	end

	table.clear(self._txtAddScorePool)

	if self._movingAddScore then
		for k, v in pairs(self._movingAddScore) do
			goutil.destroy(v)
		end

		self._movingAddScore = nil
	end
end

function NewYearPrayBurnLanternView:_onSliderValueChange(value)
	for idx, cell in ipairs(self._gridCellList) do
		GameUtil.SetActive(cell._imgSelected, idx == self._curGridIndex)
	end

	if value >= 1 then
		self:_stopTicking()

		local tipsContent = "烛火过旺，点灯失败！"

		local function okFunc()
			self:_checkResult()
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	end
end

function NewYearPrayBurnLanternView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function NewYearPrayBurnLanternView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function NewYearPrayBurnLanternView:_playLiangEffect()
	self._liangEffPlaying = self._liangEffPlaying or false

	if self._liangEffPlaying == true then
		return
	end

	local effParent = self._lanternCol_eff
	local pathName = "20231222/qiyuanxinnian/fx_ui_qiyuanxinnian_liang"

	self:_stopLiangEffect()

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self._liangEffPlaying = false
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._liangEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		self._liangEffPlaying = true
	end
end

function NewYearPrayBurnLanternView:_stopLiangEffect()
	UIEffectManager.instance:stopEffect(self._liangEff)

	self._liangEffPlaying = false
end

function NewYearPrayBurnLanternView:_playYanhuaEffect(_finishHandler)
	local effParent = self._lanternCol_eff
	local pathName = "20231222/qiyuanxinnian/fx_ui_qiyuanxinnian_yanhua"

	self:_stopYanhuaEffect()

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			GameUtil.callBack(_finishHandler, handlerTarget, eff)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._yanhuaEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function NewYearPrayBurnLanternView:_stopYanhuaEffect()
	UIEffectManager.instance:stopEffect(self._yanhuaEff)
end

function NewYearPrayBurnLanternView:_onClickBtnBurn()
	if not self._isTiciking then
		return
	end

	self._curProgress = Mathf.Min(self._curProgress + self._addProgress, 1)

	self._sliderComp:SetValue(self._curProgress)
end

return NewYearPrayBurnLanternView
