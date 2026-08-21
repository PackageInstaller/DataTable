-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\CommonHeroListPanel.lua

local DragHeroSortPanel = require("UI/Battle/DragHeroSortPanel")
local DragPlane = require("UI/Control/Com/DragPlane")
local strClassName = "CommonHeroListPanel"
local CommonHeroListPanel = Class(strClassName, UIControls.Panel)

function CommonHeroListPanel:ctor()
	self.isDragTip = true
	self.cells = {}
	self._slot4CellSelect = Slot(self.onHeroCellSelect, self)

	self:initUI()
end

function CommonHeroListPanel:initUI()
	self.scrollHeros = UIControls.ScrollViewLoopV(self, self.mPath .. "/HeroList")

	self.scrollHeros:addEventCellChanged(self.onHeroCellChanged)

	self.panelSort = DragHeroSortPanel(self, self.mPath .. "/ListFunPanel")
	self.panelSort.mEventHeroListChanged = Slot(self.onHerosChanged, self)

	if UIControls.checkControlFunc(self, self.mPath .. "/BgNothing") then
		self.panelBgNone = UIControls.Panel(self, self.mPath .. "/BgNothing")
	end
end

function CommonHeroListPanel:setHeroAttrFilter(fitlerTable)
	self.attrFilters = fitlerTable

	if self.allHeros then
		for index = #self.allHeros, 1, -1 do
			local hero = self.allHeros[index]
			local filterOK = false

			for _, filterInfo in ipairs(self.attrFilters) do
				if hero[filterInfo[1]] == filterInfo[2] then
					filterOK = true

					break
				end
			end

			if not filterOK then
				table.remove(self.allHeros, index)
			end
		end
	end
end

function CommonHeroListPanel:initHeroList(cellClass, cellPrefab, sortMap, filterMap, allHeros, topFunc)
	self.cellClass = cellClass
	self.cellPrefab = cellPrefab
	self.allHeros = allHeros

	self.panelSort:initSortPanel(sortMap, filterMap, topFunc)
end

function CommonHeroListPanel:updateHeroFilter(filter, goToTop)
	self:updateHeroBag(nil, filter, goToTop)
end

function CommonHeroListPanel:refreshSort(...)
	self.panelSort:refreshHeros()
end

function CommonHeroListPanel:filterSort(...)
	self.panelSort:_filterHeros()
end

function CommonHeroListPanel:updateHeroBag(allHeros, filter, goToTop)
	self.allHeros = allHeros or self.allHeros
	self.filter = filter or {}
	self.showHeros = {}

	local haveNewNotInTeamFiveStar = false

	if CurAvatar.fiveUpStarHeroDic then
		self.mWindow.fiveUpStarNotInTeamHeroDic = {}

		for gid, hero in pairs(CurAvatar.fiveUpStarHeroDic) do
			self.mWindow.fiveUpStarNotInTeamHeroDic[gid] = hero
		end
	end

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			for gid, hero in pairs(self.mWindow.fiveUpStarNotInTeamHeroDic) do
				if hero.gid == obj.hero.gid then
					self.mWindow.fiveUpStarNotInTeamHeroDic[gid] = nil
				end
			end
		end
	end

	for _, hero in ipairs(self.allHeros) do
		if not self.filter[hero.gid] then
			if self.attrFilters then
				for _, filterInfo in ipairs(self.attrFilters) do
					if hero[filterInfo[1]] == filterInfo[2] then
						table.insert(self.showHeros, hero)

						if self.mWindow.fiveUpStarNotInTeamHeroDic and self.mWindow.fiveUpStarNotInTeamHeroDic[hero.gid] ~= nil then
							haveNewNotInTeamFiveStar = true
						end

						break
					end
				end
			else
				table.insert(self.showHeros, hero)

				if self.mWindow.fiveUpStarNotInTeamHeroDic and self.mWindow.fiveUpStarNotInTeamHeroDic[hero.gid] ~= nil then
					haveNewNotInTeamFiveStar = true
				end
			end
		end
	end

	local heroCount = #self.showHeros

	for idx, cell in pairs(self.cells) do
		local hero = self.showHeros[idx]

		if hero then
			cell:setHero(hero)
		end
	end

	if self.mWindow.imgIconNew and self.mWindow.imgIconNew2 then
		self.mWindow.imgIconNew:setVisible(haveNewNotInTeamFiveStar)
		self.mWindow.imgIconNew2:setVisible(haveNewNotInTeamFiveStar)
	end

	if self.panelBgNone then
		self.panelBgNone:setVisible(heroCount <= 0)
	end

	if goToTop then
		self.scrollHeros:setTotalCount(heroCount, 1)
	else
		self.scrollHeros:setTotalCount(heroCount)
	end
end

function CommonHeroListPanel:onHerosChanged(heros, goToTop)
	self:updateHeroBag(heros, self.filter, goToTop)
end

function CommonHeroListPanel:onHeroCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = self.cellClass(sender, self.cellPrefab, newIdx, 0, 0)

		targetCell:setSelectCallback(self._slot4CellSelect)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local hero = self.showHeros[newIdx]

	if hero then
		targetCell:setHero(hero)

		targetCell.isDragTip = self.isDragTip

		targetCell.imgStateIcon:setVisible(false)
		targetCell:setSelected(hero.gid == self.tgtHeroGID)
	end

	self.cells[newIdx] = targetCell
end

function CommonHeroListPanel:onHeroCellSelect(tgtCell)
	self.tgtHeroGID = tgtCell.hero.gid

	for idx, cell in pairs(self.cells) do
		cell:setSelected(cell == tgtCell)
	end
end

return CommonHeroListPanel
