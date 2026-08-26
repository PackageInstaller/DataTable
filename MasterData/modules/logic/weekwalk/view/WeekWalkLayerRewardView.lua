-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerRewardView.lua

module("modules.logic.weekwalk.view.WeekWalkLayerRewardView", package.seeall)

local WeekWalkLayerRewardView = class("WeekWalkLayerRewardView", BaseView)

function WeekWalkLayerRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txttitlecn = gohelper.findChildText(self.viewGO, "#txt_titlecn")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_titlecn/#txt_name")
	self._txtstar = gohelper.findChildText(self.viewGO, "#txt_star")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtdeeptip = gohelper.findChildText(self.viewGO, "#txt_deeptip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkLayerRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function WeekWalkLayerRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function WeekWalkLayerRewardView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalkLayerRewardView:_editableInitView()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, self._getTaskBouns, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnChangeLayerRewardMapId, self._onChangeLayerRewardMapId, self)
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function WeekWalkLayerRewardView:_updateTask()
	local type = WeekWalkRewardView.getTaskType(self._mapId)

	WeekWalkTaskListModel.instance:showLayerTaskList(type, self._mapId)
end

function WeekWalkLayerRewardView:onUpdateParam()
	return
end

function WeekWalkLayerRewardView:_onChangeLayerRewardMapId(mapId)
	self._mapId = mapId

	gohelper.setActive(self._txtdeeptip.gameObject, not WeekWalkModel.isShallowMap(self._mapId))
	self:_updateTask()
	self:_updateInfo()
end

function WeekWalkLayerRewardView:onOpen()
	self:_onChangeLayerRewardMapId(self.viewParam.mapId)
end

function WeekWalkLayerRewardView:_onWeekwalkTaskUpdate()
	if not self._getTaskBonusItem then
		return
	end

	self._getTaskBonusItem:playOutAnim()

	self._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalkLayerRewardView bonus")
	TaskDispatcher.runDelay(self._showRewards, self, 0.3)
end

function WeekWalkLayerRewardView:_getTaskBouns(taskItem)
	self._getTaskBonusItem = taskItem
end

function WeekWalkLayerRewardView:_showRewards()
	self:_updateTask()
	self:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalkLayerRewardView bonus")

	local list = WeekWalkTaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
end

function WeekWalkLayerRewardView:_updateInfo()
	local list = WeekWalkTaskListModel.instance:getList()
	local maxNum = 0

	for i, v in ipairs(list) do
		if v.maxProgress then
			maxNum = math.max(maxNum, v.maxProgress)
		end
	end

	local sceneId = lua_weekwalk.configDict[self._mapId].sceneId
	local sceneConfig = lua_weekwalk_scene.configDict[sceneId]

	self._txtname.text = sceneConfig.name
	self._txttitlecn.text = luaLang(WeekWalkModel.instance.isShallowMap(self._mapId) and "p_weekwalklayerrewardview_shallowtitle" or "p_weekwalklayerrewardview_deeptitle")
	self._mapInfo = WeekWalkModel.instance:getMapInfo(self._mapId)
	self._txtstar.text = string.format("%s/%s", (self._mapInfo or nil) and self._mapInfo:getCurStarInfo(), maxNum)
end

function WeekWalkLayerRewardView:onClose()
	TaskDispatcher.cancelTask(self._showRewards, self)
end

function WeekWalkLayerRewardView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return WeekWalkLayerRewardView
