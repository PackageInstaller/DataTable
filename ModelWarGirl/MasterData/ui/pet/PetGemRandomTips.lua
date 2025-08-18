-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemRandomTips.lua

local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local BattleConst = require("Common/FrameBattle/BattleConst")
local GemRandomInfoPanel = require("UI/Pet/GemRandomInfoPanel")
local strClassName = "PetGemRandomTips"
local PetGemRandomTips = Class(strClassName, UIControls.Window)
local MAIN_ATTR_MAX_NUM = 6
local SUB_ATTR_MAX_NUM = 16

function PetGemRandomTips:ctor()
	self:initUI()
end

function PetGemRandomTips:initUI()
	self.petGemName = UIControls.Label(self, "BgPanel/BgR/PetGemName")
	self.btnTips = UIControls.Button(self, "BgPanel/BgR/AttrPanel/Attr/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.randomInfoPanel = UIControls.Panel(self, "BgPanel/RandomInfoPanel")
	self.gemRandomInfo = GemRandomInfoPanel(self, "BgPanel/RandomInfoPanel")
end

function PetGemRandomTips:setObj(gem)
	self.gem = gem

	self.petGemName:setText(self.gem.name)

	if self.gemGrid == nil then
		self.gemGrid = UIControls.GridPetGemChild(self, "BgPanel/BgR/PetGemItem", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.gemGrid:setObj(self.gem)
	self.gemGrid:setGridClickEnable(false)
	self.gemRandomInfo:setData(self.gem)
end

function PetGemRandomTips:onBtnTipsClick()
	self.randomInfoPanel:setVisible(true)
end

return PetGemRandomTips
