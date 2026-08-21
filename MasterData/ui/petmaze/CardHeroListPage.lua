-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\CardHeroListPage.lua

local ResHero = require("ClientData/ResHero")
local FilterTitleBtnPanel = require("UI/MainState/FilterTitleBtnPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local CardHeroListPage = Class("CardHeroListPage", UIControls.Panel)

function CardHeroListPage:ctor()
	self.btnSave = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnCancel = UIControls.Button(self, self.mPath .. "/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, self.mPath .. "/HeroList")

	self.scrollView:addEventCellChanged(self.onHeroCellChange)

	self.slotOnCellSelect = Slot(self.onCellSelect, self)
	self.slotFilterHeroCard = Slot(self.filterHeroCard, self)
	self.filterSelectPanel = FilterSelectPanel(self, self.mPath .. "/ListSelectPanel")
	self.filterTitleBtnPanel = FilterTitleBtnPanel(self, self.mPath .. "/ListFunPanel/SelectPanel", 3, self.filterSelectPanel, self.slotFilterHeroCard, UIConst.CLAN_CLEAR_FILTER_PANEL_MAP)
	self.showHeroList = nil
	self.heroDic = nil
	self.selectHeroGidList = {}
	self.selectHeroDic = nil
	self.maxNumTip = Lang.get(76929)
	self.necessaryHeroTip = ""
end

function CardHeroListPage:init(maxSelectNum, excludeSameHero, necessaryHeroId, cancelAction, confirmAction, showCellAction, selectHeroChangeAction, sortHeroAction)
	self.maxSelectNum = maxSelectNum
	self.excludeSameHero = excludeSameHero
	self.necessaryHeroId = necessaryHeroId and necessaryHeroId > 0 and necessaryHeroId or nil
	self.necessaryHeroFullName = nil

	if self.necessaryHeroId then
		self.necessaryHeroFullName = ResHero[self.necessaryHeroId].full_name
	end

	self.cancelAction = cancelAction
	self.confirmAction = confirmAction
	self.showCellAction = showCellAction
	self.selectHeroChangeAction = selectHeroChangeAction
	self.sortHeroAction = sortHeroAction
end

function CardHeroListPage:setTip(maxNumTip, necessaryHeroTip)
	self.maxNumTip = maxNumTip or self.maxNumTip
	self.necessaryHeroTip = necessaryHeroTip or self.necessaryHeroTip
end

function CardHeroListPage:onOpen(selectHeroGidList, excludeHeroIdDic, heroDic)
	self.heroDic = heroDic or CurAvatar.heroDic
	self.excludeHeroIdDic = excludeHeroIdDic
	self.selectHeroGidList = {}
	self.selectHeroDic = {}

	if selectHeroGidList then
		for i = 1, #selectHeroGidList do
			local gid = selectHeroGidList[i]
			local hero = self.heroDic[gid]

			if hero then
				if #self.selectHeroGidList >= self.maxSelectNum then
					break
				end

				self.selectHeroDic[gid] = hero

				table.insert(self.selectHeroGidList, gid)
			end
		end
	end

	self.allHeroList = {}

	for gid, hero in pairs(self.heroDic) do
		if not self.excludeHeroIdDic or not self.excludeHeroIdDic[hero.id] then
			table.insert(self.allHeroList, hero)
		end
	end

	self.filterTitleBtnPanel:setFilterClear()
	self:refreshHerosShow(self.allHeroList)
end

function CardHeroListPage:filterHeroCard(filterAction)
	local heroList = {}

	for _, hero in ipairs(self.allHeroList) do
		if filterAction(hero) then
			table.insert(heroList, hero)
		end
	end

	self:refreshHerosShow(heroList)
end

function CardHeroListPage:refreshHerosShow(heroList)
	self.sortHeroList = self.sortHeroList or function(hero1, hero2)
		local res = 0

		res = res + (hero1.level > hero2.level and 100 or hero1.level < hero2.level and -100 or 0)
		res = res + (hero1.star > hero2.star and 10 or hero1.star < hero2.star and -10 or 0)
		res = res + (hero1.id > hero2.id and 1 or hero1.id < hero2.id and -1 or 0)

		return res > 0
	end

	table.sort(heroList, self.sortHeroList)

	local insertList = {}

	for i = #heroList, 1, -1 do
		local hero = heroList[i]

		if self.selectHeroDic[hero.gid] ~= nil then
			table.insert(insertList, hero)
			table.remove(heroList, i)
		end
	end

	for i = 1, #insertList do
		table.insert(heroList, 1, insertList[i])
	end

	self.showHeroList = heroList

	if self.sortHeroAction then
		self.sortHeroAction(self.showHeroList)
	end

	self.scrollView:setTotalCount(#self.showHeroList)
end

function CardHeroListPage:onHeroCellChange(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx, 0, 0)

		targetCell:setSelectCallback(self.slotOnCellSelect)
	else
		targetCell.mIndex = newIdx
	end

	local hero = self.showHeroList[newIdx]

	if hero then
		targetCell:setHero(hero)

		targetCell.isDragTip = false

		targetCell.imgStateIcon:setVisible(false)

		targetCell.showSelect = true

		targetCell:setSelected(self.selectHeroDic[hero.gid] ~= nil)

		if self.showCellAction then
			self.showCellAction(targetCell)
		end
	end
end

function CardHeroListPage:onCellSelect(sender)
	local hero = sender.hero
	local gid = sender.hero.gid

	if self.selectHeroDic[gid] then
		sender:setSelected(false)

		self.selectHeroDic[gid] = nil

		for i = #self.selectHeroGidList, 1, -1 do
			if self.selectHeroGidList[i] == gid then
				table.remove(self.selectHeroGidList, i)

				break
			end
		end

		if self.selectHeroChangeAction then
			self.selectHeroChangeAction(self.selectHeroGidList)
		end
	else
		local curSelectNum = #self.selectHeroGidList

		if curSelectNum >= self.maxSelectNum then
			MsgManager.notice(self.maxNumTip)
		else
			local checkConflictSame = false

			if self.excludeSameHero then
				local id = sender.hero.id

				for k, v in pairs(self.selectHeroDic) do
					if v.id == id then
						checkConflictSame = true

						break
					end
				end
			end

			if checkConflictSame then
				MsgManager.notice(string.format(Lang.get(30255), ""))
			else
				local checkConlictNecessary = false

				if self.necessaryHeroId and curSelectNum == self.maxSelectNum - 1 and sender.hero.id ~= self.necessaryHeroId then
					checkConlictNecessary = true

					for k, v in pairs(self.selectHeroDic) do
						if v.id == self.necessaryHeroId then
							checkConlictNecessary = false

							break
						end
					end
				end

				if checkConlictNecessary then
					MsgManager.notice(self.necessaryHeroTip)
				else
					sender:setSelected(true)

					self.selectHeroDic[gid] = hero

					table.insert(self.selectHeroGidList, gid)

					if self.selectHeroChangeAction then
						self.selectHeroChangeAction(self.selectHeroGidList)
					end
				end
			end
		end
	end
end

function CardHeroListPage:cancelSelectCell(gid)
	if self.selectHeroDic[gid] then
		self.selectHeroDic[gid] = nil

		for i = #self.selectHeroGidList, 1, -1 do
			if self.selectHeroGidList[i] == gid then
				table.remove(self.selectHeroGidList, i)

				break
			end
		end

		self.scrollView:refreshCells()

		if self.selectHeroChangeAction then
			self.selectHeroChangeAction(self.selectHeroGidList)
		end
	end
end

function CardHeroListPage:onBtnCancelClick()
	if self.cancelAction() then
		self.cancelAction()
	end
end

function CardHeroListPage:onBtnSaveClick()
	if self.confirmAction then
		self.confirmAction(self.selectHeroGidList)
	end
end

return CardHeroListPage
