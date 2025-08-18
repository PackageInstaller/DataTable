-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\MultiHeroScrollCell.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")
local MultiHeroScrollCell = Class("MultiHeroScrollCell", UIControls.HeroCardLoop)

function MultiHeroScrollCell:ctor()
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnGet(self.onDragGet)
	self.sensor:addEventDragOnClick(self.onDragClick)
end

function MultiHeroScrollCell:onDragGet(sender)
	local obj = DragPlane.addDragObj(true, self.hero, nil, BattleConst.CAMP_PLAYER)

	DragPlane.showBlock(obj, self.hero)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function MultiHeroScrollCell:onDragClick(sender)
	local tips = UIManager.getUI("battleDragHeroTips")

	tips:show(self)
	tips:correctPos(true)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function MultiHeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected
end

return MultiHeroScrollCell
