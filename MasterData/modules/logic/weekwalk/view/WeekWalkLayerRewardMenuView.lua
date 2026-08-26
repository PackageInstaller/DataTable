-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerRewardMenuView.lua

module("modules.logic.weekwalk.view.WeekWalkLayerRewardMenuView", package.seeall)

local WeekWalkLayerRewardMenuView = class("WeekWalkLayerRewardMenuView", BaseView)

function WeekWalkLayerRewardMenuView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerRewardMenuView:addEvents()
	return
end

function WeekWalkLayerRewardMenuView:removeEvents()
	return
end

function WeekWalkLayerRewardMenuView:_editableInitView()
	self._goTabContent = gohelper.findChild(self.viewGO, "top/#scroll_TabList/Viewport/Content")
	self._goTabItem = gohelper.findChild(self.viewGO, "top/#scroll_TabList/Viewport/Content/#go_tabitem")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")

	gohelper.setActive(self._goTabItem, false)
end

function WeekWalkLayerRewardMenuView:onUpdateParam()
	return
end

function WeekWalkLayerRewardMenuView:onOpen()
	local mapId = self.viewParam.mapId

	if WeekWalkModel.isShallowMap(mapId) then
		return
	end

	self:_initPageList()
	self:_initTabList()

	self._selectedId = mapId

	self:_updateTabItems()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
end

function WeekWalkLayerRewardMenuView:_onWeekwalkTaskUpdate()
	self:_updateTabItems()
end

function WeekWalkLayerRewardMenuView:_initPageList()
	local pageList = {}
	local info = WeekWalkModel.instance:getInfo()
	local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)
	local maxLayer = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if deepLayerList then
		for i, v in ipairs(deepLayerList) do
			if not self.isVerifing or maxLayer >= v.layer then
				table.insert(pageList, v)
			end
		end
	end

	self._pageList = pageList
end

function WeekWalkLayerRewardMenuView:_initTabList()
	self._tabItemList = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onTabItemShow, self._pageList, self._goTabContent, self._goTabItem)
end

function WeekWalkLayerRewardMenuView:_onTabItemShow(obj, data, index)
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

function WeekWalkLayerRewardMenuView:_btnClick(id)
	self._selectedId = id

	self:_updateTabItems()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeLayerRewardMapId, id)

	self._scrollreward.verticalNormalizedPosition = 1
end

function WeekWalkLayerRewardMenuView:_updateTabItems()
	for k, v in pairs(self._tabItemList) do
		local mapId = v.data.id
		local isSelected = mapId == self._selectedId

		gohelper.setActive(v.select, isSelected)
		gohelper.setActive(v.unselect, not isSelected)

		local taskType = WeekWalkRewardView.getTaskType(mapId)
		local canGetNum, unFinishNum = WeekWalkTaskListModel.instance:canGetRewardNum(taskType, mapId)
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

function WeekWalkLayerRewardMenuView:onClose()
	if self._tabItemList then
		for k, v in pairs(self._tabItemList) do
			v.btnClick:RemoveClickListener()
		end
	end
end

function WeekWalkLayerRewardMenuView:onDestroyView()
	return
end

return WeekWalkLayerRewardMenuView
