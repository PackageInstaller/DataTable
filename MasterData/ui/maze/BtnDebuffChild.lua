-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\BtnDebuffChild.lua

local ResRelics = require("ClientData/ResRelics")
local BtnDebuffChild = Class("BtnDebuffChild", UIControls.Child)

function BtnDebuffChild:ctor(...)
	self:initUI()

	self.mClickEvent = nil
end

function BtnDebuffChild:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.imgIcon = UIControls.Image(self, "IconDebuff")
	self.imgBg = UIControls.Image(self, "Bg")
end

function BtnDebuffChild:setData(hallowId)
	local resRelic = ResRelics[hallowId]

	self.imgIcon:setImage(resRelic.relic_icon_path, resRelic.relic_icon_name)

	self.relicData = resRelic
end

function BtnDebuffChild:hideBg()
	self.imgBg:setVisible(false)
end

function BtnDebuffChild:onBtnSensorClick(...)
	if self.mClickEvent ~= nil then
		self.mClickEvent(self, ...)
	end
end

return BtnDebuffChild
