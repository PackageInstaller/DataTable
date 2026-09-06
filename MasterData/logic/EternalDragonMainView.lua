-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/EternalDragonMainView.lua

module("logic.extensions.eternaldragon.view.EternalDragonMainView", package.seeall)

local EternalDragonMainView = class("EternalDragonMainView", ViewComponent)

function EternalDragonMainView:buildUI()
	EternalDragonMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._growEffParent = goutil.findChild(self.mainGO, "growEffParent")
	self._growEff = nil
	self._waterEffParent = goutil.findChild(self.mainGO, "waterEffParent")
	self._waterEff = nil
	self._growBtnCol = {}

	if self._growBtnCol then
		local mainGo = goutil.findChild(self.mainGO, "growInfoCol/growBtnCol")

		self._growBtnCol._mainGo = mainGo
		self._growBtnCol._btnGrow1 = {}
		self._growBtnCol._btnGrow1._mainGo = goutil.findChild(mainGo, "btnGrow1")
		self._growBtnCol._btnGrow1._content = goutil.findChild(mainGo, "btnGrow1/content")
		self._growBtnCol._btnGrow1._redPoint = goutil.findChild(mainGo, "btnGrow1/content/redPoint")
		self._growBtnCol._btnGrow1._txtTips = goutil.findChildTextComponent(mainGo, "btnGrow1/content/txtTips/txt")
		self._growBtnCol._btnGrow1._imgLock = goutil.findChild(mainGo, "btnGrow1/imgLock")
		self._growBtnCol._btnGrow2 = {}
		self._growBtnCol._btnGrow2._mainGo = goutil.findChild(mainGo, "btnGrow2")
		self._growBtnCol._btnGrow2._content = goutil.findChild(mainGo, "btnGrow2/content")
		self._growBtnCol._btnGrow2._redPoint = goutil.findChild(mainGo, "btnGrow2/content/redPoint")
		self._growBtnCol._btnGrow2._imgLock = goutil.findChild(mainGo, "btnGrow2/imgLock")
		self._growBtnCol._btnGrow2._txtTips = goutil.findChildTextComponent(mainGo, "btnGrow2/content/txtTips/txt")
		self._growBtnCol._btnGrow3 = {}
		self._growBtnCol._btnGrow3._mainGo = goutil.findChild(mainGo, "btnGrow3")
		self._growBtnCol._btnGrow3._content = goutil.findChild(mainGo, "btnGrow3/content")
		self._growBtnCol._btnGrow3._redPoint = goutil.findChild(mainGo, "btnGrow3/content/redPoint")
		self._growBtnCol._btnGrow3._txtTips = goutil.findChildTextComponent(mainGo, "btnGrow3/content/txtTips/txt")
		self._growBtnCol._btnGrow3._imgLock = goutil.findChild(mainGo, "btnGrow3/imgLock")
		self._growBtnCol._btnGrow3._bubble = goutil.findChild(mainGo, "btnGrow3/bubble")
		self._growBtnCol._btnGrow3._txtBubble = goutil.findChildTextComponent(mainGo, "btnGrow3/bubble/txt")
	end

	self._growInfoCol = {}

	if self._growInfoCol then
		local mainGo = goutil.findChild(self.mainGO, "growInfoCol")

		self._growInfoCol._mainGo = mainGo
		self._growInfoCol._imgCon = goutil.findChild(mainGo, "imgCon")
		self._growInfoCol._bubble = goutil.findChild(mainGo, "bubble")
		self._growInfoCol._txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
	end

	self._tabCol = {}

	if self._tabCol then
		local mainGo = goutil.findChild(self.mainGO, "descCol/tabCol")

		self._tabCol._mainGo = mainGo

		local tabScrollerview = goutil.findChild(mainGo, "tabScrollerview")
		local tabScrollercell = goutil.findChild(mainGo, "tabScrollercell")

		self._tabCol._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	end

	self._prizeCol = {}

	if self._prizeCol then
		local mainGo = goutil.findChild(self.mainGO, "descCol/prizeCol")

		self._prizeCol._mainGo = mainGo

		local prizeScrollerview = goutil.findChild(mainGo, "prizeScrollerview")
		local prizeScrollercell = goutil.findChild(mainGo, "prizeScrollercell")

		self._prizeCol._prizeScrollList = ScrollerList.create(prizeScrollerview, prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
		self._prizeCol._txtTipsOfNotCanGain = goutil.findChildTextComponent(mainGo, "txtTipsOfNotCanGain")
		self._prizeCol._txtTipsOfCanGain = goutil.findChildTextComponent(mainGo, "txtTipsOfCanGain")
		self._prizeCol._btnGet = goutil.findChild(mainGo, "btnGet")
	end

	self._storyCol = {}

	if self._storyCol then
		local mainGo = goutil.findChild(self.mainGO, "descCol/storyCol")

		self._storyCol._mainGo = mainGo
		self._storyCol._single = goutil.findChild(mainGo, "single")
		self._storyCol._double = goutil.findChild(mainGo, "double")
	end
end

function EternalDragonMainView:bindEvents()
	EternalDragonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._growBtnCol._btnGrow1._mainGo, self._onClickBtnGrow1, self)
	GameUtil.addClickHandler(self._growBtnCol._btnGrow2._mainGo, self._onClickBtnGrow2, self)
	GameUtil.addClickHandler(self._growBtnCol._btnGrow3._mainGo, self._onClickBtnGrow3, self)
	GameUtil.addClickHandler(self._prizeCol._btnGet, self._onClickPrizeColBtnGet, self)
end

function EternalDragonMainView:unbindEvents()
	EternalDragonMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._growBtnCol._btnGrow1._mainGo)
	GameUtil.rmClickHandler(self._growBtnCol._btnGrow2._mainGo)
	GameUtil.rmClickHandler(self._growBtnCol._btnGrow3._mainGo)
	GameUtil.rmClickHandler(self._prizeCol._btnGet)
end

function EternalDragonMainView:onEnter()
	EternalDragonMainView.super.onEnter(self)

	self._activityId = EternalDragonController.instance:getActivityId()
	self._activityType = EternalDragonController.instance:getActivityType()

	local isInTime = EternalDragonController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._edActData = EternalDragonConfig.instance:getEdActData(self._activityId)

	local storyId = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "firstStoryId")

	if storyId > 0 then
		local key = "EternalDragon_" .. self._activityId

		local function firstTimeCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.EternalDragonInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.EternalDragonGainPrizeRes, self._handleGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.EternalDragonWaterRes, self._handleWaterRes, self)
	self.addGEvent(self, GlobalNotify.EternalDragonStartGameRes, self._handleStartGameRes, self)
	self.addGEvent(self, GlobalNotify.EternalDragonCuttingRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function EternalDragonMainView:onExit()
	EternalDragonMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._growBtnCol._btnGrow1._redPoint)
	RedPointController.instance:unregRedPoint(self._growBtnCol._btnGrow2._redPoint)
	RedPointController.instance:unregRedPoint(self._growBtnCol._btnGrow3._redPoint)
	self:_stopEnergyCountDown()
	self:_onClearTabCol()
	self:_onClearPrizeCol()
	self:_onClearStoryCol()
	self:_onClearGrowInfoCol()
end

function EternalDragonMainView:_handleGainPrizeRes()
	self:_sendInfoReq()
end

function EternalDragonMainView:_handleWaterRes()
	self:_playWaterToGrowEff(function()
		self:_sendInfoReq()
	end)
end

function EternalDragonMainView:_handleStartGameRes()
	UIStateManager.instance:push(ViewName.EdCopyBuryGameMainView, self._activityId)
end

function EternalDragonMainView:_sendInfoReq()
	EternalDragonController.instance:sendPM_EternalDragonInfoReq(self._activityId)
end

function EternalDragonMainView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	RedPointController.instance:regRedPoint(self._growBtnCol._btnGrow1._redPoint, RedPointModel.ID_ETERNAL_DRAGON_WATER)
	RedPointController.instance:regRedPoint(self._growBtnCol._btnGrow2._redPoint, RedPointModel.ID_ETERNAL_DRAGON_DISPEL)
	RedPointController.instance:regRedPoint(self._growBtnCol._btnGrow3._redPoint, RedPointModel.ID_ETERNAL_DRAGON_CUT)
end

function EternalDragonMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalDragonMainView:_onUpdateData()
	self:_onUpdateTabData()
	self:_onUpdateGrowInfoColData()
end

function EternalDragonMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdatePrizeColUI()
	self:_onUpdateStoryColUI()
	self:_onUpdateGrowInfoColUI()
end

function EternalDragonMainView:_onUpdatePlaneUI()
	local waterTimes = EternalDragonController.instance:getLeftWaterTimes()

	self._growBtnCol._btnGrow1._txtTips.text = string.format("次数：%s", waterTimes)

	local isUnlockOfDisple = EternalDragonController.instance:isUnlockOfDisple(self._activityId)
	local maxGameTimes = EternalDragonController.instance:getMaxGameTimes(self._activityId)
	local leftGameTimes = EternalDragonController.instance:getLeftGameTimes(self._activityId)

	self._growBtnCol._btnGrow2._txtTips.text = string.format("次数：%s/%s", leftGameTimes, maxGameTimes)

	GameUtil.SetActive(self._growBtnCol._btnGrow2._imgLock, not isUnlockOfDisple)
	GameUtil.SetGray(self._growBtnCol._btnGrow2._content, not isUnlockOfDisple)

	local isUnlockOfCut = EternalDragonController.instance:isUnlockOfCut(self._activityId)
	local isFullEnergy = EternalDragonController.instance:isFullEnergy(self._activityId)
	local maxCutTimes = EternalDragonController.instance:getMaxCutTimes(self._activityId)
	local curCutTimes = EternalDragonController.instance:getCurCutTimes(self._activityId)

	self._growBtnCol._btnGrow3._txtTips.text = string.format("次数：%s/%s", curCutTimes, maxCutTimes)

	GameUtil.SetActive(self._growBtnCol._btnGrow3._imgLock, not isUnlockOfCut)
	GameUtil.SetGray(self._growBtnCol._btnGrow3._content, not isUnlockOfCut)

	if isUnlockOfCut and not isFullEnergy then
		GameUtil.SetActive(self._growBtnCol._btnGrow3._bubble, true)
		self:_startEnergyCountDown(self._growBtnCol._btnGrow3._txtBubble)
	else
		GameUtil.SetActive(self._growBtnCol._btnGrow3._bubble, false)
		self:_stopEnergyCountDown()
	end
end

function EternalDragonMainView:_onUpdateTabData()
	local curGrowId = EternalDragonController.instance:getCurGrowId(self._activityId)

	self._tabInfoList = {}

	local dataList = EternalDragonConfig.instance:getEdScoreDataList(self._activityId)

	for id, data in ipairs(dataList) do
		local info = {}

		info.growId = id
		info.data = data
		info.result = EternalDragonController.instance:getTryGainPrizeResultAndTips(self._activityId, info.growId)
		info.state = EternalDragonController.instance:getPrizeState(self._activityId, info.growId)
		info.isUnlockStory = info.state == GameEnum.PrizeState.IsHasGain and curGrowId >= info.growId

		table.insert(self._tabInfoList, info)
	end

	self._curTabIdx = 0

	for idx, info in ipairs(self._tabInfoList) do
		if info.isUnlockStory then
			self._curTabIdx = idx
		elseif info.state == GameEnum.PrizeState.IsCanGet then
			self._curTabIdx = idx

			break
		end
	end

	self._curTabIdx = Mathf.Clamp(self._curTabIdx, 1, #self._tabInfoList)
end

function EternalDragonMainView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function EternalDragonMainView:_getGrowId(tabIdx)
	local info = self:_getTabInfo(tabIdx)

	return info.growId
end

function EternalDragonMainView:_getGrowData(tabIdx)
	local info = self:_getTabInfo(tabIdx)

	return info.data
end

function EternalDragonMainView:_getGrowPrizeResult(tabIdx)
	local info = self:_getTabInfo(tabIdx)

	return info.result
end

function EternalDragonMainView:_getGrowPrizeState(tabIdx)
	local info = self:_getTabInfo(tabIdx)

	return info.state
end

function EternalDragonMainView:_isUnlockStory(tabIdx)
	local info = self:_getTabInfo(tabIdx)

	return info.isUnlockStory
end

function EternalDragonMainView:_onUpdateTabColUI()
	local tabIdxList = {}

	for tabIndex, info in ipairs(self._tabInfoList) do
		table.insert(tabIdxList, tabIndex)
	end

	self._tabCol._tabScrollList:reloadData(tabIdxList)
	self._tabCol._tabScrollList:MoveCellInView(self._curTabIdx - 1, true)
end

function EternalDragonMainView:_onClearTabCol()
	self._tabCol._tabScrollList:dispose()
end

function EternalDragonMainView:_updateTabCell(view, cell, tabIdx, tag)
	local info = self:_getTabInfo(tabIdx)
	local growId = self:_getGrowId(tabIdx)
	local data = self:_getGrowData(tabIdx)
	local result = self:_getGrowPrizeResult(tabIdx)
	local state = self:_getGrowPrizeState(tabIdx)
	local isUnlockStory = self:_isUnlockStory(tabIdx)
	local curGrowId = EternalDragonController.instance:getCurGrowId(self._activityId)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local change = goutil.findChild(mainGo, "txtName"):GetComponent(ComponentType.UITextColorChange)
	local isGray = curGrowId < growId
	local isSelect = self._curTabIdx == tabIdx

	txtName.text = data.desc

	GameUtil.SetActive(redPoint, result == GameEnum.ResultCode.Success)
	GameUtil.SetActive(imgSelect, isSelect)
	GameUtil.SetGray(mainGo, not isSelect and isGray)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, tabIdx))
	change:SetState(not isSelect and isGray and 0 or 1)
end

function EternalDragonMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	GameUtil.rmClickHandler(mainGo)
end

function EternalDragonMainView:_onClickTab(tabIdx)
	self._curTabIdx = tabIdx

	self:_onUpdateUI()
end

function EternalDragonMainView:_onUpdatePrizeColUI()
	local isUnlockStory = self:_isUnlockStory(self._curTabIdx)
	local isNeedUpdate = not isUnlockStory

	GameUtil.SetActive(self._prizeCol._mainGo, isNeedUpdate)

	if not isNeedUpdate then
		return
	end

	local data = self:_getGrowData(self._curTabIdx)
	local state = self:_getGrowPrizeState(self._curTabIdx)
	local tipsOfCanGain = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfCanGain")

	self._prizeCol._txtTipsOfCanGain.text = string.format(tipsOfCanGain, data.desc)
	self._prizeCol._txtTipsOfNotCanGain.text = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfNotCanGain")

	GameUtil.SetActive(self._prizeCol._btnGet, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(self._prizeCol._txtTipsOfNotCanGain.gameObject, state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.SetActive(self._prizeCol._txtTipsOfCanGain.gameObject, state == GameEnum.PrizeState.IsCanGet)

	local prizeStrList

	self._prizeCol._prizeScrollList:reloadData((not string.nilorempty(data.prize) or nil) and string.split(data.prize, "#") or {})
end

function EternalDragonMainView:_onClearPrizeCol()
	self._prizeCol._prizeScrollList:dispose()
end

function EternalDragonMainView:_updatePrizeCell(view, cell, prizeStr, tag)
	local state = self:_getGrowPrizeState(self._curTabIdx)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effParent = goutil.findChild(mainGo, "effParent")

	MaterialMgr.setCellByCfg(prizeStr, item)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[effParent])

	if state == GameEnum.PrizeState.IsCanGet then
		local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			local handlerTarget

			self._prizeEffPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function EternalDragonMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local effParent = goutil.findChild(mainGo, "effParent")

	MaterialMgr.resetAll(item)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[effParent])
	end

	GameUtil.rmClickHandler(mainGo)
end

function EternalDragonMainView:_onClickPrizeCell(data, tabIdx)
	self._curTabIdx = tabIdx

	self:_onUpdateUI()
end

function EternalDragonMainView:_onClickPrizeColBtnGet()
	local growId = self:_getGrowId(self._curTabIdx)
	local result, tips = EternalDragonController.instance:getTryGainPrizeResultAndTips(self._activityId, growId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	EternalDragonController.instance:sendPM_EternalDragonGainPrizeReq(self._activityId, growId)
end

function EternalDragonMainView:_onUpdateStoryColUI()
	local isNeedUpdate = self:_isUnlockStory(self._curTabIdx)

	GameUtil.SetActive(self._storyCol._mainGo, isNeedUpdate)

	if not isNeedUpdate then
		return
	end

	local parentTran
	local growData = self:_getGrowData(self._curTabIdx)

	if not growData.storyIdList then
		local storyIdList = {}

		if #storyIdList == 1 then
			parentTran = self._storyCol._single

			GameUtil.SetActive(self._storyCol._single, true)
			GameUtil.SetActive(self._storyCol._double, not GameUtil.GetActive(self._storyCol._single))
		elseif #storyIdList >= 2 then
			parentTran = self._storyCol._double

			GameUtil.SetActive(self._storyCol._single, false)
			GameUtil.SetActive(self._storyCol._double, not GameUtil.GetActive(self._storyCol._single))
		else
			GameUtil.SetActive(self._storyCol._single, false)
			GameUtil.SetActive(self._storyCol._double, false)
		end

		local childeren = GameUtil.getChildren(parentTran)

		for idx, storyId in ipairs(storyIdList) do
			local mainGo = childeren[idx]

			if mainGo then
				self:_updateStoryCell(mainGo, storyId)
			else
				printError(string.format("配置超出预制数量( storyId = %s )( yy运营-永恒圣龙揭秘.xlsx | export_故事配置 )", storyId))
			end
		end
	end
end

function EternalDragonMainView:_onClearStoryCol()
	local parentTran = self._storyCol._mainGo
	local childeren = GameUtil.getChildren(parentTran)

	for _, col in ipairs(childeren) do
		for idx = 1, col.transform.childCount do
			local mainGo = col.transform:GetChild(idx - 1).gameObject

			self:_clearStoryCell(mainGo)
		end
	end
end

function EternalDragonMainView:_updateStoryCell(mainGo, storyId)
	local imgStory = goutil.findChild(mainGo, "imgStory")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc/Viewport/Content")
	local data = EternalDragonConfig.instance:getEdStoryData(storyId)

	self:_loadBigBg(imgStory, data.picturePath)

	txtDesc.text = data.desc
end

function EternalDragonMainView:_clearStoryCell(mainGo)
	local imgStory = goutil.findChild(mainGo, "imgStory")

	self:_unLoadBigBg(imgStory)
end

function EternalDragonMainView:_onUpdateGrowInfoColData()
	return
end

function EternalDragonMainView:_onUpdateGrowInfoColUI()
	self:_tryUpdateCurGrowInfoToNextPeriod()
end

function EternalDragonMainView:_onClearGrowInfoCol()
	self:_clearGrowInfoValueChangeAnim()
	self:_clearPictureOfGrow()
	self:_clearGrowUpdateEff()
	self:_clearWaterToGrowEff()
end

function EternalDragonMainView:_updateTxtGrowInfo(progress, desc)
	local tipsOfBubbleInGrowing = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfBubbleInGrowing")

	self._growInfoCol._txtBubble.text = string.format(tipsOfBubbleInGrowing, progress * 100, desc)
end

function EternalDragonMainView:_updatePictureOfGrow(growId)
	local data = EternalDragonConfig.instance:getEdScoreData(self._activityId, growId)
	local path = string.format("bigbg/%s", data.picturePath)

	self:_loadBigBg(self._growInfoCol._imgCon, path, true)
end

function EternalDragonMainView:_clearPictureOfGrow()
	self:_unLoadBigBg(self._growInfoCol._imgCon)
end

function EternalDragonMainView:_tryUpdateCurGrowInfoToNextPeriod()
	local oldGrowScore = EternalDragonController.instance:getOldGrowScore(self._activityId)
	local oldGrowId = EternalDragonController.instance:getGrowIdByScore(self._activityId, oldGrowScore)
	local curGrowId = EternalDragonController.instance:getCurGrowId(self._activityId)

	if curGrowId <= oldGrowId then
		local curGrowScore = EternalDragonController.instance:getCurGrowScore()
		local oldLeftGrowProgress = EternalDragonController.instance:getLeftGrowProgressToNexGrow(self._activityId, oldGrowScore)
		local curLeftGrowProgress = EternalDragonController.instance:getLeftGrowProgressToNexGrow(self._activityId, curGrowScore)

		EternalDragonController.instance:svaeOldGrowScore(self._activityId, curGrowScore)

		local nextGrowIdAsCur = EternalDragonController.instance:getNextGrowId(self._activityId, curGrowId)
		local nextDesc = EternalDragonController.instance:getGrowDesc(self._activityId, nextGrowIdAsCur)

		self:_updatePictureOfGrow(curGrowId)

		local function startCallBack()
			self._isPlayingGrowAnim = true
		end

		local function finishCallBack()
			self._isPlayingGrowAnim = false

			local isHasAllGrowEnd = EternalDragonController.instance:isHasAllGrowEnd(self._activityId)

			if isHasAllGrowEnd then
				self._growInfoCol._txtBubble.text = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfBubbleInFinish")
			end

			if not self._isPlayingWaterEff and not self._isPlayingGrowAnim then
				self:_popPrize()
			end
		end

		self:_startGrowInfoValueChangeAnim(oldLeftGrowProgress, curLeftGrowProgress, nextDesc, startCallBack, finishCallBack)
	else
		local leftGrowProgress = EternalDragonController.instance:getLeftGrowProgressToNexGrow(self._activityId, oldGrowScore)
		local nextGrowIdAsOld = EternalDragonController.instance:getNextGrowId(self._activityId, oldGrowId)
		local nextDesc = EternalDragonController.instance:getGrowDesc(self._activityId, nextGrowIdAsOld)

		self:_updatePictureOfGrow(oldGrowId)

		local function startCallBack()
			self._isPlayingGrowAnim = true
		end

		local function finishCallBack()
			local nextGrowId = EternalDragonController.instance:getNextGrowId(self._activityId, oldGrowId)
			local curGrowId = EternalDragonController.instance:getCurGrowId(self._activityId)

			EternalDragonController.instance:svaeOldGrowScore(self._activityId, curGrowId < nextGrowId and EternalDragonController.instance:getCurGrowScore() or EternalDragonController.instance:getCurGrowScoreBase(self._activityId, nextGrowId))
			self:_playGrowUpdateEff(function()
				self._isPlayingGrowAnim = false

				self:_tryUpdateCurGrowInfoToNextPeriod()
			end)
		end

		self:_startGrowInfoValueChangeAnim(leftGrowProgress, 0, nextDesc, startCallBack, finishCallBack)
	end
end

function EternalDragonMainView:_startGrowInfoValueChangeAnim(startValue, endValue, desc, startCallBack, finishCallBack)
	local function updateHander(val)
		self:_updateTxtGrowInfo(val, desc)
	end

	local function startHander()
		GameUtil.callBack(startCallBack)
	end

	local function endHander()
		GameUtil.callBack(finishCallBack)
	end

	local function killHander()
		return
	end

	local duration = Mathf.Clamp(Mathf.Clamp(endValue - startValue, 0.05, 0.1) * 30, 1.5, 2)
	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear

	self:_clearGrowInfoValueChangeAnim()

	if startValue == endValue then
		GameUtil.callBack(startHander)
		GameUtil.callBack(updateHander, endValue)
		GameUtil.callBack(endHander)

		return
	end

	self._tweenerOfGrowInfoValueChange = TweenUtil.ValueTo(startValue, endValue, duration, updateHander, endHander, luaTarget, easeType)

	self._tweenerOfGrowInfoValueChange:OnStart(startHander)
	self._tweenerOfGrowInfoValueChange:OnKill(killHander)
end

function EternalDragonMainView:_clearGrowInfoValueChangeAnim()
	if self._tweenerOfGrowInfoValueChange then
		self._tweenerOfGrowInfoValueChange:Kill(false)

		self._tweenerOfGrowInfoValueChange = nil
	end
end

function EternalDragonMainView:_playGrowUpdateEff(finishCallBack)
	self:_clearGrowUpdateEff()

	local effParent = self._growEffParent
	local pathName = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "levelUpEff")

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			GameUtil.callBack(finishCallBack)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._growEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function EternalDragonMainView:_clearGrowUpdateEff()
	UIEffectManager.instance:stopEffect(self._growEff)
end

function EternalDragonMainView:_playWaterToGrowEff(finishCallBack)
	self:_clearWaterToGrowEff()

	local effParent = self._waterEffParent
	local pathName = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "progressEff")

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			self._isPlayingWaterEff = false

			GameUtil.callBack(finishCallBack)
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = false
		end

		local handlerTarget

		self._isPlayingWaterEff = true
		self._waterEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function EternalDragonMainView:_clearWaterToGrowEff()
	UIEffectManager.instance:stopEffect(self._waterEff)

	self._isPlayingWaterEff = false
end

function EternalDragonMainView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/%s.png", path)

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

function EternalDragonMainView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function EternalDragonMainView:_getTipsOfWater()
	return EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfWater")
end

function EternalDragonMainView:_getTipsOfGrowing()
	return EternalDragonConfig.instance:getEdCommonValue(self._activityId, "tipsOfGrowing")
end

function EternalDragonMainView:_startEnergyCountDown(txtCountDown)
	self._txtCountDown = txtCountDown
	self._energyId = EternalDragonController.instance:getEnergyId(self._activityId)

	settimer(1, self._energyCountDown, self, true)
end

function EternalDragonMainView:_stopEnergyCountDown()
	removetimer(self._energyCountDown, self)

	self._txtCountDown = nil
	self._energyId = 0
end

function EternalDragonMainView:_energyCountDown()
	local isFullEnergy = EternalDragonController.instance:isFullEnergy(self._activityId)

	if isFullEnergy then
		self:_stopEnergyCountDown()
		self:_onUpdatePlaneUI()

		return
	end

	local leftTime = EnergyModel.instance:getCurEnergyLeftTime(self._energyId)

	self._txtCountDown.text = string.format("%s后恢复一次", GameUtil.FormatTimeSymbol(leftTime))
end

function EternalDragonMainView:_popPrize()
	local changSetIdList = {}
	local changeSetId = EternalDragonModel.instance:popChangSetIdOfWater()

	if changeSetId then
		table.insert(changSetIdList, changeSetId)
	end

	changeSetId = EternalDragonModel.instance:popChangSetIdOfDisple()

	if changeSetId then
		table.insert(changSetIdList, changeSetId)
	end

	changeSetId = EternalDragonModel.instance:popChangSetIdOfCut()

	if changeSetId then
		table.insert(changSetIdList, changeSetId)
	end

	for _, changeSetId in ipairs(changSetIdList) do
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function EternalDragonMainView:_onClickBtnGrow1()
	if self._isPlayingWaterEff then
		FloatWordMgr.instance:show(self:_getTipsOfWater())

		return
	end

	if self._isPlayingGrowAnim then
		FloatWordMgr.instance:show(self:_getTipsOfGrowing())

		return
	end

	local result, tips = EternalDragonController.instance:getTryWaterResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result == GameEnum.ResultCode.Error then
		-- block empty
	elseif result == GameEnum.ResultCode.NotEnoughTimes then
		UIStateManager.instance:push(ViewName.EternalDragonWaterView)
	elseif result == GameEnum.ResultCode.Success then
		EternalDragonController.instance:sendPM_EternalDragonWaterReq(self._activityId)
	end
end

function EternalDragonMainView:_onClickBtnGrow2()
	if self._isPlayingWaterEff then
		FloatWordMgr.instance:show(self:_getTipsOfWater())

		return
	end

	if self._isPlayingGrowAnim then
		FloatWordMgr.instance:show(self:_getTipsOfGrowing())

		return
	end

	local result, tips = EternalDragonController.instance:getTryDispleResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	EternalDragonController.instance:sendPM_EternalDragonStartGameReq(self._activityId)
end

function EternalDragonMainView:_onClickBtnGrow3()
	if self._isPlayingWaterEff then
		FloatWordMgr.instance:show(self:_getTipsOfWater())

		return
	end

	if self._isPlayingGrowAnim then
		FloatWordMgr.instance:show(self:_getTipsOfGrowing())

		return
	end

	local result, tips = EternalDragonController.instance:getTryCutResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	GotoMgr.gotoByString(self._edActData.cutViewJumpStr)
end

function EternalDragonMainView:_onClickBtnTip()
	local key = EternalDragonConfig.instance:getEdCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return EternalDragonMainView
