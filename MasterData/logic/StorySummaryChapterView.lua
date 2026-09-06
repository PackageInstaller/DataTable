-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryChapterView.lua

module("logic.extensions.storysummary.view.StorySummaryChapterView", package.seeall)

local StorySummaryChapterView = class("StorySummaryChapterView", ViewComponent)

function StorySummaryChapterView:ctor()
	StorySummaryChapterView.super.ctor(self)
end

function StorySummaryChapterView:buildUI()
	StorySummaryChapterView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._bubble = goutil.findChild(self.mainGO, "bubble")
	self._btnShip = goutil.findChild(self.mainGO, "btnShip")
	self._btnShipRed = goutil.findChild(self.mainGO, "btnShip/redpoint")
	self._chapterL = goutil.findChild(self.mainGO, "chapterL")
	self._chapterR = goutil.findChild(self.mainGO, "chapterR")
	self._mainIcon = goutil.findChild(self.mainGO, "mainIcon")
	self._bigBg = goutil.findChild(self.mainGO, "bigBg")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtChapterName = goutil.findChildTextComponent(self.mainGO, "txtChapterName/txt")
	self._stagePos = goutil.findChild(self.mainGO, "stageCol/stagePos")
	self._stageCell = goutil.findChild(self.mainGO, "stageCol/stageCell")
	self._prologueCol = goutil.findChild(self.mainGO, "prologueCol")
	self._prologueBg = goutil.findChild(self.mainGO, "prologueCol/prologueBg")
	self._prologueIcon = goutil.findChild(self.mainGO, "prologueCol/prologueIcon")
	self._txtPrologueName = goutil.findChildTextComponent(self.mainGO, "prologueCol/txtPrologueName")
	self._txtPrologueDesc = goutil.findChildTextComponent(self.mainGO, "prologueCol/txtPrologueDesc")

	GameUtil.SetActive(self._stageCell, false)
end

function StorySummaryChapterView:bindEvents()
	StorySummaryChapterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShip, self._onClickBtnShip, self)
end

function StorySummaryChapterView:unbindEvents()
	StorySummaryChapterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShip)
end

function StorySummaryChapterView:destroyUI()
	StorySummaryChapterView.super.destroyUI(self)
end

function StorySummaryChapterView:onEnter()
	StorySummaryChapterView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._curPartId = checknumber(params[1])

	if self._curPartId == 0 then
		FloatWordMgr.instance:show("篇章方案id错误")
		self:close()

		return
	end

	self._ssChapterCfg = StorySummaryConfig.instance:getSsChapterCfg(self._curPartId)

	if #self._ssChapterCfg == 0 then
		FloatWordMgr.instance:show(string.format("章节配置缺失( partId=%d )", self._curPartId))
		self:close()

		return
	end

	self._minChapterIdx = StorySummaryController.instance:isStorySummaryPartNeedPrologue(self._curPartId) and 0 or 1
	self._maxChapterIdx = #self._ssChapterCfg

	if params[2] then
		local curChapterIdx = checknumber(params[2])

		self:_onUpdateChapterAndStageData(params[2])
		self:_onSetUI()
		self:_onUpdate()
		GlobalDispatcher:addListener(GlobalNotify.StorySummaryInfoRes, self._onUpdate, self)
		GlobalDispatcher:addListener(GlobalNotify.StorySummaryFightEndRes, self._onHandleFightEndRes, self)
		StorySummaryController.instance:onSendStorySummaryInfoReq()
	end
end

function StorySummaryChapterView:onExit()
	StorySummaryChapterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.StorySummaryFightEndRes, self._onHandleFightEndRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.StorySummaryInfoRes, self._onUpdate, self)
	RoleRelationshipController.instance:unRegRedAboutRoleShip(self._btnShipRed)
	self:_clearPlaneUI()
	self:_clearPrologueCol()
	self:_clearStageCol()
end

function StorySummaryChapterView:_onSetUI()
	GameUtil.SetActive(self._btnShipRed, false)

	local isNeedBtnShip = false
	local partData = StorySummaryConfig.instance:getSsPartDataByPId(self._curPartId)
	local shipActivityId = checknumber(partData.shipActivityId)

	if shipActivityId > 0 then
		isNeedBtnShip = RoleRelationshipController.instance:isRoleRelationshipInTime(shipActivityId)

		RoleRelationshipController.instance:regRedAboutRoleShip(self._btnShipRed, shipActivityId)
	end

	GameUtil.SetActive(self._btnShip, isNeedBtnShip)
	GameUtil.SetActive(self._bubble, isNeedBtnShip)
end

function StorySummaryChapterView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StorySummaryChapterView:_onUpdateData()
	return
end

function StorySummaryChapterView:_onUpdateUI()
	self:_onUpdateIntroPopWinView()
	self:_onUpdatePlaneUI()
	self:_onUpdatePrologueCol()
	self:_onUpdateStageCol()
	self:_onUpdateBtnChapter()
end

function StorySummaryChapterView:_onHandleFightEndRes()
	self:_onUpdateChapterAndStageData()
	self:_onUpdate()
end

function StorySummaryChapterView:_onUpdateChapterAndStageData(chapterIdx)
	self._curChapterIdx = chapterIdx or self:_getFitChapterIdx()
	self._curStageId = self:_getFitStageId()
end

function StorySummaryChapterView:_getFitChapterIdx()
	local fitChapterIdx = 0

	if StorySummaryController.instance:isStorySummaryPartNeedPrologue(self._curPartId) then
		local key = "StorySummaryFirstEnterPart" .. self._curPartId

		if GameUtil.getUserData(key) ~= true then
			GameUtil.saveUserData(key, true)

			return fitChapterIdx
		end
	end

	if StorySummaryController.instance:isStorySummaryPartPass(self._curPartId) then
		for i = self._maxChapterIdx, 0, -1 do
			local data = self._ssChapterCfg[i]
			local isChapterUnlock = StorySummaryController.instance:isChapterUnlock(data.partId, data.chapterIdx)

			if isChapterUnlock then
				fitChapterIdx = data.chapterIdx

				break
			end
		end
	else
		for _, data in ipairs(self._ssChapterCfg) do
			local isChapterPass = StorySummaryController.instance:isStorySummaryChapterPass(data.partId, data.chapterIdx)
			local isChapterUnlock = StorySummaryController.instance:isChapterUnlock(data.partId, data.chapterIdx)

			if not isChapterPass and isChapterUnlock then
				fitChapterIdx = data.chapterIdx

				break
			end

			local nextChapterIdx = Mathf.Clamp(data.chapterIdx + 1, self._minChapterIdx, self._maxChapterIdx)

			if data.chapterIdx == nextChapterIdx then
				fitChapterIdx = data.chapterIdx

				break
			else
				local isNextChapterUnlock = StorySummaryController.instance:isChapterUnlock(data.partId, nextChapterIdx)

				if not isNextChapterUnlock then
					fitChapterIdx = data.chapterIdx

					break
				end
			end
		end
	end

	return fitChapterIdx
end

function StorySummaryChapterView:_getFitStageId()
	local fitStageId = 0
	local ssStageCfg = StorySummaryConfig.instance:getSsStageCfgByIdx(self._curPartId, self._curChapterIdx)

	for _, data in ipairs(ssStageCfg) do
		local isStageUnlock = StorySummaryController.instance:isStageUnlock(data.chapterId, data.stageId)
		local isStagePass = StorySummaryController.instance:isStorySummaryStagePass(data.chapterId, data.stageId)

		if isStageUnlock and not isStagePass then
			fitStageId = data.stageId

			break
		end
	end

	return fitStageId
end

function StorySummaryChapterView:_onUpdatePlaneUI()
	local chapterData = StorySummaryConfig.instance:getSsChapterData(self._curPartId, self._curChapterIdx)

	self._txtChapterName.text = self._curChapterIdx == 0 and "序章" or chapterData.chapterName

	local startDate, endDate

	if self._curChapterIdx == 0 then
		local partData = StorySummaryConfig.instance:getSsPartDataByPId(self._curPartId)

		endDate = GameUtil.string2date(partData.endTime)
		startDate = GameUtil.string2date(partData.startTime)
	else
		endDate = GameUtil.string2date(chapterData.endTime)
		startDate = GameUtil.string2date(chapterData.startTime)
	end

	self._txtOpenTime.text = string.format("开启时间：%d.%02d.%02d %d:%02d", startDate.year % 1000, startDate.month, startDate.day, startDate.hour, startDate.min)

	local isNeedMainIcon = self._curChapterIdx > 0 and not string.nilorempty(chapterData.mainIconPath)

	GameUtil.SetActive(self._mainIcon, isNeedMainIcon)

	if isNeedMainIcon then
		local path = string.format("ui/bigbg/%s.png", chapterData.mainIconPath)

		uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(self._mainIcon)
	end

	local isNeedBigBg = self._curChapterIdx > 0 and not string.nilorempty(chapterData.bigBgPath)

	GameUtil.SetActive(self._bigBg, isNeedBigBg)

	if isNeedBigBg then
		local path = string.format("ui/bigbg/%s.png", chapterData.bigBgPath)

		uGuiUtil.setSpriteToImage(self._bigBg, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(self._bigBg)
	end
end

function StorySummaryChapterView:_clearPlaneUI()
	uGuiUtil.clearImage(self._mainIcon)
	uGuiUtil.clearImage(self._bigBg)
end

function StorySummaryChapterView:_onUpdateIntroPopWinView()
	if self._curChapterIdx <= 0 or self._curChapterIdx > self._maxChapterIdx then
		return
	end

	local chapterData = StorySummaryConfig.instance:getSsChapterData(self._curPartId, self._curChapterIdx)
	local key = StorySummaryController.instance:getChapterIntroKey(chapterData.chapterId)
	local isHasView = StorySummaryController.instance:isChapterIntroHasView(key)

	if isHasView then
		return
	end

	local info = {
		titleStr = chapterData.chapterName,
		descStr = chapterData.chapterDesc,
		num = chapterData.chapterIdx
	}

	UIStateManager.instance:push(ViewName.IntroPopWinView, info)
	StorySummaryController.instance:setChapterIntroState(key, true)
end

function StorySummaryChapterView:_onUpdatePrologueCol()
	local isPrologue = self._curChapterIdx == 0

	GameUtil.SetActive(self._prologueCol, isPrologue)

	if not isPrologue then
		return
	end

	local partData = StorySummaryConfig.instance:getSsPartDataByPId(self._curPartId)
	local isNeedPrologueIcon = not string.nilorempty(partData.prologueIconPath)

	GameUtil.SetActive(self._prologueIcon, isNeedPrologueIcon)

	if isNeedPrologueIcon then
		local path = string.format("ui/bigbg/%s.png", partData.prologueIconPath)

		uGuiUtil.setSpriteToImage(self._prologueIcon, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(self._prologueIcon)
	end

	local isNeedPrologueBg = not string.nilorempty(partData.prologueBgPath)

	GameUtil.SetActive(self._prologueBg, isNeedPrologueBg)

	if isNeedPrologueBg then
		local path = string.format("ui/bigbg/%s.png", partData.prologueBgPath)

		uGuiUtil.setSpriteToImage(self._prologueBg, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(self._prologueBg)
	end

	self._txtPrologueName.text = partData.prologueName
	self._txtPrologueDesc.text = partData.prologueDesc
end

function StorySummaryChapterView:_clearPrologueCol()
	uGuiUtil.clearImage(self._prologueIcon)
	uGuiUtil.clearImage(self._prologueBg)
end

function StorySummaryChapterView:_onUpdateStageCol()
	local ssStageCfg = StorySummaryConfig.instance:getSsStageCfgByIdx(self._curPartId, self._curChapterIdx)
	local stageNum = #ssStageCfg
	local childList = GameUtil.getChildren(self._stagePos)

	for idx, go in ipairs(childList) do
		if stageNum < idx then
			GameUtil.SetActive(go, false)
		end
	end

	self._stageCellList = {}

	for stageId = 1, stageNum do
		local cell = {}

		cell._mainGo = childList[stageId] or goutil.cloneAndSetParent(self._stageCell, self._stagePos.transform)
		cell._select = goutil.findChild(cell._mainGo, "select")
		cell._videoIcon = goutil.findChild(cell._mainGo, "videoIcon")
		cell._battleIcon = goutil.findChild(cell._mainGo, "battleIcon")
		cell._videoLock = goutil.findChild(cell._mainGo, "videoLock")
		cell._battleLock = goutil.findChild(cell._mainGo, "battleLock")
		cell._passIcon = goutil.findChild(cell._mainGo, "passIcon")
		cell._txtStageName = goutil.findChildTextComponent(cell._mainGo, "txtStageName")

		table.insert(self._stageCellList, cell)
		GameUtil.SetActive(cell._mainGo, true)

		local stageData = ssStageCfg[stageId]

		cell._mainGo.name = string.format("stageCell_%d", stageId)

		if not stageData.stagePos then
			GameUtil.setLocalPos(cell._mainGo, stageData.stagePos[1] or 0, stageData.stagePos[2] or 0, 0)

			local isPurePlot = StorySummaryController.instance:isPurePlotStage(stageData.chapterId, stageId)
			local isStageUnlock = StorySummaryController.instance:isStageUnlock(stageData.chapterId, stageId)
			local isStagePass = StorySummaryController.instance:isStorySummaryStagePass(stageData.chapterId, stageId)

			GameUtil.SetActive(cell._videoIcon, isPurePlot)
			GameUtil.SetActive(cell._battleIcon, not isPurePlot)
			GameUtil.SetActive(cell._videoLock, isPurePlot and not isStageUnlock)
			GameUtil.SetActive(cell._battleLock, not isPurePlot and not isStageUnlock)
			GameUtil.SetActive(cell._passIcon, isStagePass)

			local isNeedSelect = stageId == self._curStageId

			GameUtil.SetActive(cell._select, isNeedSelect)

			cell._txtStageName.text = stageData.stageName

			local function handler()
				if not isStageUnlock then
					FloatWordMgr.instance:show("前置关卡未通关")

					return
				end

				local ssPartData = StorySummaryConfig.instance:getSsPartDataByPId(self._curPartId)

				StorySummaryModel.instance:clearViewInfos()
				StorySummaryModel.instance:addViewInfo(ViewName.StorySummaryPalaceView, ssPartData.storyPlanId)
				StorySummaryModel.instance:addViewInfo(ViewName.StorySummaryChapterView, self._curPartId)
				StorySummaryController.instance:enterStorySummaryStage(stageData.chapterId, stageId)
			end

			GameUtil.addClickHandler(cell._mainGo, handler)
		end
	end
end

function StorySummaryChapterView:_clearStageCol()
	return
end

function StorySummaryChapterView:_onUpdateBtnChapter()
	local isInHomeChapter = self._curChapterIdx == self._minChapterIdx
	local isInLastChapter = self._curChapterIdx == self._maxChapterIdx

	GameUtil.SetActive(self._chapterL, not isInHomeChapter)
	GameUtil.SetActive(self._chapterR, not isInLastChapter)

	local lastChapterIdx = Mathf.Clamp(self._curChapterIdx - 1, self._minChapterIdx, self._maxChapterIdx)
	local nextChapterIdx = Mathf.Clamp(self._curChapterIdx + 1, self._minChapterIdx, self._maxChapterIdx)

	self:_updateBtnChapter(self._chapterL, lastChapterIdx, -1)
	self:_updateBtnChapter(self._chapterR, nextChapterIdx, 1)
end

function StorySummaryChapterView:_updateBtnChapter(mainGo, chapterIdx, delta)
	local txtChapterName = goutil.findChildTextComponent(mainGo, "txtChapterName")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txtLock")

	if chapterIdx <= 0 or chapterIdx > self._maxChapterIdx then
		GameUtil.SetActive(lock, false)

		txtChapterName.text = "序章"

		GameUtil.SetActive(redpoint, false)
		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._changeChapter, self, delta, "", true))

		return
	end

	local ssChapterData = StorySummaryConfig.instance:getSsChapterData(self._curPartId, chapterIdx)
	local perType = StorySummaryController.instance:getChapterPeriodType(self._curPartId, chapterIdx)
	local isInTime = perType == GameUtil.inTimePeriod
	local isPassThreadCond = StorySummaryController.instance:isChapterPassThreadCond(self._curPartId, chapterIdx)
	local isPassPreChapter = StorySummaryController.instance:isChapterPassPreChapterCond(self._curPartId, chapterIdx)
	local isChapterPass = StorySummaryController.instance:isStorySummaryChapterPass(self._curPartId, chapterIdx)
	local isChapterUnlock = StorySummaryController.instance:isChapterUnlock(self._curPartId, chapterIdx)
	local floatStr = ""
	local lockStr = ""

	if not isInTime then
		local startDate, endDate = GameUtil.string2date(ssChapterData.startTime), GameUtil.string2date(ssChapterData.endTime)

		if perType == GameUtil.beforeTimePeriod then
			lockStr = string.format("%d.%d日 %d:%02d\n开启第%d章", startDate.month, startDate.day, startDate.hour, startDate.min, chapterIdx)
			floatStr = "章节未开启"
		elseif perType == GameUtil.afterTimePeriod then
			lockStr = string.format("%d.%d日 %d:%02d\n第%d章已结束", endDate.month, endDate.day, endDate.hour, endDate.min, chapterIdx)
			floatStr = "章节已结束"
		end
	elseif not isPassThreadCond then
		local threadChapterId, threadStageId = ssChapterData.unlockCondition[1], ssChapterData.unlockCondition[2]
		local threadStageData = CopyConfig.instance:getStageById(threadChapterId, threadStageId)

		lockStr = string.format("通关【主线%s】解锁", threadStageData.stageName)
		floatStr = string.format("通关【主线%s】解锁", threadStageData.stageName)
	elseif not isPassPreChapter then
		local preChapterData = StorySummaryConfig.instance:getSsChapterDataByCId(ssChapterData.preChapterId)

		lockStr = string.format("通关【%s】解锁", preChapterData.chapterName)
		floatStr = string.format("通关【%s】解锁", preChapterData.chapterName)
	end

	txtLock.text = lockStr

	GameUtil.SetActive(lock, not isChapterUnlock)

	txtChapterName.text = string.format("第%d章", chapterIdx)

	local isNeedRed = StorySummaryController.instance:isChapterNeedRed(self._curPartId, chapterIdx)

	GameUtil.SetActive(redpoint, isNeedRed)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._changeChapter, self, delta, floatStr, isChapterUnlock))
end

function StorySummaryChapterView:_changeChapter(delta, floatStr, isChapterUnlock)
	if not string.nilorempty(floatStr) then
		FloatWordMgr.instance:show(floatStr)
	end

	if isChapterUnlock then
		local chapterIdx = self._curChapterIdx + delta

		chapterIdx = Mathf.Clamp(chapterIdx, self._minChapterIdx, self._maxChapterIdx)

		self:_onUpdateChapterAndStageData(chapterIdx)
		self:_onUpdate()
	end
end

function StorySummaryChapterView:_onClickBtnShip()
	local partData = StorySummaryConfig.instance:getSsPartDataByPId(self._curPartId)
	local shipActivityId = checknumber(partData.shipActivityId)

	if shipActivityId > 0 then
		UIStateManager.instance:push(ViewName.RoleRelationshipView, shipActivityId)
		SurveyController.instance:reportBehavior(201183)
	end
end

return StorySummaryChapterView
