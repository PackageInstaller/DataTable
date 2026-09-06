-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/view/NaiLongHotSearchMainView.lua

module("logic.extensions.nailonghotsearch.view.NaiLongHotSearchMainView", package.seeall)

local NaiLongHotSearchMainView = class("NaiLongHotSearchMainView", ViewComponent)

function NaiLongHotSearchMainView:buildUI()
	NaiLongHotSearchMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._goldBarCon = self:getGo("goldBarCon")

	local noteScrView = self:getGo("noteCol/scrView")
	local noteScrCell = self:getGo("noteCol/scrCell")

	self._noteScrollerList = ScrollerList.create(noteScrView, noteScrCell, GameUtil.handler(self._updateNoteCell, self), GameUtil.handler(self._clearNoteCell, self))
	self._myDescCell = self:getGo("myDescCell")
	self._txtRankInMyDesc = self:getTxt("myDescCell/txtRank")
	self._txtDescInMyDesc = self:getTxt("myDescCell/txtDesc")
	self._txtHotInMyDesc = self:getTxt("myDescCell/txtHot")
	self._headConMyNote = self:getGo("myNote/head/con")
	self._hotValueMyNote = self:getGo("myNote/head/con")
	self._txtHotMyNote = self:getTxt("myNote/hotValue/txt")
	self._btnHomeMyNote = self:getGo("myNote/btnHome")
	self._txtDescMyNote = self:getTxt("myNote/txtDesc")
	self._btnFeed = self:getGo("btnFeed")
	self._btnKudo = self:getGo("btnKudo")
	self._txtKudoCount = self:getTxt("btnKudo/txtKudoCount")
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/redPoint")
	self._btnHuifu = self:getGo("btnHuifu")
	self._replyCol = self:getGo("replyCol")
	self._replyScrollRect = self:getGo("replyCol/scrView"):GetComponent(ComponentType.ScrollRect)
	self._emptyReply = self:getGo("replyCol/empty")
	self._replyScrView = self:getGo("replyCol/scrView")

	local replyScrCell1 = self:getGo("replyCol/scrCell1")
	local replyScrCell2 = self:getGo("replyCol/scrCell2")

	self._sizeList = {}

	local replyScrCells = {
		replyScrCell1,
		replyScrCell2
	}

	for tag, go in ipairs(replyScrCells) do
		self._sizeList[tag] = {
			GameUtil.getWidth(go),
			GameUtil.getHeight(go)
		}
	end

	self._replyScrollerList = ScrollerList.create(self._replyScrView, replyScrCells, GameUtil.handler(self._updateReplyCell, self), GameUtil.handler(self._clearReplyCell, self))

	self._replyScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._replyScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._huifuCol = self:getGo("huifuCol")
	self._huifuScrView = self:getGo("huifuCol/scrView")
	self._huifuScrCell = self:getGo("huifuCol/scrCell")
	self._huifuScrollList = ScrollerList.create(self._huifuScrView, self._huifuScrCell, GameUtil.handler(self._updateHuifuCell, self), GameUtil.handler(self._clearHuifuCell, self))
	self._customInputOfGroup = UICustomInput.Get(self._huifuCol)

	GameUtil.SetActive(self._huifuCol, false)

	self._prizeScrView = self:getGo("progressCol/scrView")
	self._prizeScrCell = self:getGo("progressCol/scrCell")
	self._sliderComp = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtNumPrize = self:getTxt("progressCol/total/txtNum")
	self._goodFlyToPos = self:getGo("progressCol/total/goodFlyToPos")
	self._iconPrize = self:getGo("progressCol/total/icon")
	self._btnGetAll = self:getGo("progressCol/btnGetAll")
	self._imgFire = self:getGo("progressCol/total/imgFire")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._goodFlyView = self:getGo("goodFlyView")
	self._goodFlyGoList = {}

	for idx = 1, self._goodFlyView.transform.childCount do
		local mainGo = self._goodFlyView.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(mainGo, false)
		table.insert(self._goodFlyGoList, mainGo)
	end
end

function NaiLongHotSearchMainView:bindEvents()
	NaiLongHotSearchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFeed, self._onClickBtnFeed, self)
	GameUtil.addClickHandler(self._btnKudo, self._onClickBtnKudo, self)
	GameUtil.addClickHandler(self._btnHuifu, self._onClickBtnHuifu, self)
	GameUtil.addClickHandler(self._btnHomeMyNote, self._onClickBtnHome, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnGetAll, self._onClickPrizeGetAll, self)
	self._customInputOfGroup:AddListener(self._onCustomInputCallbackOfHuifu, self)

	self._beginDragHandler = BeginDragHandler.Get(self._replyScrView):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)

	self._replyScrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
end

function NaiLongHotSearchMainView:unbindEvents()
	NaiLongHotSearchMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFeed)
	GameUtil.rmClickHandler(self._btnKudo)
	GameUtil.rmClickHandler(self._btnHuifu)
	GameUtil.rmClickHandler(self._btnHomeMyNote)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnGetAll)
	self._customInputOfGroup:RemoveListener()
	BeginDragHandler.Get(self._replyScrView):RemoveLuaHandler(self._beginDragHandler)
	self._replyScrollerList:regReloadFinish(nil, nil)
end

function NaiLongHotSearchMainView:onEnter()
	NaiLongHotSearchMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = NaiLongHotSearchController.instance:getActivityId()
	end

	self._activityType = NaiLongHotSearchController.instance:getActivityType()

	local isInTime = NaiLongHotSearchController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = NaiLongHotSearchConfig.instance:getActData(self._activityId)
	self._searchMo = NaiLongHotSearchController.instance:getNaiLongHotSearchMo(self._activityId)
	self._informationId = NaiLongHotSearchController.instance:getCurInformationId(self._activityId)
	self._informationData = NaiLongHotSearchConfig.instance:getInformationData(self._activityId, self._informationId)
	self._giftItem = self._actData.giftItem

	local matType, matId, matNum = MaterialMgr.getMatParams(self._giftItem)

	self._giftItemMat = {
		matType = matType,
		matId = matId,
		matNum = matNum,
		matName = MaterialMgr.getMaterialsNameByCfg(self._giftItem)
	}
	self._playScrollAnim = -1
	self._scheduleList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchKudosRes, self._handlePM_HotSearchKudosRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchPresentRes, self._handlePM_HotSearchPresentRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HotSearchReplyRes, self._handleHotSearchReplyRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes, self._handlePM_WorldProgressPrizeGetInfoRes, self)
	self:_onSetUI()
	self:_onUpdate()
	self:_sendGetInfoReq()
	settimer(1, self._onTicking, self, true)
end

function NaiLongHotSearchMainView:onExit()
	NaiLongHotSearchMainView.super.onExit(self)

	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end

	removetimer(self._onTicking, self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	self:_onClearNoteCol()
	self:_onClearReplyCol()
	self:_onClearPrizeCol()
	self:_onClearHuifuColUI()
end

function NaiLongHotSearchMainView:_sendGetInfoReq()
	NaiLongHotSearchController.instance:sendPM_HotSearchGetInfoReq(self._activityId)
	WorldProgressPrizeController.instance:sendPM_WorldProgressPrizeGetInfoReq(self._activityId)
end

function NaiLongHotSearchMainView:_handleHotSearchReplyRes()
	self:_sendGetInfoReq()
end

function NaiLongHotSearchMainView:_handlePM_HotSearchKudosRes()
	local formPos = GameUtil.getPos(self._btnKudo)
	local toPos = GameUtil.getPos(self._goodFlyToPos)

	self:_flyGoodAnim(formPos, toPos, GameUtil.handler(self._onUpdate, self))
end

function NaiLongHotSearchMainView:_handlePM_HotSearchPresentRes()
	local formPos = GameUtil.getPos(self._btnFeed)
	local toPos = GameUtil.getPos(self._goodFlyToPos)

	self:_flyGoodAnim(formPos, toPos, GameUtil.handler(self._onUpdate, self))
end

function NaiLongHotSearchMainView:_handlePM_WorldProgressPrizeGetInfoRes()
	self:_onUpdateNoteColUI()
end

function NaiLongHotSearchMainView:_onTicking()
	if self._newestNpcId < self._maxNpcId then
		local newestNpcId = self:_getNewestNpcIdByTime(ServerTime.now())

		if newestNpcId ~= self._newestNpcId then
			self._newestNpcId = newestNpcId

			self:_onUpdateReplyColUI()
		end
	end

	if self._playScrollAnim > 0 then
		self._playScrollAnim = self._playScrollAnim - 1
	end

	if self._playScrollAnim <= 0 then
		self._playScrollAnim = -1

		self:_playScrollAnimation()
	end
end

function NaiLongHotSearchMainView:_getNewestNpcIdByTime(nowTime)
	for npcId = self._maxNpcId, 1, -1 do
		if nowTime > self._scheduleList[npcId] then
			return npcId
		end
	end

	return 0
end

function NaiLongHotSearchMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local list = {}
	local tab = {
		showAdd = true,
		id = self._giftItem
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local redId = AnchorSimulatorController.instance:getEventTaskRedId()

	if redId then
		RedPointController.instance:regRedPoint(self._redBtnTask, redId)
	end
end

function NaiLongHotSearchMainView:_onUpdate()
	local todayRecord = self._searchMo:getTodayRecord()

	self._replyId = 0
	self._newestNpcId = 0
	self._replyTimeStamp = 0

	if todayRecord then
		self._replyId = todayRecord.replyId
		self._replyTimeStamp = Mathf.Floor(checknumber(todayRecord.replyTime) / 1000)
	end

	self._maxNpcId = NaiLongHotSearchConfig.instance:getMaxNpcId(self._replyId)
	self._scheduleList = {}

	local npcCfg = NaiLongHotSearchConfig.instance:getReplyNpcCfg(self._replyId) or {}

	for _, data in ipairs(npcCfg) do
		self._scheduleList[data.npcId] = self._replyTimeStamp + data.afterSec
	end

	local newestNpcId = self:_getNewestNpcIdByTime(ServerTime.now())

	if newestNpcId ~= self._newestNpcId then
		self._newestNpcId = newestNpcId
	end

	self:_onUpdateNoteColUI()
	self:_onUpdateMyNote()
	self:_onUpdateReplyColUI()
	self:_onUpdatePrizeCol()
	self:_onUpdateHuifuColUI()
	GameUtil.SetActive(self._btnHuifu, not self._searchMo:getTodayReply())
end

function NaiLongHotSearchMainView:_onUpdateMyNote()
	self._txtHotMyNote.text = self._searchMo:getHeatValue()
	self._txtDescMyNote.text = self._informationData.desc

	local kudosCount = self._searchMo:getKudosCount()

	self._txtKudoCount.text = 13000 >= 10000 and string.format("x%d万+", 13000 / 10000) or string.format("x%s", 13000)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtHotMyNote.gameObject:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._hotValueMyNote:GetComponent(goutil.Type_RectTransform))
	GameUtil.setUIGroupIdx(self._btnKudo, self._searchMo:isHasDailyKudosLimit() and 1 or 0)
end

function NaiLongHotSearchMainView:_onUpdateReplyColUI()
	self._replyInfoList = {}

	local myData = NaiLongHotSearchConfig.instance:getReplyPlanData(self._activityId, self._informationId, self._replyId)

	if myData then
		local myInfo = {}

		myInfo.tag = 1
		myInfo.data = myData

		table.insert(self._replyInfoList, myInfo)
	end

	for npcId = 1, self._newestNpcId do
		local data = NaiLongHotSearchConfig.instance:getReplyNpcData(self._replyId, npcId)

		if data then
			local info = {}

			info.tag = 2
			info.data = data

			table.insert(self._replyInfoList, info)
		end
	end

	self._replyScrollerList:reloadData(self._replyInfoList)
	GameUtil.SetActive(self._emptyReply, #self._replyInfoList <= 0)
end

function NaiLongHotSearchMainView:_onClearReplyCol()
	self._replyScrollerList:dispose()
end

function NaiLongHotSearchMainView:_updateReplyCell(view, cell, info, tag)
	if tag == 1 then
		self:_updateReplyCellInMy(view, cell, info, tag)
	elseif tag == 2 then
		self:_updateReplyCellInNpc(view, cell, info, tag)
	end
end

function NaiLongHotSearchMainView:_updateReplyCellInMy(view, cell, info, tag)
	local data = info.data
	local mainGo = cell.gameObject
	local headCon = goutil.findChild(mainGo, "headCon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = data.context
	txtName.text = RoleModel.instance:getUserName()

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(headCon, headInfo, false)
end

function NaiLongHotSearchMainView:_updateReplyCellInNpc(view, cell, info, tag)
	local data = info.data
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "head/con")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	MaterialMgr.setIcon(con, MatType.Pet, data.skinId, nil, nil)

	txtDesc.text = data.context
	txtName.text = CharacterConfig.instance:getPetName(data.skinId)
end

function NaiLongHotSearchMainView:_clearReplyCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "head/con")
	local headCon = goutil.findChild(mainGo, "headCon")

	MaterialMgr.clearIcon(con)
	HeadItemController.instance:resetHeadCell(headCon)
end

function NaiLongHotSearchMainView:_getTagByIdx(data, idx)
	return data.tag
end

function NaiLongHotSearchMainView:_getCellSize(view, idx)
	local info = self._replyInfoList[idx + 1]
	local tag = info.tag

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function NaiLongHotSearchMainView:_onUpdateHuifuColUI()
	local cfg = NaiLongHotSearchConfig.instance:getReplyPlanCfg(self._activityId, self._informationId) or {}

	self._huifuScrollList:reloadData(cfg)

	local idx = Mathf.Max(self._replyId - 1, 0)

	self._huifuScrollList:MoveCellInView(idx, true)
end

function NaiLongHotSearchMainView:_onClearHuifuColUI()
	self._huifuScrollList:dispose()
end

function NaiLongHotSearchMainView:_updateHuifuCell(view, cell, data, tag)
	local replyId = data.replyId
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = data.context

	GameUtil.addClickHandler(mainGo, function()
		if self._searchMo:getTodayReply() then
			FloatWordMgr.instance:show("今日已回复")

			return
		end

		NaiLongHotSearchController.instance:sendPM_HotSearchReplyReq(self._activityId, replyId)
		GameUtil.SetActive(self._btnHuifu, false)
		GameUtil.SetActive(self._huifuCol, false)

		local fromPos = GameUtil.getPos(mainGo)
		local toPos = GameUtil.getPos(self._goodFlyToPos)

		self:_flyGoodAnim(fromPos, toPos, nil)
	end)
end

function NaiLongHotSearchMainView:_clearHuifuCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function NaiLongHotSearchMainView:_onCustomInputCallbackOfHuifu(hover)
	if not hover then
		GameUtil.SetActive(self._huifuCol, not GameUtil.GetActive(self._huifuCol))
	end
end

function NaiLongHotSearchMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0
	local isHavePrize = false

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			index = idx
			isHavePrize = true

			break
		elseif self:_isHasGainPrize(data) then
			index = idx
		end
	end

	GameUtil.SetActive(self._btnGetAll, isHavePrize)
	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._txtNumPrize.text = curProgress
end

function NaiLongHotSearchMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function NaiLongHotSearchMainView:_getProgressDataList()
	return NaiLongHotSearchConfig.instance:getProPrizeCfg(self._activityId) or {}
end

function NaiLongHotSearchMainView:_getSliderComp()
	return self._sliderComp
end

function NaiLongHotSearchMainView:_getScrollRect()
	return self._prizeScrView:GetComponent(ComponentType.ScrollRect)
end

function NaiLongHotSearchMainView:_getCurProgress()
	return self._searchMo:getHeatValue()
end

function NaiLongHotSearchMainView:_getProgressByData(data)
	return checknumber(data.needProgress)
end

function NaiLongHotSearchMainView:_getPrizeIdByData(data)
	return data.prizeId
end

function NaiLongHotSearchMainView:_getPrizeStrByData(data)
	return data.prize
end

function NaiLongHotSearchMainView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._searchMo:isHasGainPrize(prizeId)
end

function NaiLongHotSearchMainView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._searchMo:isEnoughGetPrize(prizeId)
end

function NaiLongHotSearchMainView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._searchMo:isCanGetPrize(prizeId)
end

function NaiLongHotSearchMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
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
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function NaiLongHotSearchMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function NaiLongHotSearchMainView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	NaiLongHotSearchController.instance:sendPM_HotSearchGainPrizeReq(self._activityId, {
		prizeId
	})
end

function NaiLongHotSearchMainView:_onClickPrizeGetAll()
	local prizeIds = {}
	local dataList = self:_getProgressDataList()

	if dataList then
		for _, data in ipairs(dataList) do
			if self:_isCanGetPrize(data) then
				table.insert(prizeIds, self:_getPrizeIdByData(data))
			end
		end
	end

	if #prizeIds <= 0 then
		FloatWordMgr.instance:show("没有可领取的奖励")

		return
	end

	NaiLongHotSearchController.instance:sendPM_HotSearchGainPrizeReq(self._activityId, prizeIds)
end

function NaiLongHotSearchMainView:_onUpdateNoteColUI()
	local noteInfoList = {}
	local naiLongInfo = {}
	local myData = NaiLongHotSearchConfig.instance:getInformationData(self._activityId, self._informationId)

	naiLongInfo.noteId = 0

	if myData then
		naiLongInfo.desc = myData.desc or ""
	end

	naiLongInfo.hotValue = self._searchMo:getHeatValue()

	table.insert(noteInfoList, naiLongInfo)

	local cfg = NaiLongHotSearchConfig.instance:getNoteCfg(self._activityId) or {}

	for _, data in ipairs(cfg) do
		local info = {}

		info.noteId = data.noteId
		info.desc = data.desc
		info.hotValue = WorldProgressPrizeController.instance:getProgress(self._activityId, data.progressId)

		table.insert(noteInfoList, info)
	end

	table.sort(noteInfoList, function(a, b)
		return a.hotValue > b.hotValue
	end)

	local list = {}

	for i = 1, Mathf.Min(#noteInfoList, 5) do
		table.insert(list, noteInfoList[i])
	end

	self._noteScrollerList:reloadData(list)

	self._txtHotInMyDesc.text = self._searchMo:getHeatValue()
	self._txtDescInMyDesc.text = self._informationData.desc

	local myRank = 0

	for rank, info in ipairs(noteInfoList) do
		if info.noteId == 0 then
			myRank = rank

			break
		end
	end

	self._txtRankInMyDesc.text = myRank <= 0 and "无" or myRank
end

function NaiLongHotSearchMainView:_onClearNoteCol()
	self._noteScrollerList:dispose()
end

function NaiLongHotSearchMainView:_updateNoteCell(view, cell, info, tag)
	local rank = cell.data
	local mainGo = cell.gameObject
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtHot = goutil.findChildTextComponent(mainGo, "txtHot")
	local imgRank = goutil.findChild(mainGo, "imgRank")

	txtDesc.text = info.desc
	txtHot.text = info.hotValue

	local isTop3 = rank <= 3

	if isTop3 then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	else
		txtRank.text = rank
	end

	GameUtil.SetActive(txtRank.gameObject, not isTop3)
	GameUtil.SetActive(imgRank.gameObject, isTop3)
end

function NaiLongHotSearchMainView:_clearNoteCell(cell)
	return
end

function NaiLongHotSearchMainView:_flyGoodAnim(formPos, toPos, completeCallBack)
	self:_clearFlyGoodAnim()

	local distance = Vector2.Distance(formPos, toPos)
	local speedRatio = 3
	local duration = distance / speedRatio
	local intervalDelta = 0.1
	local sequence = DG.Tweening.DOTween.Sequence()

	for _, mainGo in ipairs(self._goodFlyGoList) do
		GameUtil.SetActive(mainGo, false)
		GameUtil.setLocalScale(mainGo, 1)
		GameUtil.setPos(mainGo, formPos.x, formPos.y, formPos.z)

		local arcXFactor = math.random() * 2 - 1
		local arcYFactor = math.random() * 2 - 1
		local pathPoints = self:_getArcPathPoints(formPos, toPos, arcXFactor, arcYFactor)
		local tweenerPath = mainGo.transform:DOPath(pathPoints, duration, DG.Tweening.PathType.CatmullRom)

		tweenerPath:SetEase(DG.Tweening.Ease.Linear)
		tweenerPath:OnStart(function()
			GameUtil.SetActive(mainGo, true)
		end)
		tweenerPath:OnComplete(function()
			GameUtil.SetActive(mainGo, false)
		end)

		local random = 1.3
		local tweenerScale = mainGo.transform:DOScale(Vector3.New(1, 1, 1):Mul(random), duration)

		tweenerScale:OnComplete(function()
			GameUtil.setLocalScale(mainGo, 1)
		end)
		tweenerScale:SetEase(DG.Tweening.Ease.OutQuad)
		sequence:Join(tweenerPath)
		sequence:Join(tweenerScale)
		sequence:PrependInterval(intervalDelta)
	end

	GameUtil.setLocalScale(self._imgFire, 1)
	GameUtil.setLocalRotation(self._imgFire, 0, 0, 0)

	local swingDuration = 0.2
	local swingAngle = 15
	local scaleAmount = 0.3
	local loopCount = math.floor((duration + intervalDelta * #self._goodFlyGoList) / swingDuration)
	local tweenRotateImgFire = self._imgFire.transform:DORotate(Vector3.New(0, 0, swingAngle), swingDuration)

	tweenRotateImgFire:SetEase(DG.Tweening.Ease.InOutSine)
	tweenRotateImgFire:SetLoops(loopCount, DG.Tweening.LoopType.Yoyo)
	tweenRotateImgFire:OnComplete(function()
		GameUtil.setLocalRotation(self._imgFire, 0, 0, 0)
	end)

	local tweenScaleImgFire = self._imgFire.transform:DOScale(Vector3.New(1 + scaleAmount, 1 - scaleAmount, 1), swingDuration / 2)

	tweenScaleImgFire:SetEase(DG.Tweening.Ease.InOutSine)
	tweenScaleImgFire:SetLoops(loopCount * 2, DG.Tweening.LoopType.Yoyo)
	tweenScaleImgFire:OnComplete(function()
		GameUtil.setLocalScale(self._imgFire, 1)
	end)
	sequence:Join(tweenRotateImgFire)
	sequence:Join(tweenScaleImgFire)
	sequence:OnComplete(function()
		self:_clearFlyGoodAnim()
		GameUtil.callBack(completeCallBack)
	end)

	self._goodFlySequence = sequence
end

function NaiLongHotSearchMainView:_clearFlyGoodAnim()
	if self._goodFlySequence then
		self._goodFlySequence:Kill(false)

		self._goodFlySequence = nil
	end

	for _, mainGo in ipairs(self._goodFlyGoList) do
		GameUtil.SetActive(mainGo, false)
	end
end

function NaiLongHotSearchMainView:_getArcPathPoints(formPos, toPos, arcXFactor, arcYFactor)
	local pathPoints = {
		formPos
	}
	local midPoint = Vector3.Lerp(formPos, toPos, 0.5)
	local offessX = Mathf.Abs(toPos.x - midPoint.x)
	local offessY = Mathf.Abs(toPos.y - midPoint.y)

	midPoint.x = midPoint.x + offessX * arcXFactor
	midPoint.y = midPoint.y + offessY * arcYFactor

	table.insert(pathPoints, midPoint)
	table.insert(pathPoints, toPos)

	return pathPoints
end

function NaiLongHotSearchMainView:_onBeginDragHandler(go, eventData)
	self._playScrollAnim = 3

	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end
end

function NaiLongHotSearchMainView:_onReloadFinish()
	self._playScrollAnim = 0
end

function NaiLongHotSearchMainView:_playScrollAnimation()
	if self._sequence then
		return
	end

	local startPos = self._replyScrollRect.verticalNormalizedPosition
	local endPos = 0
	local duration = #self._replyInfoList * 2 * startPos

	local function updateTween(num)
		if self._replyScrollRect then
			self._replyScrollRect.verticalNormalizedPosition = num
		end
	end

	local sequence = DG.Tweening.DOTween.Sequence()
	local tweener1 = TweenUtil.DOTweenNum(startPos, endPos, duration, updateTween, {})

	tweener1:SetEase(DG.Tweening.Ease.Linear)
	sequence:Append(tweener1)
	sequence:AppendInterval(1.5)
	sequence:OnComplete(function()
		self._sequence = nil
		self._replyScrollRect.verticalNormalizedPosition = 1

		self:_playScrollAnimation()
	end)

	self._sequence = sequence
end

function NaiLongHotSearchMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function NaiLongHotSearchMainView:_onClickBtnFeed()
	local num = MaterialModel.instance:getMaterialsNumber(self._giftItemMat.matType, self._giftItemMat.matId)

	if num <= 0 then
		FloatWordMgr.instance:show("礼物数量不足")

		return
	end

	local num = MaterialModel.instance:getMaterialsNumber(self._giftItemMat.matType, self._giftItemMat.matId)
	local tipsContent = string.format("是否投喂%s个%s？", num, self._giftItemMat.matName)

	local function okFunc()
		NaiLongHotSearchController.instance:sendPM_HotSearchPresentReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function NaiLongHotSearchMainView:_onClickBtnKudo()
	if self._searchMo:isHasDailyKudosLimit() then
		FloatWordMgr.instance:show("已达今日点赞上限")

		return
	end

	NaiLongHotSearchController.instance:sendPM_HotSearchKudosReq(self._activityId)
end

function NaiLongHotSearchMainView:_onClickBtnHuifu()
	if not self._searchMo:getTodayReply() then
		self:_onCustomInputCallbackOfHuifu(false)
	end
end

function NaiLongHotSearchMainView:_onClickBtnHome()
	UIStateManager.instance:push(ViewName.NaiLongHotSearchReplyView, self._activityId)
end

function NaiLongHotSearchMainView:_onClickBtnTask()
	AnchorSimulatorController.instance:opEventTask()
end

return NaiLongHotSearchMainView
