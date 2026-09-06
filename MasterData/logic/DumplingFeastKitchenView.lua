-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastKitchenView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastKitchenView", package.seeall)

local DumplingFeastKitchenView = class("DumplingFeastKitchenView", ViewComponent)

function DumplingFeastKitchenView:buildUI()
	DumplingFeastKitchenView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtOneKeyTips = self:getTxt("rule/oneKeyTips/txt")
	self._strTxtOneKeyTips = self._txtOneKeyTips.text
	self._oneKeyTips = self:getGo("rule/oneKeyTips")
	self._doughMatView = self:getGo("doughMatView")
	self._doughMatGos = {}

	for idx = 1, self._doughMatView.transform.childCount do
		self._doughMatGos[idx] = self._doughMatView.transform:GetChild(idx - 1).gameObject
	end

	self._dragStuffingMat = self:getGo("dragStuffingMat")

	local stuffingMatScrView = self:getGo("stuffingMat/scrView")
	local stuffingMatScrCell = self:getGo("stuffingMat/scrCell")

	self._stuffingMatScrollerList = ScrollerList.create(stuffingMatScrView, stuffingMatScrCell, GameUtil.handler(self._updateStuffingMatCell, self), GameUtil.handler(self._clearStuffingMatCell, self))

	self._stuffingMatScrollerList:setCenterMode(true)
	self._stuffingMatScrollerList:setDragCallBack("drayPlane", function(eventData, data, go)
		self:_onDragBeginStuffingMatScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragStuffingMatScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragEndStuffingMatScrCell(eventData, data, go)
	end)

	self._doughSeatCell_mainGo = self:getGo("workbench/doughSeat")
	self._doughSeatCell_tips = self:getGo("workbench/doughSeat/tips")
	self._doughSeatCell_btnStart = self:getGo("workbench/doughSeat/btnStart")
	self._doughSeatCell_icon = self:getGo("workbench/doughSeat/icon")
	self._stickGo = self:getGo("workbench/stickGo")
	self._stickEnd = self:getGo("workbench/stickEnd")
	self._stickStart = self:getGo("workbench/stickStart")
	self._workbenchProgress = self:getGo("workbench/progress")
	self._workbenchProgressPoint = self:getGo("workbench/progress/range/point")
	self._workbenchProgressRange = self:getGo("workbench/progress/range")
	self._workbenchProgressRangeWidth = GameUtil.getWidth(self._workbenchProgressRange)

	local stuffingSeat = self:getGo("workbench/stuffingSeat")

	self._stuffingSeatMainGo = stuffingSeat
	self._stuffingSeatReadyTips = goutil.findChild(stuffingSeat, "readyTips")
	self._stuffingSeatMakeTips = goutil.findChild(stuffingSeat, "makeTips")
	self._stuffingSeatCompleteTips = goutil.findChild(stuffingSeat, "completeTips")
	self._stuffingSeatIconDough = goutil.findChild(stuffingSeat, "iconDough")
	self._stuffingSeatIconStuffing = goutil.findChild(stuffingSeat, "iconDough/iconStuffing")
	self._stuffingSeatIconDumpling = goutil.findChild(stuffingSeat, "iconDumpling")
	self._stuffingSeatBtnStart = goutil.findChild(stuffingSeat, "btnStart")
	self._stuffingSeatDragPlane = goutil.findChild(stuffingSeat, "dragPlane")
	self._stuffingSeatPutStuffingArea = goutil.findChild(stuffingSeat, "putStuffingArea")
	self._dragStuffingDumpling = self:getGo("dragStuffingDumpling")
	self._potCells = {}

	local pots = self:getGo("pots")

	for idx = 1, pots.transform.childCount do
		local mainGo = pots.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._iconEmpty = goutil.findChild(mainGo, "iconEmpty")
		cell._iconRuning = goutil.findChild(mainGo, "iconRuning")
		cell._progress = goutil.findChild(mainGo, "progress")
		cell._btnComplete = goutil.findChild(mainGo, "progress/btnComplete")
		cell._point = goutil.findChild(mainGo, "progress/range/point")
		cell._range = goutil.findChild(mainGo, "progress/range")
		cell._rangeWidth = GameUtil.getWidth(cell._range)
		self._potCells[idx] = cell
	end

	self._bowlCells = {}

	local bowls = self:getGo("bowls")

	for idx = 1, bowls.transform.childCount do
		local mainGo = bowls.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._imgQuality = goutil.findChild(mainGo, "imgQuality")
		cell._icon = goutil.findChild(mainGo, "icon")
		cell._btnGain = goutil.findChild(mainGo, "btnGain")
		cell._btnOneKey = goutil.findChild(mainGo, "btnOneKey")
		cell._effRoot = goutil.findChild(mainGo, "effRoot")

		if cell._effRoot == nil then
			printError("bowlCells effRoot is nil ", idx)
		end

		self._bowlCells[idx] = cell
	end
end

function DumplingFeastKitchenView:bindEvents()
	DumplingFeastKitchenView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DumplingFeastKitchenView:unbindEvents()
	DumplingFeastKitchenView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DumplingFeastKitchenView:onEnter()
	DumplingFeastKitchenView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)

	self:_onInit()
	settimer(0, self._onTicking, self, true)
	self:_onTicking()

	local goldMats = {}
	local rollMatMo = self._subMo:getRollDoughNeedItemMatMo()

	table.insert(goldMats, rollMatMo.matType .. ":" .. rollMatMo.matId)

	local datas = DumplingFeastConfig.instance:getDumplingDatas(self._activityId) or {}

	for i, data in ipairs(datas) do
		local matType, matId, matNum = MaterialMgr.getMatParams(data.stuffFillingNeedItem)

		table.insert(goldMats, matType .. ":" .. matId)
	end

	local list = {}

	for _, matStr in ipairs(goldMats) do
		local tab = {
			showAdd = true,
			id = matStr
		}

		table.insert(list, tab)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastInfoRes, self._handlePM_DumplingFeastInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastRollDoughRes, self._handlePM_DumplingFeastRollDoughRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastStuffFillingRes, self._handlePM_DumplingFeastStuffFillingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastBoilDumplingRes, self._handlePM_DumplingFeastBoilDumplingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastTakeOutDumplingRes, self._handlePM_DumplingFeastTakeOutDumplingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastGainDumplingRes, self._handlePM_DumplingFeastGainDumplingRes, self)
	DumplingFeastController.instance:sendPM_DumplingFeastInfoReq(self._activityId)
end

function DumplingFeastKitchenView:onExit()
	DumplingFeastKitchenView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClear()
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastInfoRes()
	self._dataReady = true

	self:_onUpdate()
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastRollDoughRes()
	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Empty
	self._doughSeatInfo_startMakeMs = 0
	self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_StuffFilling
	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Ready
	self._stuffingSeatInfo_startMakeMs = 0
	self._stuffingSeatInfo_fillingId = 0

	self:_onUpdateDoughSeatUI()
	self:_onUpdateStuffingSeatUI()
	self:_onUpdateStuffingMatUI()
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastStuffFillingRes()
	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Empty
	self._doughSeatInfo_startMakeMs = 0
	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Complete
	self._stuffingSeatInfo_startMakeMs = 0

	self:_onUpdateStuffingSeatUI()
	self:_onUpdateStuffingMatUI()
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastBoilDumplingRes(msg)
	local potId = msg.potId

	self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_None
	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Empty
	self._stuffingSeatInfo_startMakeMs = 0
	self._stuffingSeatInfo_fillingId = 0

	local potInfo = self._potInfos[potId]

	potInfo.state = DumplingFeastSubEnum.SeatState_Making
	potInfo.startMakeMs = checknumber(msg.boilDumplingTime)

	self:_onUpdateStuffingSeatUI()
	self:_onUpdatePotCellUI(potId)
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastTakeOutDumplingRes(msg)
	local potId = msg.potId
	local potInfo = self._potInfos[potId]

	potInfo.state = DumplingFeastSubEnum.SeatState_Empty
	potInfo.startMakeMs = 0

	local bowlId = msg.bowlId
	local bowlInfo = self._bowlInfos[bowlId]

	bowlInfo.state = DumplingFeastSubEnum.SeatState_Complete

	self:_onUpdatePotCellUI(potId)
	self:_onUpdateBowlUI()
	self:_onUpdateOneKeyUI()
end

function DumplingFeastKitchenView:_handlePM_DumplingFeastGainDumplingRes(msg)
	FloatWordMgr.instance:show("领取汤圆成功，快去投喂吧")

	local bowlId = msg.bowlId

	self._bowlInfos[bowlId].state = DumplingFeastSubEnum.SeatState_Empty

	self:_onUpdateBowlCellUI(bowlId)
end

function DumplingFeastKitchenView:_onTicking()
	if not self._dataReady then
		return
	end

	if self._potInfos then
		for potId, potInfo in pairs(self._potInfos) do
			if potInfo.state == DumplingFeastSubEnum.SeatState_Making then
				self:_onPotCellTickingUpdate(potId)
			end
		end
	end
end

function DumplingFeastKitchenView:_onInit()
	self._dataReady = false
	self._maxRollDoughSeconds = self._subMo:getMaxRollDoughSeconds()
	self._maxStuffFillingSeconds = self._subMo:getMaxStuffFillingSeconds()
	self._maxBoilSeconds = self._subMo:getMaxBoilSeconds()

	self:_onUpdateData()
	self:_stopDoughAnimation()
	self:_stopAllTransparentAnim()
	self:_onInitDoughMatUI()
	self:_onInitStuffingMatUI()
	self:_onInitDoughSeatUI()
	self:_onInitStuffingSeatUI()
	self:_onInitPotUI()
	self:_onInitBowlUI()
	self:_onUpdate()
end

function DumplingFeastKitchenView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DumplingFeastKitchenView:_onUpdateData()
	local lastDoughSeconds = self._subMo:getLastDoughSeconds()
	local lastFillingSeconds = self._subMo:getLastFillingSeconds()

	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Empty
	self._doughSeatInfo_startMakeMs = 0
	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Empty
	self._stuffingSeatInfo_startMakeMs = 0
	self._stuffingSeatInfo_fillingId = 0
	self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_None

	if lastFillingSeconds >= 0 then
		self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Complete
		self._stuffingSeatInfo_startMakeMs = lastFillingSeconds * 1000
		self._stuffingSeatInfo_fillingId = self._subMo:getLastStuffFillingDumplingId()
		self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_StuffFilling
	elseif lastDoughSeconds >= 0 then
		self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Ready
		self._stuffingSeatInfo_startMakeMs = 0
		self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_StuffFilling
	end

	self._potInfos = {}

	local potNum = self._subMo:getPotNum()

	for potId = 1, potNum do
		self._potInfos[potId] = {}

		if self._subMo:isEmptyPot(potId) then
			self._potInfos[potId].state = DumplingFeastSubEnum.SeatState_Empty
			self._potInfos[potId].startMakeMs = 0
		else
			self._potInfos[potId].state = DumplingFeastSubEnum.SeatState_Making
			self._potInfos[potId].startMakeMs = self._subMo:getPotDumplingBoilTime(potId)
		end
	end

	self._bowlInfos = {}

	local bowlNum = self._subMo:getBowlNum()

	for bowlId = 1, bowlNum do
		self._bowlInfos[bowlId] = {}
		self._bowlInfos[bowlId].state = self._subMo:isEmptyBowl(bowlId) and DumplingFeastSubEnum.SeatState_Empty or DumplingFeastSubEnum.SeatState_Complete
	end
end

function DumplingFeastKitchenView:_onUpdateUI()
	GameUtil.SetActive(self._workbenchProgress, false)
	self:_onUpdateDoughSeatUI()
	self:_onUpdateStuffingSeatUI()
	self:_onUpdateStuffingMatUI()
	self:_onUpdatePotUI()
	self:_onUpdateBowlUI()
	self:_onUpdateOneKeyUI()
end

function DumplingFeastKitchenView:_onClear()
	self:_stopDoughAnimation()
	self:_stopAllTransparentAnim()
	MaterialMgr.clearIcon(self._dragStuffingMat)
	MaterialMgr.clearIcon(self._dragStuffingDumpling)
	self._stuffingMatScrollerList:dispose()
	self:_onClearDoughSeatUI()
	self:_onClearDoughMatUI()
	self:_onClearStuffingSeatUI()
	self:_onClearPotUI()
	self:_onClearBowlUI()
end

function DumplingFeastKitchenView:_onUpdateOneKeyUI()
	GameUtil.SetActive(self._oneKeyTips, not self._subMo:isCanOpenOneClickMake())

	local cur = self._subMo:getHasMakeBestDumplingTimes()
	local need = self._subMo:getOneClickMakeDumplingNeedBestTimes()

	self._txtOneKeyTips.text = string.format(self._strTxtOneKeyTips, cur, need)
end

function DumplingFeastKitchenView:_onInitDoughMatUI()
	for _, go in ipairs(self._doughMatGos) do
		GameUtil.addClickHandler(go, self._onClickDoughMat, self)
	end
end

function DumplingFeastKitchenView:_onClearDoughMatUI()
	for _, go in ipairs(self._doughMatGos) do
		GameUtil.rmClickHandler(go)
	end
end

function DumplingFeastKitchenView:_onClickDoughMat()
	if not self._dataReady then
		return
	end

	if self._dumplingProcess ~= DumplingFeastSubEnum.DumplingProcess_None then
		FloatWordMgr.instance:show("正在制作中")

		return
	end

	local doughMatMo = self._subMo:getRollDoughNeedItemMatMo()
	local withNum = MaterialModel.instance:getMaterialsNumber(doughMatMo.matType, doughMatMo.matId)

	if withNum < doughMatMo.matNum then
		FloatWordMgr.instance:show(string.format("%s不足，先去购买再进行制作吧", doughMatMo.matName))

		return
	end

	self._dumplingProcess = DumplingFeastSubEnum.DumplingProcess_RollDough
	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Ready
	self._doughSeatInfo_startMakeMs = 0

	self:_onUpdateDoughSeatUI()
end

function DumplingFeastKitchenView:_onInitDoughSeatUI()
	self._doughSeatPressHelper = self._doughSeatPressHelper or BtnLongPressHelper.create(self._doughSeatCell_btnStart)

	self._doughSeatPressHelper:addPressStartHandler(GameUtil.handler(self._onDoughSeatPressStart, self))
	self._doughSeatPressHelper:addPressEndHandler(GameUtil.handler(self._onDoughSeatPressEnd, self))
	self._doughSeatPressHelper:addPressUpdateHandler(GameUtil.handler(self._onDoughSeatPressUpdate, self))
end

function DumplingFeastKitchenView:_onClearDoughSeatUI()
	if self._doughSeatPressHelper then
		self._doughSeatPressHelper:dispose()

		self._doughSeatPressHelper = nil
	end
end

function DumplingFeastKitchenView:_onUpdateDoughSeatUI()
	local isShowDoughSeat = self._dumplingProcess == DumplingFeastSubEnum.DumplingProcess_RollDough

	GameUtil.SetActive(self._doughSeatCell_mainGo, isShowDoughSeat)
	self:_hideChildGos(self._doughSeatCell_mainGo)

	if isShowDoughSeat then
		GameUtil.SetActive(self._workbenchProgress, false)
	end

	local state = self._doughSeatInfo_state

	if state == DumplingFeastSubEnum.SeatState_Empty then
		-- block empty
	elseif state == DumplingFeastSubEnum.SeatState_Ready then
		GameUtil.SetActive(self._doughSeatCell_tips, true)
		GameUtil.SetActive(self._doughSeatCell_btnStart, true)
		GameUtil.SetActive(self._doughSeatCell_icon, true)
		GameUtil.setUIImageSpriteIdx(self._doughSeatCell_icon, DumplingFeastSubEnum.DoughState_One)
		self._doughSeatCell_icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	elseif state == DumplingFeastSubEnum.SeatState_Making then
		GameUtil.SetActive(self._workbenchProgress, true)
		GameUtil.SetActive(self._doughSeatCell_icon, true)
		GameUtil.setUIImageSpriteIdx(self._doughSeatCell_icon, DumplingFeastSubEnum.DoughState_Two)
		self._doughSeatCell_icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	elseif state == DumplingFeastSubEnum.SeatState_Complete then
		GameUtil.SetActive(self._doughSeatCell_icon, true)
		GameUtil.setUIImageSpriteIdx(self._doughSeatCell_icon, DumplingFeastSubEnum.DoughState_Three)
		self._doughSeatCell_icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end
end

function DumplingFeastKitchenView:_onDoughSeatPressStart()
	if not self._doughSeatPressHelper._isLongPress then
		return
	end

	if not self._dataReady then
		return
	end

	if self._dumplingProcess ~= DumplingFeastSubEnum.DumplingProcess_RollDough then
		FloatWordMgr.instance:show("请先准备面团")

		return
	end

	if self._doughSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Ready then
		FloatWordMgr.instance:show("请先准备面团")

		return
	end

	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Making
	self._doughSeatInfo_startMakeMs = ServerTime.nowMs()
	self._doughMsList = {}

	local scoreDatas = DumplingFeastConfig.instance:getDoughScoreDatas(self._activityId) or {}

	for idx, data in pairs(scoreDatas) do
		table.insert(self._doughMsList, data.seconds * 1000)
	end

	ArraySort.sortOn(self._doughMsList, "", ArraySort.NUMERIC)
	GameUtil.SetActive(self._doughSeatCell_tips, false)
	GameUtil.SetActive(self._workbenchProgress, true)
	self:_playDoughAnimation()
end

function DumplingFeastKitchenView:_onDoughSeatPressEnd(pressTime)
	self:_stopDoughAnimation()

	if self._doughSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	self._doughSeatInfo_state = DumplingFeastSubEnum.SeatState_Complete

	GameUtil.SetActive(self._workbenchProgress, false)

	local startMs = self._doughSeatInfo_startMakeMs
	local nowMs = ServerTime.nowMs()
	local makingSec = Mathf.Floor((nowMs - startMs) / 1000)

	makingSec = Mathf.Clamp(makingSec, 0, self._maxRollDoughSeconds)

	DumplingFeastController.instance:sendPM_DumplingFeastRollDoughReq(self._activityId, makingSec)
end

function DumplingFeastKitchenView:_onDoughSeatPressUpdate(deltaTime, pressTime)
	if self._doughSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	local startMs = self._doughSeatInfo_startMakeMs
	local nowMs = ServerTime.nowMs()
	local makingMs = Mathf.Max(0, nowMs - startMs)
	local maxMs = self._maxRollDoughSeconds * 1000
	local percent = Mathf.Clamp(makingMs / maxMs, 0, 1)
	local localPosX = self._workbenchProgressRangeWidth * percent - self._workbenchProgressRangeWidth / 2

	GameUtil.setAnchoredPos(self._workbenchProgressPoint, localPosX, 0, 0)

	local index = 0

	for idx, doughMs in ipairs(self._doughMsList) do
		if doughMs <= makingMs then
			index = idx - 1
		else
			break
		end
	end

	GameUtil.setUIImageSpriteIdx(self._doughSeatCell_icon, index)
	self._doughSeatCell_icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
end

function DumplingFeastKitchenView:_playDoughAnimation()
	self:_stopDoughAnimation()

	local startPos = GameUtil.getPos(self._stickStart)
	local endPos = GameUtil.getPos(self._stickEnd)
	local durationForward = 2
	local durationBack = 0.7
	local scaleAtEnd = 0.85
	local tweenerToEnd = self._stickGo.transform:DOMove(endPos, durationForward)

	tweenerToEnd:SetEase(DG.Tweening.Ease.OutQuad)

	local tweenerScaleToEnd = self._stickGo.transform:DOScale(Vector3.New(scaleAtEnd, scaleAtEnd, scaleAtEnd), durationForward)

	tweenerScaleToEnd:SetEase(DG.Tweening.Ease.OutQuad)

	local tweenerToStart = self._stickGo.transform:DOMove(startPos, durationBack)

	tweenerToStart:SetEase(DG.Tweening.Ease.InQuad)

	local tweenerScaleToStart = self._stickGo.transform:DOScale(Vector3.New(1, 1, 1), durationBack)

	tweenerScaleToStart:SetEase(DG.Tweening.Ease.InQuad)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(tweenerToEnd):Join(tweenerScaleToEnd)
	sequence:AppendCallback(function()
		GameUtil.setPos(self._stickGo, endPos.x, endPos.y, endPos.z)

		self._stickGo.transform.localScale = Vector3.New(scaleAtEnd, scaleAtEnd, scaleAtEnd)
	end)
	sequence:Append(tweenerToStart):Join(tweenerScaleToStart)
	sequence:SetLoops(-1)

	self._stickDoughSequence = sequence

	sequence:Play()
end

function DumplingFeastKitchenView:_stopDoughAnimation()
	if self._stickDoughSequence then
		self._stickDoughSequence:Kill(true)

		self._stickDoughSequence = nil
	end

	self:_resetDefaultDoughAnimation()
end

function DumplingFeastKitchenView:_resetDefaultDoughAnimation()
	local pos = GameUtil.getPos(self._stickStart)

	GameUtil.setPos(self._stickGo, pos.x, pos.y, pos.z)
	GameUtil.setLocalScale(self._stickGo, 1)
end

function DumplingFeastKitchenView:_onInitStuffingMatUI()
	GameUtil.SetActive(self._dragStuffingMat, false)

	local datas = DumplingFeastConfig.instance:getDumplingDatas(self._activityId) or {}

	self._stuffingMatScrollerList:reloadData(datas)

	self._isSuccessDragStuffingMat = false
end

function DumplingFeastKitchenView:_onUpdateStuffingMatUI()
	self._stuffingMatScrollerList:refresh()
end

function DumplingFeastKitchenView:_updateStuffingMatCell(view, cell, data, tag)
	local dumplingId = data.dumplingId
	local matMo = self._subMo:getStuffFillingMatMo(dumplingId)
	local isEnough = self._subMo:isEnoughStuffFillingNeedItem(dumplingId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local spriteName = GameUrl.getBigbgPngUrl(data.iconPath)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.SetGray(icon, not isEnough)
end

function DumplingFeastKitchenView:_clearStuffingMatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function DumplingFeastKitchenView:_onDragBeginStuffingMatScrCell(eventData, data, go)
	if self._dumplingProcess ~= DumplingFeastSubEnum.DumplingProcess_StuffFilling then
		FloatWordMgr.instance:show("请先擀面")

		return
	end

	local dumplingId = data.dumplingId

	if not self._subMo:isEnoughStuffFillingNeedItem(dumplingId) then
		local matMo = self._subMo:getStuffFillingMatMo(dumplingId)

		FloatWordMgr.instance:show(string.format("%s不足", matMo.matName))

		return
	end

	self._isSuccessDragStuffingMat = true

	GameUtil.SetActive(self._dragStuffingMat, true)

	local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, data.dumplingId)
	local spriteName = data and GameUrl.getBigbgPngUrl(data.stuffingPath)

	uGuiUtil.setSpriteToImage(self._dragStuffingMat, uGuiUtil.SpriteType.BigBg, spriteName, function()
		self._dragStuffingMat:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragStuffingMat, worldPos.x, worldPos.y, worldPos.z)
end

function DumplingFeastKitchenView:_onDragStuffingMatScrCell(eventData, data, go)
	if not self._isSuccessDragStuffingMat then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragStuffingMat, worldPos.x, worldPos.y, worldPos.z)
end

function DumplingFeastKitchenView:_onDragEndStuffingMatScrCell(eventData, data, go)
	if not self._isSuccessDragStuffingMat then
		return
	end

	self._isSuccessDragStuffingMat = false

	GameUtil.SetActive(self._dragStuffingMat, false)
	MaterialMgr.clearIcon(self._dragStuffingMat)

	local isInRect = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._stuffingSeatPutStuffingArea.transform, eventData.position, GlobalModel.instance.uiCamera)

	if isInRect then
		FloatWordMgr.instance:show("添加馅料成功")

		self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Ready
		self._stuffingSeatInfo_fillingId = data.dumplingId

		self:_onUpdateStuffingSeatUI()
	end
end

function DumplingFeastKitchenView:_onInitStuffingSeatUI()
	self._stuffingSeatPressHelper = self._stuffingSeatPressHelper or BtnLongPressHelper.create(self._stuffingSeatBtnStart)

	self._stuffingSeatPressHelper:addPressStartHandler(GameUtil.handler(self._onStuffingSeatPressStart, self))
	self._stuffingSeatPressHelper:addPressEndHandler(GameUtil.handler(self._onStuffingSeatPressEnd, self))
	self._stuffingSeatPressHelper:addPressUpdateHandler(GameUtil.handler(self._onStuffingSeatPressUpdate, self))

	local triggerGo = self._stuffingSeatDragPlane

	self._stuffingBeginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragBeginDumplingFromStuffing(eventData)
	end)
	self._stuffingDragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragDumplingFromStuffing(eventData)
	end)
	self._stuffingEndDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragEndDumplingFromStuffing(eventData)
	end)

	GameUtil.SetActive(self._dragStuffingDumpling, false)
end

function DumplingFeastKitchenView:_onUpdateStuffingSeatUI()
	local isShowStuffingSeat = self._dumplingProcess == DumplingFeastSubEnum.DumplingProcess_StuffFilling

	GameUtil.SetActive(self._stuffingSeatMainGo, isShowStuffingSeat)
	uGuiUtil.clearImage(self._stuffingSeatIconStuffing)
	uGuiUtil.clearImage(self._stuffingSeatIconDumpling)
	self:_hideChildGos(self._stuffingSeatMainGo)

	if isShowStuffingSeat then
		GameUtil.SetActive(self._workbenchProgress, false)
	end

	local state = self._stuffingSeatInfo_state

	if state == DumplingFeastSubEnum.SeatState_Empty then
		-- block empty
	elseif state == DumplingFeastSubEnum.SeatState_Ready then
		GameUtil.SetActive(self._stuffingSeatIconDough, true)

		local fillingId = self._stuffingSeatInfo_fillingId

		if fillingId > 0 then
			GameUtil.SetActive(self._stuffingSeatIconStuffing, true)
			GameUtil.SetActive(self._stuffingSeatMakeTips, true)
			GameUtil.SetActive(self._stuffingSeatBtnStart, true)

			local fillingId = self._stuffingSeatInfo_fillingId
			local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, fillingId)
			local spriteName = data and GameUrl.getBigbgPngUrl(data.stuffingPath)

			uGuiUtil.setSpriteToImage(self._stuffingSeatIconStuffing, uGuiUtil.SpriteType.BigBg, spriteName, function()
				self._stuffingSeatIconStuffing:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		else
			GameUtil.SetActive(self._stuffingSeatIconStuffing, false)
			GameUtil.SetActive(self._stuffingSeatReadyTips, true)
		end
	elseif state == DumplingFeastSubEnum.SeatState_Making then
		GameUtil.SetActive(self._stuffingSeatIconDough, true)
		GameUtil.SetActive(self._stuffingSeatIconStuffing, true)
		GameUtil.SetActive(self._stuffingSeatMakeTips, true)
		GameUtil.SetActive(self._workbenchProgress, true)

		local fillingId = self._stuffingSeatInfo_fillingId
		local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, fillingId)
		local spriteName = data and GameUrl.getBigbgPngUrl(data.stuffingPath)

		uGuiUtil.setSpriteToImage(self._stuffingSeatIconStuffing, uGuiUtil.SpriteType.BigBg, spriteName, function()
			self._stuffingSeatIconStuffing:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
		GameUtil.SetActive(self._stuffingSeatIconDumpling, true)

		local spriteName = GameUrl.getBigbgPngUrl(data.iconPath)

		uGuiUtil.setSpriteToImage(self._stuffingSeatIconDumpling, uGuiUtil.SpriteType.BigBg, spriteName, function()
			self._stuffingSeatIconDumpling:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	elseif state == DumplingFeastSubEnum.SeatState_Complete then
		GameUtil.SetActive(self._stuffingSeatIconStuffing, true)
		GameUtil.SetActive(self._stuffingSeatCompleteTips, true)
		GameUtil.SetActive(self._stuffingSeatDragPlane, true)
		GameUtil.SetActive(self._stuffingSeatIconDumpling, true)

		local fillingId = self._stuffingSeatInfo_fillingId
		local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, fillingId)
		local spriteName = data and GameUrl.getBigbgPngUrl(data.iconPath)

		uGuiUtil.setSpriteToImage(self._stuffingSeatIconStuffing, uGuiUtil.SpriteType.BigBg, spriteName)
		uGuiUtil.setSpriteToImage(self._stuffingSeatIconDumpling, uGuiUtil.SpriteType.BigBg, spriteName)
	end
end

function DumplingFeastKitchenView:_onClearStuffingSeatUI()
	uGuiUtil.clearImage(self._stuffingSeatIconStuffing)
	uGuiUtil.clearImage(self._stuffingSeatIconDumpling)

	if self._stuffingSeatPressHelper then
		self._stuffingSeatPressHelper:dispose()

		self._stuffingSeatPressHelper = nil
	end

	local triggerGo = self._stuffingSeatDragPlane

	if self._stuffingBeginDragHandler then
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._stuffingBeginDragHandler)
	end

	if self._stuffingEndDragHandler then
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._stuffingEndDragHandler)
	end

	if self._stuffingDragHandler then
		DragHandler.Get(triggerGo):RemoveLuaHandler(self._stuffingDragHandler)
	end
end

function DumplingFeastKitchenView:_onStuffingSeatPressStart()
	if not self._stuffingSeatPressHelper._isLongPress then
		return
	end

	if not self._dataReady then
		return
	end

	if self._dumplingProcess ~= DumplingFeastSubEnum.DumplingProcess_StuffFilling then
		FloatWordMgr.instance:show("请先准备面团")

		return
	end

	if self._stuffingSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Ready then
		FloatWordMgr.instance:show("不可制作")

		return
	end

	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Making
	self._stuffingSeatInfo_startMakeMs = ServerTime.nowMs()

	local fillingId = self._stuffingSeatInfo_fillingId
	local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, fillingId)

	GameUtil.SetActive(self._stuffingSeatIconDumpling, true)

	local spriteName = data and GameUrl.getBigbgPngUrl(data.iconPath)

	uGuiUtil.setSpriteToImage(self._stuffingSeatIconDumpling, uGuiUtil.SpriteType.BigBg, spriteName, function()
		self._stuffingSeatIconDumpling:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	GameUtil.SetActive(self._stuffingSeatReadyTips, false)
	GameUtil.SetActive(self._stuffingSeatMakeTips, false)
	GameUtil.SetActive(self._workbenchProgress, true)
	self:_playTransparentAnim(self._stuffingSeatIconDough, 1, 0, self._maxStuffFillingSeconds, nil)
	self:_playTransparentAnim(self._stuffingSeatIconStuffing, 1, 0, self._maxStuffFillingSeconds, nil)
	self:_playTransparentAnim(self._stuffingSeatIconDumpling, 0, 1, self._maxStuffFillingSeconds, nil)
end

function DumplingFeastKitchenView:_onStuffingSeatPressEnd(pressTime)
	if self._stuffingSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	self._stuffingSeatInfo_state = DumplingFeastSubEnum.SeatState_Complete

	self:_stopAllTransparentAnim()
	GameUtil.SetActive(self._stuffingSeatIconDough, false)
	GameUtil.SetActive(self._stuffingSeatIconDumpling, true)
	GameUtil.SetActive(self._workbenchProgress, false)

	local fillingId = self._stuffingSeatInfo_fillingId
	local startMs = self._stuffingSeatInfo_startMakeMs
	local nowMs = ServerTime.nowMs()
	local makingSec = Mathf.Floor((nowMs - startMs) / 1000)

	makingSec = Mathf.Clamp(makingSec, 0, self._maxStuffFillingSeconds)

	DumplingFeastController.instance:sendPM_DumplingFeastStuffFillingReq(self._activityId, fillingId, makingSec)
end

function DumplingFeastKitchenView:_onStuffingSeatPressUpdate(deltaTime, pressTime)
	if self._stuffingSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	local startMs = self._stuffingSeatInfo_startMakeMs
	local nowMs = ServerTime.nowMs()
	local makingMs = Mathf.Max(0, nowMs - startMs)
	local maxMs = self._maxStuffFillingSeconds * 1000
	local percent = Mathf.Clamp(makingMs / maxMs, 0, 1)
	local localPosX = self._workbenchProgressRangeWidth * percent - self._workbenchProgressRangeWidth / 2

	GameUtil.setAnchoredPos(self._workbenchProgressPoint, localPosX, 0, 0)
end

function DumplingFeastKitchenView:_onDragBeginDumplingFromStuffing(eventData)
	if self._stuffingSeatInfo_state ~= DumplingFeastSubEnum.SeatState_Complete then
		return
	end

	local emptyPotList = self._subMo:getEmptyPotList()

	if #emptyPotList <= 0 then
		FloatWordMgr.instance:show("没有空锅")

		return
	end

	local emptyBowlList = self._subMo:getEmptyBowlList()

	if #emptyBowlList <= 0 then
		FloatWordMgr.instance:show("没有空碗")

		return
	end

	self._isDraggingDumpling = true

	local fillingId = self._stuffingSeatInfo_fillingId
	local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, fillingId)
	local spriteName = data and GameUrl.getBigbgPngUrl(data.iconPath)

	uGuiUtil.setSpriteToImage(self._dragStuffingDumpling, uGuiUtil.SpriteType.BigBg, spriteName, function()
		self._dragStuffingDumpling:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	GameUtil.SetActive(self._dragStuffingDumpling, true)
	GameUtil.SetActive(self._stuffingSeatCompleteTips, false)
	GameUtil.SetActive(self._stuffingSeatIconDumpling, false)

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragStuffingDumpling, worldPos.x, worldPos.y, worldPos.z)
end

function DumplingFeastKitchenView:_onDragDumplingFromStuffing(eventData)
	if not self._isDraggingDumpling then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragStuffingDumpling, worldPos.x, worldPos.y, worldPos.z)
end

function DumplingFeastKitchenView:_onDragEndDumplingFromStuffing(eventData)
	if not self._isDraggingDumpling then
		return
	end

	self._isDraggingDumpling = false

	GameUtil.SetActive(self._dragStuffingDumpling, false)
	uGuiUtil.clearImage(self._dragStuffingDumpling)

	local targetPotId = 0

	for potId, cell in ipairs(self._potCells) do
		if self:_isDragToPotArea(eventData, potId) then
			targetPotId = potId

			break
		end
	end

	local isSuccess = false
	local floatTips

	if targetPotId > 0 then
		if self._subMo:isEmptyPot(targetPotId) then
			isSuccess = true
		else
			isSuccess = false
			floatTips = "锅已满"
		end
	end

	FloatWordMgr.instance:show(floatTips)

	if isSuccess then
		local dumplingId = self._stuffingSeatInfo_fillingId

		DumplingFeastController.instance:sendPM_DumplingFeastBoilDumplingReq(self._activityId, targetPotId, dumplingId)
	else
		GameUtil.SetActive(self._stuffingSeatIconDumpling, true)
		GameUtil.SetActive(self._stuffingSeatCompleteTips, true)
	end
end

function DumplingFeastKitchenView:_isDragToPotArea(eventData, potId)
	if not eventData then
		return false
	end

	local cell = self._potCells[potId]
	local triggerGo = cell._mainGo

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(triggerGo.transform, eventData.position, GlobalModel.instance.uiCamera)
end

function DumplingFeastKitchenView:_playTransparentAnim(go, from, to, duration, easeType)
	self:_stopTransparentAnim(go)

	if self._transparentAnimGoPool == nil then
		self._transparentAnimGoPool = {}
	end

	self._transparentAnimGoPool[go] = true
	easeType = easeType or UnityTweens.EaseType.linear

	UnityTweens.UITweenFade.StartTween(go, from, to, duration, easeType)
end

function DumplingFeastKitchenView:_stopTransparentAnim(go)
	UnityTweens.UITweenFade.StopTween(go)

	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	if canvasGroup then
		canvasGroup.alpha = 1
	else
		local graphic = go:GetComponent(typeof(UnityEngine.UI.Graphic))

		if graphic then
			graphic.color = Color.New(1, 1, 1, 1)
		else
			local renderer = go:GetComponent(ComponentType.Renderer)

			if renderer then
				renderer.material.color = Color.New(1, 1, 1, 1)
			end
		end
	end
end

function DumplingFeastKitchenView:_stopAllTransparentAnim()
	if self._transparentAnimGoPool == nil then
		return
	end

	for go, _ in pairs(self._transparentAnimGoPool) do
		self:_stopTransparentAnim(go)
	end

	self._transparentAnimGoPool = {}
end

function DumplingFeastKitchenView:_onInitPotUI()
	for potId, cell in ipairs(self._potCells) do
		GameUtil.addClickHandler(cell._btnComplete, GameUtil.handler(self._onClickPotCellBtnComplete, self, potId))
	end
end

function DumplingFeastKitchenView:_onClearPotUI()
	for idx, cell in ipairs(self._potCells) do
		GameUtil.rmClickHandler(cell._btnComplete)
	end
end

function DumplingFeastKitchenView:_onUpdatePotUI()
	for potId, cell in ipairs(self._potCells) do
		self:_onUpdatePotCellUI(potId)
	end
end

function DumplingFeastKitchenView:_onUpdatePotCellUI(potId)
	local cell = self._potCells[potId]
	local state = self._potInfos[potId].state

	self:_hideChildGos(cell._mainGo)

	if state == DumplingFeastSubEnum.SeatState_Empty then
		GameUtil.SetActive(cell._iconEmpty, true)
	elseif state == DumplingFeastSubEnum.SeatState_Ready then
		GameUtil.SetActive(cell._iconRuning, true)
	elseif state == DumplingFeastSubEnum.SeatState_Making or state == DumplingFeastSubEnum.SeatState_Complete then
		GameUtil.SetActive(cell._iconRuning, true)
		GameUtil.SetActive(cell._progress, true)
	end
end

function DumplingFeastKitchenView:_onPotCellTickingUpdate(potId)
	local cell = self._potCells[potId]
	local info = self._potInfos[potId]

	if info.state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	local startMs = info.startMakeMs
	local nowMs = ServerTime.nowMs()
	local makingMs = Mathf.Max(0, nowMs - startMs)
	local maxMs = self._maxBoilSeconds * 1000
	local percent = Mathf.Clamp(makingMs / maxMs, 0, 1)
	local localPosX = cell._rangeWidth * percent - cell._rangeWidth / 2

	GameUtil.setAnchoredPos(cell._point, localPosX, 0, 0)
end

function DumplingFeastKitchenView:_onClickPotCellBtnComplete(potId)
	local state = self._potInfos[potId].state

	if state ~= DumplingFeastSubEnum.SeatState_Making then
		return
	end

	local emptyBowlList = self._subMo:getEmptyBowlList()

	if #emptyBowlList <= 0 then
		FloatWordMgr.instance:show("没有空碗")

		return
	end

	DumplingFeastController.instance:sendPM_DumplingFeastTakeOutDumplingReq(self._activityId, potId)
end

function DumplingFeastKitchenView:_onInitBowlUI()
	for bowlId, cell in ipairs(self._bowlCells) do
		uGuiUtil.clearImage(cell._icon)
		self:stopViewEffectUniGo(cell._effRoot)
		GameUtil.addClickHandler(cell._btnGain, GameUtil.handler(self._onClickBowlCellBtnGain, self, bowlId))
		GameUtil.addClickHandler(cell._btnOneKey, GameUtil.handler(self._onClickBowlCellBtnOneKey, self, bowlId))
	end
end

function DumplingFeastKitchenView:_onClearBowlUI()
	for idx, cell in ipairs(self._bowlCells) do
		uGuiUtil.clearImage(cell._icon)
		self:stopViewEffectUniGo(cell._effRoot)
		GameUtil.rmClickHandler(cell._btnGain)
		GameUtil.rmClickHandler(cell._btnOneKey)
	end
end

function DumplingFeastKitchenView:_onUpdateBowlUI()
	for bowlId, cell in ipairs(self._bowlCells) do
		self:_onUpdateBowlCellUI(bowlId)
	end
end

function DumplingFeastKitchenView:_onUpdateBowlCellUI(bowlId)
	local cell = self._bowlCells[bowlId]
	local state = self._bowlInfos[bowlId].state

	self:_hideChildGos(cell._mainGo)
	self:stopViewEffectUniGo(cell._effRoot)

	if state == DumplingFeastSubEnum.SeatState_Empty then
		local isCanOpenOneClickMake = self._subMo:isCanOpenOneClickMake()

		GameUtil.SetActive(cell._btnOneKey, isCanOpenOneClickMake)
	elseif state == DumplingFeastSubEnum.SeatState_Complete then
		GameUtil.SetActive(cell._imgQuality, true)
		GameUtil.SetActive(cell._icon, true)
		GameUtil.SetActive(cell._effRoot, true)
		GameUtil.SetActive(cell._btnGain, true)

		local quality = self._subMo:getBowlDumplingQuality(bowlId)

		GameUtil.setUIImageSpriteIdx(cell._imgQuality, quality - 1)

		local dumplingId = self._subMo:getBowlDumplingId(bowlId)
		local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, dumplingId)
		local spriteName = data and GameUrl.getBigbgPngUrl(data.iconPath)

		uGuiUtil.setSpriteToImage(cell._icon, uGuiUtil.SpriteType.BigBg, spriteName)
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell._effRoot, nil, true, nil, nil)
	end
end

function DumplingFeastKitchenView:_onClickBowlCellBtnGain(bowlId)
	local state = self._bowlInfos[bowlId].state

	if state ~= DumplingFeastSubEnum.SeatState_Complete then
		return
	end

	DumplingFeastController.instance:sendPM_DumplingFeastGainDumplingReq(self._activityId, bowlId)
end

function DumplingFeastKitchenView:_onClickBowlCellBtnOneKey(bowlId)
	local state = self._bowlInfos[bowlId].state

	if state ~= DumplingFeastSubEnum.SeatState_Empty then
		return
	end

	local isCanOpenOneClickMake = self._subMo:isCanOpenOneClickMake()

	if not isCanOpenOneClickMake then
		FloatWordMgr.instance:show("需要达到最优品质汤圆次数才能一键制作")

		return
	end

	UIStateManager.instance:push(ViewName.DumplingFeastOneKeyMakeView, self._activityId, bowlId)
end

function DumplingFeastKitchenView:_onClickBtnTip()
	local data = DumplingFeastConfig.instance:getActivityData(self._activityId)
	local key = data and data.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DumplingFeastKitchenView:_hideChildGos(go)
	for idx = 1, go.transform.childCount do
		local childGo = go.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(childGo, false)
	end
end

return DumplingFeastKitchenView
