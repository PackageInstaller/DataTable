-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridFragItemMixin.lua

local ResHero = require("ClientData/ResHero")
local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local GridFragItemMixin = {}
local UIConst = UIConst

function GridFragItemMixin:initUI()
	GridItemMixin.initUI(self)

	self.slider = UIControls.Slider(self, "Slider")
	self.imgStar = UIControls.Image(self, "ImgStar")
	self.imgShatter = UIControls.Image(self, "ImgShatter")
	self.textNumRight = UIControls.Label(self, "TextNum2")
	self.bgTxtNum2 = UIControls.Image(self, "BgTextNum2")
	self.imgQualityArtifact = UIControls.Image(self, "ImgQuality2")
	self.imgQualityEquip = UIControls.Image(self, "ImgQuality3")
	self.inBag = false

	if UIControls.checkControlFunc(self, "ImgSkin") then
		self.imgSkin = UIControls.Image(self, "ImgSkin")
	end
end

function GridFragItemMixin:_setObj(object)
	local heroId = object.resData.extend_args2

	if not ResHero[heroId] and object.subType == Const.ITEM_STYPE_HERO_FRAG then
		return
	end

	GridItemMixin._setObj(self, object)

	if self.inBag then
		local compose = object.resData.extend_args1

		if compose and compose > 0 then
			self.textNum:setText(object.num .. "/" .. compose)
			self.slider:setVisible(true)
			self.slider:setValue(object.num / compose)
			self.imgNew:setVisible(compose <= object.num and not object:getCantComposeNoticeId())
		end

		self.textNumRight:setVisible(false)
		self.bgTxtNum2:setVisible(false)
		self.textNum:setVisible(true)
	else
		self.textNumRight:setVisible(object.num and object.num > 1)

		if not self.configHideFragBg then
			self.bgTxtNum2:setVisible(object.num and object.num > 1)
		end

		self.textNum:setVisible(false)
		self.slider:setVisible(false)

		if object.num and object.num > 1 then
			self.textNumRight:setText(object.num)
		end
	end

	local starPath = object:getFragHeroStarPath()

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	self.imgStar:setVisible(starPath ~= nil)
	self.imgQualityEquip:setVisible(false)
	self.imgQuality:setVisible(false)

	if not self.configHideQuality then
		local qualityPath = object:getQualityPath()

		if qualityPath then
			if object.subType == Const.ITEM_STYPE_RAND_EQUIP_FRAG then
				self.imgQualityEquip:setImage(qualityPath[1], qualityPath[2])
				self.imgQualityEquip:setVisible(true)
			elseif object.subType == Const.ITEM_STYPE_RAND_ARTIFACT_FRAG then
				self.imgQualityEquip:setImage(qualityPath[1], qualityPath[2])
				self.imgQualityEquip:setVisible(true)
			else
				self.imgQuality:setImage(qualityPath[1], qualityPath[2])
				self.imgQuality:setVisible(true)
			end
		end
	end

	if self.imgSkin then
		self.imgSkin:setVisible(object.subType == Const.ITEM_STYPE_SKIN_FRAG)
	end
end

function GridFragItemMixin:clear()
	GridItemMixin.clear(self)
end

function GridFragItemMixin:openTipsPanel()
	if self.mEnableTips then
		UIManager.getUI("fragItemTips"):show(self, self.mTipsConfig)
	end
end

function GridFragItemMixin:setIconGray(isGray)
	GridItemMixin.setIconGray(self, isGray)

	if self.imgQualityArtifact and self.imgQualityArtifact:getVisible() then
		self.imgQualityArtifact:setImageGray(isGray)
	end

	if self.imgQualityEquip and self.imgQualityEquip:getVisible() then
		self.imgQualityEquip:setImageGray(isGray)
	end
end

function GridFragItemMixin:_setTextNumColor(color)
	self.textNumRight:setColorByRGBA(color.r / 255, color.g / 255, color.b / 255, color.a / 255)
end

function GridFragItemMixin:_setTextNumCtrlEnable()
	local ctrl = self.textNumRight:getGameObject().transform:GetComponent("UICustomColor")

	if ctrl then
		UnityEngine.Object.Destroy(ctrl)
	end
end

function GridFragItemMixin:_hideTextNum(isHide)
	self.textNumRight:setVisible(not isHide)
end

function GridFragItemMixin:onConfigHideQuality()
	self.configHideQuality = true

	self.imgQualityArtifact:setVisible(false)
end

function GridFragItemMixin:onConfigHideFragBg()
	self.configHideFragBg = true

	if not self.bgStar then
		self.bgStar = UIControls.Panel(self, self.basePath .. "BgStar")
	end

	self.bgStar:setVisible(false)
end

function GridFragItemMixin:onSpeIconHide()
	self.imgShatter:setVisible(false)
end

setmetatable(GridFragItemMixin, {
	__index = GridItemMixin
})

return GridFragItemMixin
