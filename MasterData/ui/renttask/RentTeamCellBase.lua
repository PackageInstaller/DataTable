-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTeamCellBase.lua

local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local RentTeamCellBase = Class("RentTeamCellBase", UIControls.Panel)

function RentTeamCellBase:ctor(...)
	self:initUI()
end

function RentTeamCellBase:initUI()
	local path = ""

	if self.mPath ~= "" then
		path = self.mPath .. "/"
	end

	self.titleTxt = UIControls.Label(self, path .. "TextNum")
	self.powerTxt = UIControls.Label(self, path .. "TextPower")
	self.heroGrids = {}

	for i = 1, 5 do
		local heroItem = UIControls.GridHeroInfoChild(self, path .. "GridHero" .. i, "System/Common/Grid/GridHeroInfo")

		heroItem.tipsDynamicOrder = true
		self.heroGrids[i] = heroItem
	end

	if UIControls.checkControlFunc(self, path .. "GridPet") then
		self.panelPet = UIControls.Panel(self, path .. "GridPet")
		self.gridPet = UIControls.PetCardChild(self, path .. "GridPet", "System/Pet/GridPetCard")
	end
end

function RentTeamCellBase:setRentFormation(formation, idx, isGray)
	self:_setTitle(idx)
	self:_setPower(formation)

	local heros = {}
	local newPet = {}

	if formation then
		heros, newPet = utils.getFormationHeros(formation)
	end

	self:setHeros(heros, isGray)
	self:setPet(newPet, isGray)
end

function RentTeamCellBase:setRentFormationWithLocalData(formation, idx, isGray, teamId)
	self:_setTitle(idx)

	local heros = {}
	local power = 0

	if formation then
		for gid, pos in pairs(formation) do
			local hero = CurAvatar.heroDic[gid]

			if hero then
				table.insert(heros, hero)

				power = power + hero:getCapacity()
			end
		end
	end

	local otherInfo = CurAvatar:getFormationOtherInfo(teamId)
	local pet

	if otherInfo and otherInfo.petId then
		pet = CurAvatar:getPetByResId(otherInfo.petId)
	end

	if pet then
		power = power + pet:getCapacity()
	end

	self.powerTxt:setText(power)
	self:setHeros(heros, isGray)
	self:setPet(pet, isGray, CurAvatar:petSystemEnable())
end

function RentTeamCellBase:setHeros(heros, isGray)
	self.heros = heros

	if #self.heros == 0 or self.heros[1].id == BattleConst.HIDE_FORMATION_MONSTER_ID then
		self.isEmpty = true
	else
		self.isEmpty = false
	end

	isGray = isGray and true or false

	if self.isEmpty then
		for i, grid in ipairs(self.heroGrids) do
			grid:setVisible(false)
		end
	else
		for i, grid in ipairs(self.heroGrids) do
			grid:setVisible(true)
		end

		local item, hero

		if heros then
			for i = 1, #heros do
				hero = heros[i]
				item = self.heroGrids[i]

				if item then
					item:setVisible(true)
					item:setHero(hero)
					item:setObjGray(isGray)
					item.btnHeroHead:setEnable(true)
				end
			end

			for i = #heros + 1, #self.heroGrids do
				self.heroGrids[i]:setVisible(false)
			end
		end
	end
end

function RentTeamCellBase:setPet(pet, isGray, selfUnLock)
	self.pet = pet

	if self.panelPet then
		if self.pet and self.pet.star then
			self.panelPet:setVisible(true)
			self.gridPet:setVisible(true)
			self.gridPet:setPet(pet)
			self.gridPet:setObjGray(isGray)
		elseif selfUnLock then
			self.panelPet:setVisible(true)
			self.gridPet:setVisible(false)
		else
			self.panelPet:setVisible(false)
		end
	end
end

function RentTeamCellBase:_setTitle(teamId)
	self.titleTxt:setText(string.format(Lang.get(30732), Const.NUMBER_TO_WORD[teamId]))
end

function RentTeamCellBase:_setPower(formation)
	local power = 0

	if formation then
		power = CapacityHelper.getFormationCapacity(formation)
	end

	self.powerTxt:setText(power)

	self.power = power
end

return RentTeamCellBase
