-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MapView.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MapView", package.seeall)

local TowerV3a7MapView = class("TowerV3a7MapView", BaseView)

function TowerV3a7MapView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txttarget = gohelper.findChildText(self.viewGO, "#txt_target")
	self._txtTips = gohelper.findChildText(self.viewGO, "Tips/#txt_Tips")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "Tips/#txt_Tips/HeadMask/#simage_Head")
	self._txtcd = gohelper.findChildText(self.viewGO, "Time/#txt_cd")
	self._goPath = gohelper.findChild(self.viewGO, "#go_Path")
	self._btnemptyclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_empty_click")
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._godragroot = gohelper.findChild(self.viewGO, "#go_dragroot")
	self._godialogcontainer = gohelper.findChild(self.viewGO, "#go_dialogcontainer")
	self._godialog = gohelper.findChild(self.viewGO, "#go_dialogcontainer/#go_dialog")
	self._txtcontentcn = gohelper.findChildText(self.viewGO, "#go_dialogcontainer/#go_dialog/container/go_normalcontent/#txt_contentcn")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "#go_dialogcontainer/#btn_story")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._txtSuccess = gohelper.findChildText(self.viewGO, "#go_Success/#txt_Success")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Success/#btn_close")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7MapView:addEvents()
	self._btnemptyclick:AddClickListener(self._btnemptyclickOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerV3a7MapView:removeEvents()
	self._btnemptyclick:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function TowerV3a7MapView:_btncloseOnClick()
	self:closeThis()
end

function TowerV3a7MapView:_btnstoryOnClick()
	return
end

function TowerV3a7MapView:_btnemptyclickOnClick()
	TowerV3a7ChessManModel.instance:selectedChess()
end

function TowerV3a7MapView:_editableInitView()
	gohelper.setActive(self._goSuccess, false)
	gohelper.setActive(self._txtTips, false)
end

function TowerV3a7MapView:onOpen()
	self._elementId = TowerV3a7Model.instance:getElementId()
	self._mapConfig = TowerV3a7Model.instance:getMapConfig()

	if not self._mapConfig then
		return
	end

	self._txttarget.text = self._mapConfig.desc3

	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.GameOver, self._onGameOver, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.StoryShow, self._onStoryShow, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.MoveFinishChessMan, self._onMoveFinishChessMan, self, LuaEventSystem.Low)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.SelectChessMan, self._onSelectChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.GuideGamePause, self._onGuideGamePause, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.GuidePauseInteraction, self._onGuidePauseInteraction, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.InterruptGuide, self._onInterruptGuide, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._onFinishGuideLastStep, self)
	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio3)
end

function TowerV3a7MapView:_onFinishGuideLastStep(guideId)
	if guideId == TowerV3a7Enum.GuideId then
		TowerV3a7Model.instance:setPause(false)
		TowerV3a7Model.instance:pauseInteraction(false)
	end
end

function TowerV3a7MapView:_onInterruptGuide(guideId)
	if guideId == TowerV3a7Enum.GuideId then
		TowerV3a7Model.instance:setPause(false)
		TowerV3a7Model.instance:pauseInteraction(false)
	end
end

function TowerV3a7MapView:_onGuidePauseInteraction(param)
	local isPause = param == "1"

	TowerV3a7Model.instance:pauseInteraction(isPause)
end

function TowerV3a7MapView:_onGuideGamePause(param)
	local isPause = param == "1"

	TowerV3a7Model.instance:setPause(isPause)
end

function TowerV3a7MapView:_onSelectChessMan(mo)
	local show = mo ~= nil

	gohelper.setActive(self._txtTips, show)

	if show then
		local icon = ResUrl.getHeadIconSmall(mo.chessConfig.head)

		self._simageHead:LoadImage(icon)

		self._txtTips.text = string.nilorempty(mo.chessConfig.desc1) and mo.chessConfig.name or string.format("%s:%s", mo.chessConfig.name, mo.chessConfig.desc1)
	end
end

function TowerV3a7MapView:_onMoveFinishChessMan(mo)
	if not self._specialStage1 then
		return
	end

	if mo.id == 100602 and mo:getLocation() == 3 then
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryPlay, TowerV3a7Enum.ManualTriggerStoryId)

		return
	end

	if TowerV3a7Enum.SpecialStage1[mo.id] == mo:getLocation() then
		TowerV3a7RoomModel.instance:removeChess(mo)
	end

	if self._specialStage2 and mo.id == 100601 and mo:getLocation() == 5 then
		TowerV3a7RoomModel.instance:removeChess(mo)
	end
end

function TowerV3a7MapView:_stage2()
	self._specialStage2 = true

	local mo = TowerV3a7ChessManModel.instance:getChess(100601)

	if mo then
		mo:setTargetRoomId(5)
	end

	mo = TowerV3a7ChessManModel.instance:getChess(100681)

	if mo then
		mo.pathfindingTime = 0
	end

	mo = TowerV3a7ChessManModel.instance:getChess(100602)

	if mo then
		mo:kill()
	end
end

function TowerV3a7MapView:_onStoryShow(isShow, storyId)
	TowerV3a7Model.instance:setPause(isShow)

	if isShow == false and storyId == 100606 then
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GameOver)
	end

	if isShow == false and storyId == 100603 then
		local mo = TowerV3a7ChessManModel.instance:getChess(100601)

		if mo then
			mo:setTargetRoomId(3)
		end
	end

	if isShow == false and storyId == 100604 then
		self._specialStage1 = true

		for id, roomId in pairs(TowerV3a7Enum.SpecialStage1) do
			local mo = TowerV3a7ChessManModel.instance:getChess(id)

			if mo then
				if TowerV3a7ChessManModel.instance:chessIsSelected(mo) then
					TowerV3a7ChessManModel.instance:selectedChess()
					TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.CancelDragChessMan, mo)
				end

				if mo:getLocation() == roomId then
					TowerV3a7RoomModel.instance:removeChess(mo)
				else
					mo:setTargetRoomId(roomId)
				end
			end
		end

		local mo = TowerV3a7ChessManModel.instance:getChess(100602)

		if mo and TowerV3a7ChessManModel.instance:chessIsSelected(mo) then
			TowerV3a7ChessManModel.instance:selectedChess()
			TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.CancelDragChessMan, mo)
		end

		if mo and mo:getLocation() == 3 then
			TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryPlay, TowerV3a7Enum.ManualTriggerStoryId)
		else
			if mo then
				mo:setTargetRoomId(3)
			end

			mo = TowerV3a7ChessManModel.instance:getChess(100681)

			if mo then
				mo.pathfindingTime = Mathf.Infinity
			end
		end
	end

	if isShow == false and storyId == TowerV3a7Enum.ManualTriggerStoryId then
		self:_stage2()
	end
end

function TowerV3a7MapView:_onGameOver()
	TowerV3a7Model.instance:setWin(true)
	TaskDispatcher.cancelTask(self._frameHandler, self)
	gohelper.setActive(self._goSuccess, true)

	self._isSuccess = true

	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio10)
end

function TowerV3a7MapView:onOpenFinish()
	TaskDispatcher.runRepeat(self._frameHandler, self, 0)
end

function TowerV3a7MapView:_frameHandler()
	TowerV3a7Model.instance:updateTime()
	self:_updateCD()

	if SLFramework.FrameworkSettings.IsEditor then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
			self:_onGameOver()
		end

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
			if self._showChessIDTime and self._showChessIDTime + 1 > Time.time then
				return
			end

			self._showChessIDTime = Time.time
			TowerV3a7Enum.ShowID = not TowerV3a7Enum.ShowID

			logError("是否显示棋子ID：" .. tostring(TowerV3a7Enum.ShowID))
			TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GMRefreshChessManID)
		end
	end
end

function TowerV3a7MapView:_updateCD()
	local deltaTime = self._mapConfig.time - TowerV3a7Model.instance:getTime()

	deltaTime = math.ceil(deltaTime)
	self._txtcd.text = TimeUtil.second2TimeString(deltaTime)

	if deltaTime <= 0 then
		TaskDispatcher.cancelTask(self._frameHandler, self)

		local params = {
			type = TowerV3a7Enum.StoryFinishTarget.Survival
		}

		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryFinishTarget, params)

		if not params.isFinishTarget then
			self:_onGameOver()
		end
	end
end

function TowerV3a7MapView:onClose()
	TaskDispatcher.cancelTask(self._frameHandler, self)

	if self._isSuccess and self._elementId then
		DungeonRpc.instance:sendMapElementRequest(self._elementId, nil, function()
			DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)
		end)
	end
end

function TowerV3a7MapView:onDestroyView()
	return
end

return TowerV3a7MapView
