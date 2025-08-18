-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpEnemyDlg.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ResArenaMisc = require("ClientData/ResArenaMisc")
local ActPvpEnemyCell = Class("ActPvpEnemyCell", UIControls.ScrollViewLoopCell)
local INIT_HEIGHT = 122
local MAX_HEIGHT = 466
local MODE = {
	NEAR = 2,
	RECOMMEND = 1
}
local ICON_PATH = "Atlas/OtherBattleAtlas/ActivityPVPAtlas/ActivityPVPAtlas"

function ActPvpEnemyCell:ctor(...)
	self:initUI()
end

function ActPvpEnemyCell:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPEnemy/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnTeam = UIControls.Button(self, "BtnPVPEnemy/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnBattle = UIControls.Button(self, "BtnPVPEnemy/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.txtName = UIControls.Label(self, "BtnPVPEnemy/TextPlayerName")
	self.txtPower = UIControls.Label(self, "BtnPVPEnemy/TextPower")
	self.txtScore = UIControls.Label(self, "BtnPVPEnemy/TextScore")
	self.txtScoreChange = UIControls.Label(self, "BtnPVPEnemy/ScoreChangePanel/TextNum")
	self.imgBgEnemy = UIControls.Image(self, "BtnPVPEnemy/BgEnemy")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BtnPVPEnemy"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function ActPvpEnemyCell:setData(data)
	self.data = data
	self.baseData = data.baseData

	self:_initUIData()
end

function ActPvpEnemyCell:_initUIData(...)
	local name = utils.GetPlayerName(self.baseData.comm.name)

	self.txtName:setText(name)
	self.txtPower:setText(self.baseData.power)
	self.txtScore:setText(self.baseData.score)
	self.btnHead:setCommInfo(self.baseData.comm, true, self)
	self.btnBattle:setText(Lang.get(217))

	local league

	if self.mWindow.curMode == MODE.RECOMMEND then
		league = self.baseData.league
	end

	local info = PVPCommon.getPartInfoByScore(self.baseData.score, league)

	if info then
		PVPCommon.setRankUI(self.rankUIData, info)
	end

	local actData = CurAvatar:getPVPArenaActivityData()
	local score = 0

	if actData then
		score = actData.score
	end

	local scoreChange = PVPCommon.getScoreChange(score, self.baseData.score)

	self.txtScoreChange:setText("+" .. scoreChange)
	self:setBgIcon()
	self:extend(self.data.extend)
end

function ActPvpEnemyCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function ActPvpEnemyCell:checkFormation(...)
	local formation = CurAvatar:getOpactPvpFormation(self.baseData.uid)

	self.data.formation = formation

	if formation then
		self.panelFormation:setFormation(formation, false)
		self.panelFormation:setCommonHideMode()
		self.panelTeamInfo:setVisible(true)
	end
end

function ActPvpEnemyCell:onBtnTeamClick(...)
	self.mWindow:onCellExtendChange(self.data)
end

function ActPvpEnemyCell:onBtnBattleClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	if PVPCommon.isOpactPvpChallenged(self.baseData.uid) then
		MsgManager.clientNotice(323)

		return
	end

	if PVPCommon.getLeftChallengeTimes() <= 0 then
		MsgManager.clientNotice(320)

		return
	end

	CurAvatar.opactPvpReadyFightUid = self.baseData.uid
	ClientUtils.record.opactPvpCacheData = {}
	ClientUtils.record.opactPvpCacheData.rank = CurAvatar.opactPvpRank

	local actData = CurAvatar:getPVPArenaActivityData()
	local score = 0

	if actData then
		score = actData.score
	end

	ClientUtils.record.opactPvpCacheData.score = score
	ClientUtils.record.opactPvpCacheData.comm = self.baseData.comm

	local actId = CurAvatar:getPVPArenaActivityOpId()

	if actId then
		RPC.opactArenaDetailGet(actId, self.baseData.uid)
	end
end

function ActPvpEnemyCell:setBgIcon(...)
	local score = 0
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		score = actData.score
	end

	if self.mWindow.curMode == MODE.RECOMMEND then
		local offset = ResArenaMisc[1].part_factor

		if score > self.baseData.score then
			self.imgBgEnemy:setImage(ICON_PATH, "BgLevelLow")
		elseif offset > self.baseData.score - score then
			self.imgBgEnemy:setImage(ICON_PATH, "BgLevelMiddle")
		else
			self.imgBgEnemy:setImage(ICON_PATH, "BgLevelHigh")
		end
	elseif score < self.baseData.score then
		self.imgBgEnemy:setImage(ICON_PATH, "BgLevelHigh")
	else
		self.imgBgEnemy:setImage(ICON_PATH, "BgRankLow")
	end
end

local strClassName = "ActivityPvpEnemyDlg"
local ActivityPvpEnemyDlg = Class(strClassName, UIControls.Window)

function ActivityPvpEnemyDlg:ctor(...)
	self:initUI()
end

function ActivityPvpEnemyDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRefresh = UIControls.Button(self, "BgPanel/BtnRefresh", "Text")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.txtPower = UIControls.Label(self, "BgPanel/TextPower")
	self.txtPowerNone = UIControls.Label(self, "BgPanel/TextPowerNone")
	self.txtRefresh = UIControls.Label(self, "BgPanel/BtnRefresh/Text")
	self.txtLeftChallengeTimes = UIControls.Label(self, "BgPanel/TicketNumPanel/TextNum")
	self.txtScore = UIControls.Label(self, "BgPanel/TextScore")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/EnemyList", 0, self.onCellChanged)
	self.tabs = {}

	for i = 1, 2 do
		local tab = UIControls.Button(self, "BgPanel/TabPanel/Btn" .. i)

		tab:addEventClick(self.onTapClick)

		tab.mode = i

		table.insert(self.tabs, tab)
	end

	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BgPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end

	self:onTapClick(self.tabs[1])
end

function ActivityPvpEnemyDlg:onOpen(...)
	ActivityPvpEnemyDlg.super.onOpen(self)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		self:bindWindow(ui)
	end
end

function ActivityPvpEnemyDlg:refreshUI(isOut)
	if self.curMode == MODE.RECOMMEND then
		self.btnRefresh:setVisible(true)
		self:refreshRecommendData(isOut)
	else
		self.btnRefresh:setVisible(false)
		self:refreshNearData()
	end

	self:refreshList()
	self:checkCD()
end

function ActivityPvpEnemyDlg:refreshRecommendData(needRefresh)
	if needRefresh or self.matchDatas == nil then
		local data = CurAvatar.activityPvpOpponentData

		self.matchDatas = {}

		for i, d in ipairs(data or {}) do
			local t = {}

			t.baseData = d
			t.extend = false

			table.insert(self.matchDatas, t)
		end

		table.sort(self.matchDatas, function(v1, v2)
			return v1.baseData.score > v2.baseData.score
		end)
	end
end

function ActivityPvpEnemyDlg:refreshNearData(...)
	if self.matchNearDatas == nil then
		local data = CurAvatar.opactPvpNearMatchDatas

		self.matchNearDatas = {}

		for i, d in ipairs(data or {}) do
			local t = {}

			t.baseData = d
			t.extend = false

			table.insert(self.matchNearDatas, t)
		end

		table.sort(self.matchNearDatas, function(v1, v2)
			return v1.baseData.score > v2.baseData.score
		end)
	end
end

function ActivityPvpEnemyDlg:initData(...)
	self.txtLeftChallengeTimes:setText(PVPCommon.getLeftChallengeTimes() .. "/" .. PVPCommon.getTotalChallengeTimes())

	local actData = CurAvatar:getPVPArenaActivityData()
	local score = 0

	if actData then
		score = actData.score
	end

	local info = PVPCommon.getPartInfoByScore(score)

	if info then
		PVPCommon.setRankUI(self.rankUIData, info)
	end

	local curInfo, isLast = PVPCommon.getPartInfoByScore(score)

	if score > curInfo.high_score or isLast then
		self.txtScore:setText(score)
	else
		self.txtScore:setText(score .. "/" .. curInfo.high_score + 1)
	end
end

function ActivityPvpEnemyDlg:show(...)
	self:initData()

	local power = 0

	for i = 1, 3 do
		power = power + CurAvatar:getNowFormationCapacity(Const["FORMATION_OPACTPVP_ATTACK_" .. i])
	end

	if power > 0 then
		self.txtPower:setText(power)
	end

	self.txtPower:setVisible(power > 0)
	self.txtPowerNone:setVisible(power == 0)
end

function ActivityPvpEnemyDlg:refreshList(...)
	local data = self:getCurShowDatas()

	self.scrollView:setTotalCount(#data)
	self.panelEmpty:setVisible(#data <= 0)
end

function ActivityPvpEnemyDlg:checkCD(...)
	local leftTime = self:getLeftTime()

	if leftTime < 0 then
		local actData = CurAvatar:getPVPArenaActivityData()
		local matchTimes = 0

		if actData then
			matchTimes = actData.match_times
		end

		self.btnRefresh:setEnable(true)
		self.txtRefresh:setText(string.format(Lang.get(30649), PVPCommon.getTotalMatchTimes() - matchTimes .. "/" .. PVPCommon.getTotalMatchTimes()))
	else
		self.btnRefresh:setEnable(false)

		if self.timer ~= nil then
			self.timer:Restart()
		else
			self.timer = Timer.New(Slot(self._timeDown, self), 0, -1)

			self.timer:Start()
		end
	end
end

function ActivityPvpEnemyDlg:_timeDown()
	local leftTime = self:getLeftTime()

	if leftTime < 0 then
		local actData = CurAvatar:getPVPArenaActivityData()
		local matchTimes = 0

		if actData then
			matchTimes = actData.match_times
		end

		self.txtRefresh:setText(string.format(Lang.get(30649), PVPCommon.getTotalMatchTimes() - matchTimes .. "/" .. PVPCommon.getTotalMatchTimes()))
		self.btnRefresh:setEnable(true)
		self.timer:Pause()
	else
		self.txtRefresh:setText(string.format(Lang.get(30650), leftTime))
	end
end

function ActivityPvpEnemyDlg:getLeftTime(...)
	return (CurAvatar.nextActivityPvpMatchTime or 0) - ClientUtils.getServerTime()
end

function ActivityPvpEnemyDlg:onCellExtendChange(data)
	local datas = self:getCurShowDatas()

	for _, info in ipairs(datas) do
		if info == data then
			info.extend = not info.extend
		else
			info.extend = false
		end
	end

	self:refreshList()
end

function ActivityPvpEnemyDlg:getCurShowDatas(...)
	if self.curMode == MODE.RECOMMEND then
		return self.matchDatas or {}
	else
		return self.matchNearDatas or {}
	end
end

function ActivityPvpEnemyDlg:removeZeroPowerData(uidMap)
	if next(uidMap) then
		local info = {
			self.matchNearDatas
		}

		for _, data in ipairs(info) do
			if data then
				for i = #data, 1, -1 do
					if uidMap[data[i].baseData.uid] then
						table.remove(data, i)
					end
				end
			end
		end
	end
end

function ActivityPvpEnemyDlg:onNewDay(...)
	self.scrollView:refreshCells()
end

function ActivityPvpEnemyDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActPvpEnemyCell(sender, "System/ActivityPVP/BtnActivityPVPEnemy", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	local data = self:getCurShowDatas()

	targetCell:setData(data[newIdx])

	if self.curMode == MODE.NEAR and (CurAvatar.opactPvpNearCommGotPage == nil or newIdx == CurAvatar.opactPvpNearCommGotPage * Const.OPACTPVP_NEAR_PULL_NUM) then
		self:getNearCommInfoDetailByPage()
	end
end

function ActivityPvpEnemyDlg:getNearCommInfoDetailByPage(...)
	CurAvatar.opactPvpNearCommGotPage = (CurAvatar.opactPvpNearCommGotPage or 0) + 1

	local startIndex = (CurAvatar.opactPvpNearCommGotPage - 1) * Const.OPACTPVP_NEAR_PULL_NUM + 1
	local endIndex = CurAvatar.opactPvpNearCommGotPage * Const.OPACTPVP_NEAR_PULL_NUM
	local uids = {}
	local datas = self.matchNearDatas or {}

	for i = startIndex, endIndex do
		local info = datas[i]

		if info then
			table.insert(uids, info.baseData.uid)
		end
	end

	coroutine.start(function(...)
		coroutine.step()
		CurAvatar:getCommInfoDetail(uids, CurAvatar.opactPvpNearMatchDatas or {})
	end)
end

function ActivityPvpEnemyDlg:onBtnRefreshClick(...)
	local actData = CurAvatar:getPVPArenaActivityData()
	local matchTimes = 0

	if actData then
		matchTimes = actData.match_times
	end

	if matchTimes >= PVPCommon.getTotalMatchTimes() then
		MsgManager.clientNotice(322)

		return
	end

	local id = CurAvatar:getPVPArenaActivityOpId()

	if id then
		RPC.opactArenaMatch(id)
	end
end

function ActivityPvpEnemyDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function ActivityPvpEnemyDlg:onTapClick(sender)
	for i, tab in ipairs(self.tabs) do
		if sender == tab then
			tab:setEnable(false)
		else
			tab:setEnable(true)
		end
	end

	self.curMode = sender.mode

	self:refreshUI()
end

function ActivityPvpEnemyDlg:destroy(...)
	ActivityPvpEnemyDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end
end

return ActivityPvpEnemyDlg
