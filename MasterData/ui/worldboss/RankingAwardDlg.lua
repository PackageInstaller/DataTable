-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\RankingAwardDlg.lua

local ResRankAward = require("ClientData/ResRankAward")
local ResClanBattleRank = require("ClientData/ResClanBattleRank")
local ResNewMazeAward = require("ClientData/ResNewMazeAward")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewPveRankAward = require("ClientData/ResNewPveRankAward")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local WorldBossRankingAwardCell = Class("WorldBossRankingAwardCell", UIControls.ScrollViewLoopCell)

function WorldBossRankingAwardCell:ctor(...)
	self:initUI()
end

function WorldBossRankingAwardCell:initUI(...)
	self.txtSelf = UIControls.Label(self, "ContentPanel/TextTitle/TextSelf")
	self.txtNum = UIControls.Label(self, "ContentPanel/TextNum")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.awardCells = {}
end

function WorldBossRankingAwardCell:setData(data)
	if self.mWindow.myRank >= data.index and self.mWindow.myRank <= data.index_low_bound then
		self.panelContent:playStateAnimator("RankingAwardCellSel")
		self.txtSelf:setVisible(true)
		self.txtSelf:setText(string.format(Lang.get(30800), self.mWindow.myRank))
	else
		self.panelContent:playStateAnimator("RankingAwardCellNml")
		self.txtSelf:setVisible(false)
	end

	if data.index == data.index_low_bound then
		self.txtNum:setText(data.index)
	else
		self.txtNum:setText(data.index .. "-" .. data.index_low_bound)
	end

	ClientUtils.CreateBonusGrid(self, self.awardCells, "ContentPanel/AwardPanel", data.award, true, nil, true)

	for i, cell in ipairs(self.awardCells) do
		local spe = ClientUtils.getItemSpeTypeId(cell.object.id)

		if spe then
			cell:setSpe(true, spe)
		else
			cell:setSpe(false)
		end
	end
end

local strClassName = "RankingAwardDlg"
local RankingAwardDlg = Class(strClassName, UIControls.Window)

function RankingAwardDlg:ctor(...)
	self:initUI()
end

function RankingAwardDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtTime = UIControls.Label(self, "BgPanel/TextTime")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList", 0, self.onCellChanged)
end

function RankingAwardDlg:show(myRank, awardType)
	self.myRank = myRank
	self.awardType = awardType or 1

	self:initData()
	self:refreshTime()
end

function RankingAwardDlg:initData()
	if self.myRank == nil then
		self.myRank = 0
	end

	local myIndex = -1

	self.awardDatas = {}

	if self.awardType == Const.RANK_AWARD_TYPE_CIRLCE_BATTLE_LAYER then
		local datas = ResClanBattleRank

		for i, data in pairs(datas) do
			table.insert(self.awardDatas, data)
		end
	elseif self.awardType == Const.RANK_AWARD_TYPE_SNEAK_BATTLE then
		local type = 1
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			type = actData.type or 1
		end

		local datas = ResNewPveRankAward[type]

		for i, data in pairs(datas) do
			table.insert(self.awardDatas, data)
		end
	else
		local datas = ResRankAward[self.awardType]

		for i, data in pairs(datas) do
			table.insert(self.awardDatas, data)
		end
	end

	table.sort(self.awardDatas, function(v1, v2)
		return v1.index < v2.index
	end)

	for i, data in ipairs(self.awardDatas) do
		if self.myRank >= data.index and self.myRank <= data.index_low_bound then
			myIndex = i

			break
		end
	end

	if myIndex > 0 then
		self.scrollView:setTotalCount(#self.awardDatas, myIndex)
	else
		self.scrollView:setTotalCount(#self.awardDatas)
	end
end

function RankingAwardDlg:refreshTime()
	local leftTime = 0
	local afterStr = Lang.get(30801)

	if self.awardType == Const.RANK_AWARD_TYPE_WORLDBOSS then
		leftTime = WorldBossCommon.getCurBossLeftTime()
		afterStr = ClientUtils.getClientNotice(277)
	elseif self.awardType == Const.RANK_AWARD_TYPE_OPACTPVP then
		local actData = CurAvatar:getPVPArenaActData()

		if actData then
			leftTime = actData:getLeftTimeToEnd()
		end

		afterStr = ClientUtils.getClientNotice(325)
	elseif self.awardType == Const.RANK_AWARD_TYPE_SEASON_TOWER then
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SEASON_TOWER)

		if actObj then
			local actData = actObj.actData

			if actData then
				leftTime = actData:getFreezeOpenTime()
			end
		end

		afterStr = ClientUtils.getClientNotice(337)
	elseif self.awardType == Const.RANK_AWARD_TYPE_CIRLCE_BATTLE_LAYER then
		local actObj = CurAvatar:getCircleBattleActivity()

		if actObj then
			leftTime = actObj.actData:getLeftTimeToEnd()
		end

		afterStr = ClientUtils.getClientNotice(593)
	elseif self.awardType == Const.RANK_AWARD_TYPE_NEW_MAZE then
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			leftTime = actObj.actData:getRemainOpenTime()
		end

		afterStr = ResNewMazeDisplay[13060019].desc
	elseif self.awardType == Const.RANK_AWARD_TYPE_PET_MAZE then
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
		local checkOpen = actObj ~= nil and actObj:isValid()

		if checkOpen then
			leftTime = actObj.actData:getSeasonLeftTime()
		end
	elseif self.awardType == Const.RANK_AWARD_TYPE_SNEAK_BATTLE then
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SNEAK_BATTLE)
		local checkOpen = actObj ~= nil and actObj:isValid()

		if checkOpen then
			leftTime = actObj.actData:getCurLeftTime()
		end

		if ResNewPveShow[13090009] then
			afterStr = ResNewPveShow[13090009].desc
		end
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondTickUI(self.txtTime, leftTime, nil, "", afterStr, nil, nil)
end

function RankingAwardDlg:getRankAwardType(...)
	return self.awardType
end

function RankingAwardDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function RankingAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = WorldBossRankingAwardCell(sender, "System/Rank/RankingAwardCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.awardDatas[newIdx])
end

return RankingAwardDlg
