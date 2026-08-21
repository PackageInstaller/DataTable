-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentLetterListPanel.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local TaskLetterCell = Class("TaskLetterCell", UIControls.ScrollViewLoopCell)

TaskLetterCell.data = {}

function TaskLetterCell:ctor(...)
	self:initUI()
end

function TaskLetterCell:initUI()
	self.textPlayerName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.textServer = UIControls.Label(self, "BgPanel/TextServer")
	self.friendGiftPanel = UIControls.Panel(self, "BgPanel/FriendGiftPanel")
	self.textFriendGift = UIControls.Label(self, "BgPanel/FriendGiftPanel/TextNum")
	self.imgFriendGift = UIControls.Image(self, "BgPanel/FriendGiftPanel/Icon")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.imgRelationship = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship")
	self.btnRead = UIControls.Button(self, "BgPanel/BtnRead")

	self.btnRead:addEventClick(self._onClickRead)

	self.iconNew = UIControls.Image(self, "BgPanel/BtnRead/IconNew")
	self.textBtnRead = UIControls.Label(self, "BgPanel/BtnRead/Text")
	self.imgNewBtnRead = UIControls.Image(self, "BgPanel/BtnRead/IconNew")
	self.gridPlayer = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
end

function TaskLetterCell:_onClickRead()
	local ui = UIManager.createUI("rentTaskLetterInfoDlg", true)

	ui:setDealedData(self.data)

	if self.data.orgLetter and self.data.orgLetter.isNew then
		self.data.orgLetter.isNew = false

		self:refresh()
		CurAvatar:checkRentNewLetterRD()
	end
end

function TaskLetterCell:refresh(data)
	if data then
		self.data = data
	end

	local d = self.data
	local playerName, serverName, serverID = utils.GetPlayerName(d.playerName)

	self.textPlayerName:setText(playerName)
	self.textServer:setText(d.serverName)
	self.gridPlayer:setCommInfo(d.comm, false, self)

	if d.award and d.award <= 0 then
		self.textFriendGift:setVisible(false)
		self.imgFriendGift:setVisible(false)
	else
		self.textFriendGift:setVisible(true)
		self.imgFriendGift:setVisible(true)
		self.textFriendGift:setText(d.award)
	end

	if d.gender == 1 then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	end

	if d.award == 0 then
		self.friendGiftPanel:setVisible(false)
	else
		self.friendGiftPanel:setVisible(true)
		self.textFriendGift:setText(d.award)
	end

	RentTaskUtils.setRelationImage(self.imgRelationship, d.uid)

	local isNew = d.orgLetter.isNew

	if isNew then
		self.iconNew:setVisible(true)
	else
		self.iconNew:setVisible(false)
	end
end

local strClassName = "RentLetterListPanel"
local RentLetterListPanel = Class(strClassName, UIControls.Panel)

RentLetterListPanel.targetCells = {}

function RentLetterListPanel:ctor()
	self:initUI()
end

function RentLetterListPanel:initUI()
	self.letterPanel = UIControls.Panel(self, self.mPath)
	self.subLetterScroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/LetterList", 0, self.onSubLetterChanged)
	self.btnNewWin = UIControls.Button(self, self.mPath .. "/BtnNewWin")

	self.btnNewWin:addEventClick(self.onClickNoticeWin)

	self.imgBtnNewWin = UIControls.Image(self, self.mPath .. "/BtnNewWin/Img")

	if CurAvatar.rentLetterNoticeOn then
		self.imgBtnNewWin:playAnimator("BtnSwitchSetOn")
	else
		self.imgBtnNewWin:playAnimator("BtnSwitchSetOff")
	end

	self.helpCountTxt = UIControls.Label(self, self.mPath .. "/CaseTaskNum/TextNum")
	self.nothingPanel = UIControls.Panel(self, self.mPath .. "/NothingPanel")

	self.nothingPanel:setVisible(true)
end

function RentLetterListPanel:setData()
	self.targetCells = {}
	self.letterData = {}

	local o = CurAvatar.rentLetters

	for i, l in ipairs(o) do
		self.letterData[i] = RentTaskUtils.simpleLetterData(l)
	end
end

function RentLetterListPanel:refresh()
	self.nothingPanel:setVisible(#self.letterData == 0)
	self.subLetterScroll:setTotalCount(#self.letterData)

	if CurAvatar.rentLetterNoticeOn then
		self.imgBtnNewWin:playAnimator("BtnSwitchSetOn")
	else
		self.imgBtnNewWin:playAnimator("BtnSwitchSetOff")
	end

	self.helpCountTxt:setText(RentTaskUtils.getTotalHelpCount() or "0")
end

function RentLetterListPanel:onClickNoticeWin()
	local isOn = not CurAvatar.rentLetterNoticeOn

	CurAvatar:setShowLetterNotice(isOn)

	if isOn then
		MsgManager.notice(Lang.get(30725))
		self.imgBtnNewWin:playAnimator("BtnSwitchOn")
	else
		MsgManager.notice(Lang.get(30726))
		self.imgBtnNewWin:playAnimator("BtnSwitchOff")
	end
end

function RentLetterListPanel:onPanelOpen()
	if not CurAvatar.isRentLetterGetted then
		CurAvatar.isRentLetterGetted = true

		RentTaskUtils:getAllLetters()
		self.helpCountTxt:setText(RentTaskUtils.getTotalHelpCount() or "0")
	elseif not self.letterData then
		self:onRentGetLetter()
	else
		self:refresh()
	end
end

function RentLetterListPanel:onRentGetLetter()
	self:setData()
	self:refresh()
end

function RentLetterListPanel:onSubLetterChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = TaskLetterCell(sender, "System/CaseTask/BtnCaseTaskLetter", newIdx, 0, 0)
	else
		self.targetCells[targetCell.mIndex] = nil
	end

	targetCell.mIndex = newIdx
	self.targetCells[newIdx] = targetCell

	if self.letterData[newIdx] then
		targetCell:refresh(self.letterData[newIdx])
	end
end

function RentLetterListPanel:onPanelClose()
	for i, cell in ipairs(self.targetCells) do
		if cell.data.orgLetter and cell.data.orgLetter.isNew then
			cell.data.orgLetter.isNew = false
		end
	end

	CurAvatar:checkRentNewLetterRD()
end

return RentLetterListPanel
