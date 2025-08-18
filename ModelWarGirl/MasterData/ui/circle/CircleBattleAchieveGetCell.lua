-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleAchieveGetCell.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local strClassName = "CircleBattleAchieveGetCell"
local CircleBattleAchieveGetCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleBattleAchieveGetCell:ctor()
	self:initUI()
end

function CircleBattleAchieveGetCell:initUI()
	self.txtCondition = UIControls.Label(self, "Bg/TextCondition")
	self.txtConditionName = UIControls.Label(self, "Bg/TextConditionName")
	self.sliderProgress = UIControls.Slider(self, "Bg/Slider")
	self.txtNum = UIControls.Label(self, "Bg/TextNum")
	self.txtGotState = UIControls.Panel(self, "Bg/TextState")
	self.panelBg = UIControls.Panel(self, "Bg")
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function CircleBattleAchieveGetCell:onBtnConfirmClick()
	self.btnConfirm:clearEventClick()
	self.btnConfirm:addEventClick(self.onBtnConfirmClick, 2)

	if self.mParent.achieveType == Const.CIRCLE_ACHIEVE_TYPE.CIRCLE then
		CurAvatar:tryCallCircleBattleRpc("clanBattleGetClanAchieveAward", self.achieveCellData.resData.id)
	else
		CurAvatar:tryCallCircleBattleRpc("clanBattleGetMemberAchieveAward", self.achieveCellData.resData.id)
	end
end

function CircleBattleAchieveGetCell:resetBtnCD()
	self.btnConfirm:clearEventClick()
	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function CircleBattleAchieveGetCell:setAchieveCellData(achieveCellData)
	self:resetBtnCD()

	self.achieveCellData = achieveCellData

	self.txtCondition:setText(self.achieveCellData.resData.desc)
	self.txtConditionName:setText(self.achieveCellData.resData.name)

	local showProgress = self.achieveCellData.status ~= Const.ACHIEVE_STATUS.AWARD_GOT and self.achieveCellData.progress or self.achieveCellData.resData.action_param

	self.sliderProgress:setValue(showProgress / self.achieveCellData.resData.action_param)
	self.txtNum:setText(showProgress .. "/" .. self.achieveCellData.resData.action_param)
	self.txtGotState:setVisible(self.achieveCellData.status == Const.ACHIEVE_STATUS.AWARD_GOT)
	self.btnConfirm:setVisible(self.achieveCellData.status == Const.ACHIEVE_STATUS.COMPLETE)

	local scoreItemId = ResClanBattleMisc[1].score_id
	local awawrdScoreItem = BaseObject.GetObject(scoreItemId, self.achieveCellData.resData.score)

	if not self.awardGrid then
		self.awardGrid = UIControls.getGridAwardContainer(self, "Bg/AwardPanel")
	end

	self.awardGrid.mDisableWays = true

	self.awardGrid:setObj(awawrdScoreItem)

	if self.achieveCellData.status == Const.ACHIEVE_STATUS.AWARD_GOT then
		self.awardGrid:setState(false, true)
	else
		self.awardGrid:setState(false, false)
	end

	self.awardGrid:setVisible(true)

	if self.achieveCellData.status == Const.ACHIEVE_STATUS.AWARD_GOT then
		self.panelBg:playStateAnimator("PointGetCellDis")
	elseif self.achieveCellData.status == Const.ACHIEVE_STATUS.IN_PROCESS then
		self.panelBg:playStateAnimator("PointGetCellNml")
	elseif self.achieveCellData.status == Const.ACHIEVE_STATUS.COMPLETE then
		self.panelBg:playStateAnimator("PointGetCellSel")
	end
end

function CircleBattleAchieveGetCell:playFlyAward()
	FlyIconUtils.setFlyUItoUI(self.awardGrid, self.mWindow.btnTabList[1], self.awardGrid.object.id, self.achieveCellData.resData.score)
end

return CircleBattleAchieveGetCell
