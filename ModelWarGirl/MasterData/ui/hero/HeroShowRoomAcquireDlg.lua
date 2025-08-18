-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomAcquireDlg.lua

local strClassName = "HeroShowRoomAcquireDlg"
local HeroShowRoomAcquireDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomAcquireDlg:ctor()
	self:initUI()
end

function HeroShowRoomAcquireDlg:initUI()
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.iconLoveBook = UIControls.Image(self, "BgPanel/IconLoveBook")
	self.iconStandingSign = UIControls.Image(self, "BgPanel/IconStandingSign")
	self.textLoveBook = UIControls.Label(self, "BgPanel/BgTextDes/TextLoveBook")
	self.textStandingSign = UIControls.Label(self, "BgPanel/BgTextDes/TextStandingSign")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnCloseClick)
end

function HeroShowRoomAcquireDlg:setAcquireData(isAvg, paths)
	if isAvg then
		self.textTitle:setText(Lang.get(66394))
		self.iconLoveBook:setVisible(true)
		self.iconLoveBook:setImage(paths[1], paths[2])
		self.iconStandingSign:setVisible(false)
	else
		self.textTitle:setText(Lang.get(63937))
		self.iconStandingSign:setImage(paths[1], paths[2])
		self.iconStandingSign:setVisible(true)
		self.textStandingSign:setVisible(true)
		self.textLoveBook:setVisible(false)
	end
end

function HeroShowRoomAcquireDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroShowRoomAcquireDlg
