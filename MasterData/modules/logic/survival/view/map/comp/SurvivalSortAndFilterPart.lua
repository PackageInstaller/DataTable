-- chunkname: @modules/logic/survival/view/map/comp/SurvivalSortAndFilterPart.lua

module("modules.logic.survival.view.map.comp.SurvivalSortAndFilterPart", package.seeall)

local SurvivalSortAndFilterPart = class("SurvivalSortAndFilterPart", LuaCompBase)

function SurvivalSortAndFilterPart:init(go)
	self._btnsort = gohelper.findChildButtonWithAudio(go, "#btn_sort")
	self._btnfilter = gohelper.findChildButtonWithAudio(go, "#btn_filter")
	self._sortTips = gohelper.findChild(go, "#btn_sort/#go_tips")
	self._filterTips = gohelper.findChild(go, "#btn_filter/#go_tips")
	self._sortItem = gohelper.findChild(go, "#btn_sort/#go_tips/#go_item")
	self._filterItem = gohelper.findChild(go, "#btn_filter/#go_tips/#go_item")
	self._gosortdown = gohelper.findChild(go, "#btn_sort/#go_down")
	self._gosortup = gohelper.findChild(go, "#btn_sort/#go_up")
	self._txtsort = gohelper.findChildTextMesh(go, "#btn_sort/#txt_desc")
	self._gofilterselect = gohelper.findChild(go, "#btn_filter/#go_select")
end

function SurvivalSortAndFilterPart:addEventListeners()
	self._btnsort:AddClickListener(self._openCloseSortTips, self)
	self._btnfilter:AddClickListener(self._openCloseFilterTips, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
end

function SurvivalSortAndFilterPart:removeEventListeners()
	self._btnsort:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

function SurvivalSortAndFilterPart:setOptions(sortOptions, filterOptions, defaultSort, isDec)
	self._curSortType = defaultSort or sortOptions[1]
	self._isSortDec = isDec or false
	self._filterList = {}
	self._sortItems = {}
	self._filterItems = {}

	gohelper.CreateObjList(self, self._createSortItem, sortOptions, nil, self._sortItem, nil, nil, nil, 1)
	gohelper.CreateObjList(self, self._createFilterItem, filterOptions, nil, self._filterItem, nil, nil, nil, 1)
	self:onChange()
end

function SurvivalSortAndFilterPart:_createSortItem(obj, data, index)
	self._sortItems[index] = self:getUserDataTb_()
	self._sortItems[index].selectbg = gohelper.findChild(obj, "selectbg")
	self._sortItems[index].data = data

	local txtdesc = gohelper.findChildTextMesh(obj, "#txt_desc")

	txtdesc.text = data.desc
	self._sortItems[index].txtdesc = txtdesc
	self._sortItems[index].godown = gohelper.findChild(obj, "#go_down")
	self._sortItems[index].goup = gohelper.findChild(obj, "#go_up")

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onClickSortItem, self, data)
end

function SurvivalSortAndFilterPart:_onClickSortItem(data)
	if self._curSortType == data then
		self._isSortDec = not self._isSortDec
	else
		self._curSortType = data
	end

	self:onChange()
end

function SurvivalSortAndFilterPart:_createFilterItem(obj, data, index)
	self._filterItems[index] = self:getUserDataTb_()
	self._filterItems[index].selectbg = gohelper.findChild(obj, "selectbg")

	local txtdesc = gohelper.findChildTextMesh(obj, "#txt_desc")

	txtdesc.text = data.desc
	self._filterItems[index].txtdesc = txtdesc
	self._filterItems[index].data = data

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onClickFilterItem, self, data)
end

function SurvivalSortAndFilterPart:_onClickFilterItem(data)
	local index = tabletool.indexOf(self._filterList, data)

	if index then
		table.remove(self._filterList, index)
	else
		table.insert(self._filterList, data)
	end

	self:onChange()
end

function SurvivalSortAndFilterPart:setOptionChangeCallback(callback, callobj)
	self._changeCallback = callback
	self._changeCallobj = callobj
end

function SurvivalSortAndFilterPart:_openCloseSortTips()
	gohelper.setActive(self._sortTips, not self._sortTips.activeSelf)
	gohelper.setActive(self._filterTips, false)
end

function SurvivalSortAndFilterPart:_openCloseFilterTips()
	gohelper.setActive(self._filterTips, not self._filterTips.activeSelf)
	gohelper.setActive(self._sortTips, false)
end

function SurvivalSortAndFilterPart:onTouchScreen()
	if self._filterTips.activeSelf then
		if gohelper.isMouseOverGo(self._filterTips) or gohelper.isMouseOverGo(self._btnfilter) then
			return
		end

		gohelper.setActive(self._filterTips, false)
	end

	if self._sortTips.activeSelf then
		if gohelper.isMouseOverGo(self._sortTips) or gohelper.isMouseOverGo(self._btnsort) then
			return
		end

		gohelper.setActive(self._sortTips, false)
	end
end

function SurvivalSortAndFilterPart:onChange()
	self._txtsort.text = self._curSortType.desc

	gohelper.setActive(self._gosortdown, self._isSortDec)
	gohelper.setActive(self._gosortup, not self._isSortDec)

	for index, item in ipairs(self._sortItems) do
		local isSelect = item.data == self._curSortType

		gohelper.setActive(item.selectbg, isSelect)
		gohelper.setActive(item.godown, isSelect and self._isSortDec)
		gohelper.setActive(item.goup, isSelect and not self._isSortDec)
		SLFramework.UGUI.GuiHelper.SetColor(item.txtdesc, isSelect and "#000000" or "#FFFFFF")
	end

	for index, item in ipairs(self._filterItems) do
		local isSelect = tabletool.indexOf(self._filterList, item.data)

		gohelper.setActive(item.selectbg, isSelect)
		SLFramework.UGUI.GuiHelper.SetColor(item.txtdesc, isSelect and "#000000" or "#FFFFFF")
	end

	gohelper.setActive(self._gofilterselect, (next(self._filterList)))

	if self._changeCallback then
		self._changeCallback(self._changeCallobj, self._curSortType, self._isSortDec, self._filterList)
	end
end

return SurvivalSortAndFilterPart
