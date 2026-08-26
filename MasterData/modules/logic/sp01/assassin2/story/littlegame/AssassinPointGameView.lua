-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinPointGameView.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinPointGameView", package.seeall)

local AssassinPointGameView = class("AssassinPointGameView", BaseView)
local LineStatus = {
	Disconnected = 1,
	Connected = 2
}
local LineConnectAudioDelay = {
	1,
	2,
	3,
	4
}

function AssassinPointGameView:onInitView()
	self._gogame1 = gohelper.findChild(self.viewGO, "root/#go_game1")
	self._gopoints = gohelper.findChild(self.viewGO, "root/#go_game1/#go_points")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/top/#txt_title")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")
	self._btnfind = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_topright/#btn_find")
	self._golightbg = gohelper.findChild(self.viewGO, "root/simage_light")
	self._golighteye = gohelper.findChild(self.viewGO, "root/#go_topright/#btn_find/image_light")
	self._gogreyeye = gohelper.findChild(self.viewGO, "root/#go_topright/#btn_find/image_grey")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinPointGameView:addEvents()
	self._btnfind:AddClickListener(self._btnfindOnClick, self)
end

function AssassinPointGameView:removeEvents()
	self._btnfind:RemoveClickListener()
end

function AssassinPointGameView:_btnfindOnClick()
	if self._useEye then
		return
	end

	self._useEye = true

	self:initEyeBg()
	self:startConnectAllLines()
	gohelper.setActive(self._gopoints, self._useEye)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_clickeye)
end

function AssassinPointGameView:_editableInitView()
	self._useEye = false
	self._pointView2 = self.viewContainer._views[2]
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self:initEyeBg()
	self:initPoints()
	self:initDialogs()
end

function AssassinPointGameView:initEyeBg()
	gohelper.setActive(self._golightbg, self._useEye)
	gohelper.setActive(self._golighteye, self._useEye)
	gohelper.setActive(self._gogreyeye, not self._useEye)
end

function AssassinPointGameView:initPoints()
	self._pointGoTab = self:getUserDataTb_()
	self._pointClickTab = self:getUserDataTb_()
	self._pointAnimatorTab = self:getUserDataTb_()
	self._pointsTran = self._gopoints.transform
	self._pointCount = self._pointsTran.childCount
	self._collectPointCount = 0
	self._pointStatusMap = {}

	for i = 1, self._pointCount do
		local gocontainer = self._pointsTran:GetChild(i - 1).gameObject

		if gohelper.isNil(gocontainer) then
			break
		end

		local gopoint = gohelper.findChild(gocontainer, "point")

		self._pointGoTab[i] = gopoint

		local pointClick = gohelper.getClickWithAudio(gopoint, AudioEnum2_9.DungeonMiniGame.play_ui_clickPoint)

		pointClick:AddClickListener(self._onClickPoint, self, i)

		self._pointClickTab[i] = pointClick

		gohelper.setActive(gopoint, false)

		local goselect = gohelper.findChild(gopoint, "select")

		gohelper.setActive(goselect, false)

		self._pointStatusMap[i] = LineStatus.Disconnected
		self._pointAnimatorTab[i] = SLFramework.AnimatorPlayer.Get(gocontainer)
	end

	gohelper.setActive(self._gopoints, self._useEye)
end

function AssassinPointGameView:_onClickPoint(index)
	local pointGo = self._pointGoTab[index]

	if gohelper.isNil(pointGo) then
		return
	end

	local isAllLineConnected = self:isAllLineConnected()

	if not isAllLineConnected then
		return
	end

	self:setPointSelect(index, true)
	self._pointView2:onClickLineConnectPoint(index)
end

function AssassinPointGameView:isAllLineConnected()
	for _, status in pairs(self._pointStatusMap) do
		if status ~= LineStatus.Connected then
			return false
		end
	end

	return true
end

function AssassinPointGameView:startConnectAllLines()
	for index, lineAnimator in ipairs(self._pointAnimatorTab) do
		self._playConnectLineAnimDone({
			callTarget = self,
			lineIndex = index
		})
	end

	self._animatorPlayer:Play("click", self.onAllLineConnectDone, self)

	self._connectLineAudioFlow = FlowParallel.New()

	for _, delayTime in ipairs(LineConnectAudioDelay) do
		self._connectLineAudioFlow:addWork(DelayDoFuncWork.New(self.playFindEyeSuccAudio, self, delayTime))
	end

	self._connectLineAudioFlow:start()
end

function AssassinPointGameView:playFindEyeSuccAudio()
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)
end

function AssassinPointGameView:onAllLineConnectDone()
	self:playDialog(2)
end

function AssassinPointGameView._playConnectLineAnimDone(params)
	local callTarget = params.callTarget
	local lineIndex = params.lineIndex

	callTarget._pointStatusMap[lineIndex] = LineStatus.Connected

	local gopoint = callTarget._pointGoTab[lineIndex]

	gohelper.setActive(gopoint, true)
end

function AssassinPointGameView:initDialogs()
	self._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_PointGame)

	if self._dialogIdList then
		self._dialogCount = #self._dialogIdList or 0
	end

	self.playDialog(self, 1, self.triggerGuide, self)
end

function AssassinPointGameView:playDialog(index, callback, callbackObj)
	if self._dialogIdList then
		VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(self._dialogIdList, callback, callbackObj)
	end
end

function AssassinPointGameView:triggerGuide()
	AssassinController.instance:dispatchEvent(AssassinEvent.TriggerPointGameGuide)
end

function AssassinPointGameView:onClickPointError(pointIndex)
	self:setPointSelect(pointIndex, false)
end

function AssassinPointGameView:setPointSelect(pointIndex, isSelect)
	local gopoint = self._pointGoTab[pointIndex]

	if gohelper.isNil(gopoint) then
		return
	end

	local goselect = gohelper.findChild(gopoint, "select")

	gohelper.setActive(goselect, isSelect)
end

function AssassinPointGameView:releaseAllListeners()
	if self._pointClickTab then
		for _, pointClick in pairs(self._pointClickTab) do
			pointClick:RemoveClickListener()
		end
	end
end

function AssassinPointGameView:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
end

function AssassinPointGameView:onClose()
	self:releaseAllListeners()

	if self._connectLineAudioFlow then
		self._connectLineAudioFlow:destroy()

		self._connectLineAudioFlow = nil
	end
end

function AssassinPointGameView:onDestroyView()
	return
end

return AssassinPointGameView
