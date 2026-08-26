-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/map/VersionActivity2_0DungeonMapGraffitiEnterView.lua

module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapGraffitiEnterView", package.seeall)

local VersionActivity2_0DungeonMapGraffitiEnterView = class("VersionActivity2_0DungeonMapGraffitiEnterView", BaseView)

function VersionActivity2_0DungeonMapGraffitiEnterView:onInitView()
	self._gorole1 = gohelper.findChild(self.viewGO, "root/role/#go_role1")
	self._gorole2 = gohelper.findChild(self.viewGO, "root/role/#go_role2")
	self._gorole3 = gohelper.findChild(self.viewGO, "root/role/#go_role3")
	self._gorole4 = gohelper.findChild(self.viewGO, "root/role/#go_role4")
	self._btnenterGraffiti = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_enterGraffiti")
	self._btnenterGraffiti2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_enterGraffiti2")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_back")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gograffitiReddot = gohelper.findChild(self.viewGO, "root/#btn_enterGraffiti/#go_graffitiReddot")
	self._gobackReddot = gohelper.findChild(self.viewGO, "root/#btn_back/#go_backReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:addEvents()
	self._btnenterGraffiti:AddClickListener(self._btnenterGraffitiOnClick, self)
	self._btnenterGraffiti2:AddClickListener(self._btnenterGraffitiOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, self.setCanvasView, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.OpenGuideDialogue, self.openGuideDialogue, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.EnterGraffitiView, self._btnenterGraffitiOnClick, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, self.closeViewWithEffect, self)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:removeEvents()
	self._btnenterGraffiti:RemoveClickListener()
	self._btnenterGraffiti2:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.SetGraffitiMapSceneCanvas, self.setCanvasView, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.OpenGuideDialogue, self.openGuideDialogue, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.EnterGraffitiView, self._btnenterGraffitiOnClick, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.CloseRestaurantWithEffect, self.closeViewWithEffect, self)
end

VersionActivity2_0DungeonMapGraffitiEnterView.TextShowInterval = 0.06
VersionActivity2_0DungeonMapGraffitiEnterView.TalkStepShowInterval = 1
VersionActivity2_0DungeonMapGraffitiEnterView.TalkFinishTime = 2
VersionActivity2_0DungeonMapGraffitiEnterView.ScrollTalkMargin = {
	Top = 10,
	Bottom = 20
}
VersionActivity2_0DungeonMapGraffitiEnterView.TextMaxHeight = 200
VersionActivity2_0DungeonMapGraffitiEnterView.TipHeight = 10

function VersionActivity2_0DungeonMapGraffitiEnterView:_btnenterGraffitiOnClick()
	local isDragginMap = VersionActivity2_0DungeonModel.instance:isDraggingMapState()

	if isDragginMap then
		return
	end

	local param = {}

	param.actId = self.actId

	Activity161Controller.instance:openGraffitiView(param)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:_btnbackOnClick()
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)

	self.isClickBack = true

	local elementId = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()

	if elementId then
		VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, elementId)
	else
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	self:closeThis()
end

function VersionActivity2_0DungeonMapGraffitiEnterView:openGuideDialogue(dialogueId)
	VersionActivity2_0DungeonController.instance:openDialogueView(tonumber(dialogueId))
end

function VersionActivity2_0DungeonMapGraffitiEnterView:setCanvasView(param)
	self.mapCfg = param.mapConfig
	self.canvasGO = param.canvasGO
	self.sceneGO = param.sceneGo

	gohelper.addChild(self.canvasGO, self.viewGO)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:_editableInitView()
	self.actId = Activity161Model.instance:getActId()
	self.roleTab = self:getUserDataTb_()
	self.dialogMap = {}
	self.isStartTalk = false
	self.isClickBack = false

	RedDotController.instance:addRedDot(self._gobackReddot, RedDotEnum.DotNode.V2a0DungeonHasUnDoElement, nil, self.checkHasUnDoElement, self)

	local multiReddots = {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = self.actId
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = self.actId
		}
	}

	RedDotController.instance:addMultiRedDot(self._gograffitiReddot, multiReddots)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:checkHasUnDoElement(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local needDoElementId = VersionActivity2_0DungeonModel.instance:getCurNeedUnlockGraffitiElement()

		if needDoElementId then
			redDotIcon.show = true

			redDotIcon:showRedDot(RedDotEnum.Style.Normal)
		end
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:onOpen()
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(false)
	self:initRoleComp()
	self:initDialog()
	self:startTalk()
end

function VersionActivity2_0DungeonMapGraffitiEnterView:initRoleComp()
	for i = 1, 4 do
		local roleItem = {}

		roleItem.go = self["_gorole" .. i]
		roleItem.canvasGroup = roleItem.go:GetComponent(gohelper.Type_CanvasGroup)
		roleItem.gotalkDot = gohelper.findChild(roleItem.go, "vx_pot")
		roleItem.gotalk = gohelper.findChild(roleItem.go, "go_talk")
		roleItem.gotalkRect = roleItem.gotalk:GetComponent(gohelper.Type_RectTransform)
		roleItem.scrolltalk = gohelper.findChildScrollRect(roleItem.go, "go_talk/Scroll View")
		roleItem.txttalk = gohelper.findChildText(roleItem.go, "go_talk/Scroll View/Viewport/Content/txt_talk")
		roleItem.imgchess = gohelper.findChildImage(roleItem.go, "#chess/image_chess")
		self.roleTab[i] = roleItem

		UISpriteSetMgr.instance:setV2a0DungeonSprite(roleItem.imgchess, "v2a0_dungeon_chess_" .. i)

		local config = Activity161Config.instance:getChessConfig(i)
		local posList = string.splitToNumber(config.pos, "#")

		recthelper.setAnchor(roleItem.go.transform, posList[1], posList[2])
		gohelper.setActive(roleItem.gotalk, false)
		gohelper.setActive(roleItem.gotalkDot, false)
	end

	gohelper.setActive(self.roleTab[Activity161Enum.npcRole].go, false)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:initDialog()
	self.dialogState, self.recentFinishDialogMO = Activity161Controller.instance:checkRencentGraffitiHasDialog()

	if self:canDialog() then
		local dialogGroupId = self.recentFinishDialogMO.config.dialogGroupId

		self.dialogMap = Activity161Config.instance:getAllDialogMapCoByGraoupId(dialogGroupId)

		for step, dialogCo in pairs(self.dialogMap) do
			if dialogCo.chessId >= Activity161Enum.npcRole then
				local chessCofing = Activity161Config.instance:getChessConfig(dialogCo.chessId)

				UISpriteSetMgr.instance:setV2a0DungeonSprite(self.roleTab[Activity161Enum.npcRole].imgchess, chessCofing.resource)

				local posList = string.splitToNumber(chessCofing.pos, "#")

				recthelper.setAnchor(self.roleTab[Activity161Enum.npcRole].go.transform, posList[1], posList[2])
				gohelper.setActive(self.roleTab[Activity161Enum.npcRole].go, true)

				break
			end
		end
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:canDialog()
	return not self.dialogState and self.recentFinishDialogMO
end

function VersionActivity2_0DungeonMapGraffitiEnterView:startTalk()
	if self:canDialog() then
		self.isStartTalk = true
		self.curStepIndex = 1
		self.curCharIndex = 0
		self.lastShowTime = Time.time - VersionActivity2_0DungeonMapGraffitiEnterView.TextShowInterval
		self.dialogConfig = self.dialogMap[self.curStepIndex]
		self.dialogLength = utf8.len(self.dialogConfig.dialog)

		self:initUpdateBeat()
	else
		self.isStartTalk = false
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:initUpdateBeat()
	self.updateHandle = UpdateBeat:CreateListener(self._onTalkFrame, self)

	UpdateBeat:AddListener(self.updateHandle)

	self.lateUpdateHandle = UpdateBeat:CreateListener(self._onTalkFrameLateUpdate, self)

	UpdateBeat:AddListener(self.lateUpdateHandle)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:_onTalkFrame()
	if self.closedView then
		return
	end

	if not self.isStartTalk then
		return
	end

	if self.waitPlayNextStep or self.waitFinishTalk then
		return
	end

	local currentTime = Time.time

	if currentTime - self.lastShowTime < VersionActivity2_0DungeonMapGraffitiEnterView.TextShowInterval then
		return
	end

	self:showTalkContent()
end

function VersionActivity2_0DungeonMapGraffitiEnterView:showTalkContent()
	if self.closedView then
		return
	end

	self.lastShowTime = Time.time
	self.curCharIndex = self.curCharIndex + 1
	self.curChessId = Mathf.Min(self.dialogConfig.chessId, Activity161Enum.npcRole)

	gohelper.setActive(self.roleTab[self.curChessId].gotalk, true)
	gohelper.setActive(self.roleTab[self.curChessId].gotalkDot, true)

	self.roleTab[self.curChessId].txttalk.text = utf8.sub(self.dialogConfig.dialog, 1, self.curCharIndex)
	self.roleTab[self.curChessId].scrolltalk.verticalNormalizedPosition = 0
	self.isDirty = true

	if self.curCharIndex == self.dialogLength + 1 then
		local nextStepConfig = self.dialogMap[self.curStepIndex + 1]

		if nextStepConfig then
			self.waitPlayNextStep = true

			TaskDispatcher.runDelay(self.playNextStep, self, VersionActivity2_0DungeonMapGraffitiEnterView.TalkStepShowInterval)
		else
			self.waitFinishTalk = true

			TaskDispatcher.runDelay(self.onFinishTalk, self, VersionActivity2_0DungeonMapGraffitiEnterView.TalkFinishTime)
		end
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:playNextStep()
	self.waitPlayNextStep = false
	self.curCharIndex = 0
	self.curStepIndex = self.curStepIndex + 1
	self.dialogConfig = self.dialogMap[self.curStepIndex]
	self.dialogLength = utf8.len(self.dialogConfig.dialog)

	self:hideAllTalk()
end

function VersionActivity2_0DungeonMapGraffitiEnterView:onFinishTalk()
	self.waitFinishTalk = false
	self.waitPlayNextStep = false
	self.isStartTalk = false
	self.lastShowTime = 0
	self.curCharIndex = 0
	self.curStepIndex = 1

	self:hideAllTalk()
	gohelper.setActive(self.roleTab[Activity161Enum.npcRole].go, false)
	self:removeUpdateBeat()
end

function VersionActivity2_0DungeonMapGraffitiEnterView:hideAllTalk()
	for i = 1, 4 do
		gohelper.setActive(self.roleTab[i].gotalkDot, false)
		gohelper.setActive(self.roleTab[i].gotalk, false)
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:_onTalkFrameLateUpdate()
	if self.closedView then
		return
	end

	if not self.isStartTalk then
		return
	end

	if self.waitPlayNextStep or self.waitFinishTalk then
		return
	end

	if not self.isDirty then
		return
	end

	self.isDirty = false

	local talkHeight = 0
	local preferredHeight = self.roleTab[self.curChessId].txttalk.preferredHeight
	local margin = VersionActivity2_0DungeonMapGraffitiEnterView.ScrollTalkMargin.Top + VersionActivity2_0DungeonMapGraffitiEnterView.ScrollTalkMargin.Bottom

	talkHeight = preferredHeight > VersionActivity2_0DungeonMapGraffitiEnterView.TextMaxHeight and VersionActivity2_0DungeonMapGraffitiEnterView.TextMaxHeight + margin or preferredHeight + margin

	if self.waitPlayNextStep then
		talkHeight = talkHeight + VersionActivity2_0DungeonMapGraffitiEnterView.TipHeight
	end

	recthelper.setHeight(self.roleTab[self.curChessId].gotalkRect, talkHeight)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:onClose()
	Activity161Controller.instance:dispatchEvent(Activity161Event.CloseGraffitiEnterView)
	Activity161Controller.instance:saveRecentGraffitiDialog()
	self:removeUpdateBeat()
	TaskDispatcher.cancelTask(self.playNextStep, self)
	TaskDispatcher.cancelTask(self.onFinishTalk, self)

	self.closedView = true

	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(false)

	if not self.isClickBack then
		VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
	end

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(false)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:closeViewWithEffect()
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayExcessiveEffect)
	TaskDispatcher.runDelay(self.closeThis, self, 0.5)
end

function VersionActivity2_0DungeonMapGraffitiEnterView:removeUpdateBeat()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	if self.lateUpdateHandle then
		UpdateBeat:RemoveListener(self.lateUpdateHandle)
	end
end

function VersionActivity2_0DungeonMapGraffitiEnterView:onDestroyView()
	return
end

return VersionActivity2_0DungeonMapGraffitiEnterView
