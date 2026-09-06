-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpReadyView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpReadyView", package.seeall)

local MagicSchoolPvpReadyView = class("MagicSchoolPvpReadyView", ViewComponent)
local BUBBLE_DELTA = 0.1

function MagicSchoolPvpReadyView:ctor()
	MagicSchoolPvpReadyView.super.ctor(self)

	self._chatLists = {}
end

function MagicSchoolPvpReadyView:buildUI()
	MagicSchoolPvpReadyView.super.buildUI(self)

	self._con = self:getGo("con")
	self._effScoreWrite = self:getGo("effScoreWrite")
	self._effScoreBlack = self:getGo("effScoreBlack")
	self._effBlackTeamRoot = self:getGo("effBlackTeamRoot")
	self._effWriteTeamRoot = self:getGo("effWriteTeamRoot")
	self._txtPrizeInfo = self:getTxt("infoCol/txtPrize")
	self._txtDescInfo = self:getTxt("infoCol/txtDesc")
	self._txtDescRule = self:getTxt("ruleCol/txtDesc")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtScoreBlack = self:getTxt("scoreBlack/txt")
	self._txtScoreWrite = self:getTxt("scoreWrite/txt")
	self._leftTimeGo = self:getGo("leftTime")
	self._txtLeftTime = self:getTxt("leftTime/txt")
	self._btnFmt = self:getGo("btnFmt")
	self._btnBuff = self:getGo("btnBuff")
	self._btnClose = self:getBtn("btnClose")
	self._playerCells = {}

	local teamLeft = self:getGo("teamCol/left")
	local teamRight = self:getGo("teamCol/right")

	for campId, teamGo in ipairs({
		teamLeft,
		teamRight
	}) do
		self._playerCells[campId] = {}

		for idx = 1, 3 do
			self._playerCells[campId][idx] = {}

			local cell = self._playerCells[campId][idx]
			local mainGo = goutil.findChild(teamGo, "cell" .. idx)

			cell._mainGo = mainGo
			cell._headCon = goutil.findChild(mainGo, "headCon")
			cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
			cell._txtTagIndex = goutil.findChildTextComponent(mainGo, "tagIndex/txt")
			cell._txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
			cell._switchGo = goutil.findChild(mainGo, "switchGo")
			cell._btnChange = goutil.findChild(mainGo, "switchGo/btnChange")
			cell._switchTimes = goutil.findChild(mainGo, "switchGo/switchTimes")
			cell._txtSwitchTimes = goutil.findChildTextComponent(mainGo, "switchGo/switchTimes/txt")
			cell._bubble = goutil.findChild(mainGo, "bubble")
			cell._txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
			cell._tipsRoot = goutil.findChild(mainGo, "tipsRoot")
			cell._tagMe = goutil.findChild(mainGo, "tagMe")
		end
	end

	self._buffCells = {}

	for campId, teamGo in ipairs({
		teamLeft,
		teamRight
	}) do
		self._buffCells[campId] = {}

		local buffView = goutil.findChild(teamGo, "buffView")

		for idx = 1, buffView.transform.childCount do
			self._buffCells[campId][idx] = {}

			local cell = self._buffCells[campId][idx]
			local mainGo = buffView.transform:GetChild(idx - 1).gameObject

			cell._mainGo = mainGo
			cell._mask = goutil.findChild(mainGo, "mask")
			cell._icon = goutil.findChild(mainGo, "mask/icon")
			cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
		end
	end

	self._reqSwitchCell = {}

	if self._reqSwitchCell then
		local mainGo = self:getGo("switchTips/reqSwitchCell")

		self._reqSwitchCell._mainGo = mainGo
		self._reqSwitchCell._txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
		self._reqSwitchCell._btnSure = goutil.findChild(mainGo, "btnSure")
		self._reqSwitchCell._btnCancel = goutil.findChild(mainGo, "btnCancel")
		self._reqSwitchCell._slider = goutil.findChild(mainGo, "slider"):GetComponent(ComponentType.Slider)
	end

	self._statusSwitchCell = {}

	if self._statusSwitchCell then
		local mainGo = self:getGo("switchTips/statusSwitchCell")

		self._statusSwitchCell._mainGo = mainGo
		self._statusSwitchCell._txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
		self._statusSwitchCell._slider = goutil.findChild(mainGo, "slider"):GetComponent(ComponentType.Slider)
	end

	GameUtil.SetActive(self._reqSwitchCell._mainGo, false)
	GameUtil.SetActive(self._statusSwitchCell._mainGo, false)

	local blackChatCol = self:getGo("blackChatCol")
	local writeChatCol = self:getGo("writeChatCol")
	local chatColList = {
		blackChatCol,
		writeChatCol
	}

	self._chatColCellList = {}

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		local mainGo = chatColList[campId]

		self._chatColCellList[campId] = {}

		local cell = self._chatColCellList[campId]

		cell._mainGo = mainGo
		cell._btnChat = goutil.findChild(mainGo, "btnChat")
		cell._chatPlane = goutil.findChild(mainGo, "chatPlane")
		cell._chatScrCell = goutil.findChild(mainGo, "chatPlane/scrCell")
		cell._chatScrView = goutil.findChild(mainGo, "chatPlane/scrView")
		cell._chatScrollerList = ScrollerList.create(cell._chatScrView, cell._chatScrCell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
		cell._chatViewUiCustonInput = UICustomInput.Get(cell._chatScrView)
	end
end

function MagicSchoolPvpReadyView:bindEvents()
	MagicSchoolPvpReadyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)

	for _, cell in pairs(self._chatColCellList) do
		GameUtil.addClickHandler(cell._btnChat, function()
			self:_onClickBtnChat(false)
		end, self)
		cell._chatViewUiCustonInput:AddListener(self._onClickBtnChat, self)
	end
end

function MagicSchoolPvpReadyView:unbindEvents()
	MagicSchoolPvpReadyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnBuff)

	for _, cell in pairs(self._chatColCellList) do
		GameUtil.rmClickHandler(cell._btnChat)
		cell._chatViewUiCustonInput:RemoveListener()
	end
end

function MagicSchoolPvpReadyView:onEnter()
	MagicSchoolPvpReadyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._curPeriodType = self._subMo:getCurPeriodType()
	self._myUserId = tostring(RoleModel.instance:getUserId())
	self._myCampId = self._subMo:getCampId()
	self._readyLeftTime = 0

	if self._myCampId <= 0 then
		printError(string.format("MagicSchoolPvpReadyView:onEnter 缺失campId ( activityId:%s, campId:%s )", self._activityId, self._myCampId))
		self:close()

		return
	end

	if not self._subMo:isGameing() then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPGameStartRes, self._handlePM_NotifyMSPvPGameStartRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPAskSwitchPositionRes, self._handlePM_NotifyMSPvPAskSwitchPositionRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMSPvPAskSwitchPositionResultRes, self._handlePM_NotifyMSPvPAskSwitchPositionResultRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPGameEndRes, self._handlePM_NotifyMsPvPGameEndRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPChatRes, self._handlePM_NotifyMsPvPChatRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyMsPvPFinishSelectBuffRes, self._handlePM_NotifyMsPvPFinishSelectBuffRes, self)
	self:_setPlaneUI()
	self:_changePeriodType(self._curPeriodType)
	self:_onUpdateChatColUI()

	for k, v in pairs(self._chatColCellList) do
		GameUtil.SetActive(v._mainGo, false)
		GameUtil.SetActive(v._chatPlane, false)
	end

	GameUtil.SetActive(self._chatColCellList[self._myCampId]._mainGo, true)
	settimer(0.1, self._onTicking, self)
	self:_onTicking()
	self:_startSwitchSpine()
end

function MagicSchoolPvpReadyView:onExit()
	MagicSchoolPvpReadyView.super.onExit(self)
	self:_clearSwitchSpine()
	table.clear(self._chatLists)
	removetimer(self._onTicking, self)
	self:_stopBubbleTimer()
	self:_onClearTeamCol()
	self:_onClearSwitchTipsCol()
	self:_onClearBuffCol()
	self:_onClearChatColUI()
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMSPvPGameStartRes()
	self:_changePeriodType(MagicSchoolPvPEnum.PeriodType_Ready)
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMSPvPAskSwitchPositionRes(msg)
	local ask = msg.ask

	self._askInfo = {
		ask = ask,
		startTime = ServerTime.now(),
		leftTime = self._subMo:getSwitchReqWaitTime()
	}

	self:_onUpdateSwitchTipsCol()
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMSPvPAskSwitchPositionResultRes(msg)
	local ask = msg.ask
	local result = msg.result

	self._askInfo = nil

	if result == -1 then
		FloatWordMgr.instance:show("申请换位失败")
	elseif result == 0 then
		FloatWordMgr.instance:show("申请换位过时")
	elseif result == 1 then
		if ask.userId == self._myUserId then
			FloatWordMgr.instance:show("交换成功！")
		elseif ask.targetUserId == self._myUserId then
			FloatWordMgr.instance:show("已同意交换")
		end

		self:_onUpdateTeamColData()
		self:_onUpdateTeamColUI()
	end

	self:_onUpdateSwitchTipsCol()
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMsPvPGameEndRes(msg)
	return
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMsPvPChatRes(msg)
	local userId = msg.sendUserId
	local info = {
		isShowing = false,
		leftTime = 2.5,
		userId = userId,
		chatId = msg.chatId
	}

	self._chatLists[userId] = self._chatLists[userId] or {}

	table.insert(self._chatLists[userId], info)
	self:_startBubbleTimer()
end

function MagicSchoolPvpReadyView:_handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	self:_onUpdateBuffColUI()
end

function MagicSchoolPvpReadyView:_onTicking()
	self._serverTime = ServerTime.now()
	self._serverTimeMs = ServerTime.nowMs()

	if self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Match then
		-- block empty
	elseif self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Ready then
		if self._askInfo and self._switchSlider then
			self._switchSlider.value = 1 - (self._serverTimeMs - self._askInfo.startTime * 1000) / 1000 / self._askInfo.leftTime
		end

		local endTime = self._subMo:getPeriodTimeStamp(MagicSchoolPvPEnum.PeriodType_Boss)

		self._readyLeftTime = Mathf.Max(0, endTime - self._serverTime)
		self._txtLeftTime.text = string.format("准备倒计时：%d秒", self._readyLeftTime)
	elseif self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Boss then
		local nextBossId = self._subMo:getCurBossId() + 1

		self._nextRoundTimeStamp = self._subMo:getBossRoundTimeStamp(nextBossId, MagicSchoolPvPEnum.RoundType_Battle)

		if self._nextRoundTimeStamp <= 0 then
			self._txtLeftTime.text = "等待其他队友战斗结束"
		else
			self._leftTime = math.ceil(Mathf.Max(0, self._nextRoundTimeStamp - self._serverTime))
			self._txtLeftTime.text = string.format("剩余选择时间：%s秒", self._leftTime)
		end
	elseif self._curPeriodType == MagicSchoolPvPEnum.PeriodType_End then
		-- block empty
	end
end

function MagicSchoolPvpReadyView:_setPlaneUI()
	local targetDesc = ""
	local bossDesc = ""
	local datas = MagicSchoolPvpConfig.instance:getBossDatas(self._activityId) or {}

	for idx, data in ipairs(datas) do
		local extMsg = self._subMo:getBossExtMsg(data.bossId)
		local tDesc = string.find(data.targetDesc, "%%s") and string.format(data.targetDesc, extMsg and extMsg.param) or data.targetDesc

		targetDesc = idx == #datas and string.format("%s%s.%s", targetDesc, idx, tDesc) or string.format("%s%s.%s\n", targetDesc, idx, tDesc)
		bossDesc = idx == #datas and string.format("%s%s.%s", bossDesc, idx, data.bossDesc) or string.format("%s%s.%s\n", bossDesc, idx, data.bossDesc)
	end

	self._txtDescInfo.text = targetDesc
	self._txtDescRule.text = bossDesc

	if self._myCampId == MagicSchoolPvPEnum.CampId_Black then
		self:playViewEffectUniGo("20250926/heibaiduijue/fx_ui_hbdj_kuang01_zuo.prefab", self._effBlackTeamRoot, nil, true, nil, nil)
		self:playViewEffectUniGo("20250926/heibaiduijue/fx_ui_hbdj_kuang02.prefab", self._effScoreBlack, nil, true, nil, nil)
	else
		self:playViewEffectUniGo("20250926/heibaiduijue/fx_ui_hbdj_kuang01_you.prefab", self._effWriteTeamRoot, nil, true, nil, nil)
		self:playViewEffectUniGo("20250926/heibaiduijue/fx_ui_hbdj_kuang02.prefab", self._effScoreWrite, nil, true, nil, nil)
	end
end

function MagicSchoolPvpReadyView:_changePeriodType(periodType)
	self._curPeriodType = periodType

	self:_onUpdate()
end

function MagicSchoolPvpReadyView:_onUpdate()
	self._curPeriodType = self._subMo:getCurPeriodType()

	self:_onUpdateTeamColData()
	self:_onUpdateTeamColUI()
	self:_onUpdateSwitchTipsCol()
	self:_onUpdateBuffColUI()

	local curBossId = self._subMo:getCurBossId()
	local totalDamages = {}

	for bossId = 1, curBossId do
		for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
			totalDamages[campId] = (totalDamages[campId] or 0) + self._subMo:getDamageInRounds(bossId, campId)
		end
	end

	local curDamages = {}

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		curDamages[campId] = self._subMo:getDamageInRounds(curBossId, campId)
	end

	local totalA = totalDamages[MagicSchoolPvPEnum.CampId_Black]
	local totalB = totalDamages[MagicSchoolPvPEnum.CampId_White]
	local curA = curDamages[MagicSchoolPvPEnum.CampId_Black]
	local curB = curDamages[MagicSchoolPvPEnum.CampId_White]

	self._txtScoreBlack.text = string.format("黑魔法阵营：造成伤害%s<color=#20b376>+%s</color>", MmUtil.formatNumber(totalA, MmUtil.Units_OnlyW, 0), MmUtil.formatNumber(curA, MmUtil.Units_OnlyW, 0))
	self._txtScoreWrite.text = string.format("白魔法阵营：造成伤害%s<color=#20b376>+%s</color>", MmUtil.formatNumber(totalB, MmUtil.Units_OnlyW, 0), MmUtil.formatNumber(curB, MmUtil.Units_OnlyW, 0))

	GameUtil.SetActive(self._leftTimeGo, self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Ready or self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Boss)
	GameUtil.SetActive(self._btnFmt, self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Ready)
	GameUtil.SetActive(self._btnBuff, self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Boss)
end

function MagicSchoolPvpReadyView:_getPlayerCell(campId, bossId)
	return self._playerCells[campId] and self._playerCells[campId][bossId]
end

function MagicSchoolPvpReadyView:_onUpdateTeamColData()
	self._playerInfos = {}

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		local bossCount = self._subMo:getBossCount()

		for bossId = 1, bossCount do
			local player = self._subMo:getTeamPlayer(campId, bossId)

			self._playerInfos[player.userId] = {
				campId = campId,
				bossId = bossId,
				player = player
			}
		end
	end
end

function MagicSchoolPvpReadyView:_onUpdateTeamColUI()
	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		for bossId, cell in ipairs(self._playerCells[campId]) do
			self:_updatePlayerCell(campId, bossId)
		end
	end
end

function MagicSchoolPvpReadyView:_onClearTeamCol()
	for campId, cellList in pairs(self._playerCells) do
		for bossId, cell in pairs(cellList) do
			self:_clearPlayerCell(cell)
		end
	end
end

function MagicSchoolPvpReadyView:_updatePlayerCell(campId, bossId)
	local cell = self:_getPlayerCell(campId, bossId)
	local player = self._subMo:getTeamPlayer(campId, bossId)
	local headInfo = player.headInfo
	local userId = player.userId
	local maxZdl = player.maxZdl
	local switchTimes = self._subMo:getSwitchTimes(self._myUserId)
	local maxSwitchTimes = MagicSchoolPvPEnum.MaxSwitchPosTimes
	local leftSwitchTimes = maxSwitchTimes - switchTimes
	local isSwitching = self._askInfo ~= nil
	local isCanSwitchWitTimes = self._subMo:isCanSwitchWitTimes()

	HeadItemController.instance:setHeadCellByInfo(cell._headCon, headInfo, false)

	cell._txtName.text = headInfo.userName
	cell._txtZdl.text = MmUtil.formatNumber(maxZdl, MmUtil.Units_OnlyW, 0)
	cell._txtSwitchTimes.text = string.format("%s/%s", leftSwitchTimes, maxSwitchTimes)

	GameUtil.SetActive(cell._tagMe, userId == self._myUserId)
	GameUtil.SetGray(cell._btnChange, isSwitching or not isCanSwitchWitTimes)
	GameUtil.SetActive(cell._switchGo, campId == self._myCampId and userId ~= self._myUserId and self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Ready)

	if self._chatLists[userId] then
		if self._chatLists[userId] then
			self:_showChatBubble(userId, self._chatLists[userId].chatId)
		else
			self:_hideChatBubble(userId)
		end

		GameUtil.addClickHandler(cell._btnChange, function()
			if self._curPeriodType ~= MagicSchoolPvPEnum.PeriodType_Ready then
				FloatWordMgr.instance:show("准备阶段已结束")

				return
			end

			if self._askInfo ~= nil then
				local reqUserId = self._askInfo.ask.userId
				local targetUserId = self._askInfo.ask.targetUserId
				local infoA = self._playerInfos[reqUserId]
				local infoB = self._playerInfos[targetUserId]
				local nameA = infoA.player.headInfo.userName
				local nameB = infoB.player.headInfo.userName

				if reqUserId == self._myUserId then
					FloatWordMgr.instance:show(string.format("等待%s同意交换...", nameB))
				elseif targetUserId == self._myUserId then
					FloatWordMgr.instance:show(string.format("%s请求与你交换位置", nameA))
				else
					FloatWordMgr.instance:show(string.format("%s正与%s交换位置", nameA, nameB))
				end

				return
			end

			if not self._subMo:isCanSwitchWitTimes() then
				FloatWordMgr.instance:show("可交换位置次数不足")

				return
			end

			local myPlayerInfo = self._playerInfos[self._myUserId]
			local targetUserId = userId
			local originBossId = myPlayerInfo.bossId
			local askBossId = bossId

			MagicSchoolPvPController.instance:sendPM_MSPvPAskSwitchReq(self._activityId, targetUserId, originBossId, askBossId)
		end)
	end
end

function MagicSchoolPvpReadyView:_clearPlayerCell(cell)
	GameUtil.rmClickHandler(cell._btnChange)
	GameUtil.SetGray(cell._btnChange, false)
end

function MagicSchoolPvpReadyView:_bubbleTicking()
	local trash

	self._bubbleTaskCount = 0

	for userId, infoList in pairs(self._chatLists) do
		local info = infoList[1]

		if info then
			self._bubbleTaskCount = self._bubbleTaskCount + 1

			if info.leftTime <= 0 then
				trash = trash or {}
				trash[userId] = trash[userId] or {}

				table.insert(trash[userId], info)
			end

			info.leftTime = #infoList > 1 and info.leftTime - BUBBLE_DELTA * 1.5 or info.leftTime - BUBBLE_DELTA

			if not info.isShowing then
				info.isShowing = true

				self:_showChatBubble(info.userId, info.chatId)
			end
		end
	end

	if trash then
		for userId, infoList in pairs(trash) do
			for _, info in ipairs(infoList) do
				table.removebyvalue(self._chatLists[userId], info)
				self:_hideChatBubble(userId)
			end
		end
	end

	if self._bubbleTaskCount <= 0 then
		self:_stopBubbleTimer()
	end
end

function MagicSchoolPvpReadyView:_startBubbleTimer()
	if self._isBubbleTimerRunning then
		return
	end

	self._bubbleTaskCount = 0
	self._isBubbleTimerRunning = true

	settimer(BUBBLE_DELTA, self._bubbleTicking, self)
end

function MagicSchoolPvpReadyView:_stopBubbleTimer()
	removetimer(self._bubbleTicking, self)

	self._isBubbleTimerRunning = false
end

function MagicSchoolPvpReadyView:_showChatBubble(userId, chatId)
	local playerInfo = self._playerInfos[userId]
	local cell = self:_getPlayerCell(playerInfo.campId, playerInfo.bossId)
	local data = MagicSchoolPvpConfig.instance:getChatData(chatId)

	if data then
		cell._txtBubble.text = data.value or ""
	end

	GameUtil.SetActive(cell._bubble, true)
end

function MagicSchoolPvpReadyView:_hideChatBubble(userId)
	local playerInfo = self._playerInfos[userId]
	local cell = self:_getPlayerCell(playerInfo.campId, playerInfo.bossId)

	GameUtil.SetActive(cell._bubble, false)
end

function MagicSchoolPvpReadyView:_onUpdateChatColUI()
	self:_onClearChatColUI()

	local dataList = MagicSchoolPvpConfig.instance:getChatDataList()
	local cell = self._chatColCellList[self._myCampId]

	cell._chatScrollerList:reloadData(dataList)
end

function MagicSchoolPvpReadyView:_onClearChatColUI()
	for _, cell in pairs(self._chatColCellList) do
		cell._chatScrollerList:dispose()
	end
end

function MagicSchoolPvpReadyView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.value

	GameUtil.addClickHandler(mainGo, function()
		MagicSchoolPvPController.instance:sendPM_MSPvPChatReq(self._activityId, data.chatId)
		self:_onClickBtnChat(false)
	end)
end

function MagicSchoolPvpReadyView:_clearChatCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function MagicSchoolPvpReadyView:_onClickBtnChat(hover)
	if not hover then
		for _, cell in pairs(self._chatColCellList) do
			GameUtil.SetActive(cell._chatPlane, not GameUtil.GetActive(cell._chatPlane))
		end
	end
end

function MagicSchoolPvpReadyView:_onUpdateSwitchTipsCol()
	self:_onClearSwitchTipsCol()

	local askInfo = self._askInfo

	if askInfo then
		if askInfo.ask.targetUserId == self._myUserId then
			local playerInfo = self._playerInfos[askInfo.ask.targetUserId]
			local cell = self:_getPlayerCell(playerInfo.campId, playerInfo.bossId)
			local pos = GameUtil.getPos(cell._tipsRoot)

			GameUtil.setPos(self._reqSwitchCell._mainGo, pos.x, pos.y, pos.z)

			cell._txtSwitchTimes.text = string.format("%s/%s", 0, 1)
			self._reqSwitchCell._txtDesc.text = string.format("%s想与您更换出场顺序，是否同意？", playerInfo.player.headInfo.userName)

			local function clickHandler(isSure)
				if self._curPeriodType ~= MagicSchoolPvPEnum.PeriodType_Ready then
					FloatWordMgr.instance:show("准备阶段已结束")

					return
				end

				GameUtil.SetActive(self._reqSwitchCell._mainGo, false)
				MagicSchoolPvPController.instance:sendPM_MSPvPAskHandleSwitchReq(self._activityId, isSure)
			end

			GameUtil.addClickHandler(self._reqSwitchCell._btnSure, function()
				clickHandler(true)
			end)
			GameUtil.addClickHandler(self._reqSwitchCell._btnCancel, function()
				clickHandler(false)
			end)

			self._switchSlider = self._reqSwitchCell._slider

			GameUtil.SetActive(self._reqSwitchCell._mainGo, true)
		else
			local targetPlayerInfo = self._playerInfos[askInfo.ask.targetUserId]
			local playerInfo = self._playerInfos[askInfo.ask.userId]
			local cell = self:_getPlayerCell(targetPlayerInfo.campId, targetPlayerInfo.bossId)
			local pos = GameUtil.getPos(cell._tipsRoot)

			GameUtil.setPos(self._statusSwitchCell._mainGo, pos.x, pos.y, pos.z)

			local nameA = playerInfo.player.headInfo.userName
			local nameB = targetPlayerInfo.player.headInfo.userName

			self._statusSwitchCell._txtDesc.text = string.format("%s想与%s更换出场顺序", nameA, nameB)
			self._switchSlider = self._statusSwitchCell._slider

			GameUtil.SetActive(self._statusSwitchCell._mainGo, true)
		end
	end

	for _, campId in ipairs(MagicSchoolPvPEnum.CampIdList) do
		for bossId, cell in ipairs(self._playerCells[campId]) do
			local cell = self:_getPlayerCell(campId, bossId)
			local player = self._subMo:getTeamPlayer(campId, bossId)
			local isSwitching = self._askInfo ~= nil
			local isCanSwitchWitTimes = self._subMo:isCanSwitchWitTimes()

			GameUtil.SetGray(cell._btnChange, isSwitching or not isCanSwitchWitTimes)

			local curTimes = self._subMo:getSwitchTimes(self._myUserId)
			local maxTimes = MagicSchoolPvPEnum.MaxSwitchPosTimes
			local leftTimes = maxTimes - curTimes

			cell._txtSwitchTimes.text = string.format("%s/%s", leftTimes, maxTimes)
		end
	end
end

function MagicSchoolPvpReadyView:_onClearSwitchTipsCol()
	self._switchSlider = nil

	GameUtil.rmClickHandler(self._reqSwitchCell._btnSure)
	GameUtil.rmClickHandler(self._reqSwitchCell._btnCancel)
	GameUtil.SetActive(self._reqSwitchCell._mainGo, false)
	GameUtil.SetActive(self._statusSwitchCell._mainGo, false)
end

function MagicSchoolPvpReadyView:_onUpdateBuffColUI()
	local buffList = {}
	local list = self._subMo:getSelectedBuffIds()

	table.insertto(buffList, list)

	local bossId = self._subMo:getCurBossId()
	local buffId = self._subMo:getSelectBuffIdRecord(bossId)

	if buffId > 0 then
		table.insert(buffList, buffId)
	end

	local myCampId = self._subMo:getCampId()

	for campId, cellList in ipairs(self._buffCells) do
		for idx, cell in ipairs(cellList) do
			if not buffList[idx] then
				if buffList[idx] > 0 and campId == self._myCampId then
					self:_updateBuffCell(cell, campId, buffList[idx])
				else
					self:_clearBuffCell(cell)
				end
			end
		end
	end
end

function MagicSchoolPvpReadyView:_onClearBuffCol()
	for campId, cellList in ipairs(self._buffCells) do
		for idx, cell in ipairs(cellList) do
			self:_clearBuffCell(cell)
		end
	end
end

function MagicSchoolPvpReadyView:_updateBuffCell(cell, campId, buffId)
	local data = MagicSchoolConfig.instance:getBuffCfgData(self._activityId, campId, buffId)

	GameUtil.SetActive(cell._mainGo, true)
	GameUtil.SetActive(cell._icon, data ~= nil)

	if data then
		local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

		uGuiUtil.setSpriteToImage(cell._icon, uGuiUtil.SpriteType.BigBg, iconUrl)

		cell._txtName.text = data.name

		GameUtil.addClickHandler(cell._mask, function()
			MagicSchoolPvPController.instance:openBuffTipsView(self._activityId, campId, buffId, cell._mainGo)
		end)
	else
		self:_clearBuffCell(cell)
	end
end

function MagicSchoolPvpReadyView:_clearBuffCell(cell)
	cell._txtName.text = ""

	uGuiUtil.clearImage(cell._icon)
	GameUtil.SetActive(cell._mainGo, false)
	GameUtil.rmClickHandler(cell._mask)
end

local SKINEIDS = {
	95032,
	94023,
	92020
}

function MagicSchoolPvpReadyView:_tickingSwitchSpine()
	self._skinSpineIdx = self._skinSpineIdx % #SKINEIDS + 1

	local skinId = SKINEIDS[self._skinSpineIdx]
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)
	end
end

function MagicSchoolPvpReadyView:_startSwitchSpine()
	self._skinSpineIdx = self._skinSpineIdx or 0

	settimer(4, self._tickingSwitchSpine, self, true)
	self:_tickingSwitchSpine()
end

function MagicSchoolPvpReadyView:_clearSwitchSpine()
	removetimer(self._tickingSwitchSpine, self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function MagicSchoolPvpReadyView:_onClickBtnFmt()
	if self._curPeriodType ~= MagicSchoolPvPEnum.PeriodType_Ready then
		FloatWordMgr.instance:show("准备阶段已结束")

		return
	end

	MagicSchoolPvPController.instance:enterFormation(self._activityId, true)
end

function MagicSchoolPvpReadyView:_onClickBtnBuff()
	if self._curPeriodType == MagicSchoolPvPEnum.PeriodType_Boss then
		UIStateManager.instance:push(ViewName.MagicSchoolPvpBuffView, self._activityId)
	end
end

return MagicSchoolPvpReadyView
