-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeGameView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeGameView", package.seeall)

local SunWuKongChallengeGameView = class("SunWuKongChallengeGameView", ViewComponent)

function SunWuKongChallengeGameView:ctor()
	SunWuKongChallengeGameView.super.ctor(self)

	self._contentRange = {
		[0] = 0,
		1
	}
	self._bgInfo = {
		{
			path = "",
			pos = Vector2.New(-2400, 0)
		},
		{
			path = "",
			pos = Vector2.New(-800, 0)
		},
		{
			path = "",
			pos = Vector2.New(800, 0)
		}
	}
end

function SunWuKongChallengeGameView:buildUI()
	SunWuKongChallengeGameView.super.buildUI(self)

	self._points = self:getGo("ScrollView/Viewport/Content/points")
	self._pointsPos = self._points:GetComponent("TestRecordPos")
	self._point = self:getGo("ScrollView/Viewport/Content/points/point")
	self._pointGroup = ItemGroup.New(self._points, self._point)
	self._scrollrectGo = self:getGo("ScrollView")
	self._scrollrect = Framework.ScrollRectAdapter.Get(self._scrollrectGo)
	self._contentGo = self:getGo("ScrollView/Viewport/Content")
	self._pointInfo = self:getGo("ScrollView/Viewport/Content/pointInfos/pointInfo")
	self._pointInfos = self:getGo("ScrollView/Viewport/Content/pointInfos")
	self._infoGroup = ItemGroup.New(self._pointInfos, self._pointInfo)
	self._bgsGo = self:getGo("ScrollView/Viewport/Content/pointBg")
	self._bgGo = self:getGo("ScrollView/Viewport/Content/pointBg/bgCon")
	self._bgGroup = ItemGroup.New(self._bgsGo, self._bgGo)
	self._curPos = self:getGo("ScrollView/Viewport/Content/curPos")
	self._curPos_2 = self:getGo("ScrollView/Viewport/Content/curPos_2")
	self._goldBarCon = self:getGo("goldBar")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._txtTime = self:getTxt("tiem/txtTime")
	self._btnCimelia = self:getBtn("btnCimelia")
	self._goldBarCon = self:getGo("goldBarCon")
	self._redPointCimelia = self:getGo("btnCimelia/redpoint")
end

function SunWuKongChallengeGameView:bindEvents()
	SunWuKongChallengeGameView.super.buildUI(self)
	self._scrollrect:AddOnValueChanged(self._onScrollValueChanged, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnCimelia, self._onClickCimelia, self)
end

function SunWuKongChallengeGameView:unbindEvents()
	SunWuKongChallengeGameView.super.unbindEvents(self)
	self._scrollrect:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnCimelia)
end

function SunWuKongChallengeGameView:onEnter()
	SunWuKongChallengeGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeGetInfoRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeDoHiddenTaskRes, self._PM_SunWuKongChallengeDoHiddenTaskRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeEndGameRes, self._PM_SunWuKongChallengeEndGameRes, self)
	SunWuKongChallengeController.instance:tryToOpenTipsView(self:_getTipsViewName())
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_SUNWUKONGCHALLENGE_DAILY_OPEN)
	self:initViewData()
	self:initView()
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetInfoReq(self._activityId)
end

function SunWuKongChallengeGameView:_getTipsViewName()
	return ViewName.SunWuKongChallengeTipsView
end

function SunWuKongChallengeGameView:onExit()
	SunWuKongChallengeGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeGetInfoRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeDoHiddenTaskRes, self._PM_SunWuKongChallengeDoHiddenTaskRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeEndGameRes, self._PM_SunWuKongChallengeEndGameRes, self)
	RedPointController.instance:unregRedPoint(self._redPointCimelia)
	self._pointGroup:dispose()
	self._infoGroup:dispose(self._clearPointInfo, self)
	self._bgGroup:dispose(self._clearPointBg, self)
end

function SunWuKongChallengeGameView:initViewData()
	local actId = checknumber(self:getFirstParam())

	self._activityId = actId == 0 and SunWuKongChallengeModel.instance:getCurrActId() or actId
	self._activityCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgList = SunWuKongChallengeConfig.instance:getStageInfos(self._activityCfg.stagePlanId)
	self._isFirstEnter = true
end

function SunWuKongChallengeGameView:_initPointPlan()
	self._pointPlanId = 0
end

function SunWuKongChallengeGameView:initView()
	self:_setTopGoldBar()
	self:_initPointPlan()

	self._targetStartPointIndex = 0
	self._targetEndPointIndex = 1

	self._pointGroup:updateWithLen(#self._stageCfgList, self._updatePathPoint, self)
	self._pointsPos:LoadPlan(self._pointPlanId)

	self._pointsGo = self._pointGroup:getItems()
	self._levelPathGos = {}

	for i, v in ipairs(self._pointsGo) do
		table.insert(self._levelPathGos, {
			mainGO = v.mainGO,
			index = i
		})
	end

	table.sort(self._levelPathGos, function(a, b)
		local posA = GameUtil.getAnchoredPos(a.mainGO)
		local posB = GameUtil.getAnchoredPos(b.mainGO)

		return posA.x < posB.x
	end)
	GameUtil.SetActive(self._curPos, false)
	GameUtil.SetActive(self._curPos_2, false)

	if checknumber(self._activityCfg.redPointId) ~= 0 then
		RedPointController.instance:regRedPoint(self._redPointCimelia, self._activityCfg.redPointId, RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA)
	else
		GameUtil.SetActive(self._redPointCimelia, false)
	end
end

function SunWuKongChallengeGameView:refreshView()
	local curStage = SunWuKongChallengeModel.instance:getCurStageId(self._activityId)
	local latestStage = SunWuKongChallengeController.instance:getLatestStage()

	if latestStage > 0 and not SunWuKongChallengeModel.instance:isPassHiddenStage(self._activityId, latestStage) then
		self._tempShowLevel = latestStage

		self:_onClickLevel(self._tempShowLevel)
	end

	SunWuKongChallengeController.instance:setLatestStage(nil)

	local curLevelPos = curStage <= 0 and GameUtil.getAnchoredPos(self._pointsGo[1].mainGO) or curStage < #self._stageCfgList and curStage > 0 and GameUtil.getAnchoredPos(self._pointsGo[curStage].mainGO) or GameUtil.getAnchoredPos(self._pointsGo[#self._stageCfgList].mainGO)

	GameUtil.SetActive(self._curPos, curStage <= #self._stageCfgList and curStage > 0)
	GameUtil.SetActive(self._curPos_2, curStage <= #self._stageCfgList and curStage > 0)

	if checknumber(self._tempShowLevel) > 0 then
		local tempPos = GameUtil.getAnchoredPos(self._pointsGo[self._tempShowLevel].mainGO)

		GameUtil.setAnchoredPos(self._contentGo, -tempPos.x, -tempPos.y)

		self._tempShowLevel = 0
	elseif self._isFirstEnter == true and curLevelPos then
		GameUtil.setAnchoredPos(self._contentGo, -curLevelPos.x, -curLevelPos.y)
	end

	self._isFirstEnter = false

	self:_calculateShowIndex()
	self._infoGroup:updateWithLen(self._targetEndPointIndex - self._targetStartPointIndex + 1, self._updatePointInfo, self)
	self._bgGroup:updateWithLen(self._targetEndPointIndex - self._targetStartPointIndex + 1, self._updatePointBg, self)

	if SunWuKongChallengeController.instance:isWinMainBattle() == true and curStage <= #self._stageCfgList and curStage > 1 then
		local lastPos = GameUtil.getAnchoredPos(self._pointsGo[curStage - 1].mainGO)

		UnityTweens.TweenPosition.StartTween(self._curPos, Vector3(lastPos.x, lastPos.y, 0), Vector3(curLevelPos.x, curLevelPos.y, 0), 1, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenPosition.StartTween(self._curPos_2, Vector3(lastPos.x, lastPos.y, 0), Vector3(curLevelPos.x, curLevelPos.y, 0), 1, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
		SunWuKongChallengeController.instance:resetWinMainBattle()
	else
		GameUtil.setAnchoredPos(self._curPos, curLevelPos.x, curLevelPos.y)
		GameUtil.setAnchoredPos(self._curPos_2, curLevelPos.x, curLevelPos.y)
	end
end

function SunWuKongChallengeGameView:_updatePathPoint(cell, index)
	local go = cell.mainGO

	go.name = "pointCell" .. index
end

function SunWuKongChallengeGameView:_updatePointInfo(cell, index)
	local go = cell.mainGO
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnLevel"))
	local hiddenLevel = goutil.findChild(go, "hiddenLevel")
	local txtHiddenLevelName = goutil.findChildTextComponent(go, "hiddenLevel/txt")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local compelete = goutil.findChild(go, "compelete")
	local hiddenIconChange = goutil.findChildComponent(go, "hiddenLevel/icon", "UIImageSpriteChange")
	local levelIndex = self._levelPathGos[index + self._targetStartPointIndex - 1].index
	local cfg = self._stageCfgList[levelIndex]
	local isPass = SunWuKongChallengeModel.instance:isPassNomalStage(self._activityId, levelIndex)
	local haveHidden = false

	if isPass == true and cfg and checknumber(cfg.hiddenTaskId) > 0 then
		haveHidden = not SunWuKongChallengeModel.instance:isPassHiddenStage(self._activityId, levelIndex)
	end

	if isPass == true then
		if haveHidden == true then
			GameUtil.SetActive(compelete, false)
			GameUtil.SetActive(hiddenLevel, true)
		else
			GameUtil.SetActive(compelete, true)
			GameUtil.SetActive(hiddenLevel, false)
		end
	else
		GameUtil.SetActive(compelete, false)
		GameUtil.SetActive(hiddenLevel, false)
	end

	if haveHidden == true then
		local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(cfg.hiddenTaskId)
		local type = SunWuKongChallengeModel.HiddenType.Battle

		if hiddentTaskCfg.taskType == "Battle" then
			type = SunWuKongChallengeModel.HiddenType.Battle
		elseif hiddentTaskCfg.taskType == "CollectMaterials" then
			type = SunWuKongChallengeModel.HiddenType.CollectMaterials
		elseif hiddentTaskCfg.taskType == "VerifyPet" then
			type = SunWuKongChallengeModel.HiddenType.VerifyPet
		elseif hiddentTaskCfg.taskType == "SmallGame" then
			local hiddenTaskInfo = hiddentTaskCfg.taskParams

			if checknumber(hiddenTaskInfo.type) == SunWuKongChallengeModel.MiniGameType.Balloon then
				type = SunWuKongChallengeModel.HiddenType.Balloon
			elseif checknumber(hiddenTaskInfo.type) == SunWuKongChallengeModel.MiniGameType.FlipGame then
				type = SunWuKongChallengeModel.HiddenType.FilpGame
			end
		end

		txtHiddenLevelName.text = hiddentTaskCfg.simplyName

		hiddenIconChange:SetState(type - 1)
	else
		txtHiddenLevelName.text = ""
	end

	local targetPos = GameUtil.getAnchoredPos(self._pointsGo[levelIndex].mainGO)

	GameUtil.setAnchoredPos(go, targetPos.x, targetPos.y)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickLevel(levelIndex)
	end)
end

function SunWuKongChallengeGameView:_clearPointInfo(cell)
	local go = cell.mainGO
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnLevel"))

	btn:RemoveClickListener()
end

function SunWuKongChallengeGameView:_updatePointBg(cell, index)
	local go = cell.mainGO
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local levelIndex = self._levelPathGos[index + self._targetStartPointIndex - 1].index
	local targetPos = GameUtil.getAnchoredPos(self._pointsGo[levelIndex].mainGO)

	GameUtil.setAnchoredPos(go, targetPos.x, targetPos.y)

	txtLevel.text = levelIndex
end

function SunWuKongChallengeGameView:_clearPointBg(cell)
	return
end

function SunWuKongChallengeGameView:_onScrollValueChanged(vec2)
	local isChange = self:_calculateShowIndex()

	if isChange == true then
		self._infoGroup:updateWithLen(self._targetEndPointIndex - self._targetStartPointIndex + 1, self._updatePointInfo, self)
		self._bgGroup:updateWithLen(self._targetEndPointIndex - self._targetStartPointIndex + 1, self._updatePointBg, self)
	end
end

function SunWuKongChallengeGameView:_calculateShowIndex()
	local contentPos = GameUtil.getAnchoredPos(self._contentGo)

	self._contentRange[0] = -contentPos.x - UnityEngine.Screen.width / 2 - 200
	self._contentRange[1] = -contentPos.x + UnityEngine.Screen.width / 2 + 200

	local targetStartPointIndex, targetEndPointIndex = self:_closestToBoundarySorted(self._levelPathGos, self._contentRange)
	local isChange = false

	if self._targetStartPointIndex ~= targetStartPointIndex or self._targetEndPointIndex ~= targetEndPointIndex then
		isChange = true
		self._targetStartPointIndex = targetStartPointIndex
		self._targetEndPointIndex = targetEndPointIndex
	end

	return isChange
end

function SunWuKongChallengeGameView:_closestToBoundarySorted(arr, interval)
	local lower_idx = self:_binarySearch(arr, interval[0])
	local upper_idx = self:_binarySearch(arr, interval[1])

	if lower_idx >= #arr then
		return #arr, upper_idx - 1
	elseif lower_idx <= 1 then
		return 1, upper_idx - 1
	elseif math.abs(GameUtil.getAnchoredPos(arr[lower_idx].mainGO).x - interval[0]) < math.abs(GameUtil.getAnchoredPos(arr[lower_idx - 1].mainGO).x - interval[0]) then
		if GameUtil.getAnchoredPos(arr[lower_idx].mainGO).x >= interval[0] and GameUtil.getAnchoredPos(arr[lower_idx].mainGO).x <= interval[1] then
			return lower_idx, upper_idx - 1
		else
			return lower_idx + 1, upper_idx - 1
		end
	elseif GameUtil.getAnchoredPos(arr[lower_idx - 1].mainGO).x >= interval[0] and GameUtil.getAnchoredPos(arr[lower_idx - 1].mainGO).x <= interval[1] then
		return lower_idx - 1, upper_idx - 1
	else
		return lower_idx, upper_idx - 1
	end
end

function SunWuKongChallengeGameView:_binarySearch(arr, target)
	local left = 1
	local right = #arr

	while left <= right do
		local mid = math.floor((left + right) / 2)
		local midPos = GameUtil.getAnchoredPos(arr[mid].mainGO)

		if midPos.x == target then
			return mid
		elseif target > midPos.x then
			left = mid + 1
		else
			right = mid - 1
		end
	end

	return left
end

function SunWuKongChallengeGameView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function SunWuKongChallengeGameView:_onClickCimelia()
	UIStateManager.instance:push(ViewName.SunWuKongChallengeCimeliaView, self._activityId)
end

function SunWuKongChallengeGameView:_onClickLevel(levelIndex)
	local cfg = self._stageCfgList[levelIndex]
	local isPass = SunWuKongChallengeModel.instance:isPassNomalStage(self._activityId, levelIndex)

	if isPass == true then
		if ((cfg and checknumber(cfg.hiddenTaskId) > 0 or nil) and not SunWuKongChallengeModel.instance:isPassHiddenStage(self._activityId, levelIndex)) == true then
			self:_openHidenView(levelIndex)
		else
			return
		end
	elseif levelIndex == SunWuKongChallengeModel.instance:getCurStageId(self._activityId) then
		self:_openChallengeNormalView(levelIndex)
	else
		FloatWordMgr.instance:show(lang("请先通关前面的关卡"))
	end
end

function SunWuKongChallengeGameView:_openChallengeNormalView(levelIndex)
	UIStateManager.instance:push(ViewName.SunWuKongChallengeNomalView, self._activityId, levelIndex)
end

function SunWuKongChallengeGameView:_openHidenView(levelIndex)
	UIStateManager.instance:push(ViewName.SunWuKongChallengeHidenView, self._activityId, levelIndex)
end

function SunWuKongChallengeGameView:_PM_SunWuKongChallengeDoHiddenTaskRes()
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetInfoReq(self._activityId)
end

function SunWuKongChallengeGameView:_PM_SunWuKongChallengeEndGameRes()
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetInfoReq(self._activityId)
end

function SunWuKongChallengeGameView:_setTopGoldBar()
	local barShow = string.split(self._activityCfg.goldBar2, "#")
	local btn_list = {}

	for i, v in ipairs(barShow) do
		local matType, matId, num = MaterialMgr.getMatParams(v)

		table.insert(btn_list, {
			showAdd = true,
			id = string.format("%d:%d", matType, matId)
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return SunWuKongChallengeGameView
