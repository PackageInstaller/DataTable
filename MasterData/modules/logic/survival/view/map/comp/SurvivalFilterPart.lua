-- chunkname: @modules/logic/survival/view/map/comp/SurvivalFilterPart.lua

module("modules.logic.survival.view.map.comp.SurvivalFilterPart", package.seeall)

local SurvivalFilterPart = class("SurvivalFilterPart", LuaCompBase)

function SurvivalFilterPart:init(go)
	self._btnfilter = gohelper.findChildButtonWithAudio(go, "")
	self._filterTips = gohelper.findChild(go, "#go_tips")
	self._filterItem = gohelper.findChild(go, "#go_tips/#go_item")
	self._gofilterselect = gohelper.findChild(go, "#go_select")

	gohelper.setActive(self._filterTips, false)
end

function SurvivalFilterPart:addEventListeners()
	self._btnfilter:AddClickListener(self._openCloseFilterTips, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
end

function SurvivalFilterPart:removeEventListeners()
	self._btnfilter:RemoveClickListener()
end

function SurvivalFilterPart:setOptions(filterOptions)
	self._filterList = {}
	self._filterItems = {}

	gohelper.CreateObjList(self, self._createFilterItem, filterOptions, nil, self._filterItem, nil, nil, nil, 1)
	self:onChange()
end

function SurvivalFilterPart:_createFilterItem(obj, data, index)
	self._filterItems[index] = self:getUserDataTb_()
	self._filterItems[index].selectbg = gohelper.findChild(obj, "selectbg")

	local txtdesc = gohelper.findChildTextMesh(obj, "#txt_desc")

	txtdesc.text = data.desc
	self._filterItems[index].txtdesc = txtdesc
	self._filterItems[index].data = data

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onClickFilterItem, self, data)
end

function SurvivalFilterPart:_onClickFilterItem(data)
	local index = tabletool.indexOf(self._filterList, data)

	if index then
		table.remove(self._filterList, index)
	else
		table.insert(self._filterList, data)
	end

	self:onChange()
end

function SurvivalFilterPart:setOptionChangeCallback(callback, callobj)
	self._changeCallback = callback
	self._changeCallobj = callobj
end

function SurvivalFilterPart:_openCloseFilterTips()
	gohelper.setActive(self._filterTips, not self._filterTips.activeSelf)

	if self._clickCb and self._callobj then
		self._clickCb(self._callobj, self._filterTips.activeSelf)
	end
end

function SurvivalFilterPart:onTouchScreen()
	if self._filterTips.activeSelf then
		if gohelper.isMouseOverGo(self._filterTips) or gohelper.isMouseOverGo(self._btnfilter) then
			return
		end

		gohelper.setActive(self._filterTips, false)

		if self._clickCb and self._callobj then
			self._clickCb(self._callobj, self._filterTips.activeSelf)
		end
	end
end

function SurvivalFilterPart:onChange()
	for index, item in ipairs(self._filterItems) do
		local isSelect = tabletool.indexOf(self._filterList, item.data)

		gohelper.setActive(item.selectbg, isSelect)
		SLFramework.UGUI.GuiHelper.SetColor(item.txtdesc, isSelect and "#000000" or "#FFFFFF")
	end

	gohelper.setActive(self._gofilterselect, (next(self._filterList)))

	if self._changeCallback then
		self._changeCallback(self._changeCallobj, self._filterList)
	end
end

function SurvivalFilterPart:setClickCb(cb, callobj)
	self._clickCb = cb
	self._callobj = callobj
end

function SurvivalFilterPart:onDestroy()
	self._clickCb = nil
	self._callobj = nil
	self._changeCallback = nil
	self._changeCallobj = nil
end

return SurvivalFilterPart
