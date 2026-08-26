-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskView", package.seeall)

local CruiseSelfTaskView = class("CruiseSelfTaskView", BaseView)

function CruiseSelfTaskView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "image_timebg/#txt_time")
	self._gotaskitem = gohelper.findChild(self.viewGO, "scroll_task/Viewport/go_Content/#go_taskitem")
	self._txttarget = gohelper.findChildText(self.viewGO, "bottom/#txt_target")
	self._gobtnstates = gohelper.findChild(self.viewGO, "bottom/#go_btnstates")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_btnstates/#btn_normal")
	self._gosearch = gohelper.findChild(self.viewGO, "bottom/#go_btnstates/#btn_normal/#btn_search")
	self._txtnum = gohelper.findChildText(self.viewGO, "bottom/#go_btnstates/#btn_normal/numbg/#num")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_btnstates/#btn_canget")
	self._btncanuse = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_btnstates/#btn_canuse")
	self._gofinished = gohelper.findChild(self.viewGO, "bottom/#go_btnstates/#go_finished")
	self._gograyLine = gohelper.findChild(self.viewGO, "bottom/scroll_Reward/Viewport/go_Content/#go_grayLine")
	self._imagenormalline = gohelper.findChildImage(self.viewGO, "bottom/scroll_Reward/Viewport/go_Content/#go_normalLine")
	self._goprogressbaritem = gohelper.findChild(self.viewGO, "bottom/scroll_Reward/Viewport/go_Content/go_progressbaritem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseSelfTaskView:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btncanuse:AddClickListener(self._btncanuseOnClick, self)
end

function CruiseSelfTaskView:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btncanuse:RemoveClickListener()
end

function CruiseSelfTaskView:_btnnormalOnClick()
	local onceBonusCo = Activity216Config.instance:getOnceBonusCO(self._actId)
	local itemCos = string.splitToNumber(onceBonusCo.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(itemCos[1], itemCos[2])
end

function CruiseSelfTaskView:_btncangetOnClick()
	local onceBonusState = Activity216Model.instance:getMileStoneBonusState(self._actId)

	if onceBonusState ~= Activity216Enum.MileStoneBonusState.CanGet then
		return
	end

	Activity216Rpc.instance:sendGetAct216OnceBonusRequest(self._actId)
end

function CruiseSelfTaskView:_btncanuseOnClick()
	return
end

function CruiseSelfTaskView:_editableInitView()
	self._taskItems = self:getUserDataTb_()

	gohelper.setActive(self._gotaskitem, false)

	self._progressItems = self:getUserDataTb_()

	gohelper.setActive(self._goprogressbaritem, false)
	gohelper.setActive(self._gosearch, false)
	self:_addSelfEvents()
end

function CruiseSelfTaskView:_addSelfEvents()
	self.addEventCb(self, Activity216Controller.instance, Activity216Event.onTaskInfoUpdate, self._refresh, self)
	self.addEventCb(self, Activity216Controller.instance, Activity216Event.onBonusStateChange, self._refreshProgresses, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseSelfTaskView:_removeSelfEvents()
	self.removeEventCb(self, Activity216Controller.instance, Activity216Event.onTaskInfoUpdate, self._refresh, self)
	self.removeEventCb(self, Activity216Controller.instance, Activity216Event.onBonusStateChange, self._refreshProgresses, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseSelfTaskView:_onCheckActState()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function CruiseSelfTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_tangren_qiandao_open)

	self._actId = VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh(true)
end

function CruiseSelfTaskView:_refresh(isOpen)
	self:_refreshUI()
	self:_refreshTasks(isOpen)
	self:_refreshProgresses()
end

function CruiseSelfTaskView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CruiseSelfTaskView:_refreshUI()
	local onceBonusCo = Activity216Config.instance:getOnceBonusCO(self._actId)
	local itemCos = string.splitToNumber(onceBonusCo.bonus, "#")

	self._txtnum.text = luaLang("multiple") .. itemCos[3]
end

function CruiseSelfTaskView:_refreshTasks(isOpen)
	local taskIds = Activity216Model.instance:getAllShowTasks(self._actId)

	for index, taskId in ipairs(taskIds) do
		if not self._taskItems[taskId] then
			self._taskItems[taskId] = CruiseSelfTaskItem.New()

			local go = gohelper.cloneInPlace(self._gotaskitem)

			self._taskItems[taskId]:init(go, index, isOpen)
		end

		self._taskItems[taskId]:refresh(taskId, index)
	end
end

function CruiseSelfTaskView:_refreshProgresses()
	local needCount = Activity216Config.instance:getOnceBonusCO(self._actId).needFinishTaskNum
	local finishedCount = Activity216Model.instance:getAllFinishedTaskCount(self._actId)

	self._txttarget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cruise_selftask_targetprogress"), {
		finishedCount,
		needCount
	})
	self._imagenormalline.fillAmount = finishedCount / needCount

	local onceBonusState = Activity216Model.instance:getMileStoneBonusState(self._actId)

	gohelper.setActive(self._btnnormal.gameObject, true)
	gohelper.setActive(self._btncanget.gameObject, onceBonusState == Activity216Enum.MileStoneBonusState.CanGet)
	gohelper.setActive(self._btncanuse.gameObject, false)
	gohelper.setActive(self._gofinished, onceBonusState == Activity216Enum.MileStoneBonusState.Finished)

	for i = 1, needCount do
		if not self._progressItems[i] then
			self._progressItems[i] = CruiseSelfTaskProgressItem.New()

			local go = gohelper.cloneInPlace(self._goprogressbaritem)

			self._progressItems[i]:init(go)
		end

		self._progressItems[i]:refresh(i)
	end
end

function CruiseSelfTaskView:onClose()
	return
end

function CruiseSelfTaskView:onDestroyView()
	self:_removeSelfEvents()

	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end

	if self._progressItems then
		for _, progressItem in pairs(self._progressItems) do
			progressItem:destroy()
		end

		self._progressItems = nil
	end

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return CruiseSelfTaskView
