-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleBossAwardDlg.lua

local ResClanBattleFeat = require("ClientData/ResClanBattleFeat")
local CircleBossAwardCell = require("UI/Circle/CircleBossAwardCell")
local strClassName = "CircleBattleBossAwardDlg"
local CircleBattleBossAwardDlg = Class(strClassName, UIControls.Window)

function CircleBattleBossAwardDlg:ctor()
	self:initUI()
end

function CircleBattleBossAwardDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtTime = UIControls.Label(self, "Bg/TimePanel/TextTime")
	self.cells = {}
	self.scrollBossAward = UIControls.ScrollViewLoopV(self, "Bg/BossAwardList")

	self.scrollBossAward:addEventCellChanged(self.onBossAwardChanged)
	self:initAwardCellShow()
	self:refreshTime()
end

function CircleBattleBossAwardDlg:onBossAwardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleBossAwardCell(sender, "System/CircleBattle/BossAwardCell", newIdx)

	if not self.bossAwardDataList or #self.bossAwardDataList == 0 then
		return
	end

	if self.bossAwardDataList[newIdx] ~= nil then
		targetCell:setCircleBossAwardData(self.bossAwardDataList[newIdx], self.circleRank, self.playerRank)
	end

	self.cells[newIdx] = targetCell
end

function CircleBattleBossAwardDlg:initAwardCellShow()
	if CurAvatar.myCircle then
		local circleRankData = CurAvatar:getCachedCircleBattleLayerRankData()

		if circleRankData then
			self.circleRank = circleRankData.selfData.rank

			self:initPanelShow()
		end
	end
end

function CircleBattleBossAwardDlg:refreshForCircleRank(rank)
	if CurAvatar.myCircle then
		self.circleRank = rank

		self:initPanelShow()
	end
end

function CircleBattleBossAwardDlg:initPanelShow()
	self.playerRank = CurAvatar.myCircle:getPlayerFeatRank()
	self.bossAwardDataList = {}

	for i, bossAwardData in ipairs(ResClanBattleFeat) do
		local bossAwardData = {}

		bossAwardData.resData = ResClanBattleFeat[i]
		self.bossAwardDataList[i] = bossAwardData
	end

	self.scrollBossAward:setTotalCount(#self.bossAwardDataList, math.min(self.playerRank, #ResClanBattleFeat - 4))
end

function CircleBattleBossAwardDlg:refreshTime(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local leftTime = 0
	local actObj = CurAvatar:getCircleBattleActivity()

	if actObj then
		leftTime = actObj.actData:getLeftTimeToEnd()
	end

	if leftTime > 0 then
		ClientTimerManager.AddSecondTickUI(self.txtTime, leftTime, nil, "", ClientUtils.getClientNotice(590), nil, nil)
	end
end

function CircleBattleBossAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

return CircleBattleBossAwardDlg
