-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightCollectView.lua

module("logic.extensions.originfight.view.OriginFightCollectView", package.seeall)

local OriginFightCollectView = class("OriginFightCollectView", ViewComponent)

function OriginFightCollectView:ctor()
	OriginFightCollectView.super.ctor(self)
end

function OriginFightCollectView:unbindEvents()
	OriginFightCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollect)
end

function OriginFightCollectView:bindEvents()
	OriginFightCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClickBtnCollect, self)
end

function OriginFightCollectView:buildUI()
	OriginFightCollectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._eff = self:getGo("eff")
	self._effInsert = self:getGo("effInsert")
	self._effDrag = self:getGo("effDrag")
	self._btnCollect = self:getGo("btnCollect")
	self._imgFire = self:getGo("imgFire")
	self._dragObj = self:getGo("dragObj")
	self._imgDragObj = self:getGo("dragObj/img")
	self._pointEnterObj = self:getGo("pointEnterObj")
	self._dragTip = self:getGo("dragTip")
end

function OriginFightCollectView:onExit()
	OriginFightCollectView.super.onExit(self)

	for i, cfg in ipairs(self._tiTanCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.titanId)
		local imgTiTan = goutil.findChild(cellGo, "imgTiTan")
		local reward = goutil.findChild(cellGo, "reward")
		local effXuanZhuan = goutil.findChild(cellGo, "effXuanZhuan")

		MaterialMgr.resetAll(reward)
		self:stopViewEffectUniGo(effXuanZhuan)
	end

	for cell, handlers in pairs(self._dragHandlerMap) do
		BeginDragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.beginDragHandler)
		DragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.moveDragHandler)
		EndDragHandler.Get(cell.gameObject):RemoveLuaHandler(handlers.endDragHandler)
	end

	PointerEnterHandler.Get(self._pointEnterObj):RemoveLuaHandler(self._pointEnterHandler)
	PointerExitHandler.Get(self._pointEnterObj):RemoveLuaHandler(self._pointExitHandler)

	self._dragHandlerMap = nil
end

function OriginFightCollectView:onEnter()
	OriginFightCollectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MazeGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightCollectTitanRes, self._onCollectTitanRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 525001
	end

	self._ratioNum = 0
	self._eachScale = 0.05
	self._curScale = 1
	self._dragHandlerMap = {}
	self._pointEnterHandlerMap = {}
	self._finishDragTiTan = {}
	self._isDraging = false
	self._actCfg = OriginFightConfig.instance:getActCfg(self._activityId)

	local gainTitanActivityId = self._actCfg.gainTitanActivityId

	self._tiTanCfgs = OriginFightConfig.instance:getTiTanCfgs(self._activityId)

	local storyId = self._actCfg.firstStoryId

	if checknumber(storyId) > 0 then
		local key = string.format("OriginFightCollectView%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	OriginFightController.instance:sendPM_OriginFightInfoReq(self._activityId)
	MazeGameController.instance:sendPM_MazeGameInfoReq(gainTitanActivityId)
	WorldProgressPrizeController.instance:sendPM_WorldProgressPrizeGetInfoReq(self._activityId)
end

function OriginFightCollectView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	for i, cfg in ipairs(self._tiTanCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.titanId)
		local dragTrigger = goutil.findChild(cellGo, "dragTrigger")
		local imgTiTan = goutil.findChild(cellGo, "imgTiTan")
		local reward = goutil.findChild(cellGo, "reward")
		local txtProgress = goutil.findChildTextComponent(cellGo, "progress/txtProgress")
		local emptyRaycast = cellGo:GetComponent(typeof(UnityEngine.UI.Graphic))
		local imgPath = string.format("ui/icon/items/icon_qianghuashi_0%d.png", cfg.titanId)

		if self._dragHandlerMap[cellGo] == nil then
			self._dragHandlerMap[cellGo] = {}
			self._dragHandlerMap[cellGo].beginDragHandler = BeginDragHandler.Get(cellGo):AddLuaHandler(function(go, edata)
				self:_OnDragBegin(cellGo, cfg.titanId)
			end)
			self._dragHandlerMap[cellGo].moveDragHandler = DragHandler.Get(cellGo):AddLuaHandler(function(_go, edata)
				self:_OnDragMoved(cellGo, cfg.titanId)
			end)
			self._dragHandlerMap[cellGo].endDragHandler = EndDragHandler.Get(cellGo):AddLuaHandler(function(_go, edata)
				self:_OnDragEnded(cellGo, cfg.titanId)
			end)
		end

		MaterialMgr.setCellByCfg(cfg.reward, reward)
		GameUtil.SetActive(imgTiTan, true)
	end

	self._pointEnterHandler = PointerEnterHandler.Get(self._pointEnterObj):AddLuaHandler(function(_go, eventData)
		self:_onMoveIn()
	end)
	self._pointExitHandler = PointerExitHandler.Get(self._pointEnterObj):AddLuaHandler(function(_go, eventData)
		self:_onMoveOut()
	end)

	GameUtil.setLocalScale(self._imgFire, 1, 1, 1)
end

function OriginFightCollectView:_setDrag()
	for i, cfg in ipairs(self._tiTanCfgs) do
		local cellGo = self:getGo("cells/cell" .. cfg.titanId)

		if self._dragHandlerMap[cellGo] == nil then
			self._dragHandlerMap[cellGo] = {}
			self._dragHandlerMap[cellGo].beginDragHandler = BeginDragHandler.Get(cellGo):AddLuaHandler(function(go, edata)
				self:_OnDragBegin(cellGo, cfg.titanId)
			end)
			self._dragHandlerMap[cellGo].moveDragHandler = DragHandler.Get(cellGo):AddLuaHandler(function(_go, edata)
				self:_OnDragMoved(cellGo, cfg.titanId)
			end)
			self._dragHandlerMap[cellGo].endDragHandler = EndDragHandler.Get(cellGo):AddLuaHandler(function(_go, edata)
				self:_OnDragEnded(cellGo, cfg.titanId)
			end)
		end
	end
end

function OriginFightCollectView:_onUpdate()
	self._info = OriginFightModel.instance:getInfo(self._activityId)

	if self._info then
		if not self._info.hasCollectTitan then
			local hasCollectAllTitan = false
			local gainTitanActivityId = self._actCfg.gainTitanActivityId
			local passAllGameStage = MazeGameController.instance:hasPassAllStage(gainTitanActivityId)
			local allTiTanFinish = OriginFightController.instance:allTiTanFinish(self._activityId)
			local finishAllGodFavor = OriginFightController.instance:checkAllGodFavorFinish(self._activityId)

			if hasCollectAllTitan and not finishAllGodFavor then
				UIStateManager.instance:popByName(ViewName.OriginFightCollectView)
				UIStateManager.instance:push(ViewName.OriginFightSummonView, self._activityId)

				return
			elseif finishAllGodFavor then
				UIStateManager.instance:popByName(ViewName.OriginFightCollectView)
				UIStateManager.instance:push(ViewName.OriginFightGetRewardView, self._activityId)

				return
			end

			for i, cfg in ipairs(self._tiTanCfgs) do
				local cellGo = self:getGo("cells/cell" .. cfg.titanId)
				local dragTrigger = goutil.findChild(cellGo, "dragTrigger")
				local emptyRaycast = cellGo:GetComponent(typeof(UnityEngine.UI.Graphic))
				local imgTiTanChangeComp = goutil.findChild(cellGo, "imgTiTan"):GetComponent("UIImageSpriteChange")
				local geted = goutil.findChild(cellGo, "geted")
				local reward = goutil.findChild(cellGo, "reward")
				local effXuanZhuan = goutil.findChild(cellGo, "effXuanZhuan")
				local progress = goutil.findChild(cellGo, "progress")
				local allFinishGo = goutil.findChild(cellGo, "allFinishGo")
				local rewardBgGo = goutil.findChild(cellGo, "img")
				local txtProgress = goutil.findChildTextComponent(cellGo, "progress/txtProgress")
				local curProgress = WorldProgressPrizeController.instance:getProgress(self._activityId, cfg.progressId)
				local key = string.format("OriginFightCollect_%d_%d", self._activityId, cfg.titanId)
				local hasPass = GameUtil.getUserData(key)
				local imgPath = string.format("ui/icon/items/icon_qianghuashi_0%d.png", cfg.titanId)

				if curProgress < cfg.maxProgress then
					txtProgress.text = string.format("%d/%d", curProgress, cfg.maxProgress)
				end

				emptyRaycast.enabled = allTiTanFinish

				imgTiTanChangeComp:SetState(cfg.titanId - 1)
				GameUtil.SetActive(geted, hasPass and not allTiTanFinish)
				GameUtil.SetActive(reward, not allTiTanFinish)
				GameUtil.SetActive(progress, not allTiTanFinish)
				GameUtil.SetActive(rewardBgGo, not allTiTanFinish)
				GameUtil.SetActive(allFinishGo, allTiTanFinish)
				self:stopViewEffectUniGo(effXuanZhuan)

				if allTiTanFinish then
					self:playViewEffectUniGo("fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab", effXuanZhuan, self.mainGO.transform, true, nil, nil)
				end
			end

			GameUtil.SetActive(self._pointEnterObj, allTiTanFinish)
			GameUtil.SetActive(self._btnCollect, not allTiTanFinish)
			GameUtil.SetActive(self._dragTip, allTiTanFinish)
		end
	end
end

function OriginFightCollectView:_OnDragBegin(cellGo, data)
	if self._info then
		if not self._info.hasCollectTitan then
			local hasCollectAllTitan = false
			local allTiTanFinish = OriginFightController.instance:allTiTanFinish(self._activityId)

			if not allTiTanFinish or not not hasCollectAllTitan then
				FloatWordMgr.instance:show("收集元素泰坦全部关卡通关后可注入")

				return
			end

			local eff = goutil.findChild(cellGo, "eff")
			local effXuanZhuan = goutil.findChild(cellGo, "effXuanZhuan")
			local imgTiTan = goutil.findChild(cellGo, "imgTiTan")
			local dragChangeComp = self._imgDragObj:GetComponent("UIImageSpriteChange")

			self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
			self._effDrag.transform.position = uGuiUtil.GetTouchWorldPosition()

			dragChangeComp:SetState(data - 1)
			GameUtil.SetActive(imgTiTan, false)
			GameUtil.SetActive(self._dragObj, true)
			self:stopViewEffectUniGo(self._effDrag)
			self:stopViewEffectUniGo(effXuanZhuan)
			self:playViewEffectUniGo("fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab", self._effDrag, self.mainGO.transform, true, nil, nil)
			self:playViewEffectUniGo("20250926/baoweiluobo/fx_ui_chuxian.prefab", eff, self.mainGO.transform, false, nil, nil)

			self._isDraging = true
			self._dragingTiTanId = data
		end
	end
end

function OriginFightCollectView:_OnDragMoved(go, data)
	if self._isDraging then
		local cellGo = self:getGo("cells/cell" .. data)
		local cellGoPos = GameUtil.getLocalPos(cellGo)

		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
		self._effDrag.transform.position = uGuiUtil.GetTouchWorldPosition()

		local dragLocalPos = GameUtil.getLocalPos(self._dragObj)
		local diffX = math.abs(dragLocalPos.x)
		local diffY = math.abs(dragLocalPos.y)
		local originDistance = math.abs(cellGoPos.x) + math.abs(cellGoPos.y)
		local curDistance = diffX + diffY
		local rate = (originDistance - curDistance) / originDistance

		if rate <= 0 then
			rate = 0
		end

		local distanRate = math.min(rate, self._curScale)
		local scale = distanRate * self._eachScale
		local curScale = scale + self._curScale

		GameUtil.setLocalScale(self._imgFire, curScale, curScale, curScale)
	end
end

function OriginFightCollectView:_OnDragEnded(cell, data)
	local imgBg = goutil.findChild(cell, "imgForbid")

	if self._isDraging == true then
		self:stopViewEffectUniGo(self._effDrag)

		self._isDraging = false

		local cellGo = self:getGo("cells/cell" .. self._dragingTiTanId)
		local eff = goutil.findChild(cellGo, "eff")
		local effXuanZhuan = goutil.findChild(cellGo, "effXuanZhuan")
		local imgTiTan = goutil.findChild(cellGo, "imgTiTan")
		local allFinishGo = goutil.findChild(cellGo, "allFinishGo")
		local emptyRaycast = cellGo:GetComponent(typeof(UnityEngine.UI.Graphic))

		if self._isTouchingContainer then
			self._curScale = self._eachScale + self._curScale
			emptyRaycast.enabled = false

			GameUtil.setLocalScale(self._imgFire, self._curScale, self._curScale, self._curScale)
			table.insert(self._finishDragTiTan, self._dragingTiTanId)
			self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_xuanwohuiju.prefab", self._effInsert, self.mainGO.transform, false, nil, nil)

			if #self._finishDragTiTan == #self._tiTanCfgs then
				OriginFightController.instance:sendPM_OriginFightCollectTitanReq(self._activityId)
			end
		else
			self:playViewEffectUniGo("fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab", effXuanZhuan, self.mainGO.transform, true, nil, nil)
		end

		GameUtil.SetActive(imgTiTan, not self._isTouchingContainer)
		GameUtil.SetActive(allFinishGo, not self._isTouchingContainer)
		GameUtil.SetActive(self._dragObj, false)
	end

	self._dragingTiTanId = 0
end

function OriginFightCollectView:_onMoveIn()
	self._isTouchingContainer = true
end

function OriginFightCollectView:_onMoveOut()
	self._isTouchingContainer = false
end

function OriginFightCollectView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginFightCollectView:_onClickBtnCollect()
	local gainTitanActivityId = self._actCfg.gainTitanActivityId

	UIStateManager.instance:push(ViewName.MazeGameLevelView, gainTitanActivityId)
end

function OriginFightCollectView:_onCollectTitanRes()
	self:playViewEffectUniGo("20241220/zhongyanzhizhan/fx_ui_bianbai.prefab", self._eff, self.mainGO.transform, false, function()
		local hasOpenView = UIStateManager.instance:_isInStack(ViewName.OriginFightSummonView)

		if not hasOpenView then
			local storyId = self._actCfg.tiTanStoryId

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			UIStateManager.instance:popByName(ViewName.OriginFightCollectView)
			UIStateManager.instance:push(ViewName.OriginFightSummonView, self._activityId)
		end
	end, nil)
end

return OriginFightCollectView
