-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2Ending.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2Ending", package.seeall)

local WeekWalk_2Ending = class("WeekWalk_2Ending", BaseView)

function WeekWalk_2Ending:onInitView()
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._scrollnull = gohelper.findChildScrollRect(self.viewGO, "#go_finish/weekwalkending/#scroll_null")
	self._gostartemplate = gohelper.findChild(self.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	self._gostartemplate2 = gohelper.findChild(self.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist2/#go_star_template2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2Ending:addEvents()
	return
end

function WeekWalk_2Ending:removeEvents()
	return
end

function WeekWalk_2Ending:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animator = self._gofinish:GetComponent(typeof(UnityEngine.Animator))
	self._mapId = WeekWalk_2Model.instance:getCurMapId()
	self._animEventWrap = self._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("star", self._startShowStars, self)

	self._time2 = 0.2
end

function WeekWalk_2Ending:_startShowStars()
	if not self._starList then
		return
	end

	self:_starsAppear()
end

function WeekWalk_2Ending:_starsAppear()
	self._curAppearIndex = 1

	TaskDispatcher.cancelTask(self._oneStarAppear, self)
	TaskDispatcher.runRepeat(self._oneStarAppear, self, 0.12)
end

function WeekWalk_2Ending:_oneStarAppear()
	local starGo = self._starList[self._curAppearIndex]

	gohelper.setActive(starGo, true)

	local starGo = self._starList[self._curAppearIndex + self._maxGroupNnum]

	gohelper.setActive(starGo, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)

	self._curAppearIndex = self._curAppearIndex + 1

	if self._curAppearIndex > self._maxGroupNnum then
		TaskDispatcher.cancelTask(self._oneStarAppear, self)
	end
end

function WeekWalk_2Ending:_addStarList()
	self._starList = self:getUserDataTb_()

	local battleInfo1 = WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(self._mapId, WeekWalk_2Enum.BattleIndex.First)
	local battleInfo2 = WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(self._mapId, WeekWalk_2Enum.BattleIndex.Second)
	local num = self._maxNum

	for i = 1, num do
		local firstBattle = i <= WeekWalk_2Enum.MaxStar
		local go = firstBattle and gohelper.cloneInPlace(self._gostartemplate) or gohelper.cloneInPlace(self._gostartemplate2)

		gohelper.setActive(go, true)

		local starGo = gohelper.findChild(go, "star")

		gohelper.setActive(starGo, false)

		local icon = gohelper.findChildImage(go, "star/xingxing")

		icon.enabled = false

		local iconEffect = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)

		if firstBattle then
			WeekWalk_2Helper.setCupEffect(iconEffect, battleInfo1:getCupInfo(i))
		else
			WeekWalk_2Helper.setCupEffect(iconEffect, battleInfo2:getCupInfo(i - WeekWalk_2Enum.MaxStar))
		end

		table.insert(self._starList, starGo)
	end
end

function WeekWalk_2Ending:onOpen()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, self._onWeekwalkResetLayer, self)
	self:_showFinishAnim()
end

function WeekWalk_2Ending:_onWeekwalkResetLayer()
	gohelper.setActive(self._gofinish, false)
end

function WeekWalk_2Ending:_onWeekwalkInfoUpdate()
	self:_showFinishAnim()
end

function WeekWalk_2Ending:_showFinishAnim()
	self._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

	if not self._mapInfo then
		return
	end

	self._maxGroupNnum = WeekWalk_2Enum.MaxStar
	self._curNum, self._maxNum = 6, 6

	if not self._mapInfo.allPass or not not self._mapInfo.showFinished then
		self:_onShowFinishAnimDone()

		return
	end

	TaskDispatcher.runDelay(self._playPadAudio, self, self._time2)
	self:_addStarList()

	if not self._mapInfo.showFinished then
		WeekWalk_2Model.instance:setFinishMapId(self._mapId)
	end

	Weekwalk_2Rpc.instance:sendWeekwalkVer2MarkShowFinishedRequest(self._mapId)

	self._mapInfo.showFinished = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	gohelper.setActive(self._gofinish, true)

	self._viewAnim.enabled = true

	local time = 3.7

	if self._curNum == self._maxNum then
		self._animator:Play("ending2")
		self._viewAnim:Play("finish_map2")
	else
		self._animator:Play("ending1")
		self._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(self._closeFinishAnim, self, time)

	self._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(self._checkAnimClip, self, 0)
end

function WeekWalk_2Ending:_playPadAudio()
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_stars_pad)
end

function WeekWalk_2Ending:_checkAnimClip()
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

function WeekWalk_2Ending:_closeFinishAnim()
	TaskDispatcher.cancelTask(self._checkAnimClip, self)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(self._gofinish, self._curNum == self._maxNum)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowFinishAnimDone)
	self:_onShowFinishAnimDone()
end

function WeekWalk_2Ending:_onShowFinishAnimDone()
	TaskDispatcher.runDelay(self._showIdle, self, 0)
end

function WeekWalk_2Ending:_showIdle()
	local isFinish = self._mapInfo.allPass

	if isFinish and self._curNum == self._maxNum then
		gohelper.setActive(self._gofinish, true)
		self._animator:Play(UIAnimationName.Idle)
	end
end

function WeekWalk_2Ending:onClose()
	gohelper.setActive(self._gofinish, false)
	TaskDispatcher.cancelTask(self._playPadAudio, self)
end

function WeekWalk_2Ending:onDestroyView()
	TaskDispatcher.cancelTask(self._checkAnimClip, self)
	TaskDispatcher.cancelTask(self._oneStarAppear, self)
	TaskDispatcher.cancelTask(self._closeFinishAnim, self)
	TaskDispatcher.cancelTask(self._showIdle, self)
	self._animEventWrap:RemoveAllEventListener()
end

return WeekWalk_2Ending
