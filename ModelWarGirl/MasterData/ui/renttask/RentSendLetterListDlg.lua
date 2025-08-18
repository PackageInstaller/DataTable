-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentSendLetterListDlg.lua

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
	self.imgRelationship2 = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship2")
	self.btnRead = UIControls.Button(self, "BgPanel/BtnRead")

	self.btnRead:addEventClick(self._onClickRead)

	self.iconNew = UIControls.Image(self, "BgPanel/BtnRead/IconNew")
	self.textBtnRead = UIControls.Label(self, "BgPanel/BtnRead/Text")
	self.gridPlayer = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
end

function TaskLetterCell:_onClickRead()
	local ui = UIManager.createUI("rentTaskLetterInfoDlg", true)

	ui:setLetterType("SELF_SEND")
	ui:setDealedData(self.data)

	if self.data.orgLetter and self.data.orgLetter.isNew then
		self.data.orgLetter.isNew = false

		self:refresh()
		CurAvatar:checkRentNewSendLetterRD()
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

	RentTaskUtils.setRelationImage(self.imgRelationship, d.uid, true, self.imgRelationship2)

	local isNew = d.orgLetter.isNew

	if isNew then
		self.iconNew:setVisible(true)
	else
		self.iconNew:setVisible(false)
	end
end

local strClassName = "RentSendLetterListDlg"
local RentSendLetterListDlg = Class(strClassName, UIControls.Window)

RentSendLetterListDlg.targetCells = {}

function RentSendLetterListDlg:ctor()
	self:initUI()
end

function RentSendLetterListDlg:initUI()
	self.letterPanel = UIControls.Panel(self, "Bg/RecordLetterPanel")
	self.subLetterScroll = UIControls.ScrollViewLoopV(self, "Bg/RecordLetterPanel/LetterList")

	self.subLetterScroll:addEventCellChanged(self.onSubLetterChanged)

	self.nothingPanel = UIControls.Panel(self, "Bg/RecordLetterPanel/NothingPanel")

	self.nothingPanel:setVisible(true)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)
end

function RentSendLetterListDlg:setData()
	self.targetCells = {}
	self.letterSendData = {}

	local o = CurAvatar.rentSendLetters

	for i, l in ipairs(o) do
		self.letterSendData[i] = RentTaskUtils.simpleLetterData(l)
	end
end

function RentSendLetterListDlg:refresh()
	self.nothingPanel:setVisible(#self.letterSendData == 0)
	self.subLetterScroll:setTotalCount(#self.letterSendData)
end

function RentSendLetterListDlg:onPanelOpen()
	if not CurAvatar.isRentSendLetterGetted then
		CurAvatar.isRentSendLetterGetted = true

		RentTaskUtils.getAllSendLetters()
	end

	self:onRentGetSendLetter()
end

function RentSendLetterListDlg:_onClickClose(...)
	self:setVisible(false)
end

function RentSendLetterListDlg:onRentGetSendLetter()
	self:setData()
	self:refresh()
end

function RentSendLetterListDlg:onSubLetterChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = TaskLetterCell(sender, "System/CaseTask/BtnCaseTaskRecordLetter", newIdx, 0, 0)
		targetCell.index = newIdx
		self.targetCells[newIdx] = targetCell
	end

	if self.letterSendData[newIdx] then
		targetCell:refresh(self.letterSendData[newIdx])
	end
end

function RentSendLetterListDlg:onPanelClose()
	for i, cell in ipairs(self.targetCells) do
		if cell.data.orgLetter and cell.data.orgLetter.isNew then
			cell.data.orgLetter.isNew = false
		end
	end

	CurAvatar:checkRentNewSendLetterRD()
end

return RentSendLetterListDlg
