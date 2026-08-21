-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridBattleBuffMixin.lua

local ResBattleStateShow = require("ClientData/ResBattleStateShow")
local GridBattleBuffMixin = {}

function GridBattleBuffMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mEventClick = nil
end

function GridBattleBuffMixin:initUI()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onGridClick)

	self.imgBuff = UIControls.Image(self, "IconBuff")
	self.panelBuffTips = UIControls.Panel(self, "BuffTipsPanel")
	self.btnHideSensor = UIControls.Button(self, "BuffTipsPanel/UIClickThrough")

	self.btnHideSensor:addEventClick(self.onHideTips)

	self.textBuffName = UIControls.Label(self, "BuffTipsPanel/BuffTipsInfoPanel/TextTitle")
	self.textBuffDesc = UIControls.Label(self, "BuffTipsPanel/BuffTipsInfoPanel/TextDes")
end

function GridBattleBuffMixin:setObj(buffId)
	self.buffId = buffId

	if ResBattleStateShow[buffId] == nil then
		self:clear()

		return
	end

	self:_setObj(ResBattleStateShow[buffId])
end

function GridBattleBuffMixin:_setObj(buffData)
	self.imgBuff:setImage(buffData.icon_path, buffData.icon)
	self.textBuffName:setText(buffData.name or "")
	self.textBuffDesc:setText(buffData.desc or "")
end

function GridBattleBuffMixin:clear()
	self.buffId = nil

	self.panelBuffTips:setVisible(false)
end

function GridBattleBuffMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	else
		self:openTipsPanel()
	end
end

function GridBattleBuffMixin:openTipsPanel()
	if self.mEnableTips then
		self.panelBuffTips:setVisible(true)
	end
end

function GridBattleBuffMixin:onHideTips()
	self.panelBuffTips:setVisible(false)
end

return GridBattleBuffMixin
