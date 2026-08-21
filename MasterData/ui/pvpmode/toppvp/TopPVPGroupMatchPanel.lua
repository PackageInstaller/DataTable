-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPVPGroupMatchPanel.lua

local strClassName = "TopPVPGroupRankCell"
local TopPVPGroupRankCell = Class(strClassName, UIControls.Child)
local PVPCommon = require("Logic/PVP/PVPCommon")
local ResBPPvpTimer = require("ClientData/ResBPPvpTimer")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local groupMatchState = {
	Array = 2,
	Challenge = 3
}

function TopPVPGroupRankCell:ctor(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.imgBackground = UIControls.Image(self, "BgPanel/Bg")
	self.ImageBg1 = UIControls.Image(self, "BgPanel/Bg1")
	self.textRankNum = UIControls.Label(self, "BgPanel/TextRankNum")
	self.textSet = UIControls.Label(self, "BgPanel/TextSet")
	self.textPlayerName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.textPower = UIControls.Label(self, "BgPanel/TextPower")
	self.btnChallenge = UIControls.Button(self, "BgPanel/BtnChallenge")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

	self.imgChallenged = UIControls.Image(self, "BgPanel/ImgChallenged")
	self.textNum = UIControls.Label(self, "BgPanel/TextScore/TextNum")
	self.textRecord = UIControls.Label(self, "BgPanel/TextRecord")
end

function TopPVPGroupRankCell:setData(data)
	self.data = data

	if self.index == 1 then
		self.ImageBg1:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRanking1")
		self.imgBackground:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRank1")
	else
		self.imgBackground:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankOther")
		self.ImageBg1:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankingOther")
	end

	local name = utils.GetPlayerName(self.data.comm.name)

	self.textPlayerName:setText(name)

	local sorce = data.detail.score

	self.textNum:setText(sorce)

	local actData = CurAvatar:getTopPVPActivityData()
	local nowState

	if actData then
		nowState = actData:getTopPvpStage()
	end

	if nowState == actData.reStateMap.GroupFormation then
		self.imgBackground:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankNone")
		self.ImageBg1:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankingNone")
		self.textRankNum:setVisible(false)
		self.textPower:setText(self.data.detail.power)
		self.btnChallenge:setVisible(false)
		self.imgChallenged:setVisible(false)
		self.textSet:setVisible(true)
		self.textNum:setText("0")
		self.textRecord:setText(Lang.get(75851))
	else
		self.textPower:setText(self.data.detail.power)
		self.textSet:setVisible(false)

		if self.index == 1 then
			self.imgBackground:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRank1")
			self.ImageBg1:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRanking1")
		else
			self.imgBackground:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankOther")
			self.ImageBg1:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas", "BgTopRankingOther")
		end

		self.textRankNum:setVisible(true)
		self.textRankNum:setText(self.index)
		self.textRecord:setText(utils.format(Lang.get(90274), data.detail.win, data.detail.lose))
		self.textRankNum:setVisible(true)
		self.textRankNum:setText(self.index)

		if nowState == actData.reStateMap.GroupFight then
			local challenged = CurAvatar:checkTopPvpGroupMatchChanged(data.detail.uid)

			self.btnChallenge:setVisible(not challenged)
			self.imgChallenged:setVisible(challenged)
		else
			self.btnChallenge:setVisible(false)
			self.imgChallenged:setVisible(false)
		end
	end

	if self.data.detail.uid == CurAvatar.uid then
		self.btnChallenge:setVisible(false)
		self.imgChallenged:setVisible(false)
		self.textSet:setVisible(false)
		self.textPower:setText(data.detail.power)
	end

	self.btnHead:setCommInfo(self.data.comm, true, self)
end

function TopPVPGroupRankCell:onBtnChallengeClick()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData.topPvpReadyFightUid = self.data.detail.uid
	end

	local actId = CurAvatar:getTopPVPActivityOpId()

	if actId then
		RPC.bPPvpGroupDetailGet(actId, self.data.detail.uid, 0)

		ClientUtils.record.topPvpCacheData = {
			comm = self.data.comm
		}
	end
end

local strClassName = "TopPVPGroupMatchPanel"
local TopPVPGroupMatchPanel = Class(strClassName, UIControls.Panel)

function TopPVPGroupMatchPanel:ctor(...)
	self.textRemainTimeTips = UIControls.Label(self, "GroupMatchPanel/TipsPanel/TextTime")
	self.textPlayerName = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/TextPlayerName")

	self.textPlayerName:setText(CurAvatar.name)

	self.textRank = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/TextRank")
	self.textLv = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/TextLv")
	self.textPower = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/TextPower")
	self.textRecord = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/BgRecord/TextRecord")
	self.textScore = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/BgScore/TextScore")
	self.btnRecord = UIControls.Button(self, "GroupMatchPanel/SelfInfoPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.btnDefendTeam = UIControls.Button(self, "GroupMatchPanel/SelfInfoPanel/BtnDefendTeam")

	self.btnDefendTeam:addEventClick(self.onBtnDefendTeamClick)

	self.textRankNone = UIControls.Label(self, "GroupMatchPanel/SelfInfoPanel/TextRankNone")
	self.imgEliminate = UIControls.Image(self, "GroupMatchPanel/SelfInfoPanel/ImgEliminate")
	self.imgPromotion = UIControls.Image(self, "GroupMatchPanel/SelfInfoPanel/ImgPromotion")
	self.playerList = {}
	self.iconAbsent = UIControls.Image(self, "GroupMatchPanel/SelfInfoPanel/BtnDefendTeam/IconAbsent")
	self.cells = {}
end

local function TopPvpGroupMatchsort(a, b)
	if a.point > b.point then
		return true
	elseif a.point < b.point then
		return false
	elseif a.detail.score > b.detail.score then
		return true
	elseif a.detail.score < b.detail.score then
		return false
	else
		local flag1 = false
		local flag2 = false

		for k, v in pairs(a.winList) do
			if v == b.detail.uid then
				flag1 = true
			end
		end

		for k, v in pairs(b.winList) do
			if v == a.detail.uid then
				flag2 = true
			end
		end

		if flag1 and not flag2 then
			return true
		elseif not flag1 and flag2 then
			return false
		elseif a.detail.power > b.detail.power then
			return true
		elseif a.detail.power < b.detail.power then
			return false
		else
			return a.detail.uid < b.detail.uid
		end
	end
end

function TopPVPGroupMatchPanel:setData(groupData)
	ClientTimerManager.RemoveSecondTickUI(self.textRemainTimeTips)

	local nowState
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		nowState = actData:getTopPvpStage()
	end

	self.playerList = {}

	for k, v in pairs(self.cells) do
		v:setVisible(false)
	end

	self.iconAbsent:setVisible(actData:checkGroupMatchFormationNew())

	self.cells = {}

	local myData

	for k, v in pairs(groupData) do
		v.isme = v.detail.uid == CurAvatar.uid

		if v.isme then
			myData = v
		end
	end

	self.textPower:setText(myData.detail.power)
	self.textLv:setText(myData.comm.level)

	local remainTime = CurAvatar:getTopPvpCurStageRemainTime()

	if nowState == actData.reStateMap.GroupFormation then
		self.textRankNone:setVisible(true)

		for k, v in pairs(groupData) do
			table.insert(self.playerList, v)
		end

		self.textRank:setText("")
		self.textRecord:setText(Lang.get(75851))
		self.textScore:setText("0")
		self.textRankNone:setVisible(true)
		self.imgEliminate:setVisible(false)
		self.imgPromotion:setVisible(false)

		if remainTime > 0 then
			local resData = ResBPPvpShow[13070023]

			if resData and resData.desc then
				local content = resData.desc
				local notice = string.gsub(content, "$1", "%%s")

				ClientTimerManager.AddSecondFormatTickUI(self.textRemainTimeTips, remainTime, false, notice)
			end
		end
	else
		self.textRankNone:setVisible(false)

		local win = myData.detail.win
		local lose = myData.detail.lose
		local sorce = myData.detail.score

		self.textScore:setText(sorce)
		self.textRecord:setText(utils.format(Lang.get(90274), win, lose))

		local rank

		for k, v in pairs(groupData) do
			v.point = v.detail.win - v.detail.lose
			v.battleRecord = utils.getBitsDictFromByteString(v.detail.result)
			v.winList = {}

			for i, j in pairs(v.battleRecord) do
				if j == true then
					table.insert(v.winList, groupData[i].detail.uid)
				end
			end
		end

		table.sort(groupData, TopPvpGroupMatchsort)

		for k, v in pairs(groupData) do
			table.insert(self.playerList, v)
		end

		for index, data in pairs(self.playerList) do
			if data.detail.uid == CurAvatar.uid then
				rank = index

				break
			end
		end

		self.textRank:setText(rank)

		if nowState == actData.reStateMap.GroupFight then
			ClientTimerManager.AddSecondFormatTickUI(self.textRemainTimeTips, remainTime, false, Lang.get(77975))
		elseif nowState == actData.reStateMap.GroupSettleReady then
			self.textRemainTimeTips:setText(Lang.get(77976))
		else
			self.textRemainTimeTips:setText(Lang.get(77977))

			local myIndex

			for k, v in pairs(self.playerList) do
				if v.detail.uid == myData.detail.uid then
					myIndex = k

					break
				end
			end

			if myIndex == 1 then
				self.imgEliminate:setVisible(false)
				self.imgPromotion:setVisible(true)
			else
				self.imgEliminate:setVisible(true)
				self.imgPromotion:setVisible(false)
			end
		end
	end

	for index = 1, #self.playerList do
		local newCell = TopPVPGroupRankCell(self, "Content", "System/TopPVP/BtnTopPVPGroupRank")

		newCell:setVisible(true)

		newCell.index = index

		newCell:setData(self.playerList[index])
		table.insert(self.cells, newCell)
	end
end

function TopPVPGroupMatchPanel:refreshRedDot()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.iconAbsent:setVisible(actData:checkGroupMatchFormationNew())
	end
end

function TopPVPGroupMatchPanel:onBtnRecordClick()
	local result, hint = PVPCommon.isTopPvpEnd()

	if result then
		MsgManager.notice(hint)

		return
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		if actData.opTopPvpNextGetGroupMatchReportTime > ClientUtils.getServerTime() and actData.record.opBPPvpReports then
			UIManager.getUI("topPvpRecordDlg", true):show()
		else
			local actId = CurAvatar:getTopPVPActivityOpId()

			if actId then
				RPC.bPPvpGroupReportGet(actId)
			end
		end
	end
end

function TopPVPGroupMatchPanel:onBtnDefendTeamClick()
	local formation = CurAvatar:getNowFormation(Const.FORMATION_TOPPVP_DEFEND_1)

	if formation == nil or next(formation) == nil then
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			local nowState = actData:getTopPvpStage()

			if nowState and nowState > actData.reStateMap.GroupFormation then
				MsgManager.notice(Lang.get(79275))

				return
			end
		end

		local BattleConst = require("Common/FrameBattle/BattleConst")
		local battleData = {}

		battleData.topPvpData = {}

		local actObj = CurAvatar:getTopPVPActivity()

		if actObj then
			battleData.topPvpData.actId = actObj.actId
		end

		CurAvatar:enterFormation(ResBPPvpMisc[1].pve_id, BattleConst.FORMATION_TYPE_TOP_PVP, battleData)
	else
		UIManager.getUI("topPvpCheckTeamDlg", true):show()
	end
end

return TopPVPGroupMatchPanel
