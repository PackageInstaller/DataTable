-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskUseItemView.lua

module("logic.extensions.task.view.TaskUseItemView", package.seeall)

local TaskUseItemView = class("TaskUseItemView", ViewComponent)

function TaskUseItemView:buildUI()
	self._slider = Framework.SliderAdapter.GetFrom(self.mainGO, "Using/Slider")

	self._slider:SetValue(0)
end

function TaskUseItemView:destroyUI()
	self._slider = nil
	self._taskTarget = nil
	self._speed = nil
	self._currVal = nil
	self._deltaTime = nil
end

function TaskUseItemView:onEnter()
	self._taskTarget = self._viewPresentor._openParam[1]
	self._speed = 1
	self._currVal = 0
	self._deltaTime = 0.0333
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self._slider:SetValue(0)
	settimer(self._deltaTime, self._tickUsing, self, true)
end

function TaskUseItemView:onExit()
	self._taskTarget = nil
	self._speed = nil
	self._currVal = nil
	self._deltaTime = nil

	self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._mainPlayer = nil

	removetimer(self._tickUsing, self)
end

function TaskUseItemView:_breakUsting()
	self:localNotify(TaskConst.ON_TASK_USEITEM_BREAK)
end

function TaskUseItemView:_finishUsing()
	self:close()
	self:localNotify(TaskConst.ON_TASK_USEITEM_FINISH)
end

function TaskUseItemView:_tickUsing()
	if self._currVal >= 1 then
		self:_finishUsing()

		return
	end

	self._currVal = self._currVal + self._speed * self._deltaTime

	if self._currVal > 1 then
		self._currVal = 1
	end

	self._slider:SetValue(self._currVal)
end

function TaskUseItemView:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self:_breakUsing()
end

return TaskUseItemView
