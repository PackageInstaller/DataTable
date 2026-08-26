-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryGameView", package.seeall)

local V3A4_RoleStoryGameView = class("V3A4_RoleStoryGameView", BaseView)

function V3A4_RoleStoryGameView:onInitView()
	self.goUnfinish = gohelper.findChild(self.viewGO, "Content/itemList/unfinish")
	self.goItemScroll = gohelper.findChild(self.goUnfinish, "Scroll View")
	self.goItem = gohelper.findChild(self.goUnfinish, "Scroll View/Viewport/Content/goItem")

	gohelper.setActive(self.goItem, false)

	self.nodeItem = gohelper.findChild(self.viewGO, "Content/nodeList/Scroll View/Viewport/Content/goItem")

	gohelper.setActive(self.nodeItem, false)

	self.goFinish = gohelper.findChild(self.viewGO, "Content/itemList/finished")
	self.btnPlayAudio = gohelper.findChildButtonWithAudio(self.viewGO, "Content/itemList/finished/#btn_play")
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Content/itemList/finished/#btn_reset")
	self.animRight = gohelper.findChildComponent(self.viewGO, "Content/itemList", gohelper.Type_Animator)
	self.goFly = gohelper.findChild(self.viewGO, "fly")
	self.goFlyItem = gohelper.findChild(self.goFly, "flyitem")
	self.flyScript = gohelper.findChildComponent(self.viewGO, "fly", typeof(UnityEngine.UI.UIFlying))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A4_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnPlayAudio, self.onClickBtnPlay, self)
	self.addClickCb(self, self.btnReset, self.onClickBtnReset, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A4_PutItem, self._onPutItem, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A4_OnDataUpdate, self._onDataUpdate, self)
end

function V3A4_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnPlayAudio)
	self:removeClickCb(self.btnReset)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A4_PutItem, self._onPutItem, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.V3A4_OnDataUpdate, self._onDataUpdate, self)
end

function V3A4_RoleStoryGameView:_editableInitView()
	return
end

function V3A4_RoleStoryGameView:onClickBtnReset()
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetV3A4RoleStoryGame, MsgBoxEnum.BoxType.Yes_No, self.resetGame, nil, nil, self)
end

function V3A4_RoleStoryGameView:resetGame()
	if not self.gameMo then
		return
	end

	self.gameMo:resetGame(self.gameId)
end

function V3A4_RoleStoryGameView:onClickBtnPlay()
	self:playAudio()
end

function V3A4_RoleStoryGameView:playAudio()
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, false, false)

	local baseConfig = NecrologistStoryV3A4Config.instance:getBaseConfig(self.baseId)

	ViewMgr.instance:openView(ViewName.V3A4_RoleStoryAudioView, {
		audioId = baseConfig.finishAudio,
		audioTime = baseConfig.finishAudioTime * 0.001
	})
end

function V3A4_RoleStoryGameView:_onPutItem(item)
	local itemConfig = item.config

	if not itemConfig then
		return
	end

	if self.nodeList then
		for i, v in ipairs(self.nodeList) do
			local ret, endItem = v:tryPutItem(itemConfig)

			if ret then
				self:flyItem(item.goImage, endItem.go, v)

				break
			end
		end
	end
end

function V3A4_RoleStoryGameView:_onDataUpdate()
	self:refreshView()
end

function V3A4_RoleStoryGameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_jiemian)
	self:refreshParam()
	self:refreshView()
end

function V3A4_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A4_RoleStoryGameView:refreshParam()
	self.gameId = self.viewParam.gameId
	self.baseId = self.viewParam.baseId
	self.gameMo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V3A4)

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A4_StartGame, self.gameId)
end

function V3A4_RoleStoryGameView:refreshView()
	self:initItemList()
	self:refreshNodeList()
	self:refreshFinish()
end

function V3A4_RoleStoryGameView:initItemList()
	if self.itemList then
		return
	end

	local list = NecrologistStoryV3A4Config.instance:getItemList()

	self.itemList = {}

	for i, v in ipairs(list) do
		local go = gohelper.cloneInPlace(self.goItem, tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3A4_RoleStoryPointItem)

		item:setData(v)
		table.insert(self.itemList, item)
	end
end

function V3A4_RoleStoryGameView:refreshNodeList()
	local list = NecrologistStoryV3A4Config.instance:getGameNodeList(self.gameId)

	self.nodeList = self.nodeList or {}

	local nodeCount = #list

	for i = 1, math.max(#self.nodeList, nodeCount) do
		self:refreshNodeItem(i, list[i], nodeCount)
	end
end

function V3A4_RoleStoryGameView:refreshNodeItem(index, config, nodeCount)
	local item = self.nodeList[index]

	if not item then
		local go = gohelper.cloneInPlace(self.nodeItem, tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3A4_RoleStoryNodeItem)

		table.insert(self.nodeList, item)
	end

	item:setData(config, self.gameMo)
end

function V3A4_RoleStoryGameView:setPlayBtnVisible(isFinish)
	if self.lastFinish == false and isFinish == true then
		GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, true, false)

		local baseConfig = NecrologistStoryV3A4Config.instance:getBaseConfig(self.baseId)
		local delayTime = baseConfig.pauseTime

		if delayTime > 0 then
			TaskDispatcher.runDelay(self.playAudio, self, delayTime * 0.001)
		else
			self:playAudio()
		end
	end

	self.lastFinish = isFinish

	gohelper.setActive(self.btnPlayAudio, isFinish)
end

function V3A4_RoleStoryGameView:refreshFinish()
	local isFinish = self.gameMo:checkGameIsFinish(self.gameId)

	gohelper.setActive(self.goFinish, isFinish)
	gohelper.setActive(self.goUnfinish, not isFinish)

	if isFinish then
		self.gameMo:setBaseFinish(self.baseId)
	end

	self:setPlayBtnVisible(isFinish)

	local isChange = self.isFinish ~= nil and self.isFinish ~= isFinish

	if isChange then
		if isFinish then
			self.animRight:Play("finish")
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_complet)
		else
			self.animRight:Play("unfinish")
		end
	elseif isFinish then
		self.animRight:Play("finish_idle")
	else
		self.animRight:Play("unfinish_idle")
	end

	self.isFinish = isFinish
end

function V3A4_RoleStoryGameView:flyItem(startGO, endGO, endItem)
	self.goEndItem = endItem

	gohelper.setActive(self.goFly, true)

	local startPos = recthelper.rectToRelativeAnchorPos(startGO.transform.position, self.goFly.transform)

	recthelper.setAnchor(self.goFlyItem.transform, startPos.x, startPos.y)

	self.flyScript.startPosition = startPos
	self.flyScript.endPosition = recthelper.rectToRelativeAnchorPos(endGO.transform.position, self.goFly.transform)

	self.flyScript:StartFlying()
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, true, false)
	TaskDispatcher.runDelay(self.onItemShow, self, 0.3)
	TaskDispatcher.runDelay(self.onFlyEnd, self, 0.8)
end

function V3A4_RoleStoryGameView:onItemShow()
	if not self.goEndItem then
		return
	end

	self.goEndItem:refreshItems()
end

function V3A4_RoleStoryGameView:onFlyEnd()
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, false, false)
	gohelper.setActive(self.goFly, false)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A4_OnDataUpdate)
end

function V3A4_RoleStoryGameView:onDestroyView()
	GameUtil.setActiveUIBlock(ViewName.V3A4_RoleStoryGameView, false, false)
	TaskDispatcher.cancelTask(self.playAudio, self)
	TaskDispatcher.cancelTask(self.onItemShow, self)
end

return V3A4_RoleStoryGameView
