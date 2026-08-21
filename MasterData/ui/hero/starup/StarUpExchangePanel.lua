-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\StarUpExchangePanel.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResStarCost = require("ClientData/ResStarCost")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local BtnHeroMaterial = require("UI/Hero/StarUp/BtnHeroMaterial")
local MATERIAL_TYPE_LIST = {
	Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID,
	Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP,
	Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID
}
local strClassName = "StarUpExchangePanel"
local StarUpExchangePanel = Class(strClassName, UIControls.Panel)

function StarUpExchangePanel:ctor()
	self:initUI()
end

function StarUpExchangePanel:initUI()
	self.gridMaterials = {}
	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = {}
	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = {}
	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = {}
	self.btnStarUp = UIControls.Button(self, self.mPath .. "/BtnStarUp")

	self.btnStarUp:addEventClick(self.onBtnStarUpClick)

	self.btnFastAddMaterial = UIControls.Button(self, self.mPath .. "/BtnAdd")

	self.btnFastAddMaterial:addEventClick(self.onBtnFastAddMaterialClick)

	self.imgStarColor = UIControls.Image(self, self.mPath .. "/ImgStarColor")
end

function StarUpExchangePanel:setHero(hero)
	self.hero = hero
	self.gridHero = GridHeroStarUp(self, self.mPath .. "/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")

	self.gridHero:setVisible(true)
	self.gridHero:setClickCallback(Slot(self.clearHero, self))
	self.gridHero:setHero(self.hero)

	local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1
	local color = self.hero:getQualityColor(stepImgIdx)

	self.imgStarColor:setObjColor(color)

	self.starCostInfo = ResStarCost[self.hero.resData.star_up_id][self.hero.star + 1]

	if self.starCostInfo.same_num and self.starCostInfo.same_num > 0 then
		local gridList = {}

		for i = 1, self.starCostInfo.same_num do
			local fakeHero = BaseObject.GetObject(self.hero.id)

			fakeHero.star = self.starCostInfo.same_star

			local btnMaterial = BtnHeroMaterial(self, self.mPath .. "/MaterialPanel", "System/StarUp/BtnHeroMaterial")

			btnMaterial:initFakeHero(fakeHero)
			btnMaterial:setVisible(true)
			table.insert(gridList, btnMaterial)
		end

		self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = gridList
	end

	if self.starCostInfo.camp_num and self.starCostInfo.camp_num > 0 then
		local gridList = {}

		for i = 1, self.starCostInfo.camp_num do
			local fakeHero = BaseObject.GetObject(self.hero.id)

			fakeHero.id = nil
			fakeHero.star = self.starCostInfo.camp_star

			local btnMaterial = BtnHeroMaterial(self, self.mPath .. "/MaterialPanel", "System/StarUp/BtnHeroMaterial")

			btnMaterial:initFakeHero(fakeHero)
			btnMaterial:setVisible(true)
			table.insert(gridList, btnMaterial)
		end

		self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = gridList
	end

	if self.starCostInfo.any_num and self.starCostInfo.any_num > 0 then
		local gridList = {}

		for i = 1, self.starCostInfo.any_num do
			local fakeHero = BaseObject.GetObject(self.hero.id)

			fakeHero.id = nil
			fakeHero.camp = nil
			fakeHero.star = self.starCostInfo.any_star

			local btnMaterial = BtnHeroMaterial(self, self.mPath .. "/MaterialPanel", "System/StarUp/BtnHeroMaterial")

			btnMaterial:initFakeHero(fakeHero)
			btnMaterial:setVisible(true)
			table.insert(gridList, btnMaterial)
		end

		self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = gridList
	end

	self.btnFastAddMaterial:setVisible(self.hero.star == 6 and self.starCostInfo.camp_num and self.starCostInfo.camp_num > 0)
end

function StarUpExchangePanel:addMaterial(materialHero)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			local passTypes = CurAvatar:isStarUpNeed(self.hero, materialHero)

			if not grid.realHero and passTypes and passTypes[materialType] then
				grid:setRealHero(materialHero)
				self:setMaterialEnough(self:isMaterialEnough())
				self.mWindow:refreshHeroList()

				return
			end
		end
	end

	MsgManager.clientNotice(166)
end

function StarUpExchangePanel:getCanBeMaterialType(materialHero)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			local passTypes = CurAvatar:isStarUpNeed(self.hero, materialHero)

			if not grid.realHero and passTypes and passTypes[materialType] then
				return materialType
			end
		end
	end
end

function StarUpExchangePanel:removeMaterial(materialHero)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if grid.realHero and grid.realHero.gid == materialHero.gid then
				grid:removeMaterial()
				self:setMaterialEnough(false)
				self.mWindow:refreshHeroList()

				return
			end
		end
	end
end

function StarUpExchangePanel:clearMaterial(refreshUI)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if grid.realHero then
				grid:removeMaterial()
			end
		end
	end

	self:setMaterialEnough(false)

	if refreshUI then
		self.mWindow:refreshHeroList()
	end
end

function StarUpExchangePanel:isMaterialEnough()
	local realMaterialCounts = {}

	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if grid.realHero then
				if not realMaterialCounts[materialType] then
					realMaterialCounts[materialType] = 1
				else
					realMaterialCounts[materialType] = realMaterialCounts[materialType] + 1
				end
			end
		end
	end

	return (realMaterialCounts[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] or 0) == (self.starCostInfo.same_num or 0) and (realMaterialCounts[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] or 0) == (self.starCostInfo.camp_num or 0) and (realMaterialCounts[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] or 0) == (self.starCostInfo.any_num or 0)
end

function StarUpExchangePanel:setMaterialEnough(enough)
	self.btnStarUp:setVisible(enough)
	self.btnFastAddMaterial:setVisible(not enough and self.hero ~= nil and self.hero.star == 6)
end

function StarUpExchangePanel:isBeMaterial(materialHero)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if grid.realHero and grid.realHero.gid == materialHero.gid then
				return materialType
			end
		end
	end
end

function StarUpExchangePanel:clearHero()
	self.hero = nil

	if self.gridHero then
		self.gridHero:destroy()

		self.gridHero = nil
	end

	for _, gridList in pairs(self.gridMaterials) do
		for _, grid in ipairs(gridList) do
			grid:destroy()
		end
	end

	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = {}
	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = {}
	self.gridMaterials[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = {}

	self.btnStarUp:setVisible(false)
	self.mWindow:delHeroModel()
	self.mWindow:refreshHeroList()

	for _, imgRecommedCamp in ipairs(self.mWindow.imgRecommedCampList) do
		imgRecommedCamp:setVisible(false)
	end

	self:setVisible(false)
end

local function _sortPrepareMaterialList(a, b)
	local priorityA = a[2]
	local priorityB = b[2]
	local heroA = a[1]
	local heroB = b[1]

	if priorityA ~= priorityB then
		return priorityA < priorityB
	elseif heroA.level ~= heroB.level then
		return heroA.level < heroB.level
	else
		return heroA.id > heroB.id
	end
end

function StarUpExchangePanel:onBtnStarUpClick()
	local materials = {}

	materials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_ID] = {}
	materials[Const.HERO_STARUP_MATERIAL_TYPE.SAME_CAMP] = {}
	materials[Const.HERO_STARUP_MATERIAL_TYPE.ANY_ID] = {}

	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if grid.realHero then
				table.insert(materials[materialType], grid.realHero)
			end
		end
	end

	local heroStarUpInfoDlg = UIManager.getUI("heroStarUpInfoDlg", true)

	if heroStarUpInfoDlg then
		heroStarUpInfoDlg:setHero(self.hero, materials)
	end
end

function StarUpExchangePanel:onBtnFastAddMaterialClick()
	self:clearGridFastAddStatus()

	local hadBigStarIdDic = {}
	local prepareMaterialList = {}
	local sixStarCountDic = {}

	for _, hero in ipairs(CurAvatar.heroDic) do
		if hero.star == 6 then
			if not sixStarCountDic[hero.id] then
				sixStarCountDic[hero.id] = 0
			end

			sixStarCountDic[hero.id] = sixStarCountDic[hero.id] + 1
		end

		if hero.star >= 6 then
			if not hadBigStarIdDic[hero.id] then
				hadBigStarIdDic[hero.id] = 1
			else
				hadBigStarIdDic[hero.id] = hadBigStarIdDic[hero.id] + 1
			end
		end
	end

	for _, hero in pairs(CurAvatar.heroDic) do
		if hero.gid ~= self.hero.gid and hero.lock == 0 and hero.quality < 4 and CurAvatar:isStarUpNeed(self.hero, hero) then
			if not hadBigStarIdDic[hero.id] then
				table.insert(prepareMaterialList, {
					hero,
					hero.starUpPriority + 1000
				})
			elseif not sixStarCountDic[hero.id] or sixStarCountDic[hero.id] and sixStarCountDic[hero.id] < 2 then
				table.insert(prepareMaterialList, {
					hero,
					hero.starUpPriority + 100
				})
			else
				table.insert(prepareMaterialList, {
					hero,
					hero.starUpPriority
				})
			end
		end
	end

	table.sort(prepareMaterialList, _sortPrepareMaterialList)

	local realUseMaterialList = self:isCanFullMaterial(prepareMaterialList)

	if realUseMaterialList then
		MsgManager.clientNotice(294)
		self:clearMaterial(true)

		for _, materialHero in ipairs(realUseMaterialList) do
			self:addMaterial(materialHero)
		end
	else
		self:jumpToDrawCard(Lang.get(30398))
	end
end

function StarUpExchangePanel:isCanFullMaterial(prepareMaterialList)
	self:clearGridFastAddStatus()

	local asyncCount = utils.getTableElemCount(CurAvatar.asyncPVPDefendFormation)
	local preAsyncCount = 0
	local realUseMaterialList = {}

	for _, preInfo in ipairs(prepareMaterialList) do
		local preHero = preInfo[1]

		if preAsyncCount ~= asyncCount - 1 or not CurAvatar.asyncPVPDefendFormation[preHero.gid] then
			preAsyncCount = preAsyncCount + 1

			if self:gridFastAddStatusIsFull() then
				break
			else
				table.insert(realUseMaterialList, preHero)
				self:addGridFastAddStatus(preHero)
			end
		end
	end

	if self:gridFastAddStatusIsFull() then
		return realUseMaterialList
	else
		return nil
	end
end

local function _jumpDraw()
	local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", true)

	if drawCardMainDlg then
		drawCardMainDlg:selectPoolById(Const.DrawPoolIdStandard)
	end
end

function StarUpExchangePanel:jumpToDrawCard(msgContent)
	self:clearGridFastAddStatus()
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(455), msgContent, _jumpDraw, nil, -1, Lang.get(73), Lang.get(1333))
end

function StarUpExchangePanel:addGridFastAddStatus(materialHero)
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			local passTypes = CurAvatar:isStarUpNeed(self.hero, materialHero)

			if not grid.fastAdd and passTypes and passTypes[materialType] then
				grid.fastAdd = true

				return
			end
		end
	end
end

function StarUpExchangePanel:gridFastAddStatusIsFull()
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			if not grid.fastAdd then
				return false
			end
		end
	end

	return true
end

function StarUpExchangePanel:clearGridFastAddStatus()
	for _, materialType in ipairs(MATERIAL_TYPE_LIST) do
		for _, grid in ipairs(self.gridMaterials[materialType]) do
			grid.fastAdd = nil
		end
	end
end

return StarUpExchangePanel
