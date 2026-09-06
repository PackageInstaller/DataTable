-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgStageView.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgStageView", package.seeall)

local KingOfRadiantGoldClgStageView = class("KingOfRadiantGoldClgStageView", ViewComponent)
local _curTabIdx = 0

function KingOfRadiantGoldClgStageView:ctor()
	KingOfRadiantGoldClgStageView.super.ctor(self)
end

function KingOfRadiantGoldClgStageView:buildUI()
	KingOfRadiantGoldClgStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local fmtScrView = self:getGo("fmtCol/scrView")
	local fmtScrCell = self:getGo("fmtCol/scrCell")

	self._fmtScrollerList = ScrollerList.create(fmtScrView, fmtScrCell, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))

	local txtTipsFmtScrCell = self:getTxt("fmtCol/scrCell/tips/txt")

	self._strTxtTipsFmtScrCell = txtTipsFmtScrCell.text
	self._txtTips = self:getTxt("tips/txt")
	self._btnCollect = self:getGo("btnCollect")
	self._redBtnCollect = self:getGo("btnCollect/redPoint")
	self._btnBuff = self:getGo("btnBuff")
	self._redBtnBuff = self:getGo("btnBuff/redPoint")
	self._lockBtnBuff = self:getGo("btnBuff/lock")
	self._txtLockBuff = self:getTxt("btnBuff/lock/txt")
	self._strTxtLockBuff = self._txtLockBuff.text
end

function KingOfRadiantGoldClgStageView:bindEvents()
	KingOfRadiantGoldClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClikBtnCollect, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClikBtnBuff, self)
end

function KingOfRadiantGoldClgStageView:unbindEvents()
	KingOfRadiantGoldClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollect)
	GameUtil.rmClickHandler(self._btnBuff)
end

function KingOfRadiantGoldClgStageView:onEnter()
	KingOfRadiantGoldClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingOfRadiantGoldClgController.instance:getActivityType()

	local isInTime = KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = KingOfRadiantGoldClgController.instance:getClgMo(self._activityId)
	self._actData = KingOfRadiantGoldClgConfig.instance:getActData(self._activityId)
	_curTabIdx = _curTabIdx or 0

	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyKingOfRadiantGoldClgFinishRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgUpgradeBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgResetBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgOneKeyPassRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgGainPetRes, self._onUpdate, self)
	RedPointController.instance:regRedPoint(self._redBtnBuff, RedPointModel.ID_KingOfRadiantGoldClg_Buff)
	RedPointController.instance:regRedPoint(self._redBtnCollect, RedPointModel.ID_KingOfRadiantGoldClg_FinialPrize)
	KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgInfoReq(self._activityId)
end

function KingOfRadiantGoldClgStageView:onExit()
	KingOfRadiantGoldClgStageView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnBuff)
	RedPointController.instance:unregRedPoint(self._redBtnCollect)
	self:_onClearTabCol()
	self:_onClearFmtCol()
end

function KingOfRadiantGoldClgStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingOfRadiantGoldClgStageView:_onUpdateData()
	self._tabInfoList = {}

	local cfg = KingOfRadiantGoldClgConfig.instance:getChallengeCfg(self._activityId)

	if cfg then
		for index, data in ipairs(cfg) do
			local info = {}

			info.index = index
			info.challengeId = data.challengeId

			table.insert(self._tabInfoList, info)
		end
	end

	local isNeedAuto = false

	if _curTabIdx <= 0 then
		isNeedAuto = true
	else
		local info = self._tabInfoList[_curTabIdx]

		if info then
			if not self._clgMo:isUnlockChallenge(info.challengeId) then
				isNeedAuto = true
			end
		else
			isNeedAuto = true
		end
	end

	if isNeedAuto then
		for _, info in ipairs(self._tabInfoList) do
			local challengeId = info.challengeId

			if self._clgMo:isUnlockChallenge(challengeId) then
				_curTabIdx = info.index

				if not self._clgMo:isPassChallenge(challengeId) then
					break
				end
			end
		end
	end
end

function KingOfRadiantGoldClgStageView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()

	local day = 0
	local buffOpenTime = self._actData.buffOpenTime

	if not string.nilorempty(buffOpenTime) then
		day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(buffOpenTime))
		day = day - 1
	end

	if day > 0 then
		self._txtLockBuff.text = string.format(self._strTxtLockBuff, day)
	end

	GameUtil.SetActive(self._lockBtnBuff, day > 0)

	local tabInfo = self:_getCurTabInfo()
	local challengeId = tabInfo and tabInfo.challengeId
	local data = KingOfRadiantGoldClgConfig.instance:getChallengeData(self._activityId, challengeId)

	self._txtTips.text = data.ruleTips
end

function KingOfRadiantGoldClgStageView:_getCurTabInfo()
	return self._tabInfoList[_curTabIdx]
end

function KingOfRadiantGoldClgStageView:_onUpdateTabColUI()
	self._tabScrollerList:reloadData(self._tabInfoList)
end

function KingOfRadiantGoldClgStageView:_onClearTabCol()
	self._tabScrollerList:dispose()
end

function KingOfRadiantGoldClgStageView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.index
	local challengeId = info.challengeId
	local data = KingOfRadiantGoldClgConfig.instance:getChallengeData(self._activityId, challengeId)
	local isUnlockCond = self._clgMo:isUnlockChallengeByCond(challengeId)
	local isUnlockTime = self._clgMo:isUnlockChallengeByTime(challengeId)
	local isPassChallenge = self._clgMo:isPassChallenge(challengeId)
	local mainGo = cell.gameObject
	local lock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txt")
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")

	txtStage.text = data.name

	local isSelect = _curTabIdx == tabIdx

	GameUtil.setUIGroupIdx(mainGo, isSelect and 1 or 0)

	local lockStr = ""

	if not isUnlockTime then
		local timeStr = GameUtil.formatTimeString("%m.%d %H:%M", data.openTime)

		lockStr = string.format("%s 后开启", timeStr)
	elseif not isUnlockCond then
		local lastData = KingOfRadiantGoldClgConfig.instance:getChallengeData(self._activityId, challengeId - 1)

		lockStr = string.format("通关%s 后开启", lastData and lastData.name)
	end

	txtLock.text = lockStr

	GameUtil.SetActive(lock, not isUnlockCond or not isUnlockCond)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._clickTabCell, self, info))
end

function KingOfRadiantGoldClgStageView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function KingOfRadiantGoldClgStageView:_clickTabCell(info)
	local result = self._clgMo:getTryResultAndTipsEnterChallenge(true, info.challengeId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	_curTabIdx = info.index

	self:_onUpdateUI()
end

function KingOfRadiantGoldClgStageView:_onUpdateFmtColUI()
	local tabInfo = self:_getCurTabInfo()
	local challengeId = tabInfo and tabInfo.challengeId
	local cfg = KingOfRadiantGoldClgConfig.instance:getStageCfg(self._activityId, challengeId) or {}

	self._fmtScrollerList:reloadData(cfg)
end

function KingOfRadiantGoldClgStageView:_onClearFmtCol()
	self._fmtScrollerList:dispose()
end

function KingOfRadiantGoldClgStageView:_updateFmtCell(view, cell, data, tag)
	local challengeId = data.challengeId
	local stageId = data.stageId
	local isPassStage = self._clgMo:isPassStage(challengeId, stageId)
	local dailyScore = self._clgMo:getDailyScore(challengeId, stageId)
	local index = cell.data
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local imgPass = goutil.findChild(mainGo, "con/imgPass")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local item = goutil.findChild(mainGo, "bubble/item")
	local imgGain = goutil.findChild(mainGo, "bubble/imgGain")
	local tips = goutil.findChild(mainGo, "tips")
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")

	GameUtil.setUIImageSpriteIdx(con, (index - 1) % 3 + 1 - 1)

	txtName.text = string.format("第%s关", data.stageId)

	GameUtil.SetActive(imgGain, isPassStage)
	MaterialMgr.setCellByCfg(self._actData.xunzhangItem, item)

	local scoreCfg = KingOfRadiantGoldClgConfig.instance:getScoreCfgByStage(self._activityId, challengeId, stageId)
	local maxScoreData = scoreCfg and scoreCfg[#scoreCfg]

	if maxScoreData then
		if not maxScoreData.score then
			local maxGetScore = 0

			txtTips.text = string.format(self._strTxtTipsFmtScrCell, dailyScore, maxGetScore)

			GameUtil.SetActive(tips, scoreCfg ~= nil and maxGetScore > 0)

			local isRealPass = false

			if scoreCfg == nil then
				isRealPass = isPassStage
			end

			GameUtil.SetActive(imgPass, isRealPass)
			uGuiUtil.setImageGrayState(con, isRealPass)
			GameUtil.addClickHandler(con, function()
				local result = self._clgMo:getTryResultAndTipsStartStageClg(true, challengeId, stageId)

				if result ~= GameEnum.ResultCode.Success then
					return
				end

				KingOfRadiantGoldClgController.instance:enterBattle(self._activityId, challengeId, stageId)
			end)
		end
	end
end

function KingOfRadiantGoldClgStageView:_clearFmtCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")
	local item = goutil.findChild(mainGo, "bubble/item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
	uGuiUtil.clearImage(con)
end

function KingOfRadiantGoldClgStageView:_onClikBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KingOfRadiantGoldClgStageView:_onClikBtnCollect()
	UIStateManager.instance:push(ViewName.KingOfRadiantGoldClgCollectView, self._activityId)
end

function KingOfRadiantGoldClgStageView:_onClikBtnBuff()
	if not self._clgMo:isBuffOpenTime() then
		FloatWordMgr.instance:show("未到符文强化开启时间")

		return
	end

	UIStateManager.instance:push(ViewName.KingOfRadiantGoldClgBuffView, self._activityId)
end

return KingOfRadiantGoldClgStageView
