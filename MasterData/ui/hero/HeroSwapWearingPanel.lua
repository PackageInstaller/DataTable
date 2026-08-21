-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSwapWearingPanel.lua

local strClassName = "HeroSwapWearingPanel"
local HeroSwapWearingPanel = Class(strClassName, UIControls.Panel)

function HeroSwapWearingPanel:ctor()
	self:initUI()
end

function HeroSwapWearingPanel:initUI()
	self.imgLockArtifact = UIControls.Panel(self, self.mPath .. "/BgLock")
	self.equipGridDic = {}
end

function HeroSwapWearingPanel:setHero(hero)
	self.hero = hero

	self.imgLockArtifact:setVisible(false)

	if not self.gridHero then
		self.gridHero = UIControls.GridHeroInfoChild(self, self.mPath .. "/HeroInfo", "System/Common/Grid/GridHeroInfo")
		self.gridHero.mEnableTips = false

		self.gridHero.txtHeroLv:setFontColor(ResColor.GREYLIGHT)
		self.gridHero.txtHeroName:setFontColor(ResColor.GREYLIGHT)
	end

	self.gridHero:setHero(hero)
	self.gridHero:setHeroRealLv()

	self.equipList = self.hero:getEquips()

	for part, equip in pairs(self.equipList) do
		if not self.equipGridDic[part] then
			self.equipGridDic[part] = UIControls.EquipGridChild(self, self.mPath .. "/EquipPanel/EquipGrid" .. part, "System/Common/Grid/GridEquipItem", 0, 0, true)
		end

		local fakeEquipedItem = BaseObject.CopyObject(equip)

		fakeEquipedItem.inWearing = nil

		self.equipGridDic[part]:setObj(fakeEquipedItem)
	end

	for part, _ in pairs(self.equipGridDic) do
		if not self.equipList[part] then
			self.equipGridDic[part]:destroy()

			self.equipGridDic[part] = nil
		end
	end

	self.artifact = self.hero:getArtifact()

	if self.artifact then
		if not self.artifactGrid then
			self.artifactGrid = UIControls.ArtifactGridChild(self, self.mPath .. "/BadgeGrid", "System/Common/Grid/GridBadgeSmallItem", 0, 0, true)
		end

		local fakeArtifactItem = BaseObject.CopyObject(self.artifact)

		fakeArtifactItem.inWearing = nil

		self.artifactGrid:setObj(fakeArtifactItem)
	elseif self.artifactGrid then
		self.artifactGrid:destroy()

		self.artifactGrid = nil
	end
end

return HeroSwapWearingPanel
