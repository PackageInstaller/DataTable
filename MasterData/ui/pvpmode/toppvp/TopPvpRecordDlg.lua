-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpRecordDlg.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBPPvpRound = require("ClientData/ResBPPvpRound")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local BtnTopPvpKnockoutRecordCell = Class("BtnTopPvpKnockoutRecordCell", UIControls.ScrollViewLoopCell)

function BtnTopPvpKnockoutRecordCell:ctor()
	self:initUI()
end

function BtnTopPvpKnockoutRecordCell:initUI()
	self.imgResult = UIControls.Image(self, "BtnPVPRecord/BgEliminate/ImgResult")

	self.imgResult:setVisible(true)

	self.btnReplay = UIControls.Button(self, "BtnPVPRecord/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.txtRound = UIControls.Label(self, "BtnPVPRecord/BgEliminate/TextTime")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPRecord/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtPlayerName = UIControls.Label(self, "BtnPVPRecord/TextPlayerName")
	self.bgEliminate = UIControls.Image(self, "BtnPVPRecord/BgEliminate")
end

function BtnTopPvpKnockoutRecordCell:setData(data)
	self.data = data

	self:_initUIData()
end

function BtnTopPvpKnockoutRecordCell:_initUIData()
	self.bgEliminate:setVisible(true)

	local comm = self.data.comm.comm
	local name = utils.GetPlayerName(comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(comm, true, self)

	if self.data.replay_id ~= "0" then
		self.btnReplay:setVisible(true)
	else
		self.btnReplay:setVisible(false)
	end

	if self.data.is_winner == 1 then
		self.imgResult:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas2", "IconWin")
		self.bgEliminate:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "BgRank1")
	else
		self.imgResult:setImage("Atlas/OtherBattleAtlas/AsynPVPAtlas2", "IconDefeat")
		self.bgEliminate:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2", "BgRankOther")
	end

	local roomId = self.data.room_id
	local round = math.floor(roomId % 100 / 10)
	local roundName = ResBPPvpRound[round].round_name

	self.txtRound:setText(roundName)
end

function BtnTopPvpKnockoutRecordCell:onBtnReplayClick()
	if self.data.replay_id == 0 or self.data.replay_id == "0" or #self.data.round_time == 0 then
		local desc = ResBPPvpShow[13070007].desc

		MsgManager.notice(desc)
	else
		CurAvatar.cachedOpTopPvpKnockoutReplayData = self.data

		local myCommInfo = CurAvatar:getMyCommInfo()
		local otherComminfo = self.data.comm.comm

		CurAvatar.cachedOpTopPvpKnockoutReplayData.member = {}

		for i = 1, 2 do
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[i] = {}
		end

		if self.data.self_pos == 1 then
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[1].comm = myCommInfo
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[2].comm = otherComminfo
		else
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[2].comm = myCommInfo
			CurAvatar.cachedOpTopPvpKnockoutReplayData.member[1].comm = otherComminfo
		end

		RPC.pVEBattleReplay(tostring(self.data.replay_id), BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
	end
end

local BtnTopPvpRecordCell = Class("BtnTopPvpRecordCell", UIControls.ScrollViewLoopCell)
local INIT_HEIGHT = 122
local MAX_HEIGHT = 466
local ICON_PATH = "Atlas/OtherBattleAtlas/AsynPVPAtlas2"
local ICON_PATH2 = "Atlas/OtherBattleAtlas/AsynPVPAtlas"
local ICON_PATH3 = "Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2"

function BtnTopPvpRecordCell:ctor(...)
	self:initUI()
end

function BtnTopPvpRecordCell:initUI(...)
	self.imgBg = UIControls.Image(self, "BtnPVPRecord/Bg")
	self.imgType = UIControls.Image(self, "BtnPVPRecord/ImgType")
	self.imgTypeDes = UIControls.Image(self, "BtnPVPRecord/ImgTypeDes")
	self.imgResult = UIControls.Image(self, "BtnPVPRecord/ImgResult")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPRecord/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnTeam = UIControls.Button(self, "BtnPVPRecord/BtnTeam")

	self.btnTeam:setVisible(false)

	self.btnReplay = UIControls.Button(self, "BtnPVPRecord/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.txtTime = UIControls.Label(self, "BtnPVPRecord/TextTime")
	self.txtPlayerName = UIControls.Label(self, "BtnPVPRecord/TextPlayerName")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.bgEliminate = UIControls.Image(self, "BtnPVPRecord/BgEliminate")
end

function BtnTopPvpRecordCell:setData(data)
	self.data = data
	self.baseData = data.baseData

	self:_initUIData()
end

function BtnTopPvpRecordCell:_initUIData(...)
	self.bgEliminate:setVisible(false)

	local name = utils.GetPlayerName(self.baseData.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(self.baseData.comm, true, self)

	if self.baseData.replay_id ~= "0" then
		self.btnReplay:setVisible(true)
	else
		self.btnReplay:setVisible(false)
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
	self:extend(self.data.extend)
end

function BtnTopPvpRecordCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function BtnTopPvpRecordCell:onBtnReplayClick(...)
	CurAvatar.cachedOpTopPvpReplayData = self.baseData

	local replayEnv = {}

	replayEnv.replayId = self.baseData.replay_id

	local actObj = CurAvatar:getTopPVPActivity()

	if actObj then
		replayEnv.actId = actObj.actId
	end

	GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)
	CurAvatar:getTopPvpReplayInfo(self.baseData.replay_id, false)
end

local strClassName = "topPvpRecordDlg"
local TopPvpRecordDlg = Class(strClassName, UIControls.Window)

function TopPvpRecordDlg:ctor()
	self:initUI()
end

function TopPvpRecordDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/RecordList", 0, self.onCellChanged)
	self.scrollView2 = UIControls.ScrollViewLoopV(self, "BgPanel/RecordList", 0, self.onCellChanged2)
end

function TopPvpRecordDlg:onOpen(...)
	TopPvpRecordDlg.super.onOpen(self)

	local ui = UIManager.getUI("TopPvpMainDlg", nil, false)

	if ui then
		self:bindWindow(ui)
	end
end

function TopPvpRecordDlg:show(battletype)
	self.battletype = battletype

	if self.battletype == BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT then
		local actData = CurAvatar:getTopPVPActivityData()

		self.reports = actData.record.opBPPvpKnockoutReports or {}

		table.sort(self.reports, function(v1, v2)
			return v1.room_id > v2.room_id
		end)
		self.scrollView2:setTotalCount(#self.reports)
		self.panelEmpty:setVisible(#self.reports == 0)
	else
		local actData = CurAvatar:getTopPVPActivityData()
		local reports = actData.record.opBPPvpReports or {}

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
end

function TopPvpRecordDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.reports)
end

function TopPvpRecordDlg:onCellExtendChange(data)
	for _, info in ipairs(self.reports) do
		if info == data then
			info.extend = not info.extend
		else
			info.extend = false
		end
	end

	self:refreshList()
end

function TopPvpRecordDlg:recoveryFromReplay(replayEnv)
	local idx = 0

	for i, data in ipairs(self.reports) do
		if data.baseData.replay_id == replayEnv.replayId then
			idx = i

			break
		end
	end

	if idx > 0 then
		self.scrollView:scrollToCell(idx)
		CurAvatar:getTopPvpReplayInfo(self.reports[idx].baseData.replay_id, false)
	end
end

function TopPvpRecordDlg:onNewDay(...)
	self.scrollView:refreshCells()
end

function TopPvpRecordDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BtnTopPvpRecordCell(sender, "System/TopPVP/BtnTopPVPRecord", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.reports[newIdx])
end

function TopPvpRecordDlg:onCellChanged2(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BtnTopPvpKnockoutRecordCell(sender, "System/TopPVP/BtnTopPVPRecord", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.reports[newIdx])
end

function TopPvpRecordDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return TopPvpRecordDlg
