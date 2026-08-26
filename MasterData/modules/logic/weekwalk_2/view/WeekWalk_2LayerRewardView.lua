-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2LayerRewardView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardView", package.seeall)

local WeekWalk_2LayerRewardView = class("WeekWalk_2LayerRewardView", BaseView)

function WeekWalk_2LayerRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goicons1 = gohelper.findChild(self.viewGO, "go_star/starlist/#go_icons1")
	self._txtchapternum1 = gohelper.findChildText(self.viewGO, "go_star/starlist/#go_icons1/#txt_chapternum1")
	self._goicons2 = gohelper.findChild(self.viewGO, "go_star/starlist/#go_icons2")
	self._txtchapternum2 = gohelper.findChildText(self.viewGO, "go_star/starlist/#go_icons2/#txt_chapternum2")
	self._txttitlecn = gohelper.findChildText(self.viewGO, "#txt_titlecn")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_titlecn/#txt_name")
	self._txtmaintitle = gohelper.findChildText(self.viewGO, "#txt_maintitle")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/fade/viewport/#go_rewardcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2LayerRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function WeekWalk_2LayerRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function WeekWalk_2LayerRewardView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalk_2LayerRewardView:_editableInitView()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetTaskReward, self._getTaskBouns, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnChangeLayerRewardMapId, self._onChangeLayerRewardMapId, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, self._onChangeInfo, self)
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))

	self._gotop = gohelper.findChild(self.viewGO, "top")
end

function WeekWalk_2LayerRewardView:_updateTask()
	if self._mapId == 0 then
		if not WeekWalk_2Enum.TaskType.Once then
			local type = WeekWalk_2Enum.TaskType.Season

			WeekWalk_2TaskListModel.instance:showLayerTaskList(type, self._mapId)
		end
	end
end

function WeekWalk_2LayerRewardView:onUpdateParam()
	return
end

function WeekWalk_2LayerRewardView:_onChangeInfo()
	self:_onChangeLayerRewardMapId(self._mapId)
end

function WeekWalk_2LayerRewardView:_onChangeLayerRewardMapId(mapId)
	self._mapId = mapId

	self:_updateTask()
	self:_updateInfo()
	self:_showBattleInfo()
end

function WeekWalk_2LayerRewardView:onOpen()
	self:_onChangeLayerRewardMapId(self.viewParam.mapId)
	gohelper.setActive(self._gotop, self._mapId ~= 0)
end

function WeekWalk_2LayerRewardView:_showBattleInfo()
	self._mapInfo = WeekWalk_2Model.instance:getLayerInfo(self._mapId)

	gohelper.setActive(self._txtmaintitle, self._mapId == 0)
	gohelper.setActive(self._txttitlecn, self._mapId ~= 0)

	if not self._mapInfo then
		local startGo = gohelper.findChild(self.viewGO, "go_star")

		gohelper.setActive(startGo, false)

		local deepTipGo = gohelper.findChild(self.viewGO, "txt_deeptip")

		gohelper.setActive(deepTipGo, false)

		return
	end

	self._iconList1 = self._iconList1 or self:getUserDataTb_()
	self._iconList2 = self._iconList2 or self:getUserDataTb_()

	self:_showBattle(self._goicons1, self._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First), self._iconList1)
	self:_showBattle(self._goicons2, self._mapInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second), self._iconList2)
end

function WeekWalk_2LayerRewardView:_showBattle(go, battleInfo, iconList)
	local iconGo = gohelper.findChild(go, "icon")

	gohelper.setActive(iconGo, false)

	for i = 1, WeekWalk_2Enum.MaxStar do
		gohelper.destroy(iconList[i])

		local imgGo = gohelper.cloneInPlace(iconGo)

		iconList[i] = imgGo

		gohelper.setActive(imgGo, true)

		local img = gohelper.findChildImage(imgGo, "icon")

		img.enabled = false

		local iconEffect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, img.gameObject)
		local cupInfo = battleInfo:getCupInfo(i)

		if cupInfo then
			if not cupInfo.result then
				local result = WeekWalk_2Enum.CupType.None

				if result == WeekWalk_2Enum.CupType.None then
					result = WeekWalk_2Enum.CupType.None2
				end

				WeekWalk_2Helper.setCupEffectByResult(iconEffect, result)
			end
		end
	end

	local finishedGo = gohelper.findChild(go, "go_finished")
	local unFinishedGo = gohelper.findChild(go, "go_unfinish")
	local isFinished = battleInfo.status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(finishedGo, isFinished)
	gohelper.setActive(unFinishedGo, not isFinished)
end

function WeekWalk_2LayerRewardView:_onWeekwalkTaskUpdate()
	if not self._getTaskBonusItem then
		return
	end

	self._getTaskBonusItem:playOutAnim()

	self._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalk_2LayerRewardView bonus")
	TaskDispatcher.runDelay(self._showRewards, self, 0.3)
end

function WeekWalk_2LayerRewardView:_getTaskBouns(taskItem)
	self._getTaskBonusItem = taskItem
end

function WeekWalk_2LayerRewardView:_showRewards()
	self:_updateTask()
	self:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalk_2LayerRewardView bonus")

	local list = WeekWalk_2TaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
end

function WeekWalk_2LayerRewardView:_updateInfo()
	local list = WeekWalk_2TaskListModel.instance:getList()
	local maxNum = 0

	for i, v in ipairs(list) do
		if v.maxProgress then
			maxNum = math.max(maxNum, v.maxProgress)
		end
	end

	self._mapInfo = WeekWalk_2Model.instance:getLayerInfo(self._mapId)

	if self._mapInfo then
		self._txttitlecn.text = self._mapInfo.sceneConfig.battleName
		self._txtname.text = self._mapInfo.sceneConfig.name
	end
end

function WeekWalk_2LayerRewardView:onClose()
	TaskDispatcher.cancelTask(self._showRewards, self)
end

function WeekWalk_2LayerRewardView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return WeekWalk_2LayerRewardView
