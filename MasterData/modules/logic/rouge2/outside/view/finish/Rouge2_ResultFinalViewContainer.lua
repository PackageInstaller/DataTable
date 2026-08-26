-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultFinalViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultFinalViewContainer", package.seeall)

local Rouge2_ResultFinalViewContainer = class("Rouge2_ResultFinalViewContainer", BaseViewContainer)

function Rouge2_ResultFinalViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ResultFinalView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, self:_buildBuffListScrollView())
	table.insert(views, self:_buildAttrBuffListScrollView())

	return views
end

function Rouge2_ResultFinalViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function Rouge2_ResultFinalViewContainer:_buildBuffListScrollView()
	self._buffListModel = ListScrollModel.New()

	if self.viewParam then
		local reviewInfo = self.viewParam.reviewInfo
		local buffList = reviewInfo and reviewInfo:getItemList(Rouge2_Enum.BagType.Buff)

		if buffList then
			if not #buffList then
				local buffNum = 0

				if buffNum > 12 then
					if not ScrollEnum.ScrollDirH then
						local scrollDir = ScrollEnum.ScrollDirV
						local lineCount = buffNum > 12 and 2 or 6
						local scrollParam = ListScrollParam.New()

						scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
						scrollParam.scrollGOPath = "Right/Layout/#go_BuffContainer/#scroll_Buff"
						scrollParam.prefabUrl = "Right/Layout/#go_BuffContainer/#scroll_Buff/Viewport/Content/#go_BuffItem"
						scrollParam.scrollDir = scrollDir
						scrollParam.cellClass = Rouge2_SaveInfoDetailBuffListItem
						scrollParam.cellWidth = 144
						scrollParam.cellHeight = 136
						scrollParam.startSpace = 0
						scrollParam.endSpace = 0
						scrollParam.lineCount = lineCount

						return LuaListScrollView.New(self._buffListModel, scrollParam)
					end
				end
			end
		end
	end
end

function Rouge2_ResultFinalViewContainer:_buildAttrBuffListScrollView()
	self._attrBuffListModel = ListScrollModel.New()

	local scrollParam = ListScrollParam.New()

	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.scrollGOPath = "Right/Layout/#go_AttrBuffContainer/#scroll_AttrBuff"
	scrollParam.prefabUrl = "Right/Layout/#go_AttrBuffContainer/#scroll_AttrBuff/Viewport/Content/#go_AttrBuffItem"
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellClass = Rouge2_SaveInfoDetailAttrBuffListItem
	scrollParam.cellWidth = 162
	scrollParam.cellHeight = 150
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0
	scrollParam.lineCount = 1

	return LuaListScrollView.New(self._attrBuffListModel, scrollParam)
end

function Rouge2_ResultFinalViewContainer:setBuffList(buffIdList)
	local moList = {}

	if buffIdList then
		for _, buffId in ipairs(buffIdList) do
			table.insert(moList, {
				itemId = buffId
			})
		end
	end

	table.sort(moList, self._itemSortFunc)
	self._buffListModel:setList(moList)
end

function Rouge2_ResultFinalViewContainer._itemSortFunc(aItemMo, bItemMo)
	local aItemId = aItemMo.itemId
	local bItemId = bItemMo.itemId
	local aItemCo = Rouge2_BackpackHelper.getItemConfig(aItemId)
	local bItemCo = Rouge2_BackpackHelper.getItemConfig(bItemId)

	if aItemCo.rare ~= bItemCo.rare then
		return aItemCo.rare > bItemCo.rare
	end

	return aItemId < bItemId
end

function Rouge2_ResultFinalViewContainer:setAttrBuffList(attrBuffIdList)
	local moList = {}

	if attrBuffIdList then
		for _, buffId in ipairs(attrBuffIdList) do
			table.insert(moList, {
				itemId = buffId
			})
		end
	end

	table.sort(moList, self._itemSortFunc)
	self._attrBuffListModel:setList(moList)
end

return Rouge2_ResultFinalViewContainer
