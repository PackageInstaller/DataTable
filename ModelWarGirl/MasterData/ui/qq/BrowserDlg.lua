-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\QQ\\BrowserDlg.lua

local strClassName = "BrowserDlg"
local BrowserDlg = Class(strClassName, UIControls.Window)

function BrowserDlg:ctor()
	self:initUI()

	self._url = nil
end

function BrowserDlg:initUI()
	self.browser = UIControls.Browser(self, "BgPanel/BrowserContent")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)
end

function BrowserDlg:onShow(url)
	self._url = url

	self.browser:openUrl(url)
end

function BrowserDlg:onClickClose()
	self:setVisible(false)
end

function BrowserDlg:getUrl()
	return self._url
end

return BrowserDlg
