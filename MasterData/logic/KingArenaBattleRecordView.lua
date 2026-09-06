-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaBattleRecordView.lua

module("logic.extensions.kingarena.view.KingArenaBattleRecordView", package.seeall)

local KingArenaBattleRecordView = class("KingArenaBattleRecordView", ViewComponent)

function KingArenaBattleRecordView:buildUI()
	KingArenaBattleRecordView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._empty = goutil.findChild(self.mainGO, "empty")

	local scrCell = goutil.findChild(self.mainGO, "scrCell")
	local scrView = goutil.findChild(self.mainGO, "scrView")

	self._recordScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function KingArenaBattleRecordView:bindEvents()
	KingArenaBattleRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KingArenaBattleRecordView:unbindEvents()
	KingArenaBattleRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KingArenaBattleRecordView:onEnter()
	KingArenaBattleRecordView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = KingArenaController.instance:isInTimeOfSeason(self._seasonId)

	if not isInTime then
		self:close()

		return
	end

	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetRecordsRes, self._handlePM_KingArenaGetRecordsRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaBattleVideoRes, self._handlePM_KingArenaBattleVideoRes, self)
	self.addGEvent(self, GlobalNotify.KingArenaStepChange, self._handleKingArenaStepChange, self)
	KingArenaController.instance:sendPM_KingArenaGetRecordsReq(self._seasonId)
end

function KingArenaBattleRecordView:onExit()
	KingArenaBattleRecordView.super.onExit(self)
	self._recordScrollerList:dispose()
end

function KingArenaBattleRecordView:_handlePM_KingArenaBattleVideoRes(msg)
	if msg.btlResult then
		local myUserId = checknumber(RoleModel.instance:getUserId())

		KingArenaController.instance:playFightRecord(msg.btlResult, myUserId)
	end
end

function KingArenaBattleRecordView:_handleKingArenaStepChange(stepChangeState)
	if stepChangeState == KingArenaEnum.StepChangeState_Season then
		self:close()

		return
	end
end

function KingArenaBattleRecordView:_handlePM_KingArenaGetRecordsRes(msg)
	local records = GameUtil.pbToTable(msg.records) or {}

	table.sort(records, function(a, b)
		return a.challnegeTime > b.challnegeTime
	end)
	self._recordScrollerList:reloadData(records)
	GameUtil.SetActive(self._empty, #records <= 0)
end

function KingArenaBattleRecordView:_updateRecordCell(view, cell, data, tag)
	local timeStamp = checknumber(data.challnegeTime) / 1000
	local isWin = checkbool(data.isWin)
	local hedInfos = {}

	hedInfos[GameEnum.BattleTeam.Left] = RoleModel.instance:getHeadInfo()
	hedInfos[GameEnum.BattleTeam.Right] = data.opHeadInfo

	local isMuzhuang = checknumber(data.opHeadInfo.userId) == 0

	if isMuzhuang then
		hedInfos[GameEnum.BattleTeam.Right] = nil
	end

	local ranks = {}

	ranks[GameEnum.BattleTeam.Left] = data.beforeRank
	ranks[GameEnum.BattleTeam.Right] = data.afterRank

	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local muzhuang = goutil.findChild(headGo, "muzhuang")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local txtScore = goutil.findChildTextComponent(headGo, "txtScore")
		local tag = goutil.findChild(headGo, "tag")
		local headInfo = hedInfos[teamId]
		local score = ranks[teamId]

		if headInfo then
			local userId = checknumber(headInfo.userId)
			local isNeedShowInfo = userId > 0 and userId ~= checknumber(RoleModel.instance:getUserId())

			HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, isNeedShowInfo)

			txtName.text = headInfo.userName

			GameUtil.SetActive(headRoot, true)
			GameUtil.SetActive(muzhuang, false)
		else
			HeadItemController.instance:resetHeadCell(headRoot)

			txtName.text = "木桩"

			GameUtil.SetActive(headRoot, false)
			GameUtil.SetActive(muzhuang, true)
		end

		txtScore.text = score
	end

	GameUtil.setUIImageSpriteIdx(imgResult, isWin and 2 or 0)

	if timeStamp > 0 then
		local date = GameUtil.time2date(timeStamp)

		txtTime.text = string.format("%02d月%02d日 %02d:%02d", date.month, date.day, date.hour, date.min)
	else
		txtTime.text = ""
	end

	GameUtil.SetActive(btnVideo, not isMuzhuang)
	GameUtil.addClickHandler(btnVideo, function()
		KingArenaController.instance:sendPM_KingArenaBattleVideoReq(data.battleId)
	end)
end

function KingArenaBattleRecordView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")

		HeadItemController.instance:resetHeadCell(headRoot)
	end

	GameUtil.rmClickHandler(btnVideo)
end

function KingArenaBattleRecordView:_onClickBtnDetail(recordMo)
	local battleId = recordMo:getBattleId()

	if checknumber(battleId) > 0 then
		ShowDownController.instance:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
	else
		printError("缺失battleId")
	end
end

return KingArenaBattleRecordView
