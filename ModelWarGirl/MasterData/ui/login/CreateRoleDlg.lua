-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\CreateRoleDlg.lua

local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local strClassName = "CreateRoleDlg"
local CreateRoleDlg = Class(strClassName, UIControls.Window)
local HeadIcon = Class("HeadIcon", UIControls.Panel)

function HeadIcon:ctor(...)
	self:initUI()
end

function HeadIcon:initUI(...)
	self.selectBtn = UIControls.Button(self, self.mPath)

	self.selectBtn:addEventClick(self.select)

	self.icon = UIControls.Image(self, self.mPath .. "/IconHead")
end

function HeadIcon:setHeadInfo(headId, index)
	self.headId = headId
	self.index = index
	self.headPath = UIConst.getPlayerHeadIconPath(headId)

	if self.headPath then
		self.icon:setImage(self.headPath[1], self.headPath[2])
	end
end

function HeadIcon:select()
	self.mParent:onSelectHead(self.headId, self.index)
end

function HeadIcon:setSelected(selected)
	self.selectBtn:setEnable(not selected)
end

function CreateRoleDlg:ctor(...)
	self:initUI()
end

function CreateRoleDlg:initUI(...)
	self.idTxt = UIControls.Label(self, "IdPanel/TextNumber")

	self.idTxt:setText(CurAvatar.shortUid or "")

	self.input = UIControls.Input(self, "PlayerInfoPanel/NamePanel/InputField")

	ClientUtils.checkInputValueChange(self.input)

	self.randomBtn = UIControls.Button(self, "PlayerInfoPanel/NamePanel/BtnRandom")

	self.randomBtn:addEventClick(self._onClickRandomName)

	self.maleBtn = UIControls.Button(self, "PlayerInfoPanel/GenderPanel/BtnMale")

	self.maleBtn:addEventClick(self._onSelectMale)

	self.femaleBtn = UIControls.Button(self, "PlayerInfoPanel/GenderPanel/BtnFemale")

	self.femaleBtn:addEventClick(self._onSelectFemale)

	self.headIcons = {}

	for i = 1, 4 do
		local head = HeadIcon(self, "PlayerInfoPanel/HeadPanel/BtnHead" .. i)
		local headId = UIMiscConfig.ROLE_HEAD_LIST[i]

		if headId then
			head:setVisible(true)
			head:setHeadInfo(headId, i)
		else
			head:setVisible(false)
		end

		self.headIcons[i] = head
	end

	self.addressTxt = UIControls.Label(self, "PlayerInfoPanel/AddressPanel/TextAddress")

	self.addressTxt:setText(SvrListManager.getCurServerName() or Lang.get(30409))

	self.confirmBtn = UIControls.Button(self, "PlayerInfoPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onClickCreateRole)

	self.PanelGender = UIControls.Panel(self, "PlayerInfoPanel/GenderPanel")

	if RegionUtils.isJP() then
		self.PanelGender:setVisible(false)
	end
end

function CreateRoleDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.input, hint)
end

function CreateRoleDlg:onOpen(...)
	CreateRoleDlg.super.onOpen(self)
	self:_onSelectMale()
	self:_onClickRandomName()
	self.headIcons[1]:select()
end

function CreateRoleDlg:setRandomName(name)
	self.input:setText(name)
end

function CreateRoleDlg:_onClickRandomName(...)
	RPC.roleRandName(self.selectedGender)
end

function CreateRoleDlg:_onSelectMale(...)
	self.selectedGender = Const.GENDER_MAN

	self.maleBtn:setEnable(false)
	self.femaleBtn:setEnable(true)
end

function CreateRoleDlg:_onSelectFemale(...)
	self.selectedGender = Const.GENDER_WOMAN

	self.maleBtn:setEnable(true)
	self.femaleBtn:setEnable(false)
end

function CreateRoleDlg:onSelectHead(headId, index)
	self.selectedHeadId = headId

	for i = 1, 4 do
		self.headIcons[i]:setSelected(i == index)
	end
end

function CreateRoleDlg:_onClickCreateRole(...)
	if self.btnLockFlag then
		return
	end

	local name = self.input:getText()
	local failMsg = ClientUtils.checkPlayerName(name)

	if failMsg ~= "" then
		MsgManager.notice(failMsg)

		return
	end

	self.btnLockFlag = true

	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_CREATE_CHAR)
	CurAvatar:sendRoleInfo(name, self.selectedGender, self.selectedHeadId)
end

return CreateRoleDlg
