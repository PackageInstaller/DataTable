-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryGameBaseItem.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameBaseItem", package.seeall)

local V3A1_RoleStoryGameBaseItem = class("V3A1_RoleStoryGameBaseItem", LuaCompBase)

function V3A1_RoleStoryGameBaseItem:init(go)
	self.go = go
	self.transform = go.transform

	recthelper.setAnchor(self.transform, 0, 0)

	self.goCanClick = gohelper.findChild(self.go, "#clickable")
	self.goTime = gohelper.findChild(self.go, "time")
	self.txtTime = gohelper.findChildTextMesh(self.go, "time/#txt_time")
	self.imgBuild = gohelper.findChildImage(self.go, "#image_build")
	self.goNormalName = gohelper.findChild(self.go, "name/normal")
	self.goBigBaseName = gohelper.findChild(self.go, "name/bigBase")
	self.storyItemList = {}
	self.goProgress = gohelper.findChild(self.go, "progress")
	self.storyItemGO = gohelper.findChild(self.go, "progress/item")

	gohelper.setActive(self.storyItemGO, false)

	self.btn = gohelper.findChildButtonWithAudio(self.go, "click")
	self.goCurrent = gohelper.findChild(self.go, "#go_current")
end

function V3A1_RoleStoryGameBaseItem:addEventListeners()
	self.addClickCb(self, self.btn, self.onClickBtn, self)
end

function V3A1_RoleStoryGameBaseItem:removeEventListeners()
	self:removeClickCb(self.btn)
end

function V3A1_RoleStoryGameBaseItem:onClickBtn()
	if not self.baseConfig then
		return
	end

	local state = self.gameBaseMO:getGameState()

	if state ~= NecrologistStoryEnum.GameState.Normal then
		return
	end

	local curBase = self.gameBaseMO:getCurBaseId()
	local isCurBase = curBase == self.baseConfig.id

	if isCurBase then
		local ret, storyId = self:checkCanReadStory()

		if ret then
			NecrologistStoryController.instance:openStoryView(storyId, self.gameBaseMO.id)
		elseif self.baseConfig.type == NecrologistStoryEnum.BaseType.InteractiveBase then
			ViewMgr.instance:openView(ViewName.V3A1_RoleStoryTicketView, {
				roleStoryId = self.gameBaseMO.id
			})
		else
			self.gameBaseMO:tryFinishBase(self.baseConfig.id)
		end

		return
	end

	if self.gameBaseMO:isInEndBase() or not self.gameBaseMO:isBaseFinish(curBase) then
		return
	end

	local hasConnection, costTime = NecrologistStoryV3A1Config.instance:hasBaseConnection(curBase, self.baseConfig.id)

	if hasConnection then
		self.gameBaseMO:addTime(costTime)
		self.gameBaseMO:setCurBaseId(self.baseConfig.id)
	end
end

function V3A1_RoleStoryGameBaseItem:refreshView(baseConfig, gameBaseMO)
	self.baseConfig = baseConfig
	self.gameBaseMO = gameBaseMO

	if not baseConfig then
		self:setVisible(false)

		return
	end

	local isAreaUnLock = self.gameBaseMO:isAreaUnlock(self.baseConfig.areaId)

	if not isAreaUnLock then
		self:setVisible(false)

		return
	end

	local isPreFinish = self.gameBaseMO:isBaseAllStoryFinish(self.baseConfig.preId, true)

	if not isPreFinish then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self:refreshName()
	self:refreshTime()
	self:refreshBuild()
	self:refreshProgress()
	self:refreshClickEnabel()
	self:refreshCurrent()
end

function V3A1_RoleStoryGameBaseItem:refreshCurrent()
	local showCurrent = false
	local curBaseId = self.gameBaseMO:getCurBaseId()

	if curBaseId ~= self.baseConfig.id and self.baseConfig.unlockAreaId > 0 and not self.gameBaseMO:isAreaUnlock(self.baseConfig.unlockAreaId) then
		showCurrent = true
	end

	if not showCurrent then
		local initBaseId = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

		if curBaseId == 401 and self.baseConfig.id == initBaseId then
			showCurrent = true
		end
	end

	gohelper.setActive(self.goCurrent, showCurrent)

	if showCurrent then
		local posY = self.isTimeShow and 118 or 72

		recthelper.setAnchorY(self.goCurrent.transform, posY)
	end
end

function V3A1_RoleStoryGameBaseItem:setVisible(isVisible)
	if self.isVisible == isVisible then
		return
	end

	self.isVisible = isVisible

	gohelper.setActive(self.go, isVisible)
end

function V3A1_RoleStoryGameBaseItem:getIsVisible()
	return self.isVisible
end

function V3A1_RoleStoryGameBaseItem:refreshClickEnabel()
	local isCanClick = self:isCanClick()

	gohelper.setActive(self.goCanClick, isCanClick)
end

function V3A1_RoleStoryGameBaseItem:isCanClick()
	if not self.baseConfig then
		return false
	end

	local state = self.gameBaseMO:getGameState()

	if state ~= NecrologistStoryEnum.GameState.Normal then
		return false
	end

	local curBase = self.gameBaseMO:getCurBaseId()
	local isCurBase = curBase == self.baseConfig.id

	if isCurBase then
		local ret, storyId = self:checkCanReadStory()

		if ret then
			return true
		end

		if self.baseConfig.type == NecrologistStoryEnum.BaseType.InteractiveBase then
			return true
		end

		if self.gameBaseMO:isBaseCanFinish(curBase) then
			return true
		end
	end

	if self.gameBaseMO:isInEndBase() or not self.gameBaseMO:isBaseFinish(curBase) then
		return false
	end

	local hasConnection = NecrologistStoryV3A1Config.instance:hasBaseConnection(curBase, self.baseConfig.id)

	if hasConnection then
		return true
	end
end

function V3A1_RoleStoryGameBaseItem:refreshTime()
	self.isTimeShow = false

	local curBase = self.gameBaseMO:getCurBaseId()
	local isCurBase = curBase == self.baseConfig.id

	if isCurBase or self.gameBaseMO:isInEndBase() or not self.gameBaseMO:isBaseFinish(curBase) then
		gohelper.setActive(self.goTime, false)

		return
	end

	local hasConnection, costTime = NecrologistStoryV3A1Config.instance:hasBaseConnection(curBase, self.baseConfig.id)

	if not hasConnection or costTime == 0 then
		gohelper.setActive(self.goTime, false)

		return
	end

	self.isTimeShow = true

	gohelper.setActive(self.goTime, true)

	local hour = math.floor(costTime)
	local minute = math.floor((costTime - hour) * 60)

	self.txtTime.text = hour > 0 and (minute > 0 and string.format("+%sh%sm", hour, minute) or string.format("+%sh", hour)) or string.format("+%sm", minute)
end

function V3A1_RoleStoryGameBaseItem:refreshName()
	gohelper.setActive(self.goNormalName, false)
	gohelper.setActive(self.goBigBaseName, false)

	local isBigBase = self.baseConfig.type == NecrologistStoryEnum.BaseType.BigBase

	if isBigBase then
		if not self.goBigBaseName then
			local go = self.goNormalName

			gohelper.setActive(go, true)

			local txt = gohelper.findChildTextMesh(go, "#txt_name")

			txt.text = self.baseConfig.name
		end
	end
end

function V3A1_RoleStoryGameBaseItem:refreshBuild()
	UISpriteSetMgr.instance:setRoleStorySprite(self.imgBuild, self.baseConfig.resource, true)
end

function V3A1_RoleStoryGameBaseItem:refreshProgress()
	if not self.baseConfig then
		return
	end

	gohelper.setActive(self.goProgress, true)

	local storyList = NecrologistStoryV3A1Config.instance:getBaseStoryList(self.baseConfig.id) or {}

	for i = 1, math.max(#storyList, #self.storyItemList) do
		local item = self:getProgressItem(i)

		self:refreshProgressItem(item, storyList[i])
	end
end

function V3A1_RoleStoryGameBaseItem:getProgressItem(index)
	local item = self.storyItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.cloneInPlace(self.storyItemGO, tostring(index))
		item.goCurrent = gohelper.findChild(item.go, "current")
		item.goNormal = gohelper.findChild(item.go, "normal")
		item.goFinished = gohelper.findChild(item.go, "finished")
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self.storyItemList[index] = item
	end

	return item
end

function V3A1_RoleStoryGameBaseItem:refreshProgressItem(item, storyId)
	if not storyId then
		gohelper.setActive(item.go, false)

		return
	end

	local state = self.gameBaseMO:getStoryState(storyId)
	local lastState = item.lastState
	local showOpen = lastState == NecrologistStoryEnum.StoryState.Lock and state == NecrologistStoryEnum.StoryState.Normal

	item.lastState = state

	if state == NecrologistStoryEnum.StoryState.Lock then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	if showOpen then
		item.anim:Play("open", 0, 0)
		self:playProgressOpenAuido()
	else
		item.anim:Play("idle", 0, 0)
	end

	local isFinish = state == NecrologistStoryEnum.StoryState.Finish

	gohelper.setActive(item.goFinished, isFinish)
	gohelper.setActive(item.goCurrent, false)
	gohelper.setActive(item.goNormal, false)

	if not isFinish then
		if state == NecrologistStoryEnum.StoryState.Reading then
			gohelper.setActive(item.goCurrent, true)
		else
			gohelper.setActive(item.goNormal, true)
		end
	end
end

function V3A1_RoleStoryGameBaseItem:playProgressOpenAuido()
	TaskDispatcher.cancelTask(self._playProgressOpenAudio, self)
	TaskDispatcher.runDelay(self._playProgressOpenAudio, self, 0.7)
end

function V3A1_RoleStoryGameBaseItem:_playProgressOpenAudio()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gudu_bubble_click)
end

function V3A1_RoleStoryGameBaseItem:checkCanReadStory()
	local storyList = NecrologistStoryV3A1Config.instance:getBaseStoryList(self.baseConfig.id) or {}

	for i = 1, #storyList do
		local storyId = storyList[i]
		local state = self.gameBaseMO:getStoryState(storyId)

		if state == NecrologistStoryEnum.StoryState.Reading or state == NecrologistStoryEnum.StoryState.Normal then
			return true, storyId
		end
	end

	return false
end

function V3A1_RoleStoryGameBaseItem:onDestroy()
	TaskDispatcher.cancelTask(self._playProgressOpenAudio, self)
end

return V3A1_RoleStoryGameBaseItem
