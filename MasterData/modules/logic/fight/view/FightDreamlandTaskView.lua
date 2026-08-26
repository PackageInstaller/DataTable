-- chunkname: @modules/logic/fight/view/FightDreamlandTaskView.lua

module("modules.logic.fight.view.FightDreamlandTaskView", package.seeall)

local FightDreamlandTaskView = class("FightDreamlandTaskView", BaseView)

function FightDreamlandTaskView:onInitView()
	self._goTask = gohelper.findChild(self.viewGO, "root/topLeftContent/#go_tasktips")
	self._txtTask = gohelper.findChildText(self.viewGO, "root/topLeftContent/#go_tasktips/taskitembg/#txt_task")
	self._ani = SLFramework.AnimatorPlayer.Get(self._goTask)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightDreamlandTaskView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnIndicatorChange, self._refreshDes, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
end

function FightDreamlandTaskView:removeEvents()
	return
end

function FightDreamlandTaskView:_editableInitView()
	return
end

function FightDreamlandTaskView:onRefreshViewParam()
	return
end

function FightDreamlandTaskView:onOpen()
	local fightParam = FightModel.instance:getFightParam()

	self._taskConfig = Activity126Config.instance:getDramlandTask(fightParam and fightParam.battleId)

	self:_refreshDes()
end

function FightDreamlandTaskView:_refreshDes()
	gohelper.setActive(self._goTask, self._taskConfig)

	if self._taskConfig then
		local curProgress = FightDataHelper.fieldMgr:getIndicatorNum(self._taskConfig.indicator)
		local tarValue = self._taskConfig.num
		local progressStr = string.format("<color=#cc7f56>(%d/%d)</color>", curProgress, tarValue)

		self._txtTask.text = self._taskConfig.desc .. progressStr

		if tarValue <= curProgress then
			if self._finish then
				gohelper.setActive(self._goTask, false)

				return
			end

			self._ani:Play("finish", self._finishDone, self)

			self._finish = true
		else
			self._ani:Play("idle", nil, nil)

			self._finish = false
		end
	end
end

function FightDreamlandTaskView:_finishDone()
	gohelper.setActive(self._goTask, false)
end

function FightDreamlandTaskView:_onCameraFocusChanged(isFocus)
	if isFocus then
		gohelper.setActive(self._goTask, self._taskConfig)
	else
		self:_refreshDes()
	end
end

function FightDreamlandTaskView:onClose()
	return
end

function FightDreamlandTaskView:onDestroyView()
	return
end

return FightDreamlandTaskView
