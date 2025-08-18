-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeShopHeroCard.lua

local NewMazeLosderGrid = require("UI/NewMaze/NewMazeLosderGrid")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local strClassName = "NewMazeShopHeroCard"
local NewMazeShopHeroCard = Class(strClassName, UIControls.Child)

function NewMazeShopHeroCard:ctor()
	self:initUI()
end

function NewMazeShopHeroCard:initUI()
	self.textTitle = UIControls.Label(self, "BgTextTitle/TextTitle")
	self.imgSel = UIControls.Image(self, "ImgSel")
	self.bg = UIControls.Image(self, "Bg")
	self.heroPanel = UIControls.Panel(self, "HeroPanel")
	self.losderPanel = UIControls.Panel(self, "LosderPanel")
	self.losderCellList = {}
end

function NewMazeShopHeroCard:setData(itemId, losderType)
	self.heroId = itemId
	self.losderType = losderType

	local actObj = CurAvatar:getNewMazeActivity()

	if actObj and actObj:isValid() then
		self.hero = actObj.actData:getPerfectHero(self.heroId)
	else
		self.hero = BaseObject.GetObject(self.heroId)
	end

	if self.heroCard == nil then
		self.heroCard = UIControls.HeroCardChild(self, "HeroPanel", "System/Hero/GridHeroCard", 0, 0, true)
	end

	self.heroCard:setHero(self.hero)
	self.heroCard:setSelectCallback(Functor(self._onSelectHero, self, self.hero))
	self.textTitle:setText(self.hero.name)

	local iconName = {
		"BgHeroCardBlue",
		"BgHeroCardYellow",
		"BgHeroCardPink"
	}

	self.bg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", iconName[ResNewMazeHero[self.heroId].quality])

	self.allFetters = actObj.actData:getAllFetters()
	self.losderData = {}

	if ResNewMazeHero[self.heroId].team_label then
		table.insert(self.losderData, ResNewMazeHero[self.heroId].team_label)
	end

	if ResNewMazeHero[self.heroId].feature_label1 then
		table.insert(self.losderData, ResNewMazeHero[self.heroId].feature_label1)
	end

	if ResNewMazeHero[self.heroId].feature_label2 then
		table.insert(self.losderData, ResNewMazeHero[self.heroId].feature_label2)
	end

	for i = 1, 3 do
		local losderCell = self.losderCellList[i]

		if losderCell == nil then
			losderCell = NewMazeLosderGrid(self, "LosderPanel", "System/Common/Grid/GridLosder", 0, 0, true)
		end

		if self.losderData[i] then
			local fettersData = self:getFettersData(self.heroId, self.losderData[i])

			losderCell:setData(fettersData)
			losderCell:setGridClick(Slot(self.gridLosderClick, self))
			losderCell:setVisible(true)
		else
			losderCell:setVisible(false)
		end

		self.losderCellList[i] = losderCell
	end
end

local CanvasType = typeof(UnityEngine.Canvas)

function NewMazeShopHeroCard:setCanvasSorting()
	local heroPanelObj = self.heroPanel:getGameObject()
	local losderPanelObj = self.losderPanel:getGameObject()
	local heroPanelCanvs = heroPanelObj:GetComponent(CanvasType)
	local losderPanelCanvs = losderPanelObj:GetComponent(CanvasType)

	if heroPanelCanvs then
		heroPanelCanvs.overrideSorting = true
		heroPanelCanvs.sortingOrder = 41
	end

	if losderPanelCanvs then
		losderPanelCanvs.overrideSorting = true
		losderPanelCanvs.sortingOrder = 41
	end
end

function NewMazeShopHeroCard:getFettersData(heroId, featureLabel)
	local heroId = heroId
	local fettersData = {
		num = 0,
		formationNum = 0,
		type = featureLabel,
		heros = {},
		formationHeros = {},
		halo = {},
		notUseHalo = {}
	}

	for _, data in pairs(self.allFetters) do
		if featureLabel == data.type then
			fettersData = data

			break
		end
	end

	if self.losderType then
		if self.losderType == Const.NEW_MAZE_LOSDER_TYPE_REDUCE then
			for i, id in pairs(fettersData.formationHeros) do
				if heroId == id then
					fettersData.needFormationAni = true

					break
				end
			end

			for i, id in pairs(fettersData.heros) do
				if heroId == id then
					fettersData.needNormalAni = true

					break
				end
			end
		else
			fettersData.needNormalAni = true
			fettersData.num = fettersData.num + 1

			table.insert(fettersData.heros, heroId)
		end
	end

	return fettersData
end

function NewMazeShopHeroCard:gridLosderClick(grid)
	if self.mWindow.losderTipsInfoPanel then
		self.mWindow.losderTipsInfoPanel:setData(grid.fettersData, grid.fettersTableData)
		self.mWindow.losderTipsInfoPanel:setVisible(true)
		self.mWindow.losderTipsPanel:setVisible(true)

		if self.mWindow.fettersCellList then
			for i, cell in pairs(self.mWindow.fettersCellList) do
				cell.imgSel:setVisible(grid.fettersData.type == cell.fettersType)
			end
		end
	end
end

function NewMazeShopHeroCard:_onSelectHero(hero)
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, hero)
	heroTips:setLoasderData(hero.id)
end

return NewMazeShopHeroCard
