-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\DebuffGrid.lua

local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local strClassName = "DebuffGrid"
local DebuffGrid = Class(strClassName, UIControls.Child)

function DebuffGrid:ctor(...)
	self:initUI()
end

function DebuffGrid:initUI()
	self.iconDeBuff = UIControls.Image(self, "BgHead/IconDeBuff")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function DebuffGrid:setData(buffId)
	self.buffId = buffId

	if ResNewMazeDeBuff[buffId] then
		self.iconDeBuff:setImage(ResNewMazeDeBuff[buffId].icon_path, ResNewMazeDeBuff[buffId].icon_name)
	end
end

function DebuffGrid:setClickCallBack(clickFunc)
	self.clickFunc = clickFunc
end

function DebuffGrid:onBtnSelfClick()
	if self.clickFunc then
		self:clickFunc(self)
	end
end

return DebuffGrid
