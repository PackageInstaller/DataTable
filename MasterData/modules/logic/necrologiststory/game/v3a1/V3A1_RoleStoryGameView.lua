-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameView", package.seeall)

local V3A1_RoleStoryGameView = class("V3A1_RoleStoryGameView", BaseView)

function V3A1_RoleStoryGameView:onInitView()
	self.itemGO = gohelper.findChild(self.viewGO, "Map/Content/go_mapitem")

	gohelper.setActive(self.itemGO, false)

	self.itemList = {}
	self.goHero = gohelper.findChild(self.viewGO, "Map/Content/go_hero")
	self.heroComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goHero, V3A1_RoleStoryGameHero)
	self.goTitile = gohelper.findChild(self.viewGO, "Map/Title")
	self.animTitle = self.goTitile:GetComponent(typeof(UnityEngine.Animator))
	self.txtPlace = gohelper.findChildTextMesh(self.viewGO, "Map/Title/#txt_place")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Map/Title/#txt_time")
	self.goNum = gohelper.findChild(self.viewGO, "Map/Title/num")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "Map/Title/num/#txt_num")
	self.goTarget = gohelper.findChild(self.viewGO, "#go_target")
	self.animTarget = self.goTarget:GetComponent(typeof(UnityEngine.Animator))
	self.txtTarget = gohelper.findChildTextMesh(self.viewGO, "#go_target/taskDesc/txt_taskDesc")
	self.goTargetFinished = gohelper.findChild(self.viewGO, "#go_target/taskDesc/bg/go_finished")
	self.goTargetUnFinish = gohelper.findChild(self.viewGO, "#go_target/taskDesc/bg/go_unfinish")
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self.goRewardRed = gohelper.findChild(self.viewGO, "#btn_reward/#go_reddot")
	self.goRewardTime = gohelper.findChild(self.viewGO, "#btn_reward/#go_time")
	self.txtRewardTime = gohelper.findChildTextMesh(self.viewGO, "#btn_reward/#go_time/#txt_time")
	self.txtRewardTimeFormat = gohelper.findChildTextMesh(self.viewGO, "#btn_reward/#go_time/#txt_time/#txt_format")
	self.btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_review")
	self.fogList = {}

	for i = 1, 4 do
		local item = self:getUserDataTb_()

		item.goFog = gohelper.findChild(self.viewGO, string.format("Map/fog/#fog%02d", i))
		item.animFog = item.goFog:GetComponent(typeof(UnityEngine.Animator))

		table.insert(self.fogList, item)
	end

	self:initLineList()

	self.imageWeather = gohelper.findChildImage(self.viewGO, "Map/Title/#image_weather")
	self.goFinish = gohelper.findChild(self.viewGO, "#go_finish")
	self.animFinish = self.goFinish:GetComponent(typeof(UnityEngine.Animator))
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
end

function V3A1_RoleStoryGameView:initLineList()
	self.lineList = {}

	local lineParent = gohelper.findChild(self.viewGO, "Map/#go_line_light")
	local transform = lineParent.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)
		local baseId1, baseId2 = self:extractNumbers(child.name)

		if baseId1 and baseId2 then
			local lineItem = self:getUserDataTb_()

			lineItem.baseId1 = baseId1
			lineItem.baseId2 = baseId2
			lineItem.goLine = child.gameObject

			table.insert(self.lineList, lineItem)
		end
	end
end

function V3A1_RoleStoryGameView:extractNumbers(str)
	local num1, num2 = string.match(str, "^line(%d+)_(%d+)$")

	if num1 and num2 then
		return tonumber(num1), tonumber(num2)
	end

	return nil, nil
end

function V3A1_RoleStoryGameView:addEvents()
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_GameReset, self._onGameReset, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_MoveToBase, self._onMoveToBase, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_UnlockArea, self._onUnlockArea, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addClickCb(self, self.btnReward, self.onClickBtnReward, self)
	self.addClickCb(self, self.btnReview, self.onClickBtnReview, self)
	self.addClickCb(self, self.btnReset, self.onClickBtnReset, self)
end

function V3A1_RoleStoryGameView:removeEvents()
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_GameReset, self._onGameReset, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_MoveToBase, self._onMoveToBase, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_UnlockArea, self._onUnlockArea, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, self._onStoryStateChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:removeClickCb(self.btnReward)
	self:removeClickCb(self.btnReview)
	self:removeClickCb(self.btnReset)
end

function V3A1_RoleStoryGameView:onClickBtnReset()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.V3A1NecrologistStory_ResetGame, MsgBoxEnum.BoxType.Yes_No, self.resetGameProgress, nil, nil, self)
end

function V3A1_RoleStoryGameView:resetGameProgress()
	if not self.gameBaseMO then
		return
	end

	self.gameBaseMO:resetProgressByFail()
end

function V3A1_RoleStoryGameView:onClickBtnReward()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openTaskView(self.gameBaseMO.id)
end

function V3A1_RoleStoryGameView:onClickBtnReview()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openReviewView(self.gameBaseMO.id)
end

function V3A1_RoleStoryGameView:_onGameReset()
	NecrologistStoryStatController.instance:startGameStat()

	self._lastTime = nil

	self:refreshView()
end

function V3A1_RoleStoryGameView:_onStoryStateChange(storyId)
	self:refreshGameState()
	self:onStoryStateChangeRefresh()
end

function V3A1_RoleStoryGameView:onStoryStateChangeRefresh()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		self._waitRefreshState = true

		return
	end

	self._waitRefreshState = nil

	self:refreshBaseItemList()
	self:refreshButton()
end

function V3A1_RoleStoryGameView:_onCloseViewFinish(viewName)
	self:refreshRewardTime()

	if self._waitRefreshState then
		self:onStoryStateChangeRefresh()
	end

	if self._waitUnlockAreaId then
		self:unlockArea(self._waitUnlockAreaId)
	end

	if self.waitPlayFinishAnim then
		self:refreshFinish(true)
	end
end

function V3A1_RoleStoryGameView:_onMoveToBase(baseId)
	local isEntered = self.gameBaseMO:isBaseEntered(baseId)

	if not isEntered then
		self.gameBaseMO:setBaseEntered(baseId)
	end

	self.tempBaseHasEntered = isEntered

	self.moveToBase(self, baseId, true, self.onMoveBaseEnd, self)
	self:refreshBaseItemList()
	self:refreshTitle()
	self:refreshTask()
	self:refreshGameState()
end

function V3A1_RoleStoryGameView:onMoveBaseEnd()
	local curBaseId = self.gameBaseMO:getCurBaseId()

	for _, item in pairs(self.itemList) do
		if item.baseConfig and item.baseConfig.id == curBaseId then
			local isEntered = self.tempBaseHasEntered

			if item.baseConfig.storyId > 0 and not isEntered then
				TipDialogController.instance:openTipDialogView(item.baseConfig.storyId, item.onClickBtn, item)

				break
			end

			item:onClickBtn()

			break
		end
	end
end

function V3A1_RoleStoryGameView:_onUnlockArea(areaId)
	self:unlockArea(areaId)
end

function V3A1_RoleStoryGameView:unlockArea(areaId)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		self._waitUnlockAreaId = areaId

		return
	end

	self._waitUnlockAreaId = nil

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shuori_start_1)
	self:refreshBaseItemList()
	self:refreshFog(areaId)
	self:refreshLine()

	self._waitMoveAreaId = areaId

	TaskDispatcher.cancelTask(self._moveToArea, self)
	TaskDispatcher.runDelay(self._moveToArea, self, 1)
end

function V3A1_RoleStoryGameView:_moveToArea()
	local areaId = self._waitMoveAreaId

	self._waitMoveAreaId = nil

	if not areaId then
		return
	end

	local bigBaseId = NecrologistStoryV3A1Config.instance:getBigBaseInArea(areaId)

	if bigBaseId then
		local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(bigBaseId)

		self.gameBaseMO:setTime(config.startTime)
		self.gameBaseMO:setCurBaseId(bigBaseId)
	end
end

function V3A1_RoleStoryGameView:onOpen()
	NecrologistStoryStatController.instance:startGameStat()
	self:refreshData()
	self:refreshView()
	self:checkData()
end

function V3A1_RoleStoryGameView:checkData()
	if not self.gameBaseMO then
		return
	end

	if self.gameBaseMO:isAreaUnlock(4) and not self.gameBaseMO:isBaseEntered(401) then
		self.gameBaseMO:setBaseEntered(401)
	end

	if self.gameBaseMO:isAreaUnlock(3) and not self.gameBaseMO:isBaseEntered(301) then
		self.gameBaseMO:setBaseEntered(301)
	end
end

function V3A1_RoleStoryGameView:refreshData()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)

	self.gameBaseMO:setIsExitGame(false)
	RedDotController.instance:addRedDot(self.goRewardRed, RedDotEnum.DotNode.NecrologistStoryTask, storyId)
end

function V3A1_RoleStoryGameView:refreshView()
	self:refreshBaseItemList()
	self:refreshHero()
	self:refreshFog()
	self:refreshTitle()
	self:refreshTask()
	self:refreshButton()
	self:refreshRewardTime()
	self:refreshFinish()
end

function V3A1_RoleStoryGameView:refreshHero()
	local curBaseId = self.gameBaseMO:getCurBaseId()

	self:moveToBase(curBaseId)

	local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(curBaseId)

	if config.unlockAreaId > 0 and self.gameBaseMO:isAreaUnlock(config.unlockAreaId) then
		self._waitMoveAreaId = config.unlockAreaId

		TaskDispatcher.cancelTask(self._moveToArea, self)
		TaskDispatcher.runDelay(self._moveToArea, self, 1)
	end
end

function V3A1_RoleStoryGameView:moveToBase(baseId, tween, callback, callbackObj)
	local baseGO = gohelper.findChild(self.viewGO, string.format("Map/Content/go_item%s", baseId))
	local posX, posY = recthelper.getAnchor(baseGO.transform)

	self.heroComp:setHeroPos(posX, posY, tween, callback, callbackObj)
end

function V3A1_RoleStoryGameView:refreshBaseItemList()
	local baseList = NecrologistStoryV3A1Config.instance:getBaseList()

	for _, base in ipairs(baseList) do
		local item = self:getOrCreateItem(base.id)

		item:refreshView(base, self.gameBaseMO)
	end

	self:refreshLine()
end

function V3A1_RoleStoryGameView:getOrCreateItem(id)
	local item = self.itemList[id]

	if not item then
		local parentGO = gohelper.findChild(self.viewGO, string.format("Map/Content/go_item%s", id))
		local itemGO = gohelper.clone(self.itemGO, parentGO, "go_mapitem")

		item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, V3A1_RoleStoryGameBaseItem)
		self.itemList[id] = item
	end

	return item
end

function V3A1_RoleStoryGameView:refreshLine()
	local showLineAudio = false

	for _, line in ipairs(self.lineList) do
		local baseItem1 = self.itemList[line.baseId1]
		local baseItem2 = self.itemList[line.baseId2]
		local visible = baseItem1:getIsVisible() and baseItem2:getIsVisible()

		gohelper.setActive(line.goLine, visible)

		if line.visible ~= nil and line.visible ~= visible then
			showLineAudio = true
		end

		line.visible = visible
	end

	if showLineAudio then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_artificial_ui_entrance)
	end
end

function V3A1_RoleStoryGameView:refreshFog(unlockArea)
	for areaId, fogItem in ipairs(self.fogList) do
		if unlockArea == areaId then
			fogItem.animFog:Play("close", 0, 0)
		else
			local isUnlock = self.gameBaseMO:isAreaUnlock(areaId)

			if isUnlock then
				fogItem.animFog:Play("none", 0, 0)
			else
				fogItem.animFog:Play("idle", 0, 0)
			end
		end
	end
end

function V3A1_RoleStoryGameView:refreshTitle()
	local curBaseId = self.gameBaseMO:getCurBaseId()
	local curTime = self.gameBaseMO:getCurTime()

	if self._lastTitleBaseId and self._lastTitleBaseId ~= curBaseId then
		self.animTitle:Play("switch", 0, 0)
		TaskDispatcher.cancelTask(self._refreshTitle, self)
		TaskDispatcher.runDelay(self._refreshTitle, self, 0.15)
	else
		self:_refreshTitle()
	end

	self._lastTitleBaseId = curBaseId

	if self._lastTime and self._lastTime ~= curTime then
		local leftTime = curTime - self._lastTime
		local hour = math.floor(leftTime)
		local minute = math.floor((leftTime - hour) * 60)

		self.txtNum.text = hour > 0 and (minute > 0 and string.format("+%sh%sm", hour, minute) or string.format("+%sh", hour)) or string.format("+%sm", minute)

		gohelper.setActive(self.goNum, false)
		gohelper.setActive(self.goNum, true)
	end

	self._lastTime = curTime
end

function V3A1_RoleStoryGameView:_refreshTitle()
	local curBaseId = self.gameBaseMO:getCurBaseId()
	local curTime = self.gameBaseMO:getCurTime()
	local baseConfig = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(curBaseId)
	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(curTime)

	self.txtTime.text = string.format("%d:%02d", displayHour, minute)
	self.txtPlace.text = baseConfig.name

	local weather = baseConfig.weather

	if weather and weather > 0 then
		gohelper.setActive(self.imageWeather, true)

		if weather < NecrologistStoryEnum.WeatherType.Flow then
			UISpriteSetMgr.instance:setRoleStorySprite(self.imageWeather, string.format("rolestory_weather%s", weather))
		end
	else
		gohelper.setActive(self.imageWeather, false)
	end
end

function V3A1_RoleStoryGameView:refreshTask()
	local targetData = self.gameBaseMO:getCurTargetData()

	if not targetData then
		gohelper.setActive(self.goTarget, false)

		return
	end

	gohelper.setActive(self.goTarget, true)

	local curTargetId = targetData.config.id

	if self._targetId and self._targetId ~= curTargetId then
		if targetData.isEnter then
			if targetData.isEnter then
				self.animTarget:Play("finish", 0, 0)
			else
				self.animTarget:Play("open", 0, 0)
			end

			TaskDispatcher.cancelTask(self._refreshTask, self)
			TaskDispatcher.runDelay(self._refreshTask, self, 0.16)
		end
	else
		self:_refreshTask()
	end

	self._targetId = curTargetId
end

function V3A1_RoleStoryGameView:_refreshTask()
	local targetData = self.gameBaseMO:getCurTargetData()

	if not targetData then
		gohelper.setActive(self.goTarget, false)

		return
	end

	gohelper.setActive(self.goTarget, true)

	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(targetData.config.endTime)
	local timeStr = string.format("%d:%02d", displayHour, minute)

	self.txtTarget.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v3a1_necrologiststory_target_txt"), timeStr, targetData.config.name)

	local isFinish = not targetData.isFail and targetData.isEnter

	gohelper.setActive(self.goTargetFinished, isFinish)
	gohelper.setActive(self.goTargetUnFinish, not isFinish)
end

function V3A1_RoleStoryGameView:refreshButton()
	local hasPlotFinish = NecrologistStoryModel.instance:isReviewCanShow(self.gameBaseMO.id)

	gohelper.setActive(self.btnReview, hasPlotFinish)
end

function V3A1_RoleStoryGameView:refreshGameState()
	if not self.gameBaseMO then
		return
	end

	local state = self.gameBaseMO:getGameState()

	if state == NecrologistStoryEnum.GameState.Win then
		self:statSettlement(StatEnum.Result.Success)
		ViewMgr.instance:openView(ViewName.V3A1_RoleStorySuccessView, {
			roleStoryId = self.gameBaseMO.id
		})
	elseif state == NecrologistStoryEnum.GameState.Fail then
		self:statSettlement(StatEnum.Result.Fail)
		ViewMgr.instance:openView(ViewName.V3A1_RoleStoryFailView, {
			roleStoryId = self.gameBaseMO.id
		})
	end

	self:refreshFinish(true)
end

function V3A1_RoleStoryGameView:refreshFinish(playAnim)
	if not self.gameBaseMO then
		return
	end

	self.waitPlayFinishAnim = nil

	local state = self.gameBaseMO:getGameState()
	local isWin = state == NecrologistStoryEnum.GameState.Win

	gohelper.setActive(self.goFinish, isWin)
	gohelper.setActive(self.goHero, not isWin)

	local showReset = not isWin and self.gameBaseMO:canReset()

	gohelper.setActive(self.btnReset, showReset)

	if playAnim and isWin then
		local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

		if isTop then
			self.animFinish:Play("open", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_note_course_finish)
		else
			self.waitPlayFinishAnim = true
		end
	end
end

function V3A1_RoleStoryGameView:showBlock()
	GameUtil.setActiveUIBlock(self.viewName, true, false)
end

function V3A1_RoleStoryGameView:closeBlock()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
end

function V3A1_RoleStoryGameView:statSettlement(result)
	if not self.gameBaseMO then
		return
	end

	local curTime = self.gameBaseMO:getCurTime()
	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(curTime)
	local param = {}

	param.heroStoryId = self.gameBaseMO.id
	param.baseId = self.gameBaseMO:getCurBaseId()
	param.time = string.format("%d:%02d", displayHour, minute)

	NecrologistStoryStatController.instance:statStorySettlement(param, result)
end

function V3A1_RoleStoryGameView:refreshRewardTime()
	local hasLimitTaskNotFinish = NecrologistStoryTaskListModel.instance:hasLimitTaskNotFinish(self.gameBaseMO.id)

	gohelper.setActive(self.goRewardTime, hasLimitTaskNotFinish)

	if not hasLimitTaskNotFinish then
		return
	end

	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	TaskDispatcher.runDelay(self._frameRefreshRewardTime, self, 1)
	self:_frameRefreshRewardTime()
end

function V3A1_RoleStoryGameView:_frameRefreshRewardTime()
	if not self.gameBaseMO then
		return
	end

	local cfg = RoleStoryConfig.instance:getStoryById(self.gameBaseMO.id)
	local activityId = cfg.activityId
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local time, timeFormat = TimeUtil.secondToRoughTime2(offsetSecond, true)

		self.txtRewardTime.text = time
		self.txtRewardTimeFormat.text = timeFormat
	else
		gohelper.setActive(self.goRewardTime, false)
		TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	end
end

function V3A1_RoleStoryGameView:onClose()
	local state = self.gameBaseMO:getGameState()

	if state == NecrologistStoryEnum.GameState.Normal and not self.gameBaseMO:getIsExitGame() then
		self:statSettlement(StatEnum.Result.Abort)
	end

	self.gameBaseMO:setIsExitGame(false)
end

function V3A1_RoleStoryGameView:onDestroyView()
	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	TaskDispatcher.cancelTask(self._refreshTask, self)
	TaskDispatcher.cancelTask(self._moveToArea, self)
	TaskDispatcher.cancelTask(self._refreshTitle, self)
end

return V3A1_RoleStoryGameView
