-- chunkname: @modules/logic/sp01/assassin2/story/littlegame/AssassinEyeGameView.lua

module("modules.logic.sp01.assassin2.story.littlegame.AssassinEyeGameView", package.seeall)

local AssassinEyeGameView = class("AssassinEyeGameView", BaseView)
local WaitFindAreaTime = 2
local WaitGameDoneWorkParam = "AssassinController;AssassinEvent;OnEyeGameFinished"
local ShakeType = {
	Intense = 2,
	Slight = 1,
	None = 0
}
local ShakeType2ShakeRange = {
	[ShakeType.None] = 0,
	[ShakeType.Slight] = 10,
	[ShakeType.Intense] = 0
}
local ShakeType2ShakeInterval = {
	[ShakeType.None] = 0,
	[ShakeType.Slight] = 0.1,
	[ShakeType.Intense] = 0.05
}
local TwoRectPositionType = {
	Intersect = 2,
	Include = 3,
	Away = 1
}
local ShakeTweenDuration = 0.06
local RectPositionType2ShakeType = {
	[TwoRectPositionType.Away] = ShakeType.None,
	[TwoRectPositionType.Intersect] = ShakeType.Slight,
	[TwoRectPositionType.Include] = ShakeType.Intense
}

function AssassinEyeGameView:onInitView()
	self._gogame1 = gohelper.findChild(self.viewGO, "root/#go_game1")
	self._gogame2 = gohelper.findChild(self.viewGO, "root/#go_game2")
	self._goframe = gohelper.findChild(self.viewGO, "root/#go_frame")
	self._imageframe = gohelper.findChildImage(self.viewGO, "root/#go_frame/#image_frame")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/top/#txt_title")
	self._gopoints = gohelper.findChild(self.viewGO, "root/top/#go_points")
	self._gopoint = gohelper.findChild(self.viewGO, "root/top/#go_points/#go_point")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")
	self._btnfind = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_topright/#btn_find")
	self._gomask = gohelper.findChild(self.viewGO, "root/#go_frame/#image_frame/#go_mask")
	self._golightbg = gohelper.findChild(self.viewGO, "root/simage_light")
	self._golighteye = gohelper.findChild(self.viewGO, "root/#go_topright/#btn_find/image_light")
	self._gogreyeye = gohelper.findChild(self.viewGO, "root/#go_topright/#btn_find/image_grey")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinEyeGameView:addEvents()
	self._btnfind:AddClickListener(self._btnfindOnClick, self)
	SLFramework.UGUI.UIDragListener.Get(self._goframe):AddDragBeginListener(self._onDragBegin, self)
	SLFramework.UGUI.UIDragListener.Get(self._goframe):AddDragListener(self._onDrag, self)
	SLFramework.UGUI.UIDragListener.Get(self._goframe):AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnGameAfterStoryDone, self.closeThis, self)
end

function AssassinEyeGameView:removeEvents()
	self._btnfind:RemoveClickListener()
	SLFramework.UGUI.UIDragListener.Get(self._goframe):RemoveDragBeginListener()
	SLFramework.UGUI.UIDragListener.Get(self._goframe):RemoveDragListener()
	SLFramework.UGUI.UIDragListener.Get(self._goframe):RemoveDragEndListener()
end

function AssassinEyeGameView:_btnfindOnClick()
	if self._isUseEye then
		return
	end

	self._isUseEye = true

	self:refreshMaskPoint()
	gohelper.setActive(self._goframe, true)
	gohelper.setActive(self._golightbg, true)
	gohelper.setActive(self._golighteye, self._isUseEye)
	gohelper.setActive(self._gogreyeye, not self._isUseEye)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_clickeye)
end

function AssassinEyeGameView:_editableInitView()
	self._isUseEye = false

	gohelper.setActive(self._goframe, false)
	gohelper.setActive(self._gogame1, false)
	gohelper.setActive(self._gogame2, false)
	gohelper.setActive(self._golightbg, false)
	gohelper.setActive(self._golighteye, self._isUseEye)
	gohelper.setActive(self._gogreyeye, not self._isUseEye)

	self._frameTran = self._goframe.transform
	self._framePosTab = self:calcPosRangeInRect(0, 0, self._frameTran)
	self._frameImgTran = self._imageframe.transform
	self.viewTran = self.viewGO.transform
	self._maskTran = self._gomask.transform
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._gointersecteffect = gohelper.findChild(self._goframe, "#image_frame/#faguang")
	self._goincludeeffect = gohelper.findChild(self._goframe, "#image_frame/#jiexi")
	self._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_EyeGame)
end

function AssassinEyeGameView:onOpen()
	self._episodeId = self.viewParam and self.viewParam.episodeId
	self._flow = FlowSequence.New()

	self._flow:addWork(self:buildGameFlow(1))
	self._flow:addWork(FunctionWork.New(self.beforeSwitchNextGame, self))
	self._flow:addWork(self:buildGameFlow(2))
	self._flow:registerDoneListener(self.onGameDone, self)
	self._flow:start()
	self.playDialog(self, 1, self.triggerGuideEvent, self)
end

function AssassinEyeGameView:triggerGuideEvent()
	AssassinController.instance:dispatchEvent(AssassinEvent.TriggerEyeGameGuide)
end

function AssassinEyeGameView:buildGameFlow(index)
	local flow = FlowSequence.New()

	flow:addWork(FunctionWork.New(self.init, self, index))
	flow:addWork(WaitEventWork.New(WaitGameDoneWorkParam .. ";" .. index))
	flow:addWork(AssassinDialogWork.New(self._dialogIdList[index + 1]))

	return flow
end

function AssassinEyeGameView:beforeSwitchNextGame()
	self._animator:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_switchNext)
end

function AssassinEyeGameView:playDialog(index, callback, callbackObj)
	if self._dialogIdList then
		if not self._dialogIdList then
			return
		end

		VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(self._dialogIdList, callback, callbackObj)
	end
end

function AssassinEyeGameView:onGameDone()
	self.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, self._episodeId)
end

function AssassinEyeGameView:init(index)
	self._curGameIndex = index
	self._rootGO, self._maskRootGO = self:_activeTargetGame(index)
	self._rootTran = self._rootGO.transform
	self._maskRootTran = self._maskRootGO.transform
	self._gofindarea = gohelper.findChild(self._rootGO, "go_findarea")
	self._findAreaTran = self._gofindarea.transform
	self._findAreaWidth = recthelper.getWidth(self._findAreaTran)
	self._findAreaHeight = recthelper.getHeight(self._findAreaTran)
	self._frameTran.parent = self._findAreaTran

	gohelper.setActive(self._goframe, self._isUseEye)

	self._maskPointsGO = gohelper.findChild(self._maskRootGO, "go_points")
	self._maskPointsTran = self._maskPointsGO.transform
	self._minFindAreaPosX = -self._findAreaWidth / 2 + self._framePosTab.width / 2
	self._maxFindAreaPosX = self._findAreaWidth / 2 - self._framePosTab.width / 2
	self._minFindAreaPosY = -self._findAreaHeight / 2 + self._framePosTab.height / 2
	self._maxFindAreaPosY = self._findAreaHeight / 2 - self._framePosTab.height / 2
	self._findAreaIndex = 0
	self._rectPositionType = TwoRectPositionType.Away
	self._findAreaIndexDict = {}
	self._pointRectPosList = {}
	self._pointTranList = self:getUserDataTb_()
	self._pointIconTranList = self:getUserDataTb_()

	self:refreshMaskPoint()

	for i = 1, math.huge do
		local gopoint = gohelper.findChild(self._maskPointsGO, "go_area" .. i)

		if gohelper.isNil(gopoint) then
			break
		end

		local imagepoint = gohelper.findChildImage(gopoint, "icon")
		local pointTran = gopoint.transform
		local pointPosX, pointPosY = recthelper.rectToRelativeAnchorPos2(pointTran.position, self._findAreaTran)
		local rectPosDict = self:calcPosRangeInRect(pointPosX, pointPosY, pointTran)

		table.insert(self._pointRectPosList, rectPosDict)
		table.insert(self._pointTranList, gopoint.transform)
		table.insert(self._pointIconTranList, imagepoint.transform)
	end

	self._allPointNum = #self._pointRectPosList

	gohelper.setActive(self._findAreaTran, true)
	gohelper.setActive(self._goincludeeffect, false)
	gohelper.setActive(self._gointersecteffect, false)
	self:refreshFindProgress()
end

function AssassinEyeGameView:_activeTargetGame(index)
	local rootGO, maskRootGO

	for i = 1, math.huge do
		local goroot = gohelper.findChild(self.viewGO, "root/#go_game" .. i)
		local gomaskroot = gohelper.findChild(self._gomask, "#go_gamemask" .. i)

		if gohelper.isNil(goroot) or gohelper.isNil(gomaskroot) then
			break
		end

		local isFind = i == index

		gohelper.setActive(goroot, isFind)
		gohelper.setActive(gomaskroot, isFind)

		if isFind then
			rootGO = goroot
			maskRootGO = gomaskroot
		end
	end

	return rootGO, maskRootGO
end

function AssassinEyeGameView:_onDragBegin()
	self:_processDragEvent()
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_beginDragFrame)
end

function AssassinEyeGameView:_onDrag()
	self:_processDragEvent()
end

function AssassinEyeGameView:_onDragEnd()
	self:_processDragEvent()
end

function AssassinEyeGameView:_processDragEvent()
	local mousePosition = GamepadController.instance:getMousePosition()
	local frameTmpPosX, frameTmpPosY = recthelper.screenPosToAnchorPos2(mousePosition, self._findAreaTran)

	frameTmpPosX = Mathf.Clamp(frameTmpPosX, self._minFindAreaPosX, self._maxFindAreaPosX)
	frameTmpPosY = Mathf.Clamp(frameTmpPosY, self._minFindAreaPosY, self._maxFindAreaPosY)

	recthelper.setAnchor(self._frameTran, frameTmpPosX, frameTmpPosY)

	local type, findAreaIndex = self:checkIsFindArea(frameTmpPosX, frameTmpPosY)

	if findAreaIndex ~= self._findAreaIndex or type ~= self._rectPositionType then
		self._rectPositionType = type
		self._findAreaIndex = findAreaIndex

		TaskDispatcher.cancelTask(self._wait2FindAreaSuccee, self)

		if findAreaIndex and type == TwoRectPositionType.Include then
			TaskDispatcher.cancelTask(self._wait2FindAreaSuccee, self)
			TaskDispatcher.runDelay(self._wait2FindAreaSuccee, self, WaitFindAreaTime)
			AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEye)
		end

		local shakeType = RectPositionType2ShakeType[type]

		self:tickShake(shakeType)
	end

	gohelper.setActive(self._gointersecteffect, type == TwoRectPositionType.Intersect)
	gohelper.setActive(self._goincludeeffect, type == TwoRectPositionType.Include)
	self:refreshMaskPoint()
end

function AssassinEyeGameView:checkIsFindArea(frameTmpPosX, frameTmpPosY)
	self:calcPosRangeInRect(frameTmpPosX, frameTmpPosY, self._frameTran, self._framePosTab)

	for index, pointRectPos in ipairs(self._pointRectPosList) do
		if not self._findAreaIndexDict[index] then
			local type = self:calcTwoRectPositionType(self._framePosTab, pointRectPos)

			if type ~= TwoRectPositionType.Away then
				return type, index
			end
		end
	end

	return TwoRectPositionType.Away
end

function AssassinEyeGameView:calcTwoRectPositionType(rectTab1, rectTab2)
	local minPosX_Rect1 = rectTab1.minPosX
	local maxPosX_Rect1 = rectTab1.maxPosX
	local minPosY_Rect1 = rectTab1.minPosY
	local maxPosY_Rect1 = rectTab1.maxPosY
	local minPosX_Rect2 = rectTab2.minPosX
	local maxPosX_Rect2 = rectTab2.maxPosX
	local minPosY_Rect2 = rectTab2.minPosY
	local maxPosY_Rect2 = rectTab2.maxPosY

	if minPosX_Rect1 <= minPosX_Rect2 and maxPosX_Rect2 <= maxPosX_Rect1 and minPosY_Rect1 <= minPosY_Rect2 and maxPosY_Rect2 <= maxPosY_Rect1 then
		return TwoRectPositionType.Include
	else
		local minPosX = math.max(minPosX_Rect1, minPosX_Rect2)
		local maxPosX = math.min(maxPosX_Rect1, maxPosX_Rect2)
		local minPosY = math.max(minPosY_Rect1, minPosY_Rect2)
		local maxPosY = math.min(maxPosY_Rect1, maxPosY_Rect2)

		if minPosX < maxPosX and minPosY < maxPosY then
			return TwoRectPositionType.Intersect
		end
	end

	return TwoRectPositionType.Away
end

function AssassinEyeGameView:calcPosRangeInRect(posX, posY, rectTran, dataTab)
	dataTab = dataTab or {
		width = recthelper.getWidth(rectTran),
		height = recthelper.getHeight(rectTran)
	}

	local width = dataTab.width
	local height = dataTab.height

	dataTab.minPosX = posX - width / 2
	dataTab.maxPosX = posX + width / 2
	dataTab.minPosY = posY - height / 2
	dataTab.maxPosY = posY + height / 2
	dataTab.posX = posX
	dataTab.posY = posY
	dataTab.screenPos = recthelper.uiPosToScreenPos(rectTran)

	return dataTab
end

function AssassinEyeGameView:_wait2FindAreaSuccee()
	if self._findAreaIndex then
		self._findAreaIndexDict[self._findAreaIndex] = true

		gohelper.setActive(self._pointTranList[self._findAreaIndex], true)
		AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)

		local animator = gohelper.onceAddComponent(self._pointTranList[self._findAreaIndex], gohelper.Type_Animator)

		animator:Play("finish", 0, 0)
		self:refreshFindProgress()
		self:tickShake(ShakeType.None)
		TaskDispatcher.cancelTask(self._shake, self)

		self._findAreaIndex = nil
	end
end

function AssassinEyeGameView:refreshFindProgress()
	self._hasFindNum = tabletool.len(self._findAreaIndexDict)
	self._txttitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassineyegameview_title"), self._hasFindNum, self._allPointNum)

	gohelper.CreateObjList(self, self.refreshSingleProgress, self._pointRectPosList, self._gopoints, self._gopoint)

	if self._hasFindNum >= self._allPointNum then
		AssassinController.instance:dispatchEvent(AssassinEvent.OnEyeGameFinished, self._curGameIndex)
	end
end

function AssassinEyeGameView:refreshSingleProgress(obj, data, index)
	local isFind = index <= self._hasFindNum
	local imageicon = obj:GetComponent(gohelper.Type_Image)
	local goeffect = gohelper.findChild(obj, "#eyelight")

	gohelper.setActive(goeffect, isFind)
	UISpriteSetMgr.instance:setSp01AssassinSprite(imageicon, isFind and "assassin2_threegames_eyes_3_1" or "assassin2_threegames_eyes_3_2")
end

function AssassinEyeGameView:tickShake(shakeType)
	if self._curShakeType == shakeType then
		return
	end

	self._curShakeType = shakeType

	self:_shake()
	TaskDispatcher.cancelTask(self._shake, self)

	if shakeType ~= ShakeType.None then
		local shakeInterval = ShakeType2ShakeInterval[shakeType]

		TaskDispatcher.runRepeat(self._shake, self, shakeInterval)
	end
end

function AssassinEyeGameView:_shake()
	local shakeRange = ShakeType2ShakeRange[self._curShakeType]

	if not shakeRange then
		logError(string.format("未配置震动移动范围(ShakeType2ShakeRange) shakeType = %s", self._curShakeType))

		return
	end

	self:_killTweenId("_frameTweenId")
	self:_killTweenId("_iconTweenId")

	local framePosX, framePosY = GameUtil.getRandomPosInCircle(0, 0, shakeRange)

	self._frameTweenId = ZProj.TweenHelper.DOAnchorPos(self._frameImgTran, framePosX, framePosY, ShakeTweenDuration)

	if self._findAreaIndex and self._pointIconTranList[self._findAreaIndex] then
		local pointPosX, pointPosY = GameUtil.getRandomPosInCircle(0, 0, shakeRange)

		self._iconTweenId = ZProj.TweenHelper.DOAnchorPos(self._pointIconTranList[self._findAreaIndex], pointPosX, pointPosY, ShakeTweenDuration)
	end

	self:refreshMaskPoint()
end

function AssassinEyeGameView:_killTweenId(tweenId)
	if tweenId and self[tweenId] then
		ZProj.TweenHelper.KillById(self[tweenId])

		self[tweenId] = nil
	end
end

function AssassinEyeGameView:refreshMaskPoint()
	local maskGamePosX, maskGamePosY = recthelper.rectToRelativeAnchorPos2(self._rootTran.position, self._maskTran)

	recthelper.setAnchor(self._maskRootTran, maskGamePosX, maskGamePosY)
end

function AssassinEyeGameView:onClose()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	self:_killTweenId("_frameTweenId")
	self:_killTweenId("_iconTweenId")
	TaskDispatcher.cancelTask(self._wait2FindAreaSuccee, self)
	TaskDispatcher.cancelTask(self._shake, self)
end

function AssassinEyeGameView:onDestroyView()
	return
end

return AssassinEyeGameView
