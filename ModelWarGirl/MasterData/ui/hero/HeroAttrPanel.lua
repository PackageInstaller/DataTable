-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroAttrPanel.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "HeroAttrPanel"
local HeroAttrPanel = Class(strClassName, UIControls.Panel)

function HeroAttrPanel:ctor()
	self:initUI()
end

function HeroAttrPanel:initUI()
	self.txtAttrName = UIControls.Label(self, self.mPath .. "/TextName")
	self.txtOriValue = UIControls.Label(self, self.mPath .. "/TextNum1")

	if UIControls.checkControlFunc(self, self.mPath .. "/TextArrow") then
		self.panelArror = UIControls.Panel(self, self.mPath .. "/TextArrow")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/TextNum2") then
		self.txtTargetValue = UIControls.Label(self, self.mPath .. "/TextNum2")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/Icon") then
		self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/Efx3") then
		self.efx3 = UIControls.Panel(self, self.mPath .. "/Efx3")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/Slider") then
		self.slider = UIControls.Slider(self, self.mPath .. "/Slider")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/ImgArrow") then
		if UIControls.Image(self, self.mPath .. "/ImgArrow/Image") then
			self.imgArrow = UIControls.Image(self, self.mPath .. "/ImgArrow/Image")
		end

		if UIControls.checkControlFunc(self, self.mPath .. "/ImgArrow/Text") then
			self.txtArrow = UIControls.Label(self, self.mPath .. "/ImgArrow/Text")
		end
	end
end

function HeroAttrPanel:setData(attrName, oriValue, targetValue, propName)
	self.txtAttrName:setText(attrName)
	self.txtOriValue:setText(oriValue)

	if targetValue then
		self.txtTargetValue:setText(targetValue)
	end

	if propName then
		local attriconInfo = ClientUtils.getRolePropIcon(propName)

		if self.imgIcon then
			self.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		end
	end
end

function HeroAttrPanel:setValueColor(color)
	self.txtOriValue:setFontColor(color)
end

function HeroAttrPanel:setCrystalProp(targetValue)
	local checkTargetValue = targetValue ~= nil and targetValue > 0

	if self.efx3 then
		self.efx3:setVisible(checkTargetValue)
	end

	if self.txtTargetValue then
		self.txtTargetValue:setVisible(checkTargetValue)

		if checkTargetValue then
			self.txtTargetValue:setText(string.format("(<0620>+%d)", targetValue))
		end
	end
end

function HeroAttrPanel:setPropInfo(propName, propValue, targetValue, fromPlayer)
	local zhName, attrValue = ClientUtils.getRolePropZhName(propName, propValue, fromPlayer)

	self.txtAttrName:setText(zhName)
	self.txtOriValue:setText(attrValue)

	if self.txtTargetValue and targetValue then
		self.txtTargetValue:setVisible(true)

		local tarZhName, tarAttrValue = ClientUtils.getRolePropZhName(propName, targetValue, fromPlayer)

		self.txtTargetValue:setText(tarAttrValue)

		if self.panelArror then
			self.panelArror:setVisible(true)
		end
	elseif self.txtTargetValue then
		self.txtTargetValue:setVisible(false)

		if self.panelArror then
			self.panelArror:setVisible(false)
		end
	end

	local attriconInfo = ClientUtils.getRolePropIcon(propName)

	if self.imgIcon then
		self.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
	end
end

function HeroAttrPanel:setBattleStateDesc(stateDesc, propValue, targetValue)
	self.txtAttrName:setText(stateDesc)
	self.txtOriValue:setText(propValue)

	if targetValue then
		self.txtTargetValue:setText(targetValue)
		self.panelArror:setVisible(true)
		self.txtTargetValue:setVisible(true)
	else
		self.panelArror:setVisible(false)
		self.txtTargetValue:setVisible(false)
	end
end

function HeroAttrPanel:setSlider(value)
	self.slider:setValue(value)
end

function HeroAttrPanel:setArrow(value)
	local checkShowArrow = value and value ~= 0
	local checkShowText = value ~= nil

	if self.imgArrow then
		self.imgArrow:setVisible(checkShowArrow)

		if checkShowArrow then
			if value > 0 then
				self.imgArrow:setImage("Atlas/PetAtlas/PetEnchantAtlas8", "BgArrow" .. 1)
			else
				self.imgArrow:setImage("Atlas/PetAtlas/PetEnchantAtlas8", "BgArrow" .. 2)
			end
		end
	end

	if self.txtArrow then
		self.txtArrow:setVisible(checkShowText)

		if checkShowText then
			if value > 0 then
				self.txtArrow:setText(string.format("(+%d)", value))
				self.txtArrow:setFontColor(ResColor.GREEN)
			elseif value < 0 then
				self.txtArrow:setText(string.format("(%d)", value))
				self.txtArrow:setFontColor(ResColor.REDORANGE)
			elseif value == 0 then
				self.txtArrow:setText(string.format("(+%d)", value))
				self.txtArrow:setFontColor(ResColor.COLORBGRANK05)
			end
		end
	end
end

return HeroAttrPanel
