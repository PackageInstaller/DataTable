-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginCgDlg.lua

local ResLoginCgConfig = require("ClientData/ResLoginCgConfig")
local LoginCgCell = Class("LoginCgCell", UIControls.Child)

function LoginCgCell:ctor()
	self.btnPlay = UIControls.Button(self, "BtnPlay")

	self.btnPlay:addEventClick(self.onPlayClick)

	self.imgBg = UIControls.RawImage(self, "CGImage")
	self.textTitle = UIControls.Label(self, "TitleText")
	self.panelNew = UIControls.Panel(self, "IconNew")
end

function LoginCgCell:setData(cgConfig, isNewest)
	self.cgConfig = cgConfig

	self.panelNew:setVisible(isNewest)

	if cgConfig.cg_icon then
		self.imgBg:setImage(cgConfig.cg_icon)
	end

	self.textTitle:setText(cgConfig.cg_name or "")
end

function LoginCgCell:onPlayClick()
	if self.cgConfig and self.cgConfig.cg_path then
		UIManager.playLoginCG(Slot(self.onMovieOver, self), "Videos/" .. self.cgConfig.cg_path)
		self.mParent:setVisible(false, false)
	end
end

function LoginCgCell:onMovieOver()
	self.mParent:setVisible(true)
end

local strClassName = "LoginCgDlg"
local LoginCgDlg = Class(strClassName, UIControls.Window)

function LoginCgDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.cgCells = {}
end

function LoginCgDlg:onCloseClick(time)
	self:setVisible(false)
end

function LoginCgDlg:onOpen()
	LoginCgDlg.super.onOpen(self)

	self.showData = {}

	for index, info in ipairs(ResLoginCgConfig) do
		if info.time_valid_id == nil or ClientUtils.isTimeConfigPassed(info.time_valid_id) then
			table.insert(self.showData, info)
		end
	end

	for index = #self.cgCells + 1, #self.showData do
		local newCell = LoginCgCell(self, "BgPanel/CGPlayList/Viewport/CGPlayList", "System/Login/PlayerBackItem")

		table.insert(self.cgCells, newCell)
	end

	local maxShowNum = #self.showData

	for index, cell in ipairs(self.cgCells) do
		if self.showData[index] then
			cell:setVisible(true)
			cell:setData(self.showData[maxShowNum - index + 1], index == 1)
		else
			cell:setVisible(false)
		end
	end
end

return LoginCgDlg
