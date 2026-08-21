-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\EditSexDlg.lua

local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local strClassName = "EditSexDlg"
local EditSexDlg = Class(strClassName, UIControls.Window)
local CD = ResCommonHardCode[38].value[1]

function EditSexDlg:ctor(...)
	self:initUI()
end

function EditSexDlg:initUI(...)
	self.txtTipTime = UIControls.Label(self, "Bg/TextTips/TextTime")
	self.imgSexLeft = UIControls.Image(self, "Bg/IconSex1")
	self.imgSexRight = UIControls.Image(self, "Bg/IconSex2")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function EditSexDlg:setData(commInfo)
	self.commInfo = commInfo

	local pathMan = self:getSexIcon(Const.GENDER_MAN)
	local pathWoman = self:getSexIcon(Const.GENDER_WOMAN)

	if commInfo.gender == Const.GENDER_MAN then
		self.imgSexLeft:setImage(pathMan[1], pathMan[2])

		self.toGender = Const.GENDER_WOMAN

		self.imgSexRight:setImage(pathWoman[1], pathWoman[2])
	else
		self.imgSexLeft:setImage(pathWoman[1], pathWoman[2])

		self.toGender = Const.GENDER_MAN

		self.imgSexRight:setImage(pathMan[1], pathMan[2])
	end

	self.txtTipTime:setText(ClientUtils.CeilToDayOrHour(CD))
end

function EditSexDlg:getSexIcon(gender)
	if gender == Const.GENDER_MAN then
		return {
			"Atlas/PlayerInforAtlas/PlayerInforAtlas",
			"IconMaleBig"
		}
	else
		return {
			"Atlas/PlayerInforAtlas/PlayerInforAtlas",
			"IconFemaleBig"
		}
	end
end

function EditSexDlg:onBtnDenyClick(...)
	self:setVisible(false)
end

function EditSexDlg:onBtnConfirmClick(...)
	self:setVisible(false)
	RPC.roleCommChangeGender()

	self.commInfo.gender = self.toGender
end

return EditSexDlg
