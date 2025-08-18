-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Friend\\FriendAddDlg.lua

local OtherPlayer = require("Common/Object/OtherPlayer")
local UIControls = UIControls
local FriendRecommendHeadCell = Class("FriendRecommendHeadCell", UIControls.ScrollViewLoopCell)

function FriendRecommendHeadCell:ctor()
	self:initUI()
end

function FriendRecommendHeadCell:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.panelVip = UIControls.PanelPlayerVip(self, "BgPanel/TextPlayerName/VIPPanel")
	self.textServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.bgPlayer = UIControls.Image(self, "BgPanel/BgPlayer")
	self.btnRequest = UIControls.Button(self, "BgPanel/BtnRequest")

	self.btnRequest:addEventClick(self.onRequestClick)

	self.imgDone = UIControls.Image(self, "BgPanel/IconRequestDone")
	self.btnDel = UIControls.Button(self, "BgPanel/BtnDel")

	self.btnDel:setVisible(false)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)
end

function FriendRecommendHeadCell:onSensorClick()
	CurAvatar:showPlayerTips(self.otherPlayer.uid, self)
end

function FriendRecommendHeadCell:onRequestClick()
	local sucess = CurAvatar:addFriend(self.otherPlayer.uid)

	if sucess then
		self.btnRequest:setVisible(false)
		self.imgDone:setVisible(true)
	end
end

function FriendRecommendHeadCell:setData(otherPlayer)
	self.otherPlayer = otherPlayer

	self.textName:setText(otherPlayer.name)
	self.panelVip:setData(otherPlayer.vip, otherPlayer.vip_hide)

	if otherPlayer.gender == Const.GENDER_MAN then
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerMale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerFemale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.textServer:setText(otherPlayer.serverName or "")

	if otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.btnHead:setPlayer(otherPlayer, true, self)
	self.btnRequest:setVisible(true)
	self.imgDone:setVisible(false)
end

local MODE_RECOMMEND = 1
local MODE_SEARCH = 2
local strClassName = "FriendAddDlg"
local FriendAddDlg = Class(strClassName, UIControls.Window)

function FriendAddDlg:ctor()
	self:initUI()
end

function FriendAddDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.inputContent = UIControls.Input(self, "BgPanel/SearchPanel/InputText")

	self.inputContent:addEventValueChanged(self.onInputChanged)

	self.btnContentClear = UIControls.Button(self, "BgPanel/SearchPanel/BtnDel")

	self.btnContentClear:addEventClick(self.onContentClearClick)

	self.btnSearch = UIControls.Button(self, "BgPanel/SearchPanel/BtnSearch")

	self.btnSearch:addEventClick(self.onSearchClick)

	self.btnChange = UIControls.Button(self, "BgPanel/SearchPanel/BtnChange")

	self.btnChange:addEventClick(self.onChangeClick)

	self.textEmpty = UIControls.Panel(self, "BgPanel/TextEmpty")
	self.cells = {}
	self.scrollFriendList = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerList")

	self.scrollFriendList:addEventCellChanged(self.onFriendListChanged)
end

function FriendAddDlg:onOpen()
	FriendAddDlg.super.onOpen(self)
	RPC.buddyRecommend()

	self.preRecommendTime = Time.time
end

function FriendAddDlg:showRecommendResult(recommendList)
	self.recommendList = recommendList

	self:_showRecommendList()
end

function FriendAddDlg:showSearchResult(result, resultCode)
	if resultCode == "kBuddySearchCodeNameError" then
		self.scrollFriendList:setVisible(false)
		self.textEmpty:setVisible(true)
	elseif result then
		self.scrollFriendList:setVisible(true)
		self.textEmpty:setVisible(false)

		self.searchFriends = {}

		for _, one in ipairs(result) do
			local newFriend = OtherPlayer()

			newFriend:initFriendData(one.base)
			table.insert(self.searchFriends, newFriend)
		end

		self.mode = MODE_SEARCH

		self.scrollFriendList:setTotalCount(#self.searchFriends, 1)
	end
end

function FriendAddDlg:_showRecommendList()
	if self.recommendList then
		self.scrollFriendList:setVisible(true)
		self.textEmpty:setVisible(false)

		self.mode = MODE_RECOMMEND

		self.scrollFriendList:setTotalCount(#self.recommendList, 1)
	end
end

function FriendAddDlg:onFriendListChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = FriendRecommendHeadCell(sender, "System/Friend/BtnFriendCellS", newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	if self.mode == MODE_RECOMMEND then
		targetCell:setData(self.recommendList[newIdx])
	else
		targetCell:setData(self.searchFriends[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function FriendAddDlg:onCloseClick()
	self:setVisible(false)
end

function FriendAddDlg:onInputChanged()
	local text = self.inputContent:getText()

	if text == "" then
		self.btnContentClear:setVisible(false)
		self.btnSearch:setEnable(false)
	else
		self.btnContentClear:setVisible(true)
		self.btnSearch:setEnable(true)
	end
end

function FriendAddDlg:onContentClearClick()
	self.inputContent:setText("")
	self:_showRecommendList()
end

function FriendAddDlg:onSearchClick()
	if self.preSearchTime and Time.time - self.preSearchTime < 5 then
		MsgManager.notice(Lang.get(3402))

		return
	end

	self.preSearchTime = Time.time

	local searchName = self.inputContent:getText()

	if tonumber(searchName) then
		RPC.buddySearch("kBuddySearchTypeObjGID", "", searchName)
	else
		local failedMsg = ClientUtils.checkPlayerName(searchName)
		local serverInfo = SvrListManager.getSelectedSvrInfo()

		if failedMsg == "" then
			RPC.buddySearch("kBuddySearchTypeName", serverInfo.id .. "-" .. searchName)
		else
			MsgManager.notice(string.format(Lang.get(30474), failedMsg))
		end
	end
end

function FriendAddDlg:onChangeClick()
	if self.preRecommendTime and Time.time - self.preRecommendTime < 5 then
		MsgManager.notice(Lang.get(30475))
	else
		RPC.buddyRecommend()

		self.preRecommendTime = Time.time
	end
end

return FriendAddDlg
