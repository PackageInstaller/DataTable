-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginNoticeDlg.lua

local strClassName = "LoginNoticeDlg"
local LoginNoticeDlg = Class(strClassName, UIControls.Window)

function LoginNoticeDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onDlgClose)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.txtTitle = UIControls.Label(self, "BgPanel/NoticeList/Content/TextTitle")
	self.txtContent = UIControls.Label(self, "BgPanel/NoticeList/Content/TextContent")
end

function LoginNoticeDlg:show()
	local state = GameFsm.getState(Const.STATE_LOGIN)
	local info = state.mNoticeInfo

	if info == nil then
		state:checkLoginNotice()

		return
	end

	self.txtTitle:setText(info.title or "")
	self.txtContent:setText(info.content or "")

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function LoginNoticeDlg:showCustom(title, content)
	self.txtTitle:setText(title or "")
	self.txtContent:setText(content or "")

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function LoginNoticeDlg:onConfirmClick(sender)
	self:setVisible(false)
end

function LoginNoticeDlg:onDlgClose(sender)
	self:setVisible(false)
end

return LoginNoticeDlg
