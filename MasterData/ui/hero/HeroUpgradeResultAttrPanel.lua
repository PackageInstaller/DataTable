-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroUpgradeResultAttrPanel.lua

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local strClassName = "HeroUpgradeResultAttrPanel"
local HeroUpgradeResultAttrPanel = Class(strClassName, HeroAttrPanel)

function HeroUpgradeResultAttrPanel:ctor()
	self:_initUI()
end

function HeroUpgradeResultAttrPanel:_initUI()
	self.attrScorePanel = UIControls.Panel(self, self.mPath .. "/AttrScore")
	self.imgIconBefore = UIControls.Image(self, self.mPath .. "/AttrScore/IconScoreBefore")
	self.imgIconAfter = UIControls.Image(self, self.mPath .. "/AttrScore/IconScoreAfter")
	self.txtAttrPlus = UIControls.Label(self, self.mPath .. "/StarNum/TextNum3")
	self.bgTxtAttrPlus = UIControls.Panel(self, self.mPath .. "/StarNum")
end

function HeroUpgradeResultAttrPanel:setRankIcon(iconBefore, iconAfter)
	self.attrScorePanel:setVisible(true)
	self.imgIconBefore:setImage(iconBefore[1], iconBefore[2])
	self.imgIconAfter:setImage(iconAfter[1], iconAfter[2])
end

function HeroUpgradeResultAttrPanel:setPlusData(attrName, attrValue)
	self.panelArror:setVisible(false)
	self.txtOriValue:setVisible(false)
	self.txtTargetValue:setVisible(false)
	self.bgTxtAttrPlus:setVisible(true)
	self.txtAttrName:setText(attrName)
	self.txtAttrPlus:setText("+" .. attrValue)
end

return HeroUpgradeResultAttrPanel
