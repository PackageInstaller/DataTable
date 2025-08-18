-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Signet\\SignetCellMixin.lua

local ResSignet = require("ClientData/ResSignet")
local SignetCellMixin = {}

function SignetCellMixin:ctorMixin()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClickBtn)

	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtName = UIControls.Label(self, "TextName")
	self.selectPanel = UIControls.Panel(self, "ImgSel")
	self.noHavePanel = UIControls.Panel(self, "ImgDis")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.efxNew = UIControls.Panel(self, "EfxNew")
end

function SignetCellMixin:init(clickCb)
	self.clickCb = clickCb
end

function SignetCellMixin:setData(signetId, signetData)
	self.signetId = signetId
	self.signetData = signetData

	local config = ResSignet[signetId]

	self.group = config.group

	self.txtName:setText(config.name)

	if config.big_icon then
		self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/" .. config.big_icon_path, config.big_icon)
	end

	local checkHaveData = self.signetData ~= nil

	self.noHavePanel:setVisible(not checkHaveData)
end

function SignetCellMixin:setSelect(value)
	self.selectPanel:setVisible(value)
end

function SignetCellMixin:setRedDot(value)
	self.imgNew:setVisible(value)
end

function SignetCellMixin:setEfxNew(value)
	self.efxNew:setVisible(value)
end

function SignetCellMixin:onClickBtn()
	if self.clickCb then
		self.clickCb(self)
	end
end

return SignetCellMixin
