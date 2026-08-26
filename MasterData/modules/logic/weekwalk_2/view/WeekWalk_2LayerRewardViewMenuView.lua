-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2LayerRewardViewMenuView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardViewMenuView", package.seeall)

local WeekWalk_2LayerRewardViewMenuView = class("WeekWalk_2LayerRewardViewMenuView", BaseView)

function WeekWalk_2LayerRewardViewMenuView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2LayerRewardViewMenuView:addEvents()
	return
end

function WeekWalk_2LayerRewardViewMenuView:removeEvents()
	return
end

function WeekWalk_2LayerRewardViewMenuView:_editableInitView()
	self._goTabContent = gohelper.findChild(self.viewGO, "top/#scroll_TabList/Viewport/Content")
	self._goTabItem = gohelper.findChild(self.viewGO, "top/#scroll_TabList/Viewport/Content/#go_tabitem")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")

	gohelper.setActive(self._goTabItem, false)
end

function WeekWalk_2LayerRewardViewMenuView:onUpdateParam()
	return
end

function WeekWalk_2LayerRewardViewMenuView:onOpen()
	local mapId = self.viewParam.mapId

	self:_initPageList()
	self:_initTabList()

	self._selectedId = mapId

	self:_updateTabItems()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
end

function WeekWalk_2LayerRewardViewMenuView:_onWeekwalkTaskUpdate()
	self:_updateTabItems()
end

function WeekWalk_2LayerRewardViewMenuView:_initPageList()
	local pageList = {}

	self._info = WeekWalk_2Model.instance:getInfo()

	for i = 1, WeekWalk_2Enum.MaxLayer do
		pageList[i] = self._info:getLayerInfoByLayerIndex(i)
	end

	self._pageList = pageList
end

function WeekWalk_2LayerRewardViewMenuView:_initTabList()
	self._tabItemList = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onTabItemShow, self._pageList, self._goTabContent, self._goTabItem)
end

function WeekWalk_2LayerRewardViewMenuView:_onTabItemShow(obj, data, index)
	gohelper.setActive(obj, true)

	local select = gohelper.findChild(obj, "Select")
	local selectName = gohelper.findChildText(obj, "Select/#txt_SelectLevel")
	local selectHasGet = gohelper.findChild(obj, "Select/hasget")
	local selectCanGet = gohelper.findChild(obj, "Select/canget")
	local unselect = gohelper.findChild(obj, "UnSelect")
	local unselectName = gohelper.findChildText(obj, "UnSelect/#txt_UnSelectLevel")
	local unselectHasGet = gohelper.findChild(obj, "UnSelect/hasget")
	local unselectCanGet = gohelper.findChild(obj, "UnSelect/canget")
	local btnClick = gohelper.findChildButtonWithAudio(obj, "btn_click")

	btnClick:AddClickListener(self._btnClick, self, data.id)

	local name = GameUtil.getRomanNums(index)

	selectName.text = name
	unselectName.text = name
	self._tabItemList[index] = {
		data = data,
		select = select,
		selectHasGet = selectHasGet,
		selectCanGet = selectCanGet,
		unselect = unselect,
		unselectHasGet = unselectHasGet,
		unselectCanGet = unselectCanGet,
		btnClick = btnClick
	}
end

function WeekWalk_2LayerRewardViewMenuView:_btnClick(id)
	self._selectedId = id

	self:_updateTabItems()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeLayerRewardMapId, id)

	self._scrollreward.verticalNormalizedPosition = 1
end

function WeekWalk_2LayerRewardViewMenuView:_updateTabItems()
	for k, v in pairs(self._tabItemList) do
		local mapId = v.data.id
		local isSelected = mapId == self._selectedId

		gohelper.setActive(v.select, isSelected)
		gohelper.setActive(v.unselect, not isSelected)

		local taskType = WeekWalk_2Enum.TaskType.Season
		local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType, mapId)
		local canGetReward = canGetNum > 0

		if isSelected then
			gohelper.setActive(v.selectHasGet, not canGetReward and unFinishNum <= 0)
			gohelper.setActive(v.selectCanGet, canGetReward)
		else
			gohelper.setActive(v.unselectHasGet, not canGetReward and unFinishNum <= 0)
			gohelper.setActive(v.unselectCanGet, canGetReward)
		end
	end
end

function WeekWalk_2LayerRewardViewMenuView:onClose()
	if self._tabItemList then
		for k, v in pairs(self._tabItemList) do
			v.btnClick:RemoveClickListener()
		end
	end
end

function WeekWalk_2LayerRewardViewMenuView:onDestroyView()
	return
end

return WeekWalk_2LayerRewardViewMenuView
