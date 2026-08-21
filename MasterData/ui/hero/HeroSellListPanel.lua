-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSellListPanel.lua

local strClassName = "HeroSellListPanel"
local HeroSellListPanel = Class(strClassName, UIControls.Panel)
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local HERO_SELL_FILTER_MAP = {
	{
		title = Lang.get(1204),
		data = {
			{
				Lang.get(30355),
				"star",
				2
			},
			{
				Lang.get(30356),
				"star",
				3
			}
		}
	}
}

function HeroSellListPanel:ctor()
	self:initUI()
end

function HeroSellListPanel:initUI()
	self.cells = {}
	self.panelNoContent = UIControls.Panel(self, self.mPath .. "/NoContent")
	self.scroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/HeroList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.btnChoose = UIControls.Button(self, self.mPath .. "/ListFunPanel/BtnHeroQselect")

	self.btnChoose:addEventClick(self.onBtnChooseClick)

	self.btnHighQChoose = UIControls.Button(self, self.mPath .. "/ListFunPanel/BtnHeroAll")

	self.btnHighQChoose:addEventClick(self.onBtnHighQChooseClick)

	self.imgNewChoose = UIControls.Image(self, self.mPath .. "/ListFunPanel/BtnHeroQselect/IconNew")
	self.heroList = {}
	self.gidIdxDic = {}
	self.sortPanel = CommonSortPanel(self, self.mPath .. "/ListFunPanel")
	self.sortPanel.mEventDataListChanged = Slot(self.updateSort, self)

	self.sortPanel:initSortInfo(UIConst.SELL_HERO_SORT_MAP, true)

	self.filterConfig = ClientUtils.getFilterConfig({
		{
			1,
			2
		}
	})
end

function HeroSellListPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setHero(self.heroList[newIdx])
	targetCell:setHeroRealLv()
	targetCell.imgStateIcon:setVisible(CurAvatar.asyncPVPDefendFormation[targetCell.hero.gid] ~= nil)
	targetCell:setSelectCallback(Slot(self.clickSellHeroCard, self))

	self.cells[newIdx] = targetCell
	self.gidIdxDic[self.heroList[newIdx].gid] = newIdx
end

function HeroSellListPanel:onBtnHighQChooseClick()
	if #self.heroList > 0 then
		local function yesFunc()
			local sellHeros = {}

			for _, hero in ipairs(self.heroList) do
				if not CurAvatar.asyncPVPDefendFormation[hero.gid] then
					table.insert(sellHeros, hero)
				end
			end

			if #sellHeros > 0 then
				for _, hero in ipairs(sellHeros) do
					self.mWindow:setHeroToSell(hero, true)
				end

				self.mWindow.herolistPanel:refreshPanel()
				self.mWindow.heroSellPreviewPanel:refreshPanel()
			end
		end

		local msgContent = ClientUtils.getClientNotice(347)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	end
end

function HeroSellListPanel:onBtnChooseClick()
	local sellHeros = {}

	for _, hero in ipairs(self.heroList) do
		if not CurAvatar.asyncPVPDefendFormation[hero.gid] and hero.resData.can_sell ~= 2 then
			table.insert(sellHeros, hero)
		end
	end

	if #sellHeros > 0 then
		for _, hero in ipairs(sellHeros) do
			self.mWindow:setHeroToSell(hero, true)
		end

		self.mWindow.herolistPanel:refreshPanel()
		self.mWindow.heroSellPreviewPanel:refreshPanel()
	end
end

function HeroSellListPanel:filterCallBack(checkFilterFunc, _filterConfig)
	self.checkFilterFunc = checkFilterFunc

	local sellHeros = {}

	if self.checkFilterFunc then
		for _, hero in ipairs(self.heroList) do
			if self.checkFilterFunc(hero) and not CurAvatar.asyncPVPDefendFormation[hero.gid] then
				table.insert(sellHeros, hero)
			end
		end
	end

	for _, hero in ipairs(sellHeros) do
		self.mWindow:setHeroToSell(hero)
	end

	local siftBoxDlgSingle = UIManager.getUI("siftBoxDlgSingle", nil, false)

	if siftBoxDlgSingle then
		siftBoxDlgSingle:setVisible(false)
	end
end

function HeroSellListPanel:refreshPanel()
	self.sortPanel:sortByCurConfig(self.heroList)
	self.btnHighQChoose:setVisible(false)
	self.imgNewChoose:setVisible(false)

	for _, hero in ipairs(self.heroList) do
		if hero.resData.can_sell == 2 then
			self.btnHighQChoose:setVisible(true)
		else
			self.imgNewChoose:setVisible(true)
		end

		if self.btnHighQChoose:getVisible() and self.imgNewChoose:getVisible() then
			break
		end
	end
end

function HeroSellListPanel:updateSort(heroList)
	self.heroList = heroList

	self.scroll:setTotalCount(#self.heroList)

	self.startIdx = 1

	self.sortPanel:setVisible(#self.heroList ~= 0)
	self.panelNoContent:setVisible(#self.heroList == 0)
end

function HeroSellListPanel:clickSellHeroCard(sender)
	if self.mWindow:isLastAsyncFormationHero(sender.hero) then
		MsgManager.notice(Lang.get(30357))

		return
	end

	if sender.hero.resData.can_sell == 2 and not CurAvatar.sellHighQHeroNoConfirm then
		local function yesFunc()
			CurAvatar.sellHighQHeroNoConfirm = self.confirmui.attentionSwitch:isOn()
			self.startIdx = math.max(self.gidIdxDic[sender.hero.gid] - 8, 1)

			self.mWindow:setHeroToSell(sender.hero)
		end

		local function noFunc()
			CurAvatar.sellHighQHeroNoConfirm = self.confirmui.attentionSwitch:isOn()
		end

		local msgContent = ClientUtils.getClientNotice(340)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(30358), msgContent, yesFunc, noFunc, -1)

		self.confirmui = UIManager.getUI("confirmui", nil, false)

		self.confirmui:showToggle(Lang.get(30272), CurAvatar.sellHighQHeroNoConfirm or false)

		return
	end

	self.startIdx = math.max(self.gidIdxDic[sender.hero.gid] - 6, 1)

	self.mWindow:setHeroToSell(sender.hero)
end

function HeroSellListPanel:setHeroList(_heroList)
	self.heroList = _heroList

	self:refreshPanel()
end

function HeroSellListPanel:addHero(hero, noRefresh)
	table.insert(self.heroList, hero)

	if not noRefresh then
		self:refreshPanel()
	end
end

function HeroSellListPanel:delHero(hero, noRefresh)
	local heroCount = #self.heroList

	for idx = heroCount, 1, -1 do
		if self.heroList[idx].gid == hero.gid then
			table.remove(self.heroList, idx)
		end
	end

	if not noRefresh then
		self:refreshPanel()
	end
end

return HeroSellListPanel
