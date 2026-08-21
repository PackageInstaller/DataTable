-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeLosderTipsInfoPanel.lua

local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local HeroTipsInfoPanel = require("UI/Common/Tips/HeroTipsInfoPanel")
local ResColor = require("ClientData/ResColor")
local HaloGridCell = Class("HaloGridCell", UIControls.Child)

function HaloGridCell:ctor(...)
	self:initUI()
end

function HaloGridCell:initUI(...)
	self.iconLosder = UIControls.Image(self, "BgHead/IconLosder ")
	self.imgUpBattle = UIControls.Panel(self, "ImgUpBattle")
end

function HaloGridCell:setObj(haloId)
	if ResNewMazeHalo[haloId] and ResNewMazeHalo[haloId].icon_path then
		self.iconLosder:setImage(ResNewMazeHalo[haloId].icon_path, ResNewMazeHalo[haloId].icon_name)
	end
end

local HeroTeamGrid = Class("HeroTeamGrid", UIControls.Child)

function HeroTeamGrid:ctor()
	self:initUI()
end

function HeroTeamGrid:initUI()
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.imgPaint = UIControls.Image(self, "CoatingImg")
	self.imgUpBattle = UIControls.Image(self, "ImgUpBattle")
	self.imgNoGet = UIControls.Image(self, "ImgNoGet")
	self.panelNotDefault = UIControls.Panel(self, "ImgEnchant")
end

function HeroTeamGrid:setObj(hero)
	self.hero = hero

	local iconPath = self.hero:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local heroStar = self.hero.star

	if self.hero.paintLevel and self.hero.paintLevel > 0 then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage("Atlas/HeroAtlas/HeroCoatingAtlas", "CoatingImgC0" .. self.hero.paintLevel)

		heroStar = self.hero:getMaxStar()
	else
		self.imgPaint:setVisible(false)
	end

	local stepImgInfo = UIConst.getHeroStepPath(heroStar)

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local starPath = UIConst.getHeroStarPath(heroStar)

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	self.imgUpBattle:setVisible(self.mParent.state and self.mParent.state == Const.NEW_MAZE_HERO_STATE.InBattle)
	self.imgNoGet:setVisible(self.mParent.state and self.mParent.state == Const.NEW_MAZE_HERO_STATE.NotHave)

	if self.hero:mazeSolderIsDefault(self.mParent.fettersType) then
		self.panelNotDefault:setVisible(false)
	else
		self.panelNotDefault:setVisible(true)
	end
end

local HeroOrHaloLosderGrid = Class("HeroOrHaloLosderGrid", UIControls.Child)

function HeroOrHaloLosderGrid:ctor(...)
	self:initUI()
end

function HeroOrHaloLosderGrid:initUI(...)
	self.btnGrid = UIControls.Button(self, "")

	self.btnGrid:addEventClick(self.onGridClick)
end

function HeroOrHaloLosderGrid:setData(data, fettersType)
	self.fettersType = fettersType
	self.data = data

	if self.type then
		self.oldType = self.type
	end

	self.type = self.data.type
	self.gridId = self.data.id
	self.state = self.data.state

	if self.oldType and self.oldType ~= self.type and self.gridHero then
		self.gridHero:destroy()

		self.gridHero = nil
	end

	if self.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		if self.gridHero == nil then
			self.gridHero = HeroTeamGrid(self, "InfoPanel", "System/Common/Grid/GridHeroRogue", 0, 0, true)
		end

		local hero = BaseObject.GetObject(self.gridId)
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			hero = actObj.actData:getPerfectHero(self.gridId)
		end

		self.gridHero:setObj(hero)
	else
		if self.gridHalo == nil then
			self.gridHalo = HaloGridCell(self, "InfoPanel", "System/Common/Grid/GridHalo", 0, 0, true)
		end

		self.gridHalo:setObj(self.gridId)

		if self.data.notUse then
			self.gridHalo.imgUpBattle:setVisible(false)
		else
			self.gridHalo.imgUpBattle:setVisible(true)
		end
	end
end

function HeroOrHaloLosderGrid:setClickFunc(onClickTips)
	self.onClickTips = onClickTips
end

function HeroOrHaloLosderGrid:onGridClick()
	if self.onClickTips then
		self.onClickTips(self)
	end
end

local NewMazeLosderTipsInfoPanel = Class("NewMazeLosderTipsInfoPanel", UIControls.Child)

function NewMazeLosderTipsInfoPanel:ctor(...)
	self:initUI()
end

function NewMazeLosderTipsInfoPanel:initUI(...)
	self.textLosderNum = UIControls.Label(self, "LosderTipsDetailPanel/LosderTitlePanel/TextLosderNum")
	self.textLosderName = UIControls.Label(self, "LosderTipsDetailPanel/LosderTitlePanel/TextLosderName")
	self.textAttr2 = UIControls.Label(self, "LosderTipsDetailPanel/LvUpAttr2/TextAttr")
	self.textAttr1 = UIControls.Label(self, "LosderTipsDetailPanel/LvUpAttr1/TextAttr")
	self.textLv2 = UIControls.Label(self, "LosderTipsDetailPanel/LvUpAttr2/TextLv")
	self.textLv1 = UIControls.Label(self, "LosderTipsDetailPanel/LvUpAttr1/TextLv")
	self.bgTextLv1 = UIControls.Image(self, "LosderTipsDetailPanel/LvUpAttr1/BgTextLv")
	self.bgTextLv2 = UIControls.Image(self, "LosderTipsDetailPanel/LvUpAttr2/BgTextLv")
	self.textLosderNumMax = UIControls.Label(self, "LosderTipsDetailPanel/LosderTitlePanel/TextLosderNumMax")
	self.iconLosder = UIControls.Image(self, "LosderTipsDetailPanel/LosderTitlePanel/IconLosder")
	self.panelHeroInfo = HeroTipsInfoPanel(self, "HeroOrHaloTipsPanel/BgPanel1", "System/Common/Tips/HeroTipsInfoPanel", 0, 0, true)
	self.bgPanel1 = UIControls.Panel(self, "HeroOrHaloTipsPanel/BgPanel1")
	self.bgPanel2 = UIControls.Panel(self, "HeroOrHaloTipsPanel/BgPanel2")
	self.textHaloName = UIControls.Label(self, "HeroOrHaloTipsPanel/BgPanel2/HaloTipsInfoPanel/TextHaloName")
	self.iconHaloLosder = UIControls.Image(self, "HeroOrHaloTipsPanel/BgPanel2/HaloTipsInfoPanel/BgHalo/IconLosder ")
	self.textHaloDetail = UIControls.Label(self, "HeroOrHaloTipsPanel/BgPanel2/HaloTipsInfoPanel/TextHaloDetail")
	self.losderCareerPanel = UIControls.Panel(self, "LosderTipsDetailPanel/LosderCareerPanel")
	self.careerPanelList = {}

	for i = 1, 5 do
		local imgNoGet = UIControls.Image(self, "LosderTipsDetailPanel/LosderCareerPanel/CareerPanel" .. i .. "/ImgNoGet")
		local imgUpBattle = UIControls.Image(self, "LosderTipsDetailPanel/LosderCareerPanel/CareerPanel" .. i .. "/ImgUpBattle")

		table.insert(self.careerPanelList, {
			imgNoGet = imgNoGet,
			imgUpBattle = imgUpBattle
		})
	end

	self.heroOrHaloGridCellList = {}
end

function NewMazeLosderTipsInfoPanel:setData(fettersData, fettersTableData, isInitHero)
	self.isInitHero = isInitHero
	self.fettersData = fettersData
	self.fettersTableData = fettersTableData

	local heros = {}

	if not self.isInitHero then
		self.fettersType = self.fettersData.type
		self.formationHeros = self.fettersData.formationHeros
		self.formationNum = self.fettersData.formationNum

		self.textLosderNum:setVisible(true)
		self.textLosderNumMax:setVisible(true)
		self.textLosderNum:setText(self.formationNum + #self.fettersData.halo)
		self.textLv1:setFontColor(ResColor.QUALITYWHITE)
		self.textAttr1:setFontColor(ResColor.ROGUEROEY)
		self.textLv2:setFontColor(ResColor.QUALITYWHITE)
		self.textAttr2:setFontColor(ResColor.ROGUEROEY)
		self.bgTextLv1:setObjColor(ResColor.ROGUEROEY)
		self.bgTextLv2:setObjColor(ResColor.ROGUEROEY)

		if self.fettersType < Const.SPECIAL_FETTERS_TYPE then
			self.textLosderNumMax:setText("/" .. Const.FETTERS_ACTIVE_NUM)

			if self.formationNum + #self.fettersData.halo >= Const.FETTERS_ACTIVE_NUM then
				self.textLv1:setFontColor(ResColor.WHITE)
				self.textAttr1:setFontColor(ResColor.WHITE)
				self.bgTextLv1:setObjColor(ResColor.CIRCLEJOB03)
				self.textLosderNumMax:setText("/" .. Const.FETTERS_ACTIVE_LEVEL2_NUM)

				if self.formationNum + #self.fettersData.halo >= Const.FETTERS_ACTIVE_LEVEL2_NUM then
					self.textLv2:setFontColor(ResColor.WHITE)
					self.textAttr2:setFontColor(ResColor.WHITE)
					self.bgTextLv2:setObjColor(ResColor.CIRCLEJOB03)
				end
			end

			self.textLv1:setText(tostring(Const.FETTERS_ACTIVE_NUM))
			self.textLv2:setText(tostring(Const.FETTERS_ACTIVE_LEVEL2_NUM))
			self.losderCareerPanel:setVisible(false)
		else
			self.textLosderNumMax:setText("/" .. Const.CAREER_MAX_NUM)

			self.fettertCareer = 1

			local careerList = {}

			for i, career in pairs(self.fettersData.formationHeros) do
				if not utils.tableIsContainsElement(careerList, career) then
					table.insert(careerList, career)
				else
					self.fettertCareer = career

					break
				end
			end

			if self.formationNum >= Const.CAREER_MAX_NUM then
				self.textLv1:setFontColor(ResColor.WHITE)
				self.textAttr1:setFontColor(ResColor.WHITE)
				self.bgTextLv1:setObjColor(ResColor.CIRCLEJOB03)
				self.textLosderNumMax:setText("/" .. Const.CAREER_MAX_NUM + 1)

				if #self.fettersData.formationHeros == Const.CAREER_MAX_NUM + 1 then
					self.textLosderNum:setText(Const.CAREER_MAX_NUM + 1)
					self.textLv2:setFontColor(ResColor.WHITE)
					self.textAttr2:setFontColor(ResColor.WHITE)
					self.bgTextLv2:setObjColor(ResColor.CIRCLEJOB03)
				end
			end

			self.textLv1:setText(tostring(Const.CAREER_MAX_NUM))
			self.textLv2:setText(tostring(Const.CAREER_MAX_NUM + 1))
			self.losderCareerPanel:setVisible(true)

			for i = 1, 5 do
				if utils.tableIsContainsElement(self.fettersData.formationHeros, i) then
					self.careerPanelList[i].imgUpBattle:setVisible(true)
				else
					self.careerPanelList[i].imgUpBattle:setVisible(false)
				end

				if utils.tableIsContainsElement(self.fettersData.heros, i) then
					self.careerPanelList[i].imgNoGet:setVisible(false)
				else
					self.careerPanelList[i].imgNoGet:setVisible(true)
				end
			end
		end

		heros = self:getShowHeros()

		for i, haloId in pairs(self.fettersData.halo or {}) do
			table.insert(heros, {
				id = haloId,
				type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo
			})
		end

		for i, haloId in pairs(self.fettersData.notUseHalo or {}) do
			table.insert(heros, {
				notUse = true,
				id = haloId,
				type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo
			})
		end
	else
		self.textLosderNum:setVisible(false)
		self.textLosderNumMax:setVisible(false)

		self.fettersType = self.fettersTableData.type
		heros = self:getInitShowHeros()

		self.textLv1:setText(tostring(Const.FETTERS_ACTIVE_NUM))
		self.textLv2:setText(tostring(Const.FETTERS_ACTIVE_LEVEL2_NUM))
	end

	for i, data in ipairs(heros or {}) do
		local heroOrHaloLosderGrid = self.heroOrHaloGridCellList[i]

		if heroOrHaloLosderGrid == nil then
			heroOrHaloLosderGrid = HeroOrHaloLosderGrid(self, "LosderTipsDetailPanel/LosderHeroOrHaloPanel", "System/Common/Grid/GridHeroOrHaloLosder", 0, 0, true)
		end

		heroOrHaloLosderGrid:setData(data, self.fettersType)

		if not self.isInitHero then
			heroOrHaloLosderGrid:setClickFunc(Slot(self.openTips, self))
		end

		self.heroOrHaloGridCellList[i] = heroOrHaloLosderGrid
	end

	if #self.heroOrHaloGridCellList > #heros then
		for i = #heros + 1, #self.heroOrHaloGridCellList do
			self.heroOrHaloGridCellList[i]:destroy()

			self.heroOrHaloGridCellList[i] = nil
		end
	end

	self.bgPanel1:setVisible(false)
	self.bgPanel2:setVisible(false)
	self.iconLosder:setImage(self.fettersTableData.icon_path, self.fettersTableData.icon_name)
	self.textLosderName:setText(self.fettersTableData.name)

	for i, data in pairs(ResNewMazeFetters) do
		if data.type == self.fettersType then
			if data.level == 1 then
				self.textAttr1:setText(data.condition_effect_desc)
			elseif data.level == 2 then
				if self.fettersType < Const.SPECIAL_FETTERS_TYPE then
					self.textAttr2:setText(data.condition_effect_desc)
				elseif data.career and self.fettertCareer == data.career then
					self.textAttr2:setText(data.condition_effect_desc)
				end
			end
		end
	end
end

function NewMazeLosderTipsInfoPanel:getShowHeros()
	local heros = {}

	for i, hero in pairs(ResNewMazeHero) do
		if ClientUtils.isHeroValidById(hero.id) then
			if utils.tableIsContainsElement(self.fettersData.heros, hero.id) then
				if utils.tableIsContainsElement(self.formationHeros, hero.id) then
					table.insert(heros, {
						id = hero.id,
						state = Const.NEW_MAZE_HERO_STATE.InBattle,
						type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
					})
				else
					table.insert(heros, {
						id = hero.id,
						state = Const.NEW_MAZE_HERO_STATE.NotInBattle,
						type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
					})
				end
			elseif hero.team_label and hero.team_label == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotHave,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			elseif hero.feature_label1 and hero.feature_label1 == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotHave,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			elseif hero.feature_label2 and hero.feature_label2 == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotHave,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			end
		end
	end

	table.sort(heros, function(a, b)
		return a.state < b.state
	end)

	return heros
end

function NewMazeLosderTipsInfoPanel:getInitShowHeros()
	local heros = {}

	for i, hero in pairs(ResNewMazeHero) do
		if ClientUtils.isHeroValidById(hero.id) then
			if hero.team_label and hero.team_label == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotInBattle,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			elseif hero.feature_label1 and hero.feature_label1 == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotInBattle,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			elseif hero.feature_label2 and hero.feature_label2 == self.fettersType then
				table.insert(heros, {
					id = hero.id,
					state = Const.NEW_MAZE_HERO_STATE.NotInBattle,
					type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero
				})
			end
		end
	end

	return heros
end

function NewMazeLosderTipsInfoPanel:openTips(grid)
	if grid.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		local hero = BaseObject.GetObject(grid.gridId)
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			hero = actObj.actData:getPerfectHero(grid.gridId)
		end

		self.panelHeroInfo:setHero(hero)
		self.panelHeroInfo:setLosderData(grid.gridId, hero)
		self.bgPanel1:setVisible(true)
		self.bgPanel2:setVisible(false)
	else
		local haloId = grid.gridId

		if ResNewMazeHalo[haloId] then
			self.textHaloName:setText(ResNewMazeHalo[haloId].name)
			self.textHaloDetail:setText(ResNewMazeHalo[haloId].description)
			self.iconHaloLosder:setImage(ResNewMazeHalo[haloId].icon_path, ResNewMazeHalo[haloId].icon_name)
		end

		self.bgPanel1:setVisible(false)
		self.bgPanel2:setVisible(true)
	end
end

return NewMazeLosderTipsInfoPanel
