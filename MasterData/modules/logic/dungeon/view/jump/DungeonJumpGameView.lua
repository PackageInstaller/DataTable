-- chunkname: @modules/logic/dungeon/view/jump/DungeonJumpGameView.lua

module("modules.logic.dungeon.view.jump.DungeonJumpGameView", package.seeall)

local DungeonJumpGameView = class("DungeonJumpGameView", BaseViewExtended)
local jumpTime = 0.5
local dropTime = 1
local dropDistance = 800
local localJumpTime = 0.2
local jumpPowerNum = 1.5
local guidePowerRange = 0.4
local jumpResultEnum = {
	Final = 4,
	Fall = 3,
	ToNext = 2,
	Original = 1
}

function DungeonJumpGameView:onInitView()
	self._goNodeItemRoot = gohelper.findChild(self.viewGO, "Map/NodeRoot")
	self._goNodeItem = gohelper.findChild(self.viewGO, "Map/NodeRoot/nodeItem")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._jumpChessRoot = gohelper.findChild(self.viewGO, "Map/#go_chess")
	self._jumpChess = gohelper.findChild(self.viewGO, "Map/#go_chess/#chess")
	self._jumpChessImage = gohelper.findChild(self.viewGO, "Map/#go_chess/#chess/#image_chess")
	self._jumpChessAnimator = self._jumpChess:GetComponent(gohelper.Type_Animator)
	self._jumpCircle = gohelper.findChild(self.viewGO, "Map/#go_chess/#chess/circle")
	self._pressStateCircle = gohelper.findChild(self._jumpCircle, "StateRoot/#go_State/State2")
	self._goGreenNormalRange = gohelper.findChild(self._jumpCircle, "#go_CircleNormal")
	self._goCurrentAreaRange = gohelper.findChild(self._jumpCircle, "#go_CircleCurrent")
	self._goGreenLightRange = gohelper.findChild(self._jumpCircle, "#go_CircleLight")
	self._goDrakRange = gohelper.findChild(self._jumpCircle, "#go_CircleBlack")
	self._outRangeStateCircle = gohelper.findChild(self._jumpCircle, "StateRoot/#go_State/State3")
	self._jumpBtn = gohelper.findChildButtonWithAudio(self.viewGO, "jumpClick")
	self._jumpBtnGo = gohelper.findChild(self.viewGO, "jumpClick")
	self._jumpBtnlongpress = SLFramework.UGUI.UILongPressListener.Get(self._jumpBtnGo)
	self._jumpBtn = SLFramework.UGUI.UIClickListener.Get(self._jumpBtnGo)
	self._goMap = gohelper.findChild(self.viewGO, "Map")
	self._goBg = gohelper.findChild(self.viewGO, "fullbg")
	self._goTitle = gohelper.findChild(self.viewGO, "Title")
	self._textTitle = gohelper.findChildText(self._goTitle, "#txt_Title")
	self._tipsClick = gohelper.findChildButtonWithAudio(self.viewGO, "Title/tipsClick")
	self._goSnowEffect1 = gohelper.findChild(self.viewGO, "bg_eff/vx_snow01")
	self._goSnowEffect2 = gohelper.findChild(self.viewGO, "bg_eff/vx_snow02")
	self._goSnowEffect3 = gohelper.findChild(self.viewGO, "bg_eff/vx_snow03")
	self._goFallEffect = gohelper.findChild(self.viewGO, "vx_dead")
	self._goCircleEffect1 = gohelper.findChild(self.viewGO, "Map/#go_chess/#chess/circle/glow1")
	self._goCircleEffect2 = gohelper.findChild(self.viewGO, "Map/#go_chess/#chess/circle/glow2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonJumpGameView:_editableInitView()
	self._autoJump = false
	self._preparingJump = false
	self._maxDistance = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.MaxJumpDistance).size)
	self._maxDistance = self._maxDistance or 700
	self._distancePerSecond = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.DistancePerSecond).size)
	self._distancePerSecond = self._distancePerSecond or 400
	self._jumpTime = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.JumpTime).size)
	self._jumpTime = self._jumpTime or 0.5
	self._maxCircleSize = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.MaxCircleSize).size)
	self._maxCircleSize = self._maxCircleSize or 200

	local showSnowIdxParams = DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.ShowSnowEffectParams)
	local showSnowIdxParamArr = showSnowIdxParams and string.splitToNumber(showSnowIdxParams.size, "#") or {
		12,
		18
	}

	self._showSnow2Idx = showSnowIdxParamArr[1]
	self._showSnow3Idx = showSnowIdxParamArr[2]
	self._maxDistance = self._maxDistance or 700

	gohelper.setActive(self._outRangeStateCircle, false)
	gohelper.setActive(self._goGreenLightRange, true)
end

function DungeonJumpGameView:addEvents()
	self._btnRestart:AddClickListener(self._doClickRestartAction, self)
	self._jumpBtnlongpress:AddLongPressListener(self._onJumpLongPress, self)
	self._jumpBtnlongpress:SetLongPressTime({
		localJumpTime,
		0.1
	})
	self._jumpBtn:AddClickUpListener(self._onClickJumpBtnUp, self)
	self._jumpBtn:AddClickDownListener(self._onClickJumpDown, self)
	self._tipsClick:AddClickListener(self._onClickTips, self)
	self.addEventCb(self, DungeonJumpGameController.instance, DungeonJumpGameEvent.AutoJumpOnMaxDistance, self.onAutoJumpOnMaxDistance, self)
	self.addEventCb(self, DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameReStart, self.onRevertChess, self)
	self.addEventCb(self, DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameCompleted, self.onCompleted, self)
	self.addEventCb(self, DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameExit, self.onExit, self)
	self.addEventCb(self, DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameGuideCompleted, self.onGuideCompleted, self)
end

function DungeonJumpGameView:removeEvents()
	self._btnRestart:RemoveClickListener()
	self._jumpBtn:RemoveClickUpListener()
	self._jumpBtn:RemoveClickDownListener()
	self._jumpBtnlongpress:RemoveLongPressListener()
	self._tipsClick:RemoveClickListener()
end

function DungeonJumpGameView:_doClickRestartAction()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, self.onRestart, nil, nil, self)
end

function DungeonJumpGameView:onRestart()
	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[4], self._curIdx)
	DungeonJumpGameController.instance:ClearProgress()
	DungeonJumpGameController.instance:initStatData()
	self:setJumpable(true)
	self:_refreashFallEffect(false)
	self:_initMap()
	self:doMapTrans()
end

function DungeonJumpGameView:_onJumpLongPress()
	if not self._preparingJump then
		return
	end

	local isInJumpGameGuide = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.JumpGameLongPressGuide)

	self._currPercent = self._currPercent + Time.deltaTime * jumpPowerNum

	if isInJumpGameGuide then
		if self._currPercent > guidePowerRange then
			self:setJumpable(false)
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameLongPressGuide)
		else
			self:_refreshJumpPressingView()
		end

		return
	end

	self:_refreshJumpPressingView()
end

function DungeonJumpGameView:_refreshJumpPressingView()
	if self._autoJump then
		transformhelper.setLocalScale(self._jumpChessImage.transform, 1, 1, 1)

		local curNode = self._nodeItemsDict[self._curIdx]

		curNode:setNodeScale(1, 1)

		return
	end

	local scaleX = 1 + self._currPercent * 0.1

	if scaleX > 1.25 then
		scaleX = 1.25
	end

	local scaleY = 1 - self._currPercent * 0.1

	if scaleY < 0.75 then
		scaleY = 0.75
	end

	transformhelper.setLocalScale(self._jumpChessImage.transform, scaleX, scaleY, 1)

	local curNode = self._nodeItemsDict[self._curIdx]

	curNode:setNodeScale(scaleX, scaleY)
	self:refreshPressState(self._currPercent)
end

function DungeonJumpGameView:_onClickJumpDown()
	if not self:checkJumpable() then
		self._preparingJump = false

		return
	end

	self._preparingJump = true

	recthelper.setHeight(self._pressStateCircle.transform, 0)

	local x, y = recthelper.getAnchor(self._jumpChess.transform)
	local nextIdx = self._curIdx + 1

	if nextIdx > #self._nodeDatas then
		return
	end

	gohelper.setActive(self._goCircleEffect1, false)
	gohelper.setActive(self._goCircleEffect2, false)

	local targetNode = self._nodeDatas[nextIdx]
	local targetNodeX = targetNode.x
	local targetNodeY = targetNode.y
	local targetNodeSize = targetNode.size

	self:refreshCircleSize(true, x, y, targetNodeX, targetNodeY, targetNodeSize)

	self._currPercent = 0

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_xuli)
end

function DungeonJumpGameView:_onClickJumpBtnUp()
	if self._autoJump then
		self._autoJump = false

		return
	end

	if not self._preparingJump then
		return
	end

	local isInJumpGameGuide = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.JumpGameLongPressGuide)

	if isInJumpGameGuide then
		return
	end

	self:setJumpable(false)
	self:_doJumpView()
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_tiaoyitiao_xuli)
end

function DungeonJumpGameView:_doJumpView()
	self:refreshCircleSize(false)
	transformhelper.setLocalScale(self._jumpChessImage.transform, 1, 1, 1)

	local curNode = self._nodeItemsDict[self._curIdx]

	curNode:setNodeScale(1, 1)

	local curIdx = self._curIdx
	local curNode = self._nodeDatas[curIdx]
	local x, y = recthelper.getAnchor(self._jumpChess.transform)
	local nextIdx = curIdx + 1
	local targetNode = self._nodeDatas[nextIdx]
	local targetNodeX = targetNode.x
	local targetNodeY = targetNode.y
	local distance = math.sqrt((targetNodeX - x) * (targetNodeX - x) + (targetNodeY - y) * (targetNodeY - y))
	local jumpDistance = self._currPercent * self._distancePerSecond
	local jumpTargetX = x + (targetNodeX - x) * jumpDistance / distance
	local jumpTargetY = y + (targetNodeY - y) * jumpDistance / distance
	local jumpResult = self:checkJumpingResult(curNode, targetNode, jumpTargetX, jumpTargetY)

	if jumpResult == jumpResultEnum.Original then
		self:setJumpable(true)

		return
	elseif jumpResult == jumpResultEnum.ToNext then
		self:_jumpTo(self._jumpChess, x, y, targetNodeX, targetNodeY)
	else
		self:_jumpTo(self._jumpChess, x, y, jumpTargetX, jumpTargetY)
	end

	TaskDispatcher.runDelay(self.onAfterJump, self, jumpTime)
end

function DungeonJumpGameView:onAfterJump()
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_fall)

	self.continueGame, self.win = self:checkJumpResult()

	self:doMapTrans()

	local hasNodeEvent = self:doNodeEvent()

	if not hasNodeEvent then
		self:setJumpable(true)
		self:_refreashNextNodeItem()

		if not self.continueGame then
			if not self.win then
				DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[2], self._curIdx)

				local y = recthelper.getAnchorY(self._jumpChess.transform)
				local x = recthelper.getAnchorX(self._jumpChess.transform)

				self._jumpChessRoot.transform:SetSiblingIndex(0)

				self._dropingTween = ZProj.TweenHelper.DOAnchorPos(self._jumpChess.transform, x + 300, y - dropDistance, dropTime)

				self:_refreashFallEffect(true)
			else
				DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[1], self._curIdx)
			end

			self._gameResult = self.win

			self:setJumpable(false)
			TaskDispatcher.runDelay(self._showGameResultView, self, jumpTime)

			return
		end
	end

	DungeonJumpGameController.instance:SaveCurProgress(self._curIdx)
	self._jumpChessAnimator:Play(UIAnimationName.Jump, 0, 0)
end

function DungeonJumpGameView:_showGameResultView()
	if self._gameResult then
		DungeonRpc.instance:sendMapElementRequest(self._elementId)
	end

	DungeonJumpGameController.instance:openResultView(self._gameResult, self._elementId)

	self._gameResult = nil
end

function DungeonJumpGameView:checkJumpingResult(curNode, targetNode, x, y)
	local curNodeX = curNode.x
	local curNodeY = curNode.y
	local nextNode = targetNode
	local nextNodeX = nextNode.x
	local nextNodeY = nextNode.y
	local nextNodeSize = nextNode.size
	local distanceToCur = math.sqrt((curNodeX - x) * (curNodeX - x) + (curNodeY - y) * (curNodeY - y))

	if distanceToCur - nextNodeSize / 2 < 0 then
		return jumpResultEnum.Original
	end

	local distanceToNext = math.sqrt((nextNodeX - x) * (nextNodeX - x) + (nextNodeY - y) * (nextNodeY - y))

	if distanceToCur - nextNodeSize / 2 > 0 and distanceToNext - nextNodeSize / 2 < 0 then
		return jumpResultEnum.ToNext
	else
		return jumpResultEnum.Fall
	end
end

function DungeonJumpGameView:checkJumpResult()
	local curNode = self._nodeDatas[self._curIdx]
	local curNodeX = curNode.x
	local curNodeY = curNode.y
	local x, y = recthelper.getAnchor(self._jumpChess.transform)
	local distance = math.sqrt((curNodeX - x) * (curNodeX - x) + (curNodeY - y) * (curNodeY - y))
	local nodeSize = curNode.size
	local nextNode = self._nodeDatas[self._curIdx + 1]
	local nextNodeX = nextNode.x
	local nextNodeY = nextNode.y
	local nextNodeSize = nextNode.size
	local distanceToNext = math.sqrt((nextNodeX - x) * (nextNodeX - x) + (nextNodeY - y) * (nextNodeY - y))

	if distance - nodeSize / 2 < 0 then
		return true
	elseif distance - nodeSize / 2 > 0 and distanceToNext - nextNodeSize / 2 < 0 then
		if self._curIdx + 1 == #self._nodeDatas then
			self._curIdx = self._curIdx + 1

			return false, true
		end

		self._curIdx = self._curIdx + 1

		return true
	else
		return false, false
	end
end

function DungeonJumpGameView:checkFinish()
	return self._curIdx == #self._nodeDatas
end

function DungeonJumpGameView:doMapTrans()
	local chessPosX = self._jumpChess.transform.localPosition.x
	local chessPosY = self._jumpChess.transform.localPosition.y

	if self._curIdx > #self._nodeDatas - 1 then
		local nextNode = self._nodeDatas[#self._nodeDatas - 1]

		chessPosX = nextNode.x
		chessPosY = nextNode.y
	end

	self._mapTween = ZProj.TweenHelper.DOAnchorPos(self._goMap.transform, -chessPosX - 100, -chessPosY - 150, 0.5)

	ZProj.TweenHelper.DOAnchorPos(self._goBg.transform, -chessPosX - 100, -chessPosY - 150, 0.5)
end

function DungeonJumpGameView:doNodeEvent()
	local nodeData = self._nodeDatas[self._curIdx]

	if not nodeData then
		return
	end

	if nodeData.type == 2 then
		if nodeData.toggled then
			return false
		end

		local tipsEventParams = nodeData.evenid

		self._tipsEventArray = string.splitToNumber(tipsEventParams, "#")

		self:_onClickTips()

		nodeData.toggled = true

		return true
	elseif nodeData.type == 4 then
		if nodeData.toggled then
			return false
		end

		local dialogId = tonumber(nodeData.evenid)

		DialogueController.instance:enterDialogue(dialogId, self._onPlayDialogFinished, self)

		nodeData.toggled = true

		return true
	elseif nodeData.type == 5 then
		local episodeId = tonumber(nodeData.evenid)
		local chapterId = 0
		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		if config == nil then
			return false
		end

		local passEpisode = DungeonModel.instance:hasPassLevel(episodeId)

		if nodeData.toggled and passEpisode then
			return false
		end

		nodeData.toggled = true

		DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
		DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, config.battleId)

		return true
	elseif nodeData.type == 3 then
		local guideId = tonumber(nodeData.evenid)
		local isGuideRunning = GuideModel.instance:isGuideRunning(guideId)

		if isGuideRunning then
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameArriveNode, self._curIdx)

			return true
		end

		return false
	end

	return false
end

function DungeonJumpGameView:doNodeEventOnEnterGame()
	local nodeData = self._nodeDatas[self._curIdx]

	if not nodeData then
		return
	end

	if nodeData.type == 2 then
		if nodeData.toggled then
			return
		end

		local tipsEventParams = nodeData.evenid

		self._tipsEventArray = string.splitToNumber(tipsEventParams, "#")

		self:_onClickTips()

		nodeData.toggled = true
	elseif nodeData.type == 4 then
		if nodeData.toggled then
			return false
		end

		local dialogId = tonumber(nodeData.evenid)

		DialogueController.instance:enterDialogue(dialogId, self._onPlayDialogFinished, self)

		nodeData.toggled = true
	elseif nodeData.type == 3 then
		local guideId = tonumber(nodeData.evenid)
		local isGuideRunning = GuideModel.instance:isGuideRunning(guideId)

		if isGuideRunning then
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameArriveNode, self._curIdx)
		end
	end
end

function DungeonJumpGameView:_onClickTips()
	if self._tipsEventArray and #self._tipsEventArray > 0 then
		local eventCfg = DungeonGameConfig.instance:getJumpGameEventCfg(self._tipsEventArray[1])
		local eventDesc = eventCfg.desc

		table.remove(self._tipsEventArray, 1)
		gohelper.setActive(self._goTitle, false)
		gohelper.setActive(self._goTitle, true)

		self._textTitle.text = eventDesc
	else
		gohelper.setActive(self._goTitle, false)
		self:setJumpable(true)
		self:_refreashNextNodeItem()

		self._showingTips = false
	end
end

function DungeonJumpGameView:_onClickFight()
	local curNode = self._nodeDatas[self._curIdx]

	if not curNode.isBattle then
		return
	end

	local episodeId = tonumber(curNode.evenid)
	local passEpisode = DungeonModel.instance:hasPassLevel(episodeId)

	if passEpisode and curNode.toggled then
		return
	end

	local chapterId = 0
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if config == nil then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
	DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, config.battleId)
end

function DungeonJumpGameView:_onPlayDialogFinished()
	self:setJumpable(true)
	self:_refreashNextNodeItem()
end

function DungeonJumpGameView:checkJumpable()
	local curNode = self._nodeDatas[self._curIdx]

	if curNode.isBattle then
		local episodeId = tonumber(curNode.evenid)
		local passEpisode = DungeonModel.instance:hasPassLevel(episodeId)

		if not passEpisode then
			return false
		end
	end

	return true
end

function DungeonJumpGameView:setJumpable(able)
	if not able then
		self._jumpBtnlongpress:RemoveLongPressListener()
	else
		self._jumpBtnlongpress:AddLongPressListener(self._onJumpLongPress, self)
		self._jumpBtnlongpress:SetLongPressTime({
			localJumpTime,
			0.1
		})
	end

	self._jumpBtn.enabled = able
end

function DungeonJumpGameView:onAutoJumpOnMaxDistance()
	if self._gameResult ~= nil then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_tiaoyitiao_xuli)
	self:setJumpable(false)
	self:_doJumpView()
end

function DungeonJumpGameView:onRevertChess()
	DungeonJumpGameController.instance:initStatData()
	self:_refreashFallEffect(false)
	self:setJumpable(true)
	recthelper.setAnchor(self._jumpChess.transform, self._nodeDatas[self._curIdx].x, self._nodeDatas[self._curIdx].y)
	self._jumpChessRoot.transform:SetSiblingIndex(1)
	self:doMapTrans()
end

function DungeonJumpGameView:onCompleted()
	self:closeThis()
end

function DungeonJumpGameView:onExit()
	self:closeThis()
end

function DungeonJumpGameView:onGuideCompleted()
	self:setJumpable(true)
	self:refreshCircleSize(false)
	transformhelper.setLocalScale(self._jumpChessImage.transform, 1, 1, 1)

	local curNode = self._nodeItemsDict[self._curIdx]

	curNode:setNodeScale(1, 1)
	self:_refreashNextNodeItem()

	if self:checkFinish() then
		self._gameResult = true

		self:setJumpable(false)
		TaskDispatcher.runDelay(self._showGameResultView, self, jumpTime)

		return
	elseif not self.continueGame then
		self._gameResult = self.win

		self:setJumpable(false)
		TaskDispatcher.runDelay(self._showGameResultView, self, jumpTime)

		return
	end
end

function DungeonJumpGameView:onOpen()
	self._elementId = self.viewParam and self.viewParam.elementId

	if self._elementId then
		self._elementId = self._elementId or DungeonJumpGameEnum.elementId
	end

	self.jumpGameMapId = self._elementId and DungeonJumpGameEnum.EleementId2JumpMapIdDict[self._elementId]
	self.jumpGameMapId = self.jumpGameMapId or 1001
	self._oriBgX, self._oriBgY = recthelper.getAnchor(self._goBg.transform)

	self:_initMap()

	local curNode = self._nodeDatas[self._curIdx]

	if curNode and curNode.isBattle then
		GuideController.instance:startGudie(DungeonJumpGameEnum.battleGuideId)
	end

	self:doNodeEventOnEnterGame()
end

function DungeonJumpGameView:onOpenFinish()
	DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameEnter, self._curIdx)
end

function DungeonJumpGameView:onClose()
	return
end

function DungeonJumpGameView:_initMap()
	recthelper.setSize(self._goGreenLightRange.transform, self._maxCircleSize, self._maxCircleSize)
	gohelper.setActive(self._goTitle, false)
	recthelper.setAnchor(self._goMap.transform, 0, 0)
	recthelper.setAnchor(self._goBg.transform, self._oriBgX, self._oriBgY)

	local curIdx = DungeonJumpGameController.instance:LoadProgress()

	self._curIdx = curIdx and curIdx or 1

	self:_createNodeItems()
	recthelper.setAnchor(self._jumpChess.transform, self._nodeDatas[self._curIdx].x, self._nodeDatas[self._curIdx].y)
	self._jumpChessRoot.transform:SetSiblingIndex(1)
	self:doMapTrans()
	self:_refreashSnowEffect()

	self.continueGame = true
	self.win = false
end

function DungeonJumpGameView:_createNodeItems()
	local mapCfg = DungeonGameConfig.instance:getJumpMap(self.jumpGameMapId)

	self._nodeDatas = {}
	self._nodeDatasForSibling = {}

	local nodeSize = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.NodeSize).size)

	for idx, nodeCfg in ipairs(mapCfg) do
		local nodeData = {}
		local coord = string.splitToNumber(nodeCfg.coord, "#")

		nodeData.x = coord[1]
		nodeData.y = coord[2]
		nodeData.type = nodeCfg.celltype
		nodeData.size = nodeSize
		nodeData.evenid = nodeCfg.evenid
		nodeData.toggled = false
		nodeData.idx = idx
		nodeData.bg = nodeCfg.cellspecies
		nodeData.isBattle = nodeCfg.celltype == 5

		if idx <= self._curIdx then
			nodeData.toggled = true
		end

		self._nodeDatas[idx] = nodeData
		self._nodeDatasForSibling[#mapCfg - idx + 1] = nodeData
	end

	self._nodeItemsDict = {}

	gohelper.CreateObjList(self, self._createNodeItem, self._nodeDatasForSibling, self._goNodeItemRoot, self._goNodeItem, DungeonJumpGameNodeItem)
end

function DungeonJumpGameView:_createNodeItem(cardItemComp, nodeData, index)
	cardItemComp:onUpdateData(nodeData)
	cardItemComp:initNode()

	self._nodeItemsDict[#self._nodeDatasForSibling - index + 1] = cardItemComp

	local active = self:_checkNodeActive(#self._nodeDatasForSibling - index + 1)

	cardItemComp:setNodeActive(active)
	cardItemComp:setFightAction(self._onClickFight, self)
end

function DungeonJumpGameView:_checkNodeActive(index)
	if index > self._curIdx + 1 then
		return false
	end

	local curNode = self._nodeItemsDict[index]

	if curNode.type == 2 or curNode.type == 4 then
		return curNode.toggled
	elseif curNode.type == 5 then
		local episodeId = tonumber(curNode.evenid)
		local passEpisode = DungeonModel.instance:hasPassLevel(episodeId)

		return not passEpisode
	else
		return true
	end
end

function DungeonJumpGameView:_refreashNextNodeItem()
	local nextNode = self._nodeItemsDict[self._curIdx + 1]

	if nextNode then
		nextNode:setNodeActive(true)
	end

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_drop)
	self:_refreashSnowEffect()
end

function DungeonJumpGameView:_refreashSnowEffect()
	local showSnow1 = self._curIdx < self._showSnow2Idx
	local showSnow2 = not showSnow1 and self._curIdx < self._showSnow3Idx
	local showSnow3 = self._curIdx >= self._showSnow3Idx

	gohelper.setActive(self._goSnowEffect1, showSnow1)
	gohelper.setActive(self._goSnowEffect2, showSnow2)
	gohelper.setActive(self._goSnowEffect3, showSnow3)
end

function DungeonJumpGameView:_refreashFallEffect(active)
	if not active and self._dropingTween then
		ZProj.TweenHelper.KillById(self._dropingTween)

		self._dropingTween = nil
	end

	gohelper.setActive(self._goFallEffect, active)
end

function DungeonJumpGameView:_jumpTo(chess, oriX, oriY, targetX, targetY)
	local jumpHeight = 300
	local jumpCount = 1

	ZProj.TweenHelper.DOLocalJump(chess.transform, Vector3(targetX, targetY, 0), jumpHeight, jumpCount, jumpTime)
end

function DungeonJumpGameView:getCurCellIdx()
	return self._curIdx
end

function DungeonJumpGameView:refreshCircleSize(beginPress, curX, curY, TargetX, TargetY, TargetNodeLength)
	self._jumpCircle:SetActive(beginPress)

	if not beginPress then
		return
	end

	local distance = math.sqrt((TargetX - curX) * (TargetX - curX) + (TargetY - curY) * (TargetY - curY))

	if distance > self._maxDistance - TargetNodeLength / 2 then
		distance = self._maxDistance - TargetNodeLength / 2
	end

	self._unCatchLength = distance - TargetNodeLength / 2
	self._overCatchLength = distance + TargetNodeLength / 2
	self._toNextNodeLength = distance
	self._jumpSuccessMaxDistance = self._overCatchLength
	self._jumpSuccessMinDistance = self._unCatchLength
	self._greenCirSize = self._overCatchLength / self._maxDistance * self._maxCircleSize
	self._drakCirSize = self._unCatchLength / self._maxDistance * self._maxCircleSize

	recthelper.setSize(self._goGreenNormalRange.transform, self._greenCirSize, self._greenCirSize)
	recthelper.setSize(self._goCurrentAreaRange.transform, self._greenCirSize, self._greenCirSize)
	recthelper.setSize(self._goDrakRange.transform, self._drakCirSize, self._drakCirSize)
	gohelper.setActive(self._outRangeStateCircle, false)
	recthelper.setSize(self._pressStateCircle.transform, 0, 0)
end

function DungeonJumpGameView:refreshPressState(curSizePercent)
	local curJumpDistance = curSizePercent * self._distancePerSecond

	gohelper.setActive(self._outRangeStateCircle, curJumpDistance >= self._jumpSuccessMaxDistance)
	gohelper.setActive(self._goCurrentAreaRange, curJumpDistance > self._jumpSuccessMinDistance and curJumpDistance < self._jumpSuccessMaxDistance)
	gohelper.setActive(self._goGreenNormalRange, curJumpDistance < self._jumpSuccessMinDistance or curJumpDistance > self._jumpSuccessMaxDistance)

	local isCurrentArea = curJumpDistance >= self._jumpSuccessMinDistance and curJumpDistance < self._jumpSuccessMaxDistance

	gohelper.setActive(self._goCircleEffect1, isCurrentArea)
	gohelper.setActive(self._goCircleEffect2, isCurrentArea)

	local curSize = curJumpDistance / self._maxDistance * self._maxCircleSize

	if curJumpDistance <= self._maxDistance + 30 then
		recthelper.setSize(self._pressStateCircle.transform, curSize, curSize)
		recthelper.setSize(self._outRangeStateCircle.transform, curSize, curSize)
	else
		DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.AutoJumpOnMaxDistance)
	end
end

function DungeonJumpGameView:onDestroyView()
	return
end

return DungeonJumpGameView
