-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ArtifactTips.lua

local SingleArtifactTipsChild = require("UI/Common/Tips/SingleArtifactTipsChild")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local strClassName = "ArtifactTips"
local ArtifactTips = Class(strClassName, UIControls.Tips)

function ArtifactTips:ctor()
	self:initUI()
end

function ArtifactTips:initUI()
	self.panelArtifactInfo = SingleArtifactTipsChild(self, "BgPanel", "System/Common/Tips/BadgeInfoPanel", 0, 0, true)
	self.panelHero = UIControls.Panel(self, "BgPanel/HeroInfo")
	self.panelHeroNone = UIControls.Panel(self, "BgPanel/HeroInfoNone")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.imgBgYellow = UIControls.Image(self, "BgPanel/Func/BgHeroInfo/BgYellow")

	self:initFuncBtn(5)

	if UIControls.checkControlFunc(self, "BgPanel/Func/BtnFunc1/Image") then
		self.imgLock = UIControls.Image(self, "BgPanel/Func/BtnFunc1/Image")
	end
end

function ArtifactTips:_setObj(grid)
	self.artifact = grid.object

	local heroGid = self.artifact.inWearing
	local hero

	if CurAvatar and heroGid and not utils.isCheckRoleInfo() then
		hero = CurAvatar.heroDic[heroGid]
	end

	if hero and not self.gridHero then
		self.gridHero = UIControls.GridHeroInfoChild(self, "BgPanel/HeroInfo", "System/Common/Grid/GridHeroInfo")
	end

	self.imgBgYellow:setVisible(hero ~= nil)

	if hero then
		self.gridHero.btnHeroHead:setEnable(false)
		self.gridHero:setHero(hero)

		local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1
		local color = hero:getQualityColor(stepImgIdx)

		self.imgBgYellow:setObjColor(color)
	end

	self.panelHero:setVisible(hero ~= nil)
	self.panelHeroNone:setVisible(hero == nil and self._config ~= nil)
	self.panelEmpty:setVisible(self._config ~= nil)
	self.panelArtifactInfo:setItem(self.artifact)

	self.isLock = self.artifact.isLock

	if self.imgLock then
		local imgName = "IconLockopenNml"

		if self.isLock and self.isLock == Const.EQUIP_STATE_LOCK then
			imgName = "IconLockNml"
		end

		self.imgLock:setImage("Atlas/CommonAtlas/TipsNewAtlas", imgName)
	end
end

function ArtifactTips:refreshLockInfo()
	self.isLock = self.artifact.isLock

	if self.imgLock then
		local imgName = "IconLockopenNml"

		if self.isLock and self.isLock == Const.EQUIP_STATE_LOCK then
			imgName = "IconLockNml"
		end

		self.imgLock:setImage("Atlas/CommonAtlas/TipsNewAtlas", imgName)
	end

	self.panelArtifactInfo:setItem(self.artifact)
end

return ArtifactTips
