-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletSkillInfoPanel.lua

local PetAmuletSkillInfoPart = require("UI/Pet/PetAmuletSkillInfoPart")
local PetAmuletSkillInfoPanel = Class("PetAmuletSkillInfoPanel", UIControls.Child)

function PetAmuletSkillInfoPanel:ctor()
	self:initUI()
end

function PetAmuletSkillInfoPanel:initUI()
	self.amuletSkillInfoPart = PetAmuletSkillInfoPart(self, "SkillList")
	self.textName = UIControls.Label(self, "TextName")
	self.iconPet = UIControls.Image(self, "IconPet")
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end
end

function PetAmuletSkillInfoPanel:setData(amulet)
	self.amulet = amulet

	self.textName:setText(self.amulet.name)

	local iconPath = self.amulet:getIconPath()

	if iconPath then
		self.iconPet:setImage(iconPath[1], iconPath[2])
	end

	self.amuletSkillInfoPart:setData(self.amulet)

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= self.amulet.star)
		self.starGroup[i].star:setVisible(i <= self.amulet.maxStar)
	end
end

function PetAmuletSkillInfoPanel:setNoEffectSkillByPos(pos)
	self.amuletSkillInfoPart:setNoEffectSkillByPos(pos)
end

return PetAmuletSkillInfoPanel
