-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleBoxDlg.lua

local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local strClassName = "CircleBattleBoxDlg"
local CircleBattleBoxDlg = Class(strClassName, UIControls.Window)

function CircleBattleBoxDlg:ctor(...)
	self:intUI()
end

function CircleBattleBoxDlg:intUI(...)
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgBox = UIControls.Image(self, "BgPanel/ImgIcon")
	self.awardCells = {}

	for i = 1, 2 do
		local newGrid = UIControls.getGridAwardContainer(self, "BgPanel/AwardList")

		newGrid:setVisible(true)
		table.insert(self.awardCells, newGrid)
	end
end

function CircleBattleBoxDlg:setData(callBack)
	self.callBack = callBack

	if CurAvatar.myCircle then
		local score = CurAvatar.myCircle:getBoxShareScore()
		local contribution = CurAvatar.myCircle:getBoxShareContribution()

		self.scoreItem = BaseObject.GetObject(ResClanBattleMisc[1].score_id, score)
		self.contributionItem = BaseObject.GetObject(ResClanBattleMisc[1].contribution_id, contribution)

		self.awardCells[1]:setObj(self.scoreItem)
		self.awardCells[2]:setObj(self.contributionItem)
	end
end

function CircleBattleBoxDlg:onBtnConfirmClick(...)
	self:setVisible(false)
end

function CircleBattleBoxDlg:destroy(...)
	CircleBattleBoxDlg.super.destroy(self)

	if self.callBack then
		self.callBack()
	end

	self:flyToEnd()
end

function CircleBattleBoxDlg:flyToEnd(...)
	local ui = UIManager.tryGetUI("circleBattleMainDlg")

	if not ui then
		return
	end

	FlyIconUtils.setFlyUItoUI(self.awardCells[1], ui:getScoreUI(), self.scoreItem.id)
end

return CircleBattleBoxDlg
