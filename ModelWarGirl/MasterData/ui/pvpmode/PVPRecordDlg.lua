-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPRecordDlg.lua

local strClassName = "PVPRecordDlg"
local Formation = require("UI/PVPMode/Formation")
local ResAsyncPVPMisc = require("ClientData/ResAsyncPVPMisc")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResColor = require("ClientData/ResColor")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local ResItem = require("ClientData/ResItem")
local PVPRecordDlg = Class(strClassName, UIControls.Window)
local sweepItem = ResAsyncPVPMisc[1].sweep_item
local PVPRecordCell = Class("PVPRecordCell", UIControls.ScrollViewLoopCell)
local side = {
	ATTACK = 1,
	DEFEND = 2
}
local result = {
	WIN = 0
}
local INIT_HEIGHT = 130
local MAX_HEIGHT = 395
local config = UIConst.MONEY_ID2INFO[Const.MONEY_ID_PVP_TICKET]

function PVPRecordCell:ctor()
	self:initUI()
end

function PVPRecordCell:initUI()
	self.imgBg = UIControls.Image(self, "BtnPVPRecord/Bg")
	self.imgType = UIControls.Image(self, "BtnPVPRecord/ImgType")
	self.imgTypeDes = UIControls.Image(self, "BtnPVPRecord/ImgTypeDes")
	self.imgResult = UIControls.Image(self, "BtnPVPRecord/ImgResult")
	self.txtTime = UIControls.Label(self, "BtnPVPRecord/TextTime")
	self.txtPlayerName = UIControls.Label(self, "BtnPVPRecord/TextPlayerName")
	self.btnTeam = UIControls.Button(self, "BtnPVPRecord/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.txtSoreChange = UIControls.Label(self, "BtnPVPRecord/TextScoreChange")
	self.btnRevenge = UIControls.Button(self, "BtnPVPRecord/BtnRevenge")

	self.btnRevenge:addEventClick(self.onBtnRevengeClick)

	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPRecord/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.formation = Formation(self, "TeamInfo")
	self.imgTicketIcon = UIControls.Image(self, "BtnPVPRecord/BtnRevenge/Icon")
	self.txtTicketNum = UIControls.Label(self, "BtnPVPRecord/BtnRevenge/TextNum")
	self.btnReplay = UIControls.Button(self, "BtnPVPRecord/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)
end

local iconPath = "Atlas/OtherBattleAtlas/AsynPVPAtlas2"
local iconPath2 = "Atlas/OtherBattleAtlas/AsynPVPAtlas"

function PVPRecordCell:initData(recordData)
	self.recordData = recordData

	local data = recordData.report
	local mySide = side.ATTACK

	self.enemyData = data.defend

	local myData = data.attack

	if data.attack.comm.uid ~= CurAvatar.uid then
		mySide = side.DEFEND
		self.enemyData = data.attack
		myData = data.defend
	end

	local uid = self.enemyData.comm.uid

	if CurAvatar.rankFormation and CurAvatar.rankFormation[uid] then
		recordData.formation = CurAvatar.rankFormation[uid].formation

		self.formation:initData(recordData.formation)
	end

	if mySide == side.ATTACK then
		self.imgType:setImage(iconPath, "TxtAttack")
		self.imgTypeDes:setImage(iconPath, "BgAttack")
	else
		self.imgType:setImage(iconPath, "TxtDefense")
		self.imgTypeDes:setImage(iconPath, "BgDefense")
	end

	if data.base.result == result.WIN and mySide == side.ATTACK or data.base.result ~= result.WIN and mySide == side.DEFEND then
		self.imgResult:setImage(iconPath, "IconWin")
		self.imgBg:setImage(iconPath2, "BgRank1")
		self.btnRevenge:setVisible(false)
	else
		self.imgResult:setImage(iconPath, "IconDefeat")
		self.imgBg:setImage(iconPath2, "BgRankOther")

		if recordData.checkFight == true then
			self.btnRevenge:setVisible(true)
		else
			self.btnRevenge:setVisible(false)
		end
	end

	self.txtTime:setText(ClientUtils.timeFormat4Record(ClientUtils.getServerTime() - data.base.tick))

	local name = utils.GetPlayerName(self.enemyData.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(self.enemyData.comm, true, self)
	self.btnHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)

	if myData.score > 0 then
		self.txtSoreChange:setText(string.format("+%d", myData.score))
	else
		self.txtSoreChange:setText(string.format("%d", myData.score))
	end

	if self.recordData.report.base.replay_id ~= "0" then
		self.btnReplay:setVisible(true)
	else
		self.btnReplay:setVisible(false)
	end

	if self.btnRevenge:getVisible() then
		self.imgTicketIcon:setImage(config[1], config[2])
		self.txtTicketNum:setText(1)
		self.txtTicketNum:setVisible(true, true)
		self.imgTicketIcon:setVisible(true, true)

		if CurAvatar:getPvpCounter(Const.DayPvpCountId) < CurAvatar:getPvpFreeCount() then
			self.txtTicketNum:setVisible(false)
			self.imgTicketIcon:setVisible(false)
		elseif CurAvatar:getItemNumById(sweepItem) > 0 then
			self.txtTicketNum:setFontColor(ResColor.WHITE)
		else
			self.txtTicketNum:setFontColor(ResColor.RED)
		end
	end

	self:extend(self.recordData.extend)
end

function PVPRecordCell:onBtnReplayClick(...)
	local replayId = self.recordData.report.base.replay_id
	local replayEnv = {}

	replayEnv.replayId = replayId

	GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)
	RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_ASYNC_PVP)
end

function PVPRecordCell:onBtnRevengeClick(...)
	if CurAvatar:getItemNumById(sweepItem) <= 0 and CurAvatar:getPvpCounter(Const.DayPvpCountId) >= CurAvatar:getPvpFreeCount() then
		local itemName = ResItem[sweepItem] and ResItem[sweepItem].name or ""

		MsgManager.notice(string.format(Lang.get(30029), itemName))

		return
	end

	RPC.asyncPVPTargetCache(self.enemyData.comm.uid)
	self.mWindow:refreshShowFightState(self.mIndex)
end

function PVPRecordCell:onBtnTeamClick(...)
	self.mWindow:clearSelect(self.recordData)
end

function PVPRecordCell:isNeedRequest(uid)
	if not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= Const.FORMATION_GET_INTERVAL then
		local uids = self.mWindow:getUids()
		local result = false

		if #uids > 0 then
			RPC.asyncPVPGetDetail(uids)

			result = true
		end

		return result
	else
		return false
	end
end

function PVPRecordCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)

		local uid = self.enemyData.comm.uid

		if self:isNeedRequest(uid) then
			self.formation:setVisible(false)
		else
			self.formation:setVisible(true)
		end
	else
		self.formation:setVisible(v)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function PVPRecordDlg:ctor()
	self:initUI()
end

function PVPRecordDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/RecordList", 0, self.onCellChanged)
	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.txtTicketNum = UIControls.Label(self, "BgPanel/TicketNumPanel/TextNum")
	self.imgTicketIcon = UIControls.Image(self, "BgPanel/TicketNumPanel/Icon")

	if config then
		self.imgTicketIcon:setImage(config[1], config[2])
	end

	self.txtTicketNum:setText(CurAvatar:getItemNumById(sweepItem))
end

function PVPRecordDlg:getUids(...)
	local uids = {}

	if ClientUtils.record.pvpReport and self.cells then
		local map = {}

		for _, cell in ipairs(self.cells) do
			local uid = cell.enemyData.comm.uid

			if (not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= Const.FORMATION_GET_INTERVAL) and not map[uid] then
				table.insert(uids, uid)

				map[uid] = true
			end
		end
	end

	return uids
end

function PVPRecordDlg:show(newData)
	self.txtTicketNum:setText(CurAvatar:getItemNumById(sweepItem))

	self.cells = {}
	self.reports = ClientUtils.record.pvpReport or {}

	if newData == true then
		self:_checkShowFight()
	end

	if #self.reports > 0 then
		self.scrollView:setTotalCount(#self.reports)
		self.panelEmpty:setVisible(false)
	else
		self.panelEmpty:setVisible(true)
	end
end

function PVPRecordDlg:_checkShowFight(...)
	local map = {}

	for i, data in ipairs(self.reports) do
		if map[data.otherUid] then
			data.checkFight = false
		else
			map[data.otherUid] = true
			data.checkFight = true
		end
	end
end

function PVPRecordDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PVPRecordCell(sender, "System/AsynPVP/BtnPVPRecord", newIdx, 0, 0)

		table.insert(self.cells, targetCell)
	end

	targetCell.mIndex = newIdx

	targetCell:initData(self.reports[newIdx])
end

function PVPRecordDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PVPRecordDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.reports)
end

function PVPRecordDlg:recoveryFromReplay(replayEnv)
	local idx = 0

	for i, data in ipairs(self.reports) do
		if data.report.base.replay_id == replayEnv.replayId then
			idx = i

			break
		end
	end

	if idx > 0 then
		self.scrollView:scrollToCell(idx)
	end
end

function PVPRecordDlg:refreshShowFightState(index)
	local data = self.reports[index]

	if data then
		data.checkFight = false
	end
end

function PVPRecordDlg:clearSelect(recordData)
	for _, r in ipairs(self.reports) do
		if recordData ~= r then
			r.extend = false
		else
			recordData.extend = not recordData.extend
		end
	end

	self.scrollView:setTotalCount(#self.reports)
end

return PVPRecordDlg
