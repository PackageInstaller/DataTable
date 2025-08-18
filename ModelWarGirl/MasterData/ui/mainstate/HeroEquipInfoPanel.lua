-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\HeroEquipInfoPanel.lua

local strClassName = "HeroEquipInfoPanel"
local HeroEquipInfoPanel = Class(strClassName, UIControls.Child)
local EQUIP_QUALITY_COLOR = {
	{
		image = "IconClothes07",
		color = {
			255,
			255,
			255
		}
	},
	{
		image = "IconClothes01",
		color = {
			68,
			231,
			132
		}
	},
	{
		image = "IconClothes01",
		color = {
			68,
			231,
			132
		}
	},
	{
		image = "IconClothes02",
		color = {
			23,
			156,
			250
		}
	},
	{
		image = "IconClothes02",
		color = {
			23,
			156,
			250
		}
	},
	{
		image = "IconClothes03",
		color = {
			207,
			117,
			254
		}
	},
	{
		image = "IconClothes03",
		color = {
			207,
			117,
			254
		}
	},
	{
		image = "IconClothes04",
		color = {
			255,
			252,
			10
		}
	},
	{
		image = "IconClothes04",
		color = {
			255,
			252,
			10
		}
	},
	{
		image = "IconClothes05",
		color = {
			253,
			80,
			159
		}
	},
	{
		image = "IconClothes05",
		color = {
			253,
			80,
			159
		}
	},
	{
		image = "IconClothes06",
		color = {
			255,
			48,
			37
		}
	}
}

function HeroEquipInfoPanel:ctor()
	self:initUI()
end

function HeroEquipInfoPanel:initUI()
	self.txtUp = UIControls.Label(self, "BgEquipInfo/BgTxt/Text")
	self.imgEquipLevel = {}
	self.imgEquipDis = {}
	self.animEquipLevel = {}

	for i = 1, 6 do
		local imgEquipLevel = UIControls.Image(self, "BgEquipInfo/Equip" .. i .. "/ImgEquipLevel")
		local animEquipLevel = UIControls.UIAni(self, "BgEquipInfo/Equip" .. i .. "/ImgEquipLevel")
		local imgEquipDis = UIControls.Image(self, "BgEquipInfo/Equip" .. i .. "/ImgEquipDis")

		table.insert(self.imgEquipLevel, imgEquipLevel)
		table.insert(self.imgEquipDis, imgEquipDis)
		table.insert(self.animEquipLevel, animEquipLevel)
	end
end

function HeroEquipInfoPanel:setData(hero)
	local allEnhanceLevel = 0
	local equipList = hero:getEquips()

	for i = 1, 6 do
		if equipList and equipList[i] then
			local quality = equipList[i].quality

			allEnhanceLevel = allEnhanceLevel + equipList[i].enhanceLevel

			local imageName = EQUIP_QUALITY_COLOR[quality].image

			self.imgEquipLevel[i]:setImage("Atlas/BagAtlas/BagAtlas4", imageName)
			self.imgEquipLevel[i]:setVisible(true)
			self.imgEquipDis[i]:setVisible(false)
		else
			self.imgEquipLevel[i]:setVisible(false)
			self.imgEquipDis[i]:setVisible(true)
		end
	end

	self.txtUp:setText("+" .. allEnhanceLevel)
end

function HeroEquipInfoPanel:playWearOrOffAnim(effectPartList, type)
	if type == Const.WEAR_EQUIP_ANIM then
		for i, part in pairs(effectPartList) do
			if self.animEquipLevel[part] then
				self.animEquipLevel[part]:startAni("EquipChangeScale", true)
			end
		end
	elseif type == Const.OFF_EQUIP_ANIM then
		-- block empty
	end
end

return HeroEquipInfoPanel
