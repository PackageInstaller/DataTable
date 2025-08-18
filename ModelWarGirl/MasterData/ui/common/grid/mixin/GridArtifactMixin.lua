-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridArtifactMixin.lua

local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local GridArtifactMixin = {}
local UIConst = UIConst

function GridArtifactMixin:initUI()
	GridItemMixin.initUI(self)

	self.imgCareer = UIControls.Image(self, self.basePath .. "IconCareer")
	self.imgBgCareer = UIControls.Image(self, self.basePath .. "Bg")
	self.txtSkillLv = UIControls.Label(self, self.basePath .. "TextSkill")
	self.imgStar = UIControls.Image(self, self.basePath .. "StarPanel/Icon")
	self.imgBgStar = UIControls.Image(self, self.basePath .. "StarPanel")
	self.imgStarTxt = UIControls.Image(self, self.basePath .. "StarPanel/Text")
	self.panelEnhance = UIControls.Panel(self, self.basePath .. "BgUpgrade")
	self.textLevel = UIControls.Label(self, self.basePath .. "BgUpgrade/Text")
	self.panelWearing = UIControls.Panel(self, self.basePath .. "IconState")
	self.imgIconState = UIControls.Image(self, self.basePath .. "IconState")
	self.imgState2 = UIControls.Image(self, self.basePath .. "IconState2")
	self.imgSelect2 = UIControls.Image(self, self.basePath .. "ImgSelect2")
end

function GridArtifactMixin:setIconGray(isGray)
	GridItemMixin.setIconGray(self, isGray)

	if self.imgCareer and self.imgCareer:getVisible() then
		self.imgCareer:setImageGray(isGray)
	end

	if self.imgBgCareer and self.imgBgCareer:getVisible() then
		self.imgBgCareer:setImageGray(isGray)
	end

	if self.imgStar and self.imgStar:getVisible() then
		self.imgStar:setImageGray(isGray)
	end

	if self.imgBgStar and self.imgBgStar:getVisible() then
		self.imgBgStar:setImageGray(isGray)
	end

	if self.imgStarTxt and self.imgStarTxt:getVisible() then
		self.imgStarTxt:setImageGray(isGray)
	end
end

function GridArtifactMixin:_setObj(object)
	GridItemMixin._setObj(self, object)

	local careerIcon = object:getNewCareerIconPath()

	if careerIcon then
		self.imgCareer:setImage(careerIcon[1], careerIcon[2])
	end

	local iconStatePath = "Atlas/CommonAtlas/GridAtlas/GridAtlas01"

	if object.inWearing then
		if object.isLock == Const.EQUIP_STATE_LOCK then
			self.imgIconState:setImage(iconStatePath, "IconEquipLock")
		else
			self.imgIconState:setImage(iconStatePath, "IconEquip")
		end

		self.panelWearing:setVisible(true)
	elseif object.isLock == Const.EQUIP_STATE_LOCK then
		self.imgIconState:setImage(iconStatePath, "IconLock")
		self.panelWearing:setVisible(true)
	else
		self.panelWearing:setVisible(false)
	end

	self.panelEnhance:setVisible(object.enhanceLevel ~= 0)
	self.textLevel:setText("+" .. object.enhanceLevel)
	self.txtSkillLv:setText(utils.format(Lang.get(48062), object:getSkillLevel(), object:getMaxSkillLv()))
	self.imgStar:setVisible(object.breakLevel > 0)
	self.imgStarTxt:setVisible(object.breakLevel > 0)

	local starBgPath = object:getStarBgPath()

	self.imgBgStar:setImage(starBgPath[1], starBgPath[2])

	if object.breakLevel > 0 then
		local starPath = object:getStarPath()

		self.imgStar:setImage(starPath[1], starPath[2])

		local color = object:getQualityColor()

		self.imgStar:setColorByRGBA(color.r, color.g, color.b, color.a)

		local starPathTxt = object:getStarTxtPath()

		self.imgStarTxt:setImage(starPathTxt[1], starPathTxt[2])
	end

	local careerBgPath = object:getCareerBgIconPath()

	self.imgBgCareer:setImage(careerBgPath[1], careerBgPath[2])
end

function GridArtifactMixin:clear()
	GridItemMixin.clear(self)
end

function GridArtifactMixin:openTipsPanel(fromHold)
	if not fromHold then
		if self.mEnableTips then
			UIManager.getUI("artifactTips"):show(self, self.mTipsConfig, self.uiConfig)
		end
	elseif self.mEnableHoldTips then
		UIManager.getUI("artifactTips"):show(self, self.mTipsConfig, self.uiConfig)
	end
end

function GridArtifactMixin:closeTipsPanel()
	UIManager.tryHideUI("artifactTips")
end

function GridArtifactMixin:setGot(isGet)
	if isGet then
		if not self.panelGet then
			self.panelGet = UIControls.Panel(self, "ImgHave")
		end

		self.panelGet:setVisible(true)
	elseif self.panelGet then
		self.panelGet:setVisible(false)
	end
end

function GridArtifactMixin:onConfigHideBg()
	if not self.bgReal then
		self.bgReal = UIControls.Panel(self, self.basePath .. "BgBadge")
	end

	self.bgReal:setVisible(false)
end

setmetatable(GridArtifactMixin, {
	__index = GridItemMixin
})

return GridArtifactMixin
