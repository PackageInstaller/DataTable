-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleMemberMixin.lua

local ResColor = require("ClientData/ResColor")
local BtnCircleMemberMixin = {}

function BtnCircleMemberMixin:ctorMixin()
	self:initUI()
end

function BtnCircleMemberMixin:initUI()
	self.basePath = ""

	if self.mPath then
		self.basePath = self.mPath .. "/"
	end

	self.btnSelf = UIControls.Button(self, self.basePath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgIconSex = UIControls.Image(self, self.basePath .. "IconSex")
	self.txtName = UIControls.Label(self, self.basePath .. "TextName")
	self.txtServer = UIControls.Label(self, self.basePath .. "TextServer")
	self.txtTime = UIControls.Label(self, self.basePath .. "TextTime")
	self.imgIconJob = UIControls.Image(self, self.basePath .. "BtnJob/IconJob")
	self.txtJob = UIControls.Label(self, self.basePath .. "BtnJob/TextJob")
	self.panelVip = UIControls.PanelPlayerVip(self, self.basePath .. "TextName/VIPPanel")
end

function BtnCircleMemberMixin:setMemberBaseData(memberInfo)
	self.member = memberInfo

	self:refreshBaseInfo()
end

function BtnCircleMemberMixin:setMemberData(memberInfo)
	self.member = memberInfo

	self:refreshBaseInfo()
	self:refreshDetailInfo()
end

function BtnCircleMemberMixin:refreshBaseInfo()
	if not self.member then
		return
	end

	if self.member.online == 1 then
		self.txtTime:setText(Lang.get(841))
	else
		self.txtTime:setText(ClientUtils.timeFormat4CircleRecord(ClientUtils.getServerTime() - self.member.logout_time))
	end

	self.txtLv = UIControls.Label(self, self.basePath .. "TextLV")

	self.txtLv:setText(string.format(Lang.get(30171), self.member.base.level))

	if not self.gridPlayer then
		self.gridPlayer = UIControls.PlayerHeadGridChild(self, self.basePath .. "GridPlayerCommon", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

		self.gridPlayer:hideLevel()
	end

	self.gridPlayer:setCommInfo(self.member.base, false, self)

	self.name, self.serverName = utils.GetPlayerName(self.member.base.name)

	self.panelVip:setData(self.member.base.vip, self.member.base.vip_hide)
	self.txtName:setText(self.name)
	self.txtServer:setText(string.format(Lang.get(30168), self.serverName))

	if self.member.base.gender == Const.GENDER_MAN then
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	local dutyPath = CurAvatar:getDutySpritePath(self.member.duty)

	if dutyPath then
		self.imgIconJob:setImage(dutyPath[1], dutyPath[2])
		self.imgIconJob:setVisible(true)
		self.txtJob:setVisible(true)

		if self.member.duty == Const.CIRCLE_DUTY_MANAGER then
			self.txtJob:setColorByRGBA(0.7333333333333333, 0.4666666666666667, 0.3176470588235294)
		else
			self.txtJob:setFontColor(CurAvatar:getDutyNameColor(self.member.duty))
		end

		self.txtJob:setText(CurAvatar:getDutyName(self.member.duty))
	else
		self.txtJob:setVisible(false)
		self.imgIconJob:setVisible(false)
	end
end

function BtnCircleMemberMixin:refreshDetailInfo()
	self.btnManager = UIControls.Button(self, self.basePath .. "BtnListType")

	local canKick, canFire, canAppoint = CurAvatar:getManageMemberPermission(self.member.duty)

	self.btnManager:addEventClick(self.onBtnManagerClick)
	self.btnManager:setVisible((canKick or canFire or canAppoint) and self.member.base.uid ~= CurAvatar.uid and self.member.duty < CurAvatar.circleRoleData.duty)

	self.txtActive = UIControls.Label(self, self.basePath .. "BtnActive/Text")

	self.txtActive:setText(self.member.weekfeat)

	self.btnOpenJobTips = UIControls.Button(self, self.basePath .. "BtnJob")

	self.btnOpenJobTips:addEventClick(self.onBtnOpenJobTipsClick)

	self.btnOpenActiveTips = UIControls.Button(self, self.basePath .. "BtnActive")

	self.btnOpenActiveTips:addEventClick(self.onBtnOpenActiveTipsClick)

	self.imgIconActive = UIControls.Image(self, self.basePath .. "BtnActive/IconActive")

	local dutyPath = CurAvatar:getDutySpritePath(self.member.duty)

	self.btnOpenJobTips:setVisible(dutyPath ~= nil)
end

function BtnCircleMemberMixin:onBtnOpenActiveTipsClick()
	self.mWindow:openTipsActivePanel(self.imgIconActive)
end

function BtnCircleMemberMixin:onBtnOpenJobTipsClick()
	self.mWindow:openTipsJobPanel(self, self.member.duty)
end

function BtnCircleMemberMixin:onBtnManagerClick()
	self.mWindow:openManageMember(self.member, self.btnManager)
end

function BtnCircleMemberMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnCircleMemberMixin:onBtnSelfClick()
	if self.member and self.selectCallback then
		self.selectCallback(self.member.base.uid)
	end
end

return BtnCircleMemberMixin
