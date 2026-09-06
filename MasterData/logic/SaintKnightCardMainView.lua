-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardMainView.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardMainView", package.seeall)

local SaintKnightCardMainView = class("SaintKnightCardMainView", TableViewComponent)

function SaintKnightCardMainView:_getPath()
	return {
		cellPath = "mid/groupCol/cell",
		viewPath = "mid/groupCol/tableview"
	}
end

function SaintKnightCardMainView:buildUI()
	SaintKnightCardMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._groupCol = goutil.findChild(self.mainGO, "mid/groupCol")
	self._recordScrollerview = goutil.findChild(self.mainGO, "recordCol/recordScrollerview")
	self._recordScrollercell = goutil.findChild(self.mainGO, "recordCol/recordScrollercell")
	self._recordScrollerViewport = goutil.findChild(self.mainGO, "recordCol/recordScrollerview/Viewport")
	self._tabCol = goutil.findChild(self.mainGO, "mid/tabCol")
	self._rewardCol = goutil.findChild(self.mainGO, "rewardCol")
	self._rewardGo = goutil.findChild(self.mainGO, "rewardCol/rewardGo")
	self._btnRewardGet = goutil.findChild(self.mainGO, "rewardCol/rewardGo/btnRewardGet")
	self._rewardIcon = goutil.findChild(self.mainGO, "rewardCol/rewardGo/icon")
	self._rewardEffParent = goutil.findChild(self.mainGO, "rewardCol/rewardGo/effParent")
	self._receivedGo = goutil.findChild(self.mainGO, "rewardCol/rewardGo/receivedGo")
	self._txtExPrizeTime = goutil.findChildTextComponent(self.mainGO, "rewardCol/txtExPrizeTime")
	self._btnBuy = goutil.findChild(self.mainGO, "buy/btnBuy")
	self._imgAct = goutil.findChild(self.mainGO, "buy/imgAct")
	self._txtBtnBuy = goutil.findChildTextComponent(self.mainGO, "buy/btnBuy/txtBtnBuy")
	self._txtAmount = goutil.findChildTextComponent(self.mainGO, "txtAmount")
	self._btnTip = goutil.findChild(self.mainGO, "btnTip")
	self._imgSlogan = goutil.findChild(self.mainGO, "imgSlogan")
	self._imgBg = goutil.findChild(self.mainGO, "imgBg")
	self._recordScrollList = ScrollerList.create(self._recordScrollerview, self._recordScrollercell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
	self._rewardEff = nil
end

function SaintKnightCardMainView:bindEvents()
	SaintKnightCardMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBtnBuy, self)
	GameUtil.addClickHandler(self._btnRewardGet, self._onClickRewardGo, self)
	GameUtil.addClickHandler(self._recordScrollerViewport, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function SaintKnightCardMainView:unbindEvents()
	SaintKnightCardMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnRewardGet)
	GameUtil.rmClickHandler(self._recordScrollerViewport)
	GameUtil.rmClickHandler(self._btnTip)
end

function SaintKnightCardMainView:onEnter()
	SaintKnightCardMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SaintKnightCard)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._actData = SaintKnightCardConfig.instance:getSkcActData(self._activityId)

	local firstDrawPlanId = self._actData.drawPlanIds[1]

	if checknumber(firstDrawPlanId) > 0 then
		self._curDrawPlanId = self._curDrawPlanId or firstDrawPlanId
	else
		FloatWordMgr.instance:show("drawPlanIds缺失")
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardGainExPrizeRes, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardNotifyRes, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardDrawAnimEnd, self._handleCardDrawAnimEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardGetRecordRes, self._onUpdateRecordColUI, self)
	self:_sendInfoReq()
	SaintKnightCardController.instance:sendSaintKnightCardGetRecordReq(self._activityId)
end

function SaintKnightCardMainView:onExit()
	SaintKnightCardMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardGainExPrizeRes, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardNotifyRes, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardDrawAnimEnd, self._handleCardDrawAnimEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardGetRecordRes, self._onUpdateRecordColUI, self)
	self:_onClearTabCol()
	self:_onClearRecordCol()
	self:_onClearRewardCol()
	uGuiUtil.clearImage(self._imgSlogan)
	uGuiUtil.clearImage(self._imgBg)
	UIEffectManager.instance:stopEffect(self._bgEff)

	self._bgEff = nil
	self._imgSloganPath = nil
	self._imgViewBgPath = nil
end

function SaintKnightCardMainView:_sendInfoReq()
	SaintKnightCardController.instance:sendSaintKnightCardGetInfoReq(self._activityId)
end

function SaintKnightCardMainView:_handleCardDrawAnimEnd()
	self:_sendInfoReq()
	SaintKnightCardController.instance:sendSaintKnightCardGetRecordReq(self._activityId)
end

function SaintKnightCardMainView:_onSetUI()
	self._cell2PrizeList = {}

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SaintKnightCard, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local effParent = self.mainGO
	local pathName = "fx_ui_qirirenwu/fx_qirirenwu_pingmu"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function SaintKnightCardMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SaintKnightCardMainView:_onUpdateData()
	self:_onUpdateGroupColData()
end

function SaintKnightCardMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateGroupColUI()
	self:_onUpdateRewardColUI()
	self:_onUpdateBg()
end

function SaintKnightCardMainView:_onUpdateBg()
	local drawData = SaintKnightCardConfig.instance:getSkcDrawData(self._curDrawPlanId)

	if not drawData.imgViewBg then
		if self._imgViewBgPath ~= drawData.imgViewBg then
			uGuiUtil.clearImage(self._imgBg)

			self._imgViewBgPath = drawData.imgViewBg

			uGuiUtil.setSpriteToImage(self._imgBg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("saintknightcard", self._imgViewBgPath))
		end

		local imgSloganPath = drawData.imgSlogan

		if self._imgSloganPath ~= imgSloganPath then
			uGuiUtil.clearImage(self._imgSlogan)

			self._imgSloganPath = imgSloganPath

			uGuiUtil.setSpriteToImage(self._imgSlogan, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("saintknightcard", self._imgSloganPath))
		end
	end
end

function SaintKnightCardMainView:_onUpdatePlaneUI()
	local drawData = SaintKnightCardConfig.instance:getSkcDrawData(self._curDrawPlanId)
	local drawSpacePayNum = SaintKnightCardModel.instance:getDrawSpacePayNum(self._curDrawPlanId)

	if drawData.payType == SaintKnightCardConfig.PT_ZF then
		local value = checknumber(string.split(drawData.goodsId, "_")[2])

		self._txtBtnBuy.text = string.format("¥%d元", value)
	elseif drawData.payType == SaintKnightCardConfig.PT_ITEM then
		local matType, id, matNum = MaterialMgr.getMatParams(drawData.goodsId)
		local matName = MaterialMgr.getMaterialsName(matType, id)

		self._txtBtnBuy.text = string.format("%d%s", matNum, matName)
	else
		self._txtBtnBuy.text = lang("免费")
	end

	self._txtAmount.text = string.format("全服共%s人购买", drawSpacePayNum)

	GameUtil.SetActive(self._imgAct, SaintKnightCardModel.instance:isDrawActivated(self._curDrawPlanId))
	GameUtil.SetActive(self._btnBuy, not SaintKnightCardModel.instance:isDrawActivated(self._curDrawPlanId))
end

function SaintKnightCardMainView:_onUpdateTabColUI()
	for index, drawPlanId in ipairs(self._actData.drawPlanIds) do
		local mainGo = goutil.findChild(self._tabCol, "tabCell_" .. index)

		if mainGo == nil then
			printError("缺少预制")

			break
		end

		local select = goutil.findChild(mainGo, "select")
		local txtName = goutil.findChildTextComponent(mainGo, "txtName")
		local txtName2 = goutil.findChildTextComponent(mainGo, "select/txtName")
		local redPoint = goutil.findChild(mainGo, "redPoint")
		local drawData = SaintKnightCardConfig.instance:getSkcDrawData(drawPlanId)
		local isCanGet = SaintKnightCardController.instance:isCanGetPrizeInPlan(drawPlanId)

		txtName.text = drawData.txtTitle
		txtName2.text = drawData.txtTitle

		GameUtil.SetActive(select, self._curDrawPlanId == drawData.drawPlanId)
		GameUtil.SetActive(redPoint, false)

		if not string.nilorempty(drawData.onceRedPoint) then
			RedPointController.instance:unregRedPoint(redPoint)
			RedPointController.instance:regRedPoint(redPoint, drawData.onceRedPoint)
		end

		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, drawData))
	end
end

function SaintKnightCardMainView:_onClearTabCol()
	for index, drawPlanId in ipairs(self._actData.drawPlanIds) do
		local mainGo = goutil.findChild(self._tabCol, "tabCell_" .. index)
		local redPoint = goutil.findChild(mainGo, "redPoint")

		RedPointController.instance:unregRedPoint(redPoint)
		GameUtil.rmClickHandler(mainGo)
	end
end

function SaintKnightCardMainView:_onClickTabCell(data)
	SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))

	if not string.nilorempty(data.onceRedPoint) then
		RedPointController.instance:saveUserOnceRedPoint(data.onceRedPoint, true)
	end

	self._curDrawPlanId = data.drawPlanId

	self:_onUpdate()
end

function SaintKnightCardMainView:_onUpdateGroupColData()
	self._groupInfoList = {}

	local prizeCfg = SaintKnightCardConfig.instance:getSkcPrizeCfgById(self._curDrawPlanId)

	for _, prizeData in ipairs(prizeCfg) do
		local info = {
			state = self:_calcPrizeState(prizeData),
			isUnlock = SaintKnightCardController.instance:isPrizeGroupUnlock(self._curDrawPlanId, prizeData.groupId),
			data = prizeData
		}

		table.insert(self._groupInfoList, info)
	end
end

function SaintKnightCardMainView:_calcPrizeState(data)
	local isHasGain = SaintKnightCardController.instance:isHasGainPrizeGroup(self._curDrawPlanId, data.groupId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = SaintKnightCardController.instance:isEnoughGetPrizeGroup(self._curDrawPlanId, data.groupId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function SaintKnightCardMainView:_onUpdateGroupColUI()
	self:updateListData(self._groupInfoList)
end

function SaintKnightCardMainView:_cellSize(view, index)
	return 332, 606
end

function SaintKnightCardMainView:_updateCell(view, mainGo, info)
	local state = info.state
	local isUnlock = info.isUnlock
	local data = info.data
	local imgPath = GameUrl.getBigbgFolderUrl("saintknightcard", data.imgPet)
	local btnInfo = goutil.findChild(mainGo, "btnInfo")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtDrawTipsGo = goutil.findChild(mainGo, "txtDrawTips")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local prizeItemListGo = goutil.findChild(mainGo, "itemview")
	local prizeItemListViewportGo = goutil.findChild(mainGo, "itemview/Viewport")
	local prizeItemGo = goutil.findChild(mainGo, "item")

	txtName.text = data.txtName

	GameUtil.SetActive(redPoint, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(txtDrawTipsGo.gameObject, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(btnInfo, isUnlock and not string.nilorempty(data.jumpTo))
	uGuiUtil.clearImage(mainGo.gameObject)
	uGuiUtil.setSpriteToImage(mainGo.gameObject, uGuiUtil.SpriteType.BigBg, imgPath)
	GameUtil.addClickHandler(btnInfo, GameUtil.handler(self._onClickGroupBtnInfo, self, info))
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickGroupBtnCell, self, info))
	self:_clearPrizeCells(mainGo)

	if not string.nilorempty(data.prize) then
		local prizeStrArray = string.split(data.prize, "#")
		local prizeLen = #prizeStrArray
		local width = 0

		width = prizeLen == 1 and 58 or prizeLen == 2 and 120 or 182

		GameUtil.setWidth(prizeItemListGo, width)
		GameUtil.setWidth(prizeItemListViewportGo, width)

		local list = ScrollerList.create(prizeItemListGo, prizeItemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		self._cell2PrizeList[mainGo] = list

		local prizeInfos = {}

		for i, prize in ipairs(prizeStrArray) do
			table.insert(prizeInfos, {
				state = state,
				prize = prize
			})
		end

		list:reloadData(prizeInfos)
		list:refresh()
	end
end

function SaintKnightCardMainView:_clearTableview(cell)
	local btnInfo = goutil.findChild(cell, "btnInfo")

	GameUtil.rmClickHandler(cell)
	GameUtil.rmClickHandler(btnInfo)
	uGuiUtil.clearImage(cell)
	self:_clearPrizeCells(cell)
end

function SaintKnightCardMainView:_clearPrizeCells(cell)
	local list = self._cell2PrizeList[cell]

	if list then
		list:dispose()
	end

	self._cell2PrizeList[cell] = nil
end

function SaintKnightCardMainView:_updatePrizeCell(index, cell, data)
	local item = goutil.findChild(cell, "item")
	local receive = goutil.findChild(cell, "get")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	goutil.setActive(receive, data.state == GameEnum.PrizeState.IsHasGain)
end

function SaintKnightCardMainView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function SaintKnightCardMainView:_onClickGroupBtnGoto(data, state)
	if state == GameEnum.PrizeState.IsCanGet then
		UIStateManager.instance:push(ViewName.SaintKnightCardDrawView, self._activityId, self._curDrawPlanId, data.groupId)
	elseif state == GameEnum.PrizeState.IsNotEnough then
		FloatWordMgr.instance:show("未满足抽奖条件")
	elseif state == GameEnum.PrizeState.IsHasGain then
		if string.nilorempty(data.jumpTo) then
			return
		end

		GotoMgr.gotoByString(data.jumpTo)
	end
end

function SaintKnightCardMainView:_onClickGroupLockMask(data, state)
	local openDate = GameUtil.string2date(data.openTime)

	FloatWordMgr.instance:show(string.format("%d.%d %d:%02d 后解锁", openDate.month, openDate.day, openDate.hour, openDate.min))
end

function SaintKnightCardMainView:_onClickGroupBtnInfo(info)
	local jumpTo = info.data.jumpTo

	if string.nilorempty(jumpTo) then
		return
	end

	GotoMgr.gotoByString(jumpTo)
end

function SaintKnightCardMainView:_onClickGroupBtnCell(info)
	if not info.isUnlock then
		local openDate = GameUtil.string2date(info.data.openTime)

		FloatWordMgr.instance:show(string.format("%d-%02d-%02d %d:%02d 后即可抽奖", openDate.year, openDate.month, openDate.day, openDate.hour, openDate.min))

		return
	end

	if info.state == GameEnum.PrizeState.IsCanGet then
		UIStateManager.instance:push(ViewName.SaintKnightCardDrawView, self._activityId, self._curDrawPlanId, info.data.groupId)
	elseif info.state == GameEnum.PrizeState.IsNotEnough then
		self:_onClickBtnBuy()
	elseif info.state == GameEnum.PrizeState.IsHasGain then
		FloatWordMgr.instance:show("您已经抽过奖了哦")
	else
		FloatWordMgr.instance:show("不要再点了！")
	end
end

function SaintKnightCardMainView:_onUpdateRecordColUI()
	self._recordInfoList = SaintKnightCardModel.instance:getRecordInfoList()

	self._recordScrollList:reloadData(self._recordInfoList)
	self:_readyRecordAnim()
end

function SaintKnightCardMainView:_onClearRecordCol()
	self._recordScrollList:dispose()
	removetimer(self._playRecordAnim, self)
end

function SaintKnightCardMainView:_updateRecordCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local prizeData = SaintKnightCardConfig.instance:getSkcPrizeDataById(self._curDrawPlanId, data.groupId)

	txtDesc.text = string.format("恭喜%s服务器的%s抽中了%s", data.areaName, data.userName, prizeData.txtName)
end

function SaintKnightCardMainView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = string.format("")
end

function SaintKnightCardMainView:_readyRecordAnim()
	self._curRecordIdx = -1
	self._timeSec = 0

	removetimer(self._playRecordAnim, self)

	if #self._recordInfoList > 0 then
		settimer(1, self._playRecordAnim, self, true)
	end
end

function SaintKnightCardMainView:_playRecordAnim()
	self._curRecordIdx = self._curRecordIdx + 1

	local maxRecordIdx = #self._recordInfoList - 1

	self._timeSec = self._timeSec + 1

	if maxRecordIdx < self._curRecordIdx then
		if self._timeSec > 10 then
			self._timeSec = 0

			removetimer(self._playRecordAnim, self)
			SaintKnightCardController.instance:sendSaintKnightCardGetRecordReq(self._activityId)

			return
		else
			self._curRecordIdx = 0
		end
	end

	self._recordScrollList:MoveCellInView(self._curRecordIdx, self._curRecordIdx ~= 0)
end

function SaintKnightCardMainView:_onClickRecord()
	UIStateManager.instance:push(ViewName.SaintKnightCardRankView)
end

function SaintKnightCardMainView:_onUpdateRewardColUI()
	local drawData = SaintKnightCardConfig.instance:getSkcDrawData(self._curDrawPlanId)

	if string.nilorempty(drawData.extraPrize) then
		GameUtil.SetActive(self._rewardCol, false)

		return
	end

	local isActivated = SaintKnightCardModel.instance:isDrawActivated(self._curDrawPlanId)
	local isInTimeActivated = SaintKnightCardController.instance:isInTimeActivatedInDrawPlan(self._curDrawPlanId)
	local isCanGet = SaintKnightCardController.instance:isCanGetExPrizeInDrawPlan(self._curDrawPlanId)
	local isHasGain = SaintKnightCardController.instance:isHasGainExPrizeInDrawPlan(self._curDrawPlanId)

	MaterialMgr.setCellByCfg(drawData.extraPrize, self._rewardIcon)

	local extraPrizeTimeArray = string.split(drawData.extraPrizeOpenTime, "#")
	local endTime = GameUtil.string2time(extraPrizeTimeArray[2])
	local endDate = GameUtil.time2date(endTime)

	self._txtExPrizeTime.text = string.format("仅限%d.%d %d:%02d前", endDate.month, endDate.day, endDate.hour, endDate.min)

	UIEffectManager.instance:stopEffect(self._rewardEff)

	self._rewardEff = nil

	if isCanGet then
		local effParent = self._rewardEffParent
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

			self._rewardEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, nil)
		end
	end

	GameUtil.SetActive(self._receivedGo, isHasGain)

	if endTime <= ServerTime.now() then
		GameUtil.SetActive(self._rewardCol, isInTimeActivated)
	else
		GameUtil.SetActive(self._rewardCol, true)
	end
end

function SaintKnightCardMainView:_onClearRewardCol()
	UIEffectManager.instance:stopEffect(self._rewardEff)

	self._rewardEff = nil

	MaterialMgr.resetAll(self._rewardIcon)
end

function SaintKnightCardMainView:_onClickRewardGo()
	local drawData = SaintKnightCardConfig.instance:getSkcDrawData(self._curDrawPlanId)
	local isCanGet = SaintKnightCardController.instance:isCanGetExPrizeInDrawPlan(self._curDrawPlanId)
	local isHasGain = SaintKnightCardController.instance:isHasGainExPrizeInDrawPlan(self._curDrawPlanId)
	local isEnoughGet = SaintKnightCardController.instance:isEnoughGetExPrizeInDrawPlan(self._curDrawPlanId)

	if isCanGet then
		SaintKnightCardController.instance:sendSaintKnightCardGainExPrizeReq(self._activityId, self._curDrawPlanId)
	elseif isHasGain then
		FloatWordMgr.instance:show("该奖励您已领取")
	elseif not isEnoughGet then
		local exTimeArray = string.split(drawData.extraPrizeOpenTime, "#")
		local openDate, endDate = GameUtil.string2date(exTimeArray[1]), GameUtil.string2date(exTimeArray[2])

		FloatWordMgr.instance:show(string.format("在 %d.%d %d:%02d-%d.%d %d:%02d 时间段内购买，方可领取哦", openDate.month, openDate.day, openDate.hour, openDate.min, endDate.month, endDate.day, endDate.hour, endDate.min))
	end
end

function SaintKnightCardMainView:_clearAlphaAnimByTween(tween)
	if tween == nil then
		return
	end

	tween:Kill(true)
end

function SaintKnightCardMainView:_clearAlphaAnimByComp(comp)
	self:_clearAlphaAnimByTween(self._tweenPool[comp])
end

function SaintKnightCardMainView:_onClickBtnBuy()
	if SaintKnightCardModel.instance:isDrawActivated(self._curDrawPlanId) then
		FloatWordMgr.instance:show("该圣骑卡您已购买")

		return
	end

	local drawData = SaintKnightCardConfig.instance:getSkcDrawData(self._curDrawPlanId)
	local tipsContent = drawData.txtPayTips

	local function okFunc()
		local payGoodsId = drawData.goodsId
		local subGoodsType = GameEnum.PaySubGoodsType.SAINTKNIGHTCARDDRAWPLAN
		local subGoodsId = self._activityId

		if drawData.payType == SaintKnightCardConfig.PT_ZF then
			local para = {
				drawPlanId = drawData.drawPlanId
			}
			local extParams = GameUtil.jsonToString(para)

			PayController.instance:pay(payGoodsId, subGoodsType, subGoodsId, extParams)
		elseif drawData.payType == SaintKnightCardConfig.PT_ITEM then
			SaintKnightCardAgent.instance:sendPM_SaintKnightCardGainBuyReq(self._activityId, drawData.drawPlanId)
		end
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function SaintKnightCardMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("saintknightcard_rule")
end

return SaintKnightCardMainView
