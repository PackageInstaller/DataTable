-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChooseFriendDlg.lua

local ChooseFirendCell = Class("ChooseFirendCell", UIControls.ScrollViewLoopCell)

function ChooseFirendCell:ctor()
	self:initUI()
end

local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"

function ChooseFirendCell:initUI()
	self.body = UIControls.Button(self, "")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.txtName = UIControls.Label(self, "TextPlayerName")
	self.imgSex = UIControls.Image(self, "TextPlayerName/IconSex")
	self.panelVip = UIControls.PanelPlayerVip(self, "TextPlayerName/VIPPanel")
	self.txtServer = UIControls.Label(self, "TextServer")
	self.imgServer = UIControls.Image(self, "TextServer/IconServer")

	self.body:addEventClick(self.onClick)
end

function ChooseFirendCell:setData(data)
	self.data = data

	self.txtName:setText(data.name)
	self.panelVip:setData(data.vip, data.vip_hide)
	self.btnHead:setCommInfo(data, true, self)
	self.txtServer:setText(string.format(Lang.get(30168), data.serverName or ""))

	if data.gender == Const.GENDER_MAN then
		self.imgSex:setImage(ICON_PATH, "IconMale")
	elseif data.gender == Const.GENDER_WOMAN then
		self.imgSex:setImage(ICON_PATH, "IconFemale")
	end

	if data.sameServer then
		self.imgServer:setImage(ICON_PATH, "IconServerSame")
	else
		self.imgServer:setImage(ICON_PATH, "IconServerElse")
	end

	self.imgServer:setVisible(false)
end

function ChooseFirendCell:onClick(...)
	local ui = UIManager.getUI("chatDlg", nil, false)

	if ui then
		ui:_addFriendTalk(self.data)
	end

	self.mWindow:setVisible(false)
end

local strClassName = "ChooseFriendDlg"
local ChooseFriendDlg = Class(strClassName, UIControls.Window)

function ChooseFriendDlg:ctor()
	self:initUI()
end

function ChooseFriendDlg:initUI(...)
	self.view = UIControls.ScrollViewLoopV(self, "BgPanel/FriendList", 0, self.onCellChanged)
	self.datas = {}
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function ChooseFriendDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ChooseFriendDlg:show(data)
	if CurAvatar.friendList then
		for uid, info in pairs(CurAvatar.friendList) do
			if info then
				table.insert(self.datas, info)
			end
		end
	end

	self:setData()
end

function ChooseFriendDlg:setData()
	self.view:setTotalCount(#self.datas)
end

function ChooseFriendDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChooseFirendCell(sender, "System/Chat/ChooseFriendCell", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.datas[newIdx])
end

return ChooseFriendDlg
