-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendMainView.lua

module("logic.extensions.demondescend.view.DemonDescendMainView", package.seeall)

local DemonDescendMainView = class("DemonDescendMainView", ViewComponent)

function DemonDescendMainView:buildUI()
	DemonDescendMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._con = self:getGo("con")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollerClipGo = self:getGo("prizeCol/scrView/Viewport")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._txtTotalDamage = self:getTxt("prizeCol/damage/txtTotalDamage")
	self._txtDailyDamage = self:getTxt("prizeCol/damage/txtDailyDamage")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell1 = self:getGo("stageCol/scrCell1")
	local stageScrCell2 = self:getGo("stageCol/scrCell2")
	local scrCellList = {
		stageScrCell1,
		stageScrCell2
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._stageScrollerList = ScrollerList.create(stageScrView, scrCellList, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._stageScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._btnRank = self:getGo("btnRank")
	self._btnBuff = self:getGo("btnBuff")
	self._btnSign = self:getGo("btnSign")
	self._tagGainSign = self:getGo("btnSign/tagGain")
	self._txtBtnSign = self:getTxt("btnSign/txt")
	self._redBtnSign = self:getGo("btnSign/red")
	self._txtTimesChallenge = self:getTxt("btnChallenge/txtTimes")
	self._btnChallenge = self:getGo("btnChallenge/btn")
	self._btnTrial = self:getGo("btnTrial")
	self._goldBarCon = self:getGo("goldBarCon")
end

function DemonDescendMainView:bindEvents()
	DemonDescendMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClikBtnRank, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClikBtnBuff, self)
	GameUtil.addClickHandler(self._btnSign, self._onClikBtnSign, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClikBtnChallenge, self)
	GameUtil.addClickHandler(self._btnTrial, self._onClikBtnTrial, self)
end

function DemonDescendMainView:unbindEvents()
	DemonDescendMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnSign)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnTrial)
end

function DemonDescendMainView:onEnter()
	DemonDescendMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DemonDescendController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DemonDescendController.instance:getSubMo(self._activityId)
	self._actData = DemonDescendConfig.instance:getActData(self._activityId)
	self._wineItem = self._subMo:getWineItem()
	self._canDailyUnlockStages = {}
	self._txtBtnSign.text = string.format("%s:%s", self._wineItem.matName, self._actData.signInGainRedWine)

	local goldInfo = {
		showAdd = false,
		id = self._wineItem.matStr
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})

	local skinId = 12036
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, modelCfg[3], nil, true, x, y)

		self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendInfoRes, self._onUpdate, self)
		self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendCheckInRes, self._onUpdate, self)
		self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendGainProgressPrizeRes, self._handlePM_DemonDescendGainProgressPrizeRes, self)
		DemonDescendController.instance:sendPM_DemonDescendInfoReq(self._activityId)
		FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_5)
		self:_onUpdate()
	end
end

function DemonDescendMainView:onExit()
	DemonDescendMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	self:_onClearStageCol()
	self:_onClearPrizeCol()
end

function DemonDescendMainView:_handlePM_DemonDescendGainProgressPrizeRes(msg)
	local prizeId = msg.progressId

	self:_onUpdatePrizeCol()

	local params = FuYaoStoryController.instance:getParamsInPlot(FuYaoStoryEnum.Story_Plot_6)

	if not string.nilorempty(params) then
		local prizeIds = string.split(params, "#")

		for _, id in ipairs(prizeIds) do
			if checknumber(id) == prizeId then
				FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_6)

				break
			end
		end
	end
end

function DemonDescendMainView:_onUpdate()
	GameUtil.SetActive(self._tagGainSign, self._subMo:isTodaySignIn())
	GameUtil.SetActive(self._redBtnSign, not self._subMo:isTodaySignIn())

	local left = self._subMo:getTodayLeftBossChallengeTime()
	local max = self._subMo:getMaxBossChallengeTime()

	self._txtTimesChallenge.text = string.format("今日剩余次数<color=#ffc66d>%s</color>/%s次", left, max)

	self:_onUpdatePrizeCol()
	self:_onUpdateStageColUI()
end

function DemonDescendMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx
		else
			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtTotalDamage.text = curProgress
	self._txtDailyDamage.text = self._subMo:getTodayMaxDamage()
end

function DemonDescendMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function DemonDescendMainView:_getProgressDataList()
	return DemonDescendConfig.instance:getProgressPrizeCfg(self._activityId) or {}
end

function DemonDescendMainView:_getSliderComp()
	return self._sliderComp
end

function DemonDescendMainView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function DemonDescendMainView:_getCurProgress()
	return self._subMo:getTotalDamage()
end

function DemonDescendMainView:_getProgressByData(data)
	return data.progress
end

function DemonDescendMainView:_getPrizeIdByData(data)
	return data.progressId
end

function DemonDescendMainView:_getPrizeStrByData(data)
	return data.prize
end

function DemonDescendMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrize(prizeId)
end

function DemonDescendMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrize(prizeId)
end

function DemonDescendMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrize(prizeId)
end

local FormapList = {
	{
		100000000,
		"亿"
	},
	{
		10000,
		"万"
	}
}

function DemonDescendMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = MmUtil.formatNumber(progress, FormapList, 0)
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function DemonDescendMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DemonDescendMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DemonDescendController.instance:sendPM_DemonDescendGainProgressPrizeReq(self._activityId, prizeId)
end

function DemonDescendMainView:_onUpdateStageColUI()
	local cfg = DemonDescendConfig.instance:getStageCfg(self._activityId) or {}

	self._canDailyUnlockStages = {}

	local unlockCount = self._actData.dailyUnlockStage
	local startStageId = 0

	for stageId, data in ipairs(cfg) do
		if self._subMo:isUnlockStage(stageId) then
			startStageId = stageId
		else
			break
		end
	end

	startStageId = startStageId + 1

	local maxStageId = self._subMo:getMaxStageId()
	local stageCount = 0

	for stageId = startStageId, maxStageId do
		stageCount = stageCount + 1
		self._canDailyUnlockStages[stageId] = math.ceil(stageCount / unlockCount)
	end

	self._stageScrollerList:reloadData(cfg)

	local index

	if index == nil then
		for stageId, data in ipairs(cfg) do
			if not self._subMo:isPassStageNormal(stageId) then
				index = stageId - 1

				break
			end
		end
	end

	if index == nil then
		for stageId, data in ipairs(cfg) do
			if not self._subMo:isPassStagePerfect(stageId) then
				index = stageId - 1

				break
			end
		end
	end

	self._stageScrollerList:MoveCellToCenter(index or 0)
end

function DemonDescendMainView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function DemonDescendMainView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isUnlock = self._subMo:isUnlockStage(stageId)
	local isOpen = self._subMo:isOpenStage(stageId)
	local curNum = self._subMo:getCurWineInStage(stageId)
	local maxNum = self._subMo:getMaxWineInStage(stageId)
	local mainGo = cell.gameObject
	local btnChallenge = goutil.findChild(mainGo, "btnChallenge")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtGain = goutil.findChildTextComponent(mainGo, "txtGain")

	txtName.text = string.format("第<size=24>%s</size>关", stageId)

	GameUtil.SetGray(btnChallenge, not isUnlock or not isOpen)

	if isUnlock then
		txtGain.text = string.format("%s/<color=#FFE69AFF>%s</color>", curNum, maxNum)
	else
		local day = self._canDailyUnlockStages[stageId]

		txtGain.text = string.format("再登录%s天解锁", day)
	end

	GameUtil.addClickHandler(btnChallenge, function()
		if not isUnlock then
			if self._canDailyUnlockStages[stageId] then
				local day = self._canDailyUnlockStages[stageId]

				FloatWordMgr.instance:show(string.format("再登录%s天解锁", day))
			else
				FloatWordMgr.instance:show("未开放")
			end

			return
		end

		if not isOpen then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		DemonDescendController.instance:enterStageBattle(self._activityId, stageId)
	end)
end

function DemonDescendMainView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnChallenge = goutil.findChild(mainGo, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)
end

function DemonDescendMainView:_getTagByIdx(data, idx)
	return 2 - (idx + 1) % 2
end

function DemonDescendMainView:_getCellSize(view, idx)
	local list = self._stageScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function DemonDescendMainView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DemonDescendMainView:_onClikBtnRank()
	DemonDescendController.instance:openCommonTabRankView(self._activityId)
end

function DemonDescendMainView:_onClikBtnBuff()
	UIStateManager.instance:push(ViewName.DemonDescendBuffShopView, self._activityId)
end

function DemonDescendMainView:_onClikBtnSign()
	if self._subMo:isTodaySignIn() then
		FloatWordMgr.instance:show("已签到")

		return
	end

	DemonDescendController.instance:sendPM_DemonDescendCheckInReq(self._activityId)
end

function DemonDescendMainView:_onClikBtnChallenge()
	if not self._subMo:isEnoughTimesToBossChallenge() then
		FloatWordMgr.instance:show("剩余次数不足")

		return
	end

	UIStateManager.instance:push(ViewName.DemonDescendBuffView, self._activityId, false)
end

function DemonDescendMainView:_onClikBtnTrial()
	UIStateManager.instance:push(ViewName.DemonDescendBuffView, self._activityId, true)
end

return DemonDescendMainView
