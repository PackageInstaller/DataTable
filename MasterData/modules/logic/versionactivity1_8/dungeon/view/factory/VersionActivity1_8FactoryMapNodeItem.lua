-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryMapNodeItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapNodeItem", package.seeall)

local VersionActivity1_8FactoryMapNodeItem = class("VersionActivity1_8FactoryMapNodeItem", UserDataDispose)
local OPEN_DELAY_TIME = 0.8
local NODE_OPEN_DELAY_TIME = 0.5

function VersionActivity1_8FactoryMapNodeItem:init(go, getLineTemplateFunc, lineParentGo, parentView)
	self:__onInit()

	self.actId = Activity157Model.instance:getActId()
	self.go = go
	self.getLineTemplateFunc = getLineTemplateFunc
	self.lineParentGo = lineParentGo
	self.trans = self.go.transform
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._goLineParentInNode = gohelper.findChild(self.go, "line")
	self._gonum = gohelper.findChild(self.go, "num")
	self._txtnum = gohelper.findChildText(self.go, "num/#txt_num")
	self._gotimetips = gohelper.findChild(self.go, "timetips")
	self._txttime = gohelper.findChildText(self.go, "timetips/#txt_time")
	self._imagestatus = gohelper.findChildImage(self.go, "#image_status")
	self._godispatchrewardeff = gohelper.findChild(self.go, "#image_status/#vx_reward")
	self._gounlockeff = gohelper.findChild(self.go, "#image_status/#vx_unlock")
	self._goReddot = gohelper.findChild(self.go, "#go_reddot")
	self._btnnode = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_node")
	self.parentView = parentView

	self:addEventListeners()
end

function VersionActivity1_8FactoryMapNodeItem:addEventListeners()
	self.statusClickHandler = {
		[Activity157Enum.MissionStatus.Normal] = self._clickNormal,
		[Activity157Enum.MissionStatus.Locked] = self._clickLocked,
		[Activity157Enum.MissionStatus.Dispatching] = self._clickDispatch,
		[Activity157Enum.MissionStatus.DispatchFinish] = self._clickDispatch,
		[Activity157Enum.MissionStatus.Finish] = self._clickFinish
	}

	self._btnnode:AddClickListener(self._btnnodeOnClick, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.OnDispatchFinish, self.onDispatchFinish, self)
end

function VersionActivity1_8FactoryMapNodeItem:removeEventListeners()
	self._btnnode:RemoveClickListener()
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.OnDispatchFinish, self.onDispatchFinish, self)
end

function VersionActivity1_8FactoryMapNodeItem:_btnnodeOnClick()
	local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)

	if not elementId then
		return
	end

	local missionStatus = Activity157Model.instance:getMissionStatus(self.missionGroupId, self.missionId)
	local clickHandler = self.statusClickHandler[missionStatus]

	if clickHandler then
		clickHandler(self, elementId)
	else
		logError(string.format("VersionActivity1_8FactoryMapNodeItem:_btnnodeOnClick, no status handler, status:%s", missionStatus))
	end
end

function VersionActivity1_8FactoryMapNodeItem:_clickNormal(elementId)
	local isProgressOther = Activity157Model.instance:isInProgressOtherMissionGroup(self.missionGroupId)

	if isProgressOther then
		GameFacade.showToast(ToastEnum.V1a8Activity157HasDoingOtherMissionGroup)

		return
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, elementId)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function VersionActivity1_8FactoryMapNodeItem:_clickLocked(elementId)
	local toastId = Activity157Model.instance:getMissionUnlockToastId(self.missionId, elementId)

	if toastId then
		GameFacade.showToast(toastId)
	end
end

function VersionActivity1_8FactoryMapNodeItem:_clickDispatch(elementId)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.ManualClickElement, elementId)
end

function VersionActivity1_8FactoryMapNodeItem:_clickFinish()
	local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)

	if elementId then
		::label_8_0::

		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local type = elementCo and elementCo.type

		if type == DungeonEnum.ElementType.None or type == DungeonEnum.ElementType.Story then
			local storyId = Activity157Config.instance:getAct157MissionStoryId(self.actId, self.missionId)

			if storyId and storyId ~= 0 then
				StoryController.instance:playStory(storyId, nil, function()
					self:openFragmentInfoView(elementCo)
				end)
			else
				self:openFragmentInfoView(elementCo)
			end
		else
			GameFacade.showToast(ToastEnum.V1a8Activity157MissionHasFinished)
		end
	end
end

function VersionActivity1_8FactoryMapNodeItem:openFragmentInfoView(elementCo)
	local fragmentId = elementCo.fragment
	local dialogIdList = HandbookModel.instance:getFragmentDialogIdList(fragmentId)

	ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
		isFromHandbook = true,
		fragmentId = fragmentId,
		dialogIdList = dialogIdList
	})
end

function VersionActivity1_8FactoryMapNodeItem:onDispatchFinish()
	local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)
	local isDispatchElement = DungeonConfig.instance:isDispatchElement(elementId)

	if not isDispatchElement then
		return
	end

	self:refreshStatus()
end

function VersionActivity1_8FactoryMapNodeItem:setMissionData(missionGroupId, missionId, isOnOpen)
	if not missionGroupId or not missionId then
		return
	end

	self.missionId = missionId
	self.missionGroupId = missionGroupId

	local anchorPos = Activity157Config.instance:getAct157MissionPos(self.actId, self.missionId)

	recthelper.setAnchor(self.trans, anchorPos[1], anchorPos[2])

	self.go.name = string.format("%s-%s", self.missionGroupId, self.missionId)

	local order = Activity157Config.instance:getAct157MissionOrder(self.actId, self.missionId)

	if order then
		self._txtnum.text = order

		gohelper.setActive(self._gonum, true)
	else
		gohelper.setActive(self._gonum, false)
	end

	self:createLine()
	self:refresh()

	local dispatchId
	local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)

	if elementId then
		::label_12_0::

		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local type = elementCo and elementCo.type

		RedDotController.instance:addRedDot(self._goReddot, RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish, (type == DungeonEnum.ElementType.Dispatch or nil) and tonumber(elementCo.param), self.checkDispatchReddot, self)
		gohelper.setActive(self.go, true)

		local isNeedPlayUnlockAnim = Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(self.missionId)

		if isNeedPlayUnlockAnim then
			self:playNodeAnimation("open", "go")

			if self._lineAnimator then
				self._lineAnimator.speed = 0
			end

			self._animator.speed = 0

			local delayTime = 0

			if isOnOpen then
				delayTime = OPEN_DELAY_TIME
			else
				local isRoot = Activity157Config.instance:isRootMission(self.actId, missionId)

				if not isRoot then
					delayTime = NODE_OPEN_DELAY_TIME
				end
			end

			TaskDispatcher.cancelTask(self.playNodeUnlockAnimation, self)
			TaskDispatcher.runDelay(self.playNodeUnlockAnimation, self, delayTime)
		else
			self:playNodeAnimation("open", "open", "unlock")
		end
	end
end

function VersionActivity1_8FactoryMapNodeItem:refreshUnlockAnim()
	self:refresh()

	local isNeedPlayUnlockAnim = Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(self.missionId)

	if not isNeedPlayUnlockAnim then
		return
	end

	self:playNodeUnlockAnimation()
end

function VersionActivity1_8FactoryMapNodeItem:checkDispatchReddot(redDotIcon)
	redDotIcon:defaultRefreshDot()
	gohelper.setActive(self._godispatchrewardeff, redDotIcon.show)
end

function VersionActivity1_8FactoryMapNodeItem:createLine()
	self:destroyLine()

	local lineTemplate

	if self.getLineTemplateFunc then
		local lineRes = Activity157Config.instance:getLineResPath(self.actId, self.missionId)

		lineTemplate = self.getLineTemplateFunc(self.parentView, lineRes)
	end

	if not lineTemplate then
		return
	end

	self.lineGo = gohelper.clone(lineTemplate, self.lineParentGo or self._goLineParentInNode)

	if gohelper.isNil(self.lineGo) then
		return
	end

	self._lineAnimator = gohelper.findChildComponent(self.lineGo, "ani", typeof(UnityEngine.Animator))
	self._goLineFinish = gohelper.findChild(self.lineGo, "ani/line_finish")
	self._goLineUnlock = gohelper.findChild(self.lineGo, "ani/line_unlock")
	self._goLineLock = gohelper.findChild(self.lineGo, "ani/line_lock")
	self._lineImagePoint1 = gohelper.findChildImage(self.lineGo, "ani/point1")
	self._lineImagePoint2 = gohelper.findChildImage(self.lineGo, "ani/point2")

	local pointX, pointY = recthelper.getAnchor(self._lineImagePoint2.transform, 0, 0)
	local strOffsetY = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FactoryMapNodeLineOffsetY)
	local offsetY = tonumber(lineTemplate) or 0

	if self.lineParentGo then
		local anchorPos = Activity157Config.instance:getAct157MissionPos(self.actId, self.missionId)

		recthelper.setAnchor(self.lineGo.transform, anchorPos[1] - pointX, anchorPos[2] - pointY + offsetY)
	else
		recthelper.setAnchor(self.lineGo.transform, -pointX, -pointY + offsetY)
	end

	gohelper.setActive(self.lineGo, true)
end

function VersionActivity1_8FactoryMapNodeItem:playNodeAnimation(animName, lineName, areaAnim)
	if not string.nilorempty(animName) and self._animator then
		self._animator:Play(animName, 0, 0)
	end

	if not string.nilorempty(lineName) and self._lineAnimator then
		self._lineAnimator:Play(lineName, 0, 0)
	end

	local area = Activity157Config.instance:getMissionArea(self.actId, self.missionId)

	self.parentView:playAreaAnim(area, areaAnim)
end

function VersionActivity1_8FactoryMapNodeItem:playNodeUnlockAnimation()
	self:playNodeAnimation("open", "go", "unlock")

	if self._lineAnimator then
		self._lineAnimator.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeLineShow)
	end

	self._animator.speed = 1

	gohelper.setActive(self._gounlockeff, false)
	gohelper.setActive(self._gounlockeff, true)

	if self.missionId then
		local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. self.missionId

		Activity157Model.instance:setHasPlayedAnim(prefsKey)
		Activity157Controller.instance:dispatchEvent(Activity157Event.Act157PlayMissionUnlockAnim)
	end
end

function VersionActivity1_8FactoryMapNodeItem:everySecondCall()
	self:refreshTime()
end

function VersionActivity1_8FactoryMapNodeItem:refresh()
	self:refreshStatus()
	self:refreshTime()
	self:refreshLine()
end

function VersionActivity1_8FactoryMapNodeItem:refreshStatus()
	local statusIcon
	local missionStatus = Activity157Model.instance:getMissionStatus(self.missionGroupId, self.missionId)
	local statusShowSetting = Activity157Enum.MissionStatusShowSetting[missionStatus]

	if type(statusShowSetting) == "table" then
		local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)

		if elementId then
			::label_20_0::

			local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
			local type = elementCo and elementCo.type

			if missionStatus == Activity157Enum.MissionStatus.Finish then
				statusIcon = statusShowSetting.normal

				if type == DungeonEnum.ElementType.None or type == DungeonEnum.ElementType.Story then
					statusIcon = statusShowSetting.story
				end
			elseif missionStatus == Activity157Enum.MissionStatus.Normal then
				statusIcon = statusShowSetting.normal

				if type == DungeonEnum.ElementType.Fight then
					statusIcon = statusShowSetting.fight
				end
			else
				logError("VersionActivity1_8FactoryMapNodeItem:refreshStatus error, no status icon, status:%s", missionStatus)
			end
		end
	else
		statusIcon = statusShowSetting
	end

	if statusIcon then
		UISpriteSetMgr.instance:setV1a8FactorySprite(self._imagestatus, statusIcon)
	end

	local isDispatching = missionStatus == Activity157Enum.MissionStatus.Dispatching

	gohelper.setActive(self._gotimetips, isDispatching)
end

function VersionActivity1_8FactoryMapNodeItem:refreshTime()
	local status = Activity157Model.instance:getMissionStatus(self.missionGroupId, self.missionId)
	local isDispatching = status == Activity157Enum.MissionStatus.Dispatching

	if not isDispatching then
		return
	end

	local elementId = Activity157Config.instance:getMissionElementId(self.actId, self.missionId)

	self._txttime.text = DispatchModel.instance:getDispatchTime(elementId)
end

function VersionActivity1_8FactoryMapNodeItem:refreshLine()
	if not self.missionGroupId or not self.missionId then
		return
	end

	local missionStatus = Activity157Model.instance:getMissionStatus(self.missionGroupId, self.missionId)

	gohelper.setActive(self._goLineLock, missionStatus == Activity157Enum.MissionStatus.Locked)

	if missionStatus == Activity157Enum.MissionStatus.Normal or missionStatus == Activity157Enum.MissionStatus.Dispatching or missionStatus == Activity157Enum.MissionStatus.DispatchFinish then
		gohelper.setActive(self._goLineUnlock, true)
	else
		gohelper.setActive(self._goLineUnlock, false)
	end

	gohelper.setActive(self._goLineFinish, missionStatus == Activity157Enum.MissionStatus.Finish)

	local showIconSetting = Activity157Enum.MissionLineStatusIcon[missionStatus]

	if not showIconSetting then
		return
	end

	if self._lineImagePoint1 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(self._lineImagePoint1, showIconSetting.point, true)
	end

	if self._lineImagePoint2 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(self._lineImagePoint2, showIconSetting.point, true)
	end
end

function VersionActivity1_8FactoryMapNodeItem:reset(playAnim)
	TaskDispatcher.cancelTask(self.playNodeUnlockAnimation, self)

	if playAnim then
		self:playNodeAnimation("close", "close", "lock")
	end

	self.missionId = nil
	self.missionGroupId = nil
	self.go.name = "nodeitem"
	self._animator.speed = 1

	gohelper.setActive(self.go, false)
	self:destroyLine()
end

function VersionActivity1_8FactoryMapNodeItem:destroyLine()
	self._lineAnimator = nil
	self._lineImagePoint1 = nil
	self._lineImagePoint2 = nil

	if not gohelper.isNil(self.lineGo) then
		gohelper.destroy(self.lineGo)
	end

	self.lineGo = nil

	gohelper.setActive(self._gounlockeff, false)
end

function VersionActivity1_8FactoryMapNodeItem:destroy()
	self:removeEventListeners()
	self:reset()
	gohelper.destroy(self.go)
	self:__onDispose()
end

return VersionActivity1_8FactoryMapNodeItem
