-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroHandbookViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroHandbookViewContainer", package.seeall)

local V3a6YaMiSelectHeroHandbookViewContainer = class("V3a6YaMiSelectHeroHandbookViewContainer", BaseViewContainer)

function V3a6YaMiSelectHeroHandbookViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/scroll_employeelist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6YaMiSelectHeroHandbookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = V3a6YaMiEnum.HeroHandbookRowCount
	scrollParam.cellWidth = 275
	scrollParam.cellHeight = V3a6YaMiEnum.HeroHandbookItemHight
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	self._scrollview = LuaListScrollView.New(V3a6YaMiHeroHandbookListModel.instance, scrollParam)

	table.insert(views, self._scrollview)
	table.insert(views, V3a6YaMiSelectHeroHandbookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_panel"))
	table.insert(views, TabViewGroup.New(3, "root/#go_fundingitem"))

	return views
end

function V3a6YaMiSelectHeroHandbookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.detailView = V3a6YaMiHeroHandbookDetailView.New()

		return {
			self.detailView
		}
	elseif tabContainerId == 3 then
		self.currencyView = V3a6YaMiCurrencyView.New()

		return {
			self.currencyView
		}
	end
end

function V3a6YaMiSelectHeroHandbookViewContainer:onEquipHero(id, showToast)
	local index = tabletool.indexOf(self._equipedHeros, id)

	if index then
		table.remove(self._equipedHeros, index)
		V3a6YaMiHeroHandbookListModel.instance:selectCell(0, true)
	else
		local mo = V3a6YaMiModel.instance:getHeroMoById(id)

		if mo then
			if mo.isLock then
				return
			end

			if self._equipedHeros then
				if not #self._equipedHeros then
					local heroCount = 0
					local seatCount = V3a6YaMiModel.instance:getSeatCount()

					if seatCount <= heroCount then
						if showToast then
							GameFacade.showToast(V3a6YaMiEnum.ToastId.SelectHerosMaxCount)
						end

						return
					end

					local isUnlockSeat = V3a6YaMiModel.instance:isUnlockSeat(heroCount + 1)

					if not isUnlockSeat then
						if showToast then
							GameFacade.showToast(V3a6YaMiEnum.ToastId.SelectHerosMaxCount)
						end

						return
					end

					table.insert(self._equipedHeros, id)
				end
			end
		end
	end
end

function V3a6YaMiSelectHeroHandbookViewContainer:getIndexEquipedHero(id)
	if self._equipedHeros then
		return (tabletool.indexOf(self._equipedHeros, id))
	end
end

function V3a6YaMiSelectHeroHandbookViewContainer:getSelectHeroIdByIndex(index)
	return (self._equipedHeros or nil) and (self._equipedHeros[index] or 0)
end

function V3a6YaMiSelectHeroHandbookViewContainer:correcteSelectHeros()
	self._equipedHeros = {}

	local list = V3a6YaMiModel.instance:getSelectHeros()

	if list then
		for index, id in ipairs(list) do
			self._equipedHeros[index] = id
		end
	end
end

function V3a6YaMiSelectHeroHandbookViewContainer:getSelectHeroCount()
	return (self._equipedHeros or nil) and (#self._equipedHeros or 0)
end

function V3a6YaMiSelectHeroHandbookViewContainer:onConfirmSelectHeros()
	V3a6YaMiModel.instance:onConfirmSelectHeros(self._equipedHeros)
end

function V3a6YaMiSelectHeroHandbookViewContainer:isForceHideUnlockBtn()
	return false
end

return V3a6YaMiSelectHeroHandbookViewContainer
