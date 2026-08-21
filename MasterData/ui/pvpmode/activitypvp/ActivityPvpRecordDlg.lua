-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpRecordDlg.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BtnActivityPvpRecordCell = Class("BtnActivityPvpRecordCell", UIControls.ScrollViewLoopCell)
local INIT_HEIGHT = 122
local MAX_HEIGHT = 466
local ICON_PATH = "Atlas/OtherBattleAtlas/AsynPVPAtlas2"
local ICON_PATH2 = "Atlas/OtherBattleAtlas/AsynPVPAtlas"
local ICON_PATH3 = "Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2"

function BtnActivityPvpRecordCell:ctor(...)
	self:initUI()
end

function BtnActivityPvpRecordCell:initUI(...)
	self.imgBg = UIControls.Image(self, "BtnPVPRecord/Bg")
	self.imgType = UIControls.Image(self, "BtnPVPRecord/ImgType")
	self.imgTypeDes = UIControls.Image(self, "BtnPVPRecord/ImgTypeDes")
	self.imgResult = UIControls.Image(self, "BtnPVPRecord/ImgResult")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPRecord/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnTeam = UIControls.Button(self, "BtnPVPRecord/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnReplay = UIControls.Button(self, "BtnPVPRecord/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.btnRevenge = UIControls.Button(self, "BtnPVPRecord/BtnRevenge")

	self.btnRevenge:addEventClick(self.onBtnRevengeClick)

	self.txtTime = UIControls.Label(self, "BtnPVPRecord/TextTime")
	self.txtPlayerName = UIControls.Label(self, "BtnPVPRecord/TextPlayerName")
	self.txtScoreChange = UIControls.Label(self, "BtnPVPRecord/TextScoreChange")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BtnPVPRecord"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function BtnActivityPvpRecordCell:setData(data)
	self.data = data
	self.baseData = data.baseData

	self:_initUIData()
end

function BtnActivityPvpRecordCell:_initUIData(...)
	local name = utils.GetPlayerName(self.baseData.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(self.baseData.comm, true, self)
	self.btnHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_MULTIPVP)

	if self.baseData.replay_id ~= "0" then
		self.btnReplay:setVisible(true)
	else
		self.btnReplay:setVisible(false)
	end

	local scoreChange = self.baseData.self_new_score - self.baseData.self_old_score

	if scoreChange >= 0 then
		self.txtScoreChange:setText("+" .. scoreChange)
	else
		self.txtScoreChange:setText(scoreChange)
	end

	local isAttack = self.baseData.attack == 1

	self.isMyAttack = isAttack

	local isWin = self.baseData.win == 1

	if isAttack then
		self.imgType:setImage(ICON_PATH3, "TxtAttack")
		self.imgTypeDes:setImage(ICON_PATH, "BgAttack")
	else
		self.imgType:setImage(ICON_PATH3, "TxtDefense")
		self.imgTypeDes:setImage(ICON_PATH, "BgDefense")
	end

	if isWin then
		self.imgResult:setImage(ICON_PATH, "IconWin")
		self.imgBg:setImage(ICON_PATH3, "BgRank1")
	else
		self.imgResult:setImage(ICON_PATH, "IconDefeat")
		self.imgBg:setImage(ICON_PATH3, "BgRankOther")
	end

	self.txtTime:setText(ClientUtils.timeFormat4Record(ClientUtils.getServerTime() - self.baseData.tick))

	if PVPCommon.isOpactPvpChallenged(self.baseData.comm.uid) or self.isMyAttack or isWin then
		self.btnRevenge:setVisible(false)
	else
		self.btnRevenge:setVisible(true)
	end

	self:extend(self.data.extend)
end

function BtnActivityPvpRecordCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function BtnActivityPvpRecordCell:checkFormation(...)
	local formation = CurAvatar:getOpactPvpFormation(self.baseData.comm.uid)

	self.data.formation = formation

	if formation then
		self.panelFormation:setFormation(formation, false)
		self.panelFormation:setCommonHideMode()
		self.panelTeamInfo:setVisible(true)
	end
end

function BtnActivityPvpRecordCell:onBtnReplayClick(...)
	CurAvatar.cachedOpactPvpReplayData = self.baseData

	local replayEnv = {}

	replayEnv.replayId = self.baseData.replay_id

	local actObj = CurAvatar:getPVPArenaActivity()

	if actObj then
		replayEnv.actId = actObj.actId
	end

	GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)
	CurAvatar:getOpactPvpReplayInfo(self.baseData.replay_id, false)
end

function BtnActivityPvpRecordCell:onBtnTeamClick(...)
	self.mWindow:onCellExtendChange(self.data)
end

function BtnActivityPvpRecordCell:onBtnRevengeClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	if PVPCommon.getLeftChallengeTimes() <= 0 then
		MsgManager.clientNotice(320)

		return
	end

	CurAvatar.opactPvpReadyFightUid = self.baseData.comm.uid
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
		RPC.opactArenaDetailGet(actId, self.baseData.comm.uid)
	end
end

local strClassName = "ActivityPvpRecordDlg"
local ActivityPvpRecordDlg = Class(strClassName, UIControls.Window)

function ActivityPvpRecordDlg:ctor(...)
	self:initUI()
end

function ActivityPvpRecordDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtChallengeTimes = UIControls.Label(self, "BgPanel/TicketNumPanel/TextNum")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/RecordList", 0, self.onCellChanged)
end

function ActivityPvpRecordDlg:onOpen(...)
	ActivityPvpRecordDlg.super.onOpen(self)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		self:bindWindow(ui)
	end
end

function ActivityPvpRecordDlg:show(...)
	self.txtChallengeTimes:setText(PVPCommon.getLeftChallengeTimes() .. "/" .. PVPCommon.getTotalChallengeTimes())

	local reports = ClientUtils.record.opactPvpReports or {}

	self.reports = {}

	for _, data in ipairs(reports) do
		local info = {}

		info.baseData = data
		info.extend = false

		table.insert(self.reports, info)
	end

	table.sort(self.reports, function(v1, v2)
		return v1.baseData.tick > v2.baseData.tick
	end)
	self.panelEmpty:setVisible(#self.reports == 0)
	self:refreshList()
end

function ActivityPvpRecordDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.reports)
end

function ActivityPvpRecordDlg:onCellExtendChange(data)
	for _, info in ipairs(self.reports) do
		if info == data then
			info.extend = not info.extend
		else
			info.extend = false
		end
	end

	self:refreshList()
end

function ActivityPvpRecordDlg:recoveryFromReplay(replayEnv)
	local idx = 0

	for i, data in ipairs(self.reports) do
		if data.baseData.replay_id == replayEnv.replayId then
			idx = i

			break
		end
	end

	if idx > 0 then
		self.scrollView:scrollToCell(idx)
		CurAvatar:getOpactPvpReplayInfo(self.reports[idx].baseData.replay_id, false)
	end
end

function ActivityPvpRecordDlg:onNewDay(...)
	self.scrollView:refreshCells()
end

function ActivityPvpRecordDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BtnActivityPvpRecordCell(sender, "System/ActivityPVP/BtnActivityPVPRecord", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.reports[newIdx])
end

function ActivityPvpRecordDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return ActivityPvpRecordDlg
