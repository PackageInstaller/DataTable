-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleApplyCell.lua

local ResClanLog = require("ClientData/ResClanLog")
local strClassName = "BtnCircleApplyCell"
local BtnCircleApplyCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnCircleApplyCell:ctor()
	self:initUI()
end

function BtnCircleApplyCell:initUI()
	self.imgIconSex = UIControls.Image(self, "IconSex")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtServer = UIControls.Label(self, "TextServer")
	self.panelVip = UIControls.PanelPlayerVip(self, "TextName/VIPPanel")
	self.txtServer = UIControls.Label(self, "TextServer")
	self.txtLevel = UIControls.Label(self, "TextLV")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.btnIgnore = UIControls.Button(self, "BtnIgnore")

	self.btnIgnore:addEventClick(self.onBtnIgnoreClick)

	self.btnAgree = UIControls.Button(self, "BtnAgree")

	self.btnAgree:addEventClick(self.onBtnAgreeClick)
end

function BtnCircleApplyCell:onBtnIgnoreClick()
	local member = CurAvatar.myCircle:getCircleMember(self.roleData.uid)

	if not member then
		RPC.clanRefuseApply({
			self.roleData.uid
		})
	end

	CurAvatar.myCircle:deleteApply(self.roleData.uid)
	CurAvatar:refreshCircleApplyList()
	MsgManager.clientNotice(216)
end

function BtnCircleApplyCell:onBtnAgreeClick()
	if CurAvatar.myCircle.memberCount >= CurAvatar.myCircle:getCircleMaxMemberCount() then
		MsgManager.clientNotice(217)

		return
	end

	local member = CurAvatar.myCircle:getCircleMember(self.roleData.uid)

	if not member then
		RPC.clanAcceptApply({
			self.roleData.uid
		})
	else
		CurAvatar.myCircle:deleteApply(self.roleData.uid)
		CurAvatar:refreshCircleApplyList()
		MsgManager.notice(Lang.get(30172))
	end
end

function BtnCircleApplyCell:setApplyRoleData(roleData)
	self.roleData = roleData
	self.gridPlayer = UIControls.PlayerHeadGridChild(self, "GridPlayerCommon", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

	self.gridPlayer:hideLevel()
	self.gridPlayer:setEnable(false)
	self.gridPlayer:setCommInfo(self.roleData, false, self)

	self.name, self.serverName = utils.GetPlayerName(self.roleData.name)

	self.txtName:setText(self.name)
	self.txtServer:setText(self.serverName)
	self.panelVip:setData(self.roleData.vip, self.roleData.vip_hide)
	self.txtLevel:setText(string.format(Lang.get(30171), self.roleData.level))

	if self.roleData.gender == Const.GENDER_MAN then
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end
end

function BtnCircleApplyCell:onBtnSelfClick()
	CurAvatar:showPlayerTips(self.roleData.uid, self)
end

return BtnCircleApplyCell
