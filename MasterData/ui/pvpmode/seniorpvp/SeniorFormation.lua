-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorFormation.lua

local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew2"
local ICON_PATH2 = "Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas"
local strClassName = "SeniorFormation"
local SeniorFormation = Class(strClassName, UIControls.Child)

function SeniorFormation:ctor(...)
	self.MAX_NUMBER = 5

	self:initUI()
end

function SeniorFormation:initUI(...)
	self.txtNum = UIControls.Label(self, "TextNum")
	self.gridHeros = {}
	self.panelGrids = {}

	for i = 1, self.MAX_NUMBER do
		local heroItem = UIControls.GridHeroInfoChild(self, "GridHero" .. i, "System/Common/Grid/GridHeroInfo")

		self.gridHeros[i] = heroItem

		local grid = UIControls.Panel(self, "GridHero" .. i)

		self.panelGrids[i] = grid
	end

	self.imgBgTitle = UIControls.Image(self, "BgTitle")
	self.imgNone = UIControls.Image(self, "ImgNone")
	self.imgResult = UIControls.Image(self, "ImgResult")
	self.imgHide = UIControls.Image(self, "ImgHide")
	self.panelHide = UIControls.Panel(self, "HidePanel")
	self.petHide = UIControls.Image(self, "HidePanel/PetHide")

	if UIControls.checkControlFunc(self, "GridPet") then
		self.panelPet = UIControls.Panel(self, "GridPet")
		self.gridPet = UIControls.PetCardChild(self, "GridPet", "System/Pet/GridPetCard")
	end
end

function SeniorFormation:setFormation(formation, index, isGray)
	self:setFormationOnly(formation, index, isGray)
end

function SeniorFormation:setFormationOnly(formation, index, isGray)
	self.formation = formation

	if formation == nil then
		for i, grid in ipairs(self.gridHeros) do
			grid:setVisible(false)
		end

		return
	end

	local heros, newPet = utils.getFormationHeros(formation.data)

	self:setHeros(heros, index, isGray)
	self:setPet(newPet, isGray, CurAvatar:petSystemEnable())
end

function SeniorFormation:setIndex(index)
	if index then
		self.txtNum:setText(string.format(Lang.get(30656), index))
	end
end

function SeniorFormation:setHeros(heros, index, isGray)
	self.heros = heros

	if #self.heros == 0 or self.heros[1].id == BattleConst.HIDE_FORMATION_MONSTER_ID then
		self.isEmpty = true
	else
		self.isEmpty = false
	end

	self.imgNone:setVisible(self.isEmpty)

	isGray = isGray and true or false

	if index ~= nil then
		self:setIndex(index)
	end

	if self.isEmpty then
		for i, grid in ipairs(self.panelGrids) do
			grid:setVisible(false)
		end

		if self.panelPet then
			self.panelPet:setVisible(false)
		end
	else
		for i, grid in ipairs(self.panelGrids) do
			grid:setVisible(true)
		end

		local item, hero

		if heros then
			for i = 1, #heros do
				hero = heros[i]
				item = self.gridHeros[i]

				item:setVisible(true)
				item:setHero(hero)
				item:setObjGray(isGray)
				item.btnHeroHead:setEnable(false)
			end

			for i = #heros + 1, #self.gridHeros do
				self.gridHeros[i]:setVisible(false)
			end
		end
	end

	self:setVisible(true)
end

function SeniorFormation:setPet(pet, isGray, selfUnLock)
	self.pet = pet

	if self.panelPet then
		if self.pet then
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

function SeniorFormation:setFormationWithLocalData(formation, index, isGray)
	local heros = {}

	for gid, pos in pairs(formation) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			table.insert(heros, hero)
		end
	end

	self:setHeros(heros, index, isGray)
end

function SeniorFormation:setFormationWithLocalFormation(formation, index, isGray)
	local heros = {}

	for gid, pos in pairs(formation.formation) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			table.insert(heros, hero)
		end
	end

	self:setHeros(heros, index, isGray)

	if formation.otherInfo and formation.otherInfo.petId then
		local pet = CurAvatar:getPetByResId(formation.otherInfo.petId)

		self:setPet(pet, isGray, CurAvatar:petSystemEnable())
	else
		self:setPet(nil, isGray, CurAvatar:petSystemEnable())
	end
end

function SeniorFormation:setSideState(isMySide)
	if isMySide then
		if self.isEmpty then
			self.imgBgTitle:setImage(ICON_PATH2, "BgBlueDis")
		else
			self.imgBgTitle:setImage(ICON_PATH2, "BgBlue")
		end
	elseif self.isEmpty then
		self.imgBgTitle:setImage(ICON_PATH2, "BgRedDis")
	else
		self.imgBgTitle:setImage(ICON_PATH2, "BgRed")
	end
end

function SeniorFormation:setResultState(isWin)
	self.imgResult:setVisible(true)

	if isWin then
		self.imgResult:setImage(ICON_PATH, "TxtWin")
		self.imgBgTitle:setImage(ICON_PATH, "BgLongStripYellow")
	else
		self.imgResult:setImage(ICON_PATH, "TxtFail")
		self.imgBgTitle:setImage(ICON_PATH, "BgLongStripAsh")
	end
end

function SeniorFormation:setCommonHideMode(...)
	self.panelHide:setVisible(self.isEmpty)

	if self.isEmpty then
		self.imgNone:setVisible(false)
		self.petHide:setVisible(CurAvatar:petSystemEnable())

		if self.panelPet then
			self.panelPet:setVisible(false)
		end
	end

	self.imgHide:setVisible(false)
end

function SeniorFormation:setMyHideMode(hideFlag)
	self.imgHide:setVisible(hideFlag or false)
	self.panelHide:setVisible(false)
end

return SeniorFormation
