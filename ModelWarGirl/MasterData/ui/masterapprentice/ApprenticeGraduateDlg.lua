-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\ApprenticeGraduateDlg.lua

local ResClientNotice = require("ClientData/ResClientNotice")
local ApprenticeGraduateDlg = Class("ApprenticeGraduateDlg", UIControls.Window)

function ApprenticeGraduateDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose1")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnGraduate = UIControls.Button(self, "BtnClose")

	self.btnGraduate:addEventClick(self.onClickBtnGraduate)

	self.txtName = UIControls.Label(self, "BgPanel/TextName")
	self.headCell = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtAchiList = {}

	for i = 1, 3 do
		local txt = UIControls.Label(self, "BgPanel/AchiPanel" .. i .. "/Text")

		table.insert(self.txtAchiList, txt)
	end
end

function ApprenticeGraduateDlg:onOpen()
	ApprenticeGraduateDlg.super.onOpen(self)
	CurAvatar:clearApprenticeGraduateRed()

	local otherPlayer = CurAvatar.master

	self.headCell:setPlayer(otherPlayer, true, self)
	self.txtName:setText(otherPlayer.name)

	local day = (ClientUtils.getServerTime() - otherPlayer.time) / 86400

	self.txtAchiList[1]:setText(string.format(ResClientNotice[794].notice, day))
	self.txtAchiList[2]:setText(string.format(ResClientNotice[795].notice, otherPlayer.guideNum))
	self.txtAchiList[3]:setText(string.format(ResClientNotice[796].notice, otherPlayer.rentNum))
end

function ApprenticeGraduateDlg:onClickBtnGraduate()
	RPC.masterApprenticeGraduation(CurAvatar.master.uid)
end

function ApprenticeGraduateDlg:onClickBtnClose()
	self:setVisible(false)
end

return ApprenticeGraduateDlg
