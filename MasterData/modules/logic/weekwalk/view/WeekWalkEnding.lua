-- chunkname: @modules/logic/weekwalk/view/WeekWalkEnding.lua

module("modules.logic.weekwalk.view.WeekWalkEnding", package.seeall)

local WeekWalkEnding = class("WeekWalkEnding", BaseView)

function WeekWalkEnding:onInitView()
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._scrollnull = gohelper.findChildScrollRect(self.viewGO, "#go_finish/weekwalkending/#scroll_null")
	self._gostartemplate = gohelper.findChild(self.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkEnding:addEvents()
	return
end

function WeekWalkEnding:removeEvents()
	return
end

function WeekWalkEnding:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animator = self._gofinish:GetComponent(typeof(UnityEngine.Animator))
	self._mapId = WeekWalkModel.instance:getCurMapId()
	self._animEventWrap = self._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("star", self._startShowStars, self)
end

function WeekWalkEnding:_startShowStars()
	if not self._starList then
		return
	end

	self:_starsAppear()
end

function WeekWalkEnding:_starsAppear()
	self._curAppearIndex = 1

	TaskDispatcher.cancelTask(self._oneStarAppear, self)
	TaskDispatcher.runRepeat(self._oneStarAppear, self, 0.12)
end

function WeekWalkEnding:_oneStarAppear()
	local starGo = self._starList[self._curAppearIndex]

	gohelper.setActive(starGo, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success_star)

	self._curAppearIndex = self._curAppearIndex + 1

	if self._curAppearIndex > self._curNum then
		TaskDispatcher.cancelTask(self._oneStarAppear, self)
	end
end

function WeekWalkEnding:_addStarList()
	self._starList = self:getUserDataTb_()

	local num = self._maxNum

	for i = 1, num do
		local go = gohelper.cloneInPlace(self._gostartemplate)

		gohelper.setActive(go, true)

		local starGo = gohelper.findChild(go, "star")

		gohelper.setActive(starGo, false)
		table.insert(self._starList, starGo)
	end
end

function WeekWalkEnding:onOpen()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, self._onWeekwalkResetLayer, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, self._onWeekwalkInfoUpdate, self)
	self:_showFinishAnim()
end

function WeekWalkEnding:_onWeekwalkResetLayer()
	gohelper.setActive(self._gofinish, false)
end

function WeekWalkEnding:_onWeekwalkInfoUpdate()
	self:_showFinishAnim()
end

function WeekWalkEnding:_showFinishAnim()
	self._mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not self._mapInfo then
		return
	end

	self._curNum, self._maxNum = self._mapInfo:getCurStarInfo()

	if not WeekWalkView._canShowFinishAnim(self._mapId) then
		self:_onShowFinishAnimDone()

		return
	end

	self:_addStarList()

	if self._mapInfo.isFinished == 1 then
		WeekWalkModel.instance:setFinishMapId(self._mapId)
	end

	WeekwalkRpc.instance:sendMarkShowFinishedRequest()

	if self._mapInfo:getLayer() == WeekWalkEnum.LastShallowLayer then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnAllShallowLayerFinish)
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success)
	gohelper.setActive(self._gofinish, true)

	self._viewAnim.enabled = true

	local time = 2.83

	if self._curNum == self._maxNum then
		self._animator:Play("ending2")
		self._viewAnim:Play("finish_map2")

		time = time + 2
	else
		self._animator:Play("ending1")
		self._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(self._closeFinishAnim, self, time)

	self._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(self._checkAnimClip, self, 0)
end

function WeekWalkEnding:_checkAnimClip()
	if self._isPlayMapFinishClip then
		TaskDispatcher.cancelTask(self._checkAnimClip, self)

		return
	end

	local stateInfo = self._animator:GetCurrentAnimatorStateInfo(0)

	if stateInfo:IsName("open") then
		self._isPlayMapFinishClip = true

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	end
end

function WeekWalkEnding:_closeFinishAnim()
	TaskDispatcher.cancelTask(self._checkAnimClip, self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(self._gofinish, self._curNum == self._maxNum)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnShowFinishAnimDone)
	self:_onShowFinishAnimDone()
end

function WeekWalkEnding:_onShowFinishAnimDone()
	TaskDispatcher.runDelay(self._showIdle, self, 0)

	if WaitGuideActionOpenViewWithCondition.weekWalkFinishLayer() then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideFinishLayer)
	end
end

function WeekWalkEnding:_showIdle()
	local isFinish = self._mapInfo.isFinish == 1

	if isFinish and self._curNum == self._maxNum then
		gohelper.setActive(self._gofinish, true)
		self._animator:Play(UIAnimationName.Idle)
	end
end

function WeekWalkEnding:onClose()
	gohelper.setActive(self._gofinish, false)
end

function WeekWalkEnding:onDestroyView()
	TaskDispatcher.cancelTask(self._checkAnimClip, self)
	TaskDispatcher.cancelTask(self._oneStarAppear, self)
	TaskDispatcher.cancelTask(self._closeFinishAnim, self)
	TaskDispatcher.cancelTask(self._showIdle, self)
	self._animEventWrap:RemoveAllEventListener()
end

return WeekWalkEnding
