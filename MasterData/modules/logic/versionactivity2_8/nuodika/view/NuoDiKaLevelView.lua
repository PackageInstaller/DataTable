-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaLevelView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelView", package.seeall)

local NuoDiKaLevelView = class("NuoDiKaLevelView", BaseView)
local episodesPosX = {
	-960,
	-960,
	-960,
	-960,
	-1300,
	-1800,
	-2300,
	-3000
}
local levelDissolvePath1X = {
	0.2,
	0.2,
	0.6,
	1.3,
	1.3,
	1.3,
	1.3,
	1.3
}
local levelDissolvePath2X = {
	-0.6,
	-0.6,
	-0.6,
	-0.6,
	-0.1,
	0.3,
	0.8,
	1.3
}
local SlideTime = 0.3

function NuoDiKaLevelView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/#txt_limittime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gonotpasspath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath")
	self._imagePath = gohelper.findChildImage(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath")
	self._gopath1 = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath/#go_path1")
	self._imagePath1 = gohelper.findChildImage(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath/#go_path1")
	self._gopasspath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_passpath")
	self._goendless = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_endless")
	self._gobtnendless = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/#go_endless/#btn_endless")
	self._btnendless = gohelper.getClick(self._gobtnendless)
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnendless:AddClickListener(self._btnEndlessOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function NuoDiKaLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._btnendless:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function NuoDiKaLevelView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actConfig.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function NuoDiKaLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function NuoDiKaLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.NuoDiKaTaskView)
end

function NuoDiKaLevelView:_btnEndlessOnClick()
	self._episodeItems[8]:_btnOnClick()
end

function NuoDiKaLevelView:_onEpisodeFinished()
	local newEpisode = NuoDiKaModel.instance:getNewFinishEpisode()

	if newEpisode then
		self:_playStoryFinishAnim()
	end
end

function NuoDiKaLevelView:_playStoryFinishAnim()
	local newEpisode = NuoDiKaModel.instance:getNewFinishEpisode()

	if newEpisode then
		for k, episodeItem in ipairs(self._episodeItems) do
			if episodeItem.id == newEpisode then
				local maxEpisodeId = NuoDiKaModel.instance:getMaxEpisodeId()

				if newEpisode == maxEpisodeId then
					AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_all_pass)
					self._anim:Play("end", 0, 0)
					self:_checkShowBg()
				else
					local episodeCo = NuoDiKaConfig.instance:getEpisodeCo(self.actId, newEpisode)
					local curBg = self:_getEpisodeBg(newEpisode)
					local lastBg = self:_getEpisodeBg(episodeCo.preEpisode)

					if curBg ~= lastBg then
						gohelper.setActive(self._simagebg2.gameObject, true)

						self._simagebg2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

						self._simagebg2:LoadImage(ResUrl.getNuoDiKaSingleBg(curBg))
						AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_switch)
						self._anim:Play("switch", 0, 0)
						UIBlockMgrExtend.setNeedCircleMv(false)
						UIBlockMgr.instance:startBlock("levelSwitch")
						TaskDispatcher.runDelay(self._onChangeSwitchBg, self, 3)
					end
				end

				self._finishEpisodeIndex = k

				episodeItem:playFinish()
				episodeItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		NuoDiKaModel.instance:clearFinishEpisode()
	end
end

function NuoDiKaLevelView:_onChangeSwitchBg()
	local episodeId = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local curBg = self:_getEpisodeBg(episodeId)

	NuoDiKaModel.instance:setCurEpisode(self._curEpisodeIndex, episodeId)
	self._simagebg1:LoadImage(ResUrl.getNuoDiKaSingleBg(curBg))
	TaskDispatcher.runDelay(self._onSwitchFinish, self, 2)
end

function NuoDiKaLevelView:_onSwitchFinish()
	gohelper.setActive(self._simagebg2.gameObject, false)
	self._anim:Play("open", 0, 1)
	UIBlockMgr.instance:endBlock("levelSwitch")
end

function NuoDiKaLevelView:_onBackToLevel()
	local newEpisode = NuoDiKaModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = NuoDiKaModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = NuoDiKaModel.instance:getEpisodeIndex(maxUnlockEpisode)

		NuoDiKaModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
		self:_focusLvItem(self._curEpisodeIndex)

		if self._curEpisodeIndex == 8 then
			AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_last_level_unlock)
			self._endlessAnim:Play("open", 0, 0)
		end
	end

	self._anim:Play("back", 0, 0)
	self:_refreshUI()
	self:_refreshTask()
end

function NuoDiKaLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a4WuErLiXiTask, self.actId) then
		self._taskAnim:Play("loop", 0, 0)
	else
		self._taskAnim:Play("idle", 0, 0)
	end
end

function NuoDiKaLevelView:_onCloseTask()
	self:_refreshTask()
end

function NuoDiKaLevelView:_addEvents()
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnCloseTask, self._onCloseTask, self)
end

function NuoDiKaLevelView:_removeEvents()
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.OnCloseTask, self._onCloseTask, self)
end

function NuoDiKaLevelView:_editableInitView()
	self.actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._endlessAnim = self._goendless:GetComponent(gohelper.Type_Animator)
	self._taskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	self._notPassAnim = self._gonotpasspath:GetComponent(gohelper.Type_Animator)
	self._passAnim = self._gopasspath:GetComponent(gohelper.Type_Animator)
	self._gostages = {}

	for i = 1, 8 do
		local gostage = gohelper.findChild(self._gostoryStages, "stage" .. i)

		table.insert(self._gostages, gostage)
	end

	self:_initLevelItems()
	self:_checkShowBg()
	self:_refreshUI()
	self:_addEvents()
	gohelper.setActive(self._gotime, false)
end

function NuoDiKaLevelView:_getEpisodeBg(episodeId)
	local stages1 = string.split(NuoDiKaConfig.instance:getConstCo(3).value, "#")
	local stages2 = string.split(NuoDiKaConfig.instance:getConstCo(4).value, "#")
	local stages3 = string.split(NuoDiKaConfig.instance:getConstCo(5).value, "#")

	return episodeId >= tonumber(stages3[1]) and stages3[2] or episodeId >= tonumber(stages2[1]) and stages2[2] or stages1[2]
end

function NuoDiKaLevelView:_checkShowBg()
	local bgSpr = "v2a8_nuodika_level_fullbg1"

	if NuoDiKaModel.instance:isAllEpisodeFinish() then
		bgSpr = NuoDiKaConfig.instance:getConstCo(6).value
	else
		local maxEpisode = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
		local maxShowEpisodeIndex = NuoDiKaModel.instance:getEpisodeIndex(maxEpisode)
		local stages1 = string.split(NuoDiKaConfig.instance:getConstCo(3).value, "#")
		local stages2 = string.split(NuoDiKaConfig.instance:getConstCo(4).value, "#")
		local stages3 = string.split(NuoDiKaConfig.instance:getConstCo(5).value, "#")

		bgSpr = maxShowEpisodeIndex > NuoDiKaModel.instance:getEpisodeIndex(tonumber(stages3[1])) and stages3[2] or maxShowEpisodeIndex > NuoDiKaModel.instance:getEpisodeIndex(tonumber(stages2[1])) and stages2[2] or stages1[2]
	end

	if bgSpr ~= self._simagebg1.curImageUrl then
		self._simagebg1:LoadImage(ResUrl.getNuoDiKaSingleBg(bgSpr))
	end
end

function NuoDiKaLevelView:_refreshUI()
	local maxUnlockEpisodeId = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local maxEpisodeId = NuoDiKaModel.instance:getMaxEpisodeId()

	gohelper.setActive(self._goendless, maxUnlockEpisodeId == maxEpisodeId)

	local isAllEpisodePass = NuoDiKaModel.instance:isAllEpisodeFinish()

	gohelper.setActive(self._gonotpasspath, not isAllEpisodePass)
	gohelper.setActive(self._gopasspath, isAllEpisodePass)

	local maxUnlockIndex = NuoDiKaModel.instance:getEpisodeIndex(maxUnlockEpisodeId)

	if not isAllEpisodePass then
		local animName = maxUnlockIndex > 4 and "go_passpath_02" or "go_passpath_01"

		self._notPassAnim:Play(animName, 0, 0)

		local vector1 = Vector4.New(levelDissolvePath1X[maxUnlockIndex], -0.3, 0, 0)
		local vector2 = Vector4.New(levelDissolvePath2X[maxUnlockIndex], -0.3, 0, 0)
		local matPropCtrls = self._gonotpasspath:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		matPropCtrls.vector_01 = vector1
		matPropCtrls.vector_03 = vector2

		matPropCtrls:SetProps()
	else
		self._passAnim:Play("go_passpath_02", 0, 0)
	end

	gohelper.setActive(self._gopath1, maxUnlockIndex > 4)

	local targetWidth = 960 - episodesPosX[maxUnlockIndex]

	recthelper.setWidth(self._gostoryScroll.transform, targetWidth)
end

function NuoDiKaLevelView:onOpen()
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a4WuErLiXiTask, self.actId)
	self:_refreshLeftTime()
	self:_refreshTask()
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
end

function NuoDiKaLevelView:_refreshLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function NuoDiKaLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = NuoDiKaConfig.instance:getEpisodeCoList(self.actId)

	for i = 1, #episodeCos do
		local cloneGo = self:getResInst(path, self._gostages[i])

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, NuoDiKaLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)

		if self._episodeItems[i]:isUnlock() then
			self._curEpisodeIndex = i
		end
	end

	local curEpisodeIndex = NuoDiKaModel.instance:getCurEpisodeIndex()

	self._curEpisodeIndex = curEpisodeIndex > 0 and curEpisodeIndex or self._curEpisodeIndex

	self:_focusLvItem(self._curEpisodeIndex)
end

function NuoDiKaLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_unlockStory()
	end
end

function NuoDiKaLevelView:_unlockStory()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function NuoDiKaLevelView:_unlockLvEnd()
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()

	self._finishEpisodeIndex = nil
end

function NuoDiKaLevelView:_focusLvItem(index, needPlay)
	local maxUnlockEpisodeId = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local maxUnlockIndex = NuoDiKaModel.instance:getEpisodeIndex(maxUnlockEpisodeId)
	local targetWidth = 960 - episodesPosX[maxUnlockIndex]

	if targetWidth > UnityEngine.Screen.width then
		if not (0.5 * UnityEngine.Screen.width - targetWidth) then
			local targetX = -0.5 * UnityEngine.Screen.width

			if needPlay then
				ZProj.TweenHelper.DOLocalMoveX(self._gostoryScroll.transform, targetX, SlideTime, self._onFocusEnd, self, index)
			else
				transformhelper.setLocalPos(self._gostoryScroll.transform, targetX, 0, 0)
			end

			NuoDiKaModel.instance:setCurEpisode(index)
		end
	end
end

function NuoDiKaLevelView:_onFocusEnd(index)
	self:_checkShowBg()
end

function NuoDiKaLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
end

function NuoDiKaLevelView:onDestroyView()
	self:_removeEvents()
	self._simagebg1:UnLoadImage()

	self._episodeItems = nil
end

return NuoDiKaLevelView
