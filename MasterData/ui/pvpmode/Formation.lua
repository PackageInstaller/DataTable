-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\Formation.lua

local strClassName = "Formation"
local Hero = require("Common/Object/Hero")
local ResHero = require("ClientData/ResHero")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local Formation = Class(strClassName, UIControls.Panel)

function Formation:ctor()
	self.heros = {}

	for i = 1, 5 do
		local heroItem = UIControls.GridHeroInfoChild(self, self.mPath, "System/Common/Grid/GridHeroInfo")

		self.heros[i] = heroItem
	end

	self.gridPet = UIControls.PetCardChild(self, self.mPath, "System/Pet/GridPetCard")
end

function Formation:initData(formation)
	self.formation = formation

	local heros, pet = utils.getFormationHeros(formation)

	if heros then
		for i = 1, #self.heros - #heros do
			self.heros[#self.heros - i + 1]:setVisible(false)
		end

		for i, hero in ipairs(heros) do
			self.heros[i]:setHero(hero)
			self.heros[i]:setVisible(true)
			self.heros[i].btnHeroHead:setEnable(false)
		end
	end

	if pet then
		self.gridPet:setVisible(true)
		self.gridPet:setPet(pet)
	else
		self.gridPet:setVisible(false)
	end

	self:setVisible(true)
end

function Formation:getCapacity()
	return CapacityHelper.getFormationCapacity(self.formation)
end

return Formation
