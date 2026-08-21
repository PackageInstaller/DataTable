-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\Grid\\PetGridCard.lua

local strClassName = "PetGridCard"
local PetGridCard = Class(strClassName, UIControls.PetCardLoop)

function PetGridCard:initUI()
	PetGridCard.super.initUI(self)

	self.imgIconNew2 = UIControls.Image(self, "InfoPanel/IconNew2")
	self.imgIconNew = UIControls.Image(self, "InfoPanel/IconNew")
end

function PetGridCard:setData(pet, idx)
	self.idx = idx

	self:setPet(pet)
	self:setSelected(self.mParent.selectedPet ~= nil and self.pet.gid == self.mParent.selectedPet.gid)
end

function PetGridCard:setSelected(isSelected)
	self.beSelected = isSelected
end

return PetGridCard
