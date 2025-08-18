-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\WishCardSelectPanel.lua

local strClassName = "WishCardSelectPanel"
local WishCardSelectPanel = Class(strClassName, UIControls.Panel)
local SelectHeroCell = Class("SelectHeroCell", UIControls.ScrollViewLoopCell)

function SelectHeroCell:ctor(...)
	self:initUI()
end

function SelectHeroCell:initUI(...)
	self.selectedPanel = UIControls.Panel(self, "GridHeroPoolWish/HeroCheck")
	self.heroPanel = UIControls.HeroHeadGridPanel(self, "GridHeroPoolWish")
	self.heroPanel.mEventClick = Slot(self._onClickRootBtn, self)

	self.heroPanel.btnHeroHead:addEventHoldClick(Slot(self._onHoldRootBtn, self))

	self.newPanel = UIControls.Panel(self, "GridHeroPoolWish/NewLabel")
	self.recommendPanel = UIControls.Panel(self, "GridHeroPoolWish/RecLabel")
end

function SelectHeroCell:setHero(hero)
	self.hero = hero

	self.heroPanel:setObj(hero)
end

function SelectHeroCell:refreshHeroState(isSelected)
	self.isSelected = isSelected

	self.selectedPanel:setVisible(isSelected)
end

function SelectHeroCell:setNewHero(isNew)
	if isNew then
		self.newPanel:setVisible(true)
	else
		self.newPanel:setVisible(false)
	end
end

function SelectHeroCell:setRecommendHero(isRecommond)
	if isRecommond then
		self.recommendPanel:setVisible(true)
	else
		self.recommendPanel:setVisible(false)
	end
end

function SelectHeroCell:_onClickRootBtn(...)
	if self.mParent.cellClickCallback ~= nil then
		self.mParent.cellClickCallback(self.hero, not self.isSelected)
	end
end

function SelectHeroCell:_onHoldRootBtn(...)
	if self.hero then
		local object = BaseObject.GetObject(self.hero.id, self.hero.star)

		UIManager.getUI("heroTips"):showObj(self, object)
	end
end

function WishCardSelectPanel:ctor(...)
	self:initUI()
end

function WishCardSelectPanel:initUI(...)
	self.cellList = {}
	self.scrollCard = UIControls.ScrollViewLoopV(self, self.mPath .. "/CardPanel")

	self.scrollCard:addEventCellChanged(self.onCellChanged)
end

function WishCardSelectPanel:setHeroList(heroList, selectedHeroIdList, newHeroIdList, desireRecommendList, curCamp)
	if curCamp ~= self.curCamp then
		self.curCamp = curCamp

		local newHeroIdDict = {}

		if newHeroIdList then
			for _, heroId in ipairs(newHeroIdList) do
				newHeroIdDict[heroId] = true
			end
		end

		local recommendHeroIdDict = {}

		if desireRecommendList then
			for _, heroId in ipairs(desireRecommendList) do
				recommendHeroIdDict[heroId] = true
			end
		end

		self.recommendHeroIdDict = recommendHeroIdDict
		self.heroList = self:_sortHeroList(heroList, newHeroIdDict, recommendHeroIdDict)
		self.newHeroIdDict = newHeroIdDict
		self.selectedHeroIds = {}

		for _, heroId in ipairs(selectedHeroIdList) do
			self.selectedHeroIds[heroId] = true
		end

		self.scrollCard:setTotalCount(#self.heroList, 1)
	else
		local newHeroIdDict = {}

		if newHeroIdList then
			for _, heroId in ipairs(newHeroIdList) do
				newHeroIdDict[heroId] = true
			end
		end

		self.newHeroIdDict = newHeroIdDict

		local recommendHeroIdDict = {}

		if desireRecommendList then
			for _, heroId in ipairs(desireRecommendList) do
				recommendHeroIdDict[heroId] = true
			end
		end

		self.recommendHeroIdDict = recommendHeroIdDict
		self.selectedHeroIds = {}

		for _, heroId in ipairs(selectedHeroIdList) do
			self.selectedHeroIds[heroId] = true
		end

		self.scrollCard:setTotalCount(#self.heroList)
	end
end

function WishCardSelectPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SelectHeroCell(sender, "System/HeroPool/BtnHeroPoolWish2", newIdx, 0, 0)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local hero = self.heroList[newIdx]

	if hero then
		targetCell:setHero(hero)
		targetCell:refreshHeroState(self.selectedHeroIds[hero.id] == true)
		targetCell:setNewHero(self.newHeroIdDict[hero.id] == true)
		targetCell:setRecommendHero(self.newHeroIdDict[hero.id] ~= true and self.recommendHeroIdDict[hero.id] == true)
	end

	self.cellList[newIdx] = targetCell
end

function WishCardSelectPanel:setCellClickCallback(cellClickCB)
	self.cellClickCallback = cellClickCB
end

local function SortByStar(a, b)
	if a.star ~= b.star then
		return a.star > b.star
	else
		return a.id < b.id
	end
end

function WishCardSelectPanel:_sortHeroList(heroList, newHeroIdDict, recommendHeroIdDict)
	local newList = {}
	local commonList = {}
	local maxList = {}
	local recommendList = {}

	for i, hero in ipairs(heroList) do
		if newHeroIdDict[hero.id] then
			table.insert(newList, hero)
		elseif recommendHeroIdDict[hero.id] then
			table.insert(recommendList, hero)
		elseif CurAvatar:hasMaxStarHeroId(hero.id) then
			table.insert(maxList, hero)
		else
			table.insert(commonList, hero)
		end
	end

	table.sort(commonList, SortByStar)

	for i, v in ipairs(recommendList) do
		table.insert(newList, v)
	end

	for i, v in ipairs(commonList) do
		table.insert(newList, v)
	end

	for i, v in ipairs(maxList) do
		table.insert(newList, v)
	end

	return newList
end

return WishCardSelectPanel
