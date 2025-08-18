-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FigureGuess\\ActivityFigureGuessConfirmDlg.lua

local ResOpActivityGuessAward = require("ClientData/ResOpActivityGuessAward")
local ActivityFigureGuessTools = require("UI/OpActivity/FigureGuess/ActivityFigureGuessTools")
local ChooseNode = Class("ChooseNode", UIControls.Child)

function ChooseNode:ctor()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClickBtn)

	self.txtTitle = UIControls.Label(self, "BgTextTitle/TextTitle")
	self.imgRightIcon = UIControls.Image(self, "GuessRightPanel/Icon")
	self.txtRightNum = UIControls.Label(self, "GuessRightPanel/TextNum")
	self.imgWrongIcon = UIControls.Image(self, "GuessWrongtPanel/Icon")
	self.txtWrongNum = UIControls.Label(self, "GuessWrongtPanel/TextNum")
end

function ChooseNode:setData(config, strTitle, awardId)
	self.txtTitle:setText(strTitle)
	self.txtRightNum:setText(config.win_award)
	self.txtWrongNum:setText(config.loss_award)

	local obj = BaseObject.GetObject(awardId)
	local iconPath = obj:getIconPath()

	self.imgRightIcon:setImage(iconPath[1], iconPath[2])
	self.imgWrongIcon:setImage(iconPath[1], iconPath[2])
end

function ChooseNode:setSelect(value)
	self.btn:setEnable(not value)
end

function ChooseNode:onClickBtn()
	if self.clickAction then
		self.clickAction(self.idx)
	end
end

local ActivityFigureGuessConfirmDlg = Class("ActivityFigureGuessConfirmDlg", UIControls.Window)

function ActivityFigureGuessConfirmDlg:ctor()
	self.btnCancel = UIControls.Button(self, "BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.nodeList = {}

	for i = 1, 3 do
		local node = ChooseNode(self, "Bg/ContentPanel", "System/Activity/ActivityFigureGuess/BtnGuessBet")

		node.idx = i
		node.clickAction = Slot(self.onClickNode, self)

		table.insert(self.nodeList, node)
	end

	self.strTitleList = {
		Lang.get(76045),
		Lang.get(76046),
		Lang.get(76047)
	}
end

function ActivityFigureGuessConfirmDlg:onOpen()
	ActivityFigureGuessConfirmDlg.super.onOpen(self)

	self.curNodeIdx = 1
end

function ActivityFigureGuessConfirmDlg:setData(actObj, stageId, answerId)
	self.actObj = actObj
	self.actData = self.actObj.actData
	self.actId = self.actObj.actId
	self.opId = self.actObj.opId
	self.stageId = stageId
	self.answerId = answerId

	self:refreshView()
end

function ActivityFigureGuessConfirmDlg:refreshView()
	local configList = ResOpActivityGuessAward[1]
	local configNum = configList and #configList or 0

	for i = 1, 3 do
		local checkShow = i <= configNum
		local node = self.nodeList[i]

		node:setVisible(checkShow)

		if checkShow then
			node:setData(configList[i], self.strTitleList[i], self.actData.awardId)
			node:setSelect(i == self.curNodeIdx)
		end
	end
end

function ActivityFigureGuessConfirmDlg:onClickNode(idx)
	if idx == self.curNodeIdx then
		return
	end

	if self.curNodeIdx then
		self.nodeList[self.curNodeIdx]:setSelect(false)
	end

	self.curNodeIdx = idx

	self.nodeList[self.curNodeIdx]:setSelect(true)
end

function ActivityFigureGuessConfirmDlg:onClickConfirm()
	if not ActivityFigureGuessTools.checkActivityOpen(self.actId) then
		return
	end

	RPC.opActGuessChooseAnswer(self.opId, self.stageId, self.answerId, self.curNodeIdx)
	self:setVisible(false)
end

function ActivityFigureGuessConfirmDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ActivityFigureGuessConfirmDlg
