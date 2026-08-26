-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4ReturnTaskItem.lua

module("modules.logic.turnback.view.turnback4.Turnback4ReturnTaskItem", package.seeall)

local Turnback4ReturnTaskItem = class("Turnback4ReturnTaskItem", ListScrollCellExtend)

function Turnback4ReturnTaskItem:onInitView()
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_allfinish")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._txttagdesc = gohelper.findChildText(self.viewGO, "#go_tag/#txt_desc")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "#go_tag/#txt_desc2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback4ReturnTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Turnback4ReturnTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Turnback4ReturnTaskItem:_btnnotfinishbgOnClick()
	if not self._taskMo then
		return
	end

	if self._taskMo.finishCount >= self._taskMo:getMaxFinishCount() or self._taskMo.hasFinished then
		return
	end

	local jumpId = self._taskMo.config.jumpId

	if jumpId and jumpId > 0 then
		GameFacade.jump(jumpId, self._jumpCb, self)
	end
end

function Turnback4ReturnTaskItem:_jumpCb()
	if self._taskMo.config.listenerType == "ReadTask" then
		TaskRpc.instance:sendFinishReadTaskRequest(self._taskMo.id)
	end
end

function Turnback4ReturnTaskItem:_refreshTask()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Turnback
	}, self._refreshTaskInfo, self)
end

function Turnback4ReturnTaskItem:_refreshTaskInfo()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest(self._onGetTurnbackInfoCb, self)
end

function Turnback4ReturnTaskItem:_btnfinishbgOnClick()
	if not self._taskMo then
		return
	end

	if self._taskMo.finishCount >= self._taskMo:getMaxFinishCount() or not self._taskMo.hasFinished then
		return
	end

	self._playingFinishAni = true

	gohelper.setActive(self._goallfinish, true)
	self._animPlayer:Play("finish", self._finishTask, self)

	local idList = {
		self._taskMo.id
	}

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Turnback, nil, idList, self._refreshTask, self)
end

function Turnback4ReturnTaskItem:_finishTask()
	self._playingFinishAni = false

	self:onUpdateMO(self._taskMo, self._taskType)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnRefreshReturnRewardTask)
end

function Turnback4ReturnTaskItem:_onCloseViewFinish(viewName)
	return
end

function Turnback4ReturnTaskItem:_onGetTurnbackInfoCb()
	return
end

function Turnback4ReturnTaskItem:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function Turnback4ReturnTaskItem:_editableAddEvents()
	return
end

function Turnback4ReturnTaskItem:_editableRemoveEvents()
	return
end

function Turnback4ReturnTaskItem:onUpdateMO(mo, type)
	self._turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()
	self._taskMo = mo
	self._taskType = type

	if self._playingFinishAni then
		return
	end

	local co = mo and mo.config

	if not mo then
		local taskId = self._turnbackInfoMo:getLastFinishRandomTaskId()

		if taskId then
			co = TurnbackConfig.instance:getTurnbackTaskCo(taskId)
		end
	end

	if co then
		self._txttaskdesc.text = co.desc or ""
	end

	if co then
		self._txtnum.text = luaLang("multiple") .. self:_getTaskBonusVitality(co)
	end

	gohelper.setActive(self._txtnum.gameObject, co ~= nil)
	self:refreshTaskState()
end

function Turnback4ReturnTaskItem:refreshTaskState()
	if self._playingFinishAni then
		return
	end

	if self._taskMo then
		local isClaimed = self._taskMo.finishCount >= self._taskMo:getMaxFinishCount()
		local canClaim = true

		goto label_16_0

		::label_16_0::

		self:_refreshTaskState(isClaimed, canClaim)
	end
end

function Turnback4ReturnTaskItem:_refreshTaskState(isClaimed, canClaim)
	local waitRefresh = not self._taskMo or isClaimed and not canClaim

	if waitRefresh then
		self._taskType = self._taskType or self._taskMo and self._taskMo.config.turnbackTaskType

		if self._taskType == TurnbackEnum.TaskType.DailyRefresh and self:_isAllFinish(TurnbackEnum.TaskType.DailyRefresh) then
			self._txttagdesc.text = luaLang("return4_reward_refreshtask_all_finish")
		else
			local remainTime = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
			local time = TimeUtil.SecondToActivityTimeFormat(remainTime)
			local lang = luaLang("return4_reward_task_refresh")

			self._txttagdesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, time)
		end
	end

	gohelper.setActive(self._gotag, waitRefresh)
	gohelper.setActive(self._btnnotfinishbg, not waitRefresh and not isClaimed and not canClaim)
	gohelper.setActive(self._btnfinishbg, not waitRefresh and canClaim)
	gohelper.setActive(self._goallfinish, waitRefresh)
end

function Turnback4ReturnTaskItem:_isAllFinish(type)
	local taskIdList = self._turnbackInfoMo:getReturnLeftTaskIds()

	if taskIdList then
		for i, id in ipairs(taskIdList) do
			local mo = TaskModel.instance:getTaskById(id)

			if mo then
				if not mo.config then
					local config = TurnbackConfig.instance:getTurnbackTaskCo(id)

					if config and config.turnbackTaskType == type then
						return false
					end
				end
			end
		end
	end

	return true
end

function Turnback4ReturnTaskItem:_getTaskBonusVitality(co)
	if co and not string.nilorempty(co.bonus) then
		local bonus = GameUtil.splitString2(co.bonus, true, "|", "#")
		local currncyInfo = self._turnbackInfoMo:getCurRewardCurrencyInfo()

		for _, v in ipairs(bonus) do
			if v[2] == currncyInfo[2] then
				return v[3]
			end
		end
	end

	return 0
end

function Turnback4ReturnTaskItem:onDestroyView()
	return
end

return Turnback4ReturnTaskItem
