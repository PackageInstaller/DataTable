-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHousePopularityAwardDlg.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local EventConst = require("EventConst")
local AwardCell = Class("RearHousePopularityAwardDlg_AwardCell", UIControls.ScrollViewLoopCell)

function AwardCell:ctor()
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.animPanel = UIControls.Panel(self, "ContentPanel")
	self.btnGet = UIControls.Button(self, "ContentPanel/BtnReceive")

	self.btnGet:addEventClick(self.onClickBtnReceive, 0.5)
end

function AwardCell:setData(achieveId)
	self.achieveId = achieveId

	local achieveConfig = ResAchieve[achieveId]

	self.txtTitle:setText(achieveConfig.action_desc or "")

	local awardRandId = achieveConfig.award_randid

	self.gridList = self.gridList or {}

	ClientUtils.CreateBonusGrid(self, self.gridList, "ContentPanel/AwardPanel", awardRandId, nil, nil, true)

	local isQuality = CurAvatar.achieveQualify[self.achieveId]
	local isGot = CurAvatar.achieveAwardGot[self.achieveId]
	local animName = isGot and "AwardCellReceived" or isQuality and "AwardCellNml" or "AwardCellNotYet"

	self.animPanel:playStateAnimator(animName)
end

function AwardCell:onClickBtnReceive()
	CurAvatar:getAchieveAward(self.achieveId)
end

local RearHousePopularityAwardDlg = Class("RearHousePopularityAwardDlg", UIControls.Window)

function RearHousePopularityAwardDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.loopV = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList", 0, self.onCellChanged)
	self.btnPatch = UIControls.Button(self, "BgPanel/BtnPatch")

	self.btnPatch:addEventClick(self.onClickBtnPatch)

	self.slotOnAchieveGetAward = Slot(self.onAchieveGetAward, self)

	EventCenter.addEventListener(EventConst.ACHIEVE_GET_AWARD, self.slotOnAchieveGetAward)
end

function RearHousePopularityAwardDlg:onOpen()
	RearHousePopularityAwardDlg.super.onOpen(self)

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui and ui:isInShow() then
		self:bindWindow(ui)
	end

	self.initAchieveIdList = ResRearHouseMiscConfig[1].popularity_achieve_id_list
	self.achieveIdNum = self.initAchieveIdList and #self.initAchieveIdList or 0

	self:refreshAwardListShow()
end

function RearHousePopularityAwardDlg:refreshAwardListShow()
	self.achieveIdList = {}

	if self.achieveIdNum > 0 then
		local lastIdx = 0

		for _, achieveId in pairs(self.initAchieveIdList) do
			local isGot = CurAvatar.achieveAwardGot[achieveId]

			if isGot then
				table.insert(self.achieveIdList, achieveId)
			else
				lastIdx = lastIdx + 1

				table.insert(self.achieveIdList, lastIdx, achieveId)
			end
		end
	end

	self.loopV:setTotalCount(self.achieveIdNum)
end

function RearHousePopularityAwardDlg:destroy()
	EventCenter.removeEventListener(EventConst.ACHIEVE_GET_AWARD, self.slotOnAchieveGetAward)
	RearHousePopularityAwardDlg.super.destroy(self)
end

function RearHousePopularityAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = AwardCell(sender, "System/Backyard/BackyardPopularityAwardCell", newIdx, 0, 0)
	else
		targetCell.index = newIdx
	end

	targetCell:setData(self.achieveIdList[newIdx])
end

function RearHousePopularityAwardDlg:onClickBtnClose()
	self:setVisible(false)
end

function RearHousePopularityAwardDlg:onClickBtnPatch()
	UIManager.getUI("handBookTeamPatchDlg", true)
end

function RearHousePopularityAwardDlg:onAchieveGetAward(achieveId)
	self:refreshAwardListShow()
end

return RearHousePopularityAwardDlg
