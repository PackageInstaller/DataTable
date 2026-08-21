-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\FlowSDK\\FlowLoginNotice.lua

local UIConst = UIConst
local strClassName = "FlowLoginNotice"
local FlowLoginNotice = Class(strClassName, UIControls.Window)

function FlowLoginNotice:ctor()
	self:initUI()
end

function FlowLoginNotice:onOpen()
	FlowLoginNotice.super.onOpen(self)
	self:setVisible(false)
end

function FlowLoginNotice:initUI()
	self.labelAccount = UIControls.Label(self, "LoginNotice/TextAccount")
	self.imgAccount = UIControls.Image(self, "LoginNotice/TextAccount/IconAccount")
end

function FlowLoginNotice:setData(isMobile, name)
	if name then
		self.labelAccount:setText(string.format(Lang.get(30302), name))
	end

	self.imgAccount:setImage("Atlas/LoginAtlas/LoginAtlas", isMobile and "IconMobile" or "IconVisitor")
end

return FlowLoginNotice
