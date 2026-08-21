-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpWelcomeDlg.lua

local ActivityPvpRankAwardGetCell = require("UI/PVPMode/ActivityPVP/ActivityPvpRankAwardGetCell")
local ResArenaDan = require("ClientData/ResArenaDan")
local PVPCommon = require("Logic/PVP/PVPCommon")
local strClassName = "ActivityPvpWelcomeDlg"
local ActivityPvpWelcomeDlg = Class(strClassName, UIControls.Window)

function ActivityPvpWelcomeDlg:ctor(...)
	self:initUI()
end

function ActivityPvpWelcomeDlg:initUI(...)
	self.txtZoneName = UIControls.Label(self, "BgPanel/TextZone")
	self.txtScore = UIControls.Label(self, "BgPanel/TextScore")
	self.txtRank = UIControls.Label(self, "BgPanel/TextRank")
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRankIcon = UIControls.Image(self, "Bg/BgDec/IconRankLv")
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

	self.scrollView = UIControls.ScrollViewLoopV(self, "AwardPanel/AwardList", 0, self.onAwardCellChanged)
end

function ActivityPvpWelcomeDlg:onOpen(...)
	ActivityPvpWelcomeDlg.super.onOpen(self)
end

function ActivityPvpWelcomeDlg:show(typeStr)
	local arenaData = CurAvatar:getPVPArenaActivityData()

	if arenaData == nil then
		return
	end

	self.data = {}

	self.txtScore:setText(arenaData.score)

	local zoneInfo = PVPCommon.getZoneInfo(arenaData.league)

	if zoneInfo then
		self.txtZoneName:setText(zoneInfo.name)
	end

	local info = PVPCommon.getPartInfoByScore(arenaData.score)

	if info then
		self.txtRank:setText(info.dan_name)
		PVPCommon.setRankUI(self.rankUIData, info)
	end

	PVPCommon.setRankIconBig(self.imgRankIcon, info)

	local actData = CurAvatar:getPVPArenaActData()
	local preDan = actData:getPreDan()

	if typeStr == "leagueChange" then
		self.isZoneUp = true

		if preDan then
			for i = info.dan, preDan + 1, -1 do
				local data = ResArenaDan[i]

				if data then
					table.insert(self.data, data)
				end
			end
		end
	elseif typeStr == "seasonOpen" then
		for i = info.dan, 1, -1 do
			local data = ResArenaDan[i]

			if data then
				table.insert(self.data, data)
			end
		end
	end

	if arenaData.award_dan < info.dan then
		local actId = CurAvatar:getPVPArenaActivityOpId()

		if actId then
			RPC.opactArenaRoleInfoRefresh(actId)
		end
	end

	actData:savePreDan(info.dan)
	self.scrollView:setTotalCount(#self.data)
	RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, false)
end

function ActivityPvpWelcomeDlg:onAwardCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityPvpRankAwardGetCell(sender, "System/ActivityPVP/ActivityPVPRankAwardGetCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.data[newIdx])
end

function ActivityPvpWelcomeDlg:onBtnConfirmClick(...)
	self:setVisible(false)

	if self.isZoneUp then
		local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

		if ui then
			ui:onWelcomeColse()
		end
	end
end

return ActivityPvpWelcomeDlg
