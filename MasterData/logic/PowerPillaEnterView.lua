-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaEnterView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaEnterView", package.seeall)

local PowerPillaEnterView = class("PowerPillaEnterView", ViewComponent)

function PowerPillaEnterView:ctor()
	PowerPillaEnterView.super.ctor(self)

	self._recyclePrizeGoList = {}
	self._prizeItemList = {}
end

function PowerPillaEnterView:buildUI()
	PowerPillaEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnEnter = self:getBtn("btnEnter")
	self._btnSign = self:getBtn("btnSign")
	self._btnTask = self:getBtn("btnTask")
	self._redPointOfBtnTask = self:getGo("btnTask/redPoint")
	self._btnStore = self:getBtn("btnStore")
	self._signGet = self:getGo("btnSign/get")
	self._signRedPoint = self:getGo("btnSign/redPoint")
	self._bg = self:getGo("bg")
	self._btnBoss = self:getBtn("btnBoss")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtLevel = self:getTxt("txtLevel/txt")
	self.cell = self:getGo("rewardcell")
	self.tableview = self:getGo("rewardview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local pathPrefix = "progress/prizeview/viewport/"

	self._prizeSlider = self:getSlider(pathPrefix .. "content/progBar")
	self._prizeContentRectTrans = self:getGo(pathPrefix .. "content"):GetComponent(goutil.Type_RectTransform)
	self._recycleGo = self._prizeContentRectTrans.gameObject
	self._prizecell = self:getGo("progress/prizecell")
	self._prizeview = self:getGo("progress/prizeview")
	self._prizeViewRect = self._prizeview:GetComponent(ComponentType.ScrollRect)

	goutil.setActive(self._prizecell, false)

	self._progressRectTrans = self:getGo("progress"):GetComponent(goutil.Type_RectTransform)
	self._progressArrow = self:getGo("progress/btnArrow/arrow")
	self._effectBtnArrow = self:getGo("progress/btnArrow/effect")
	self._progressRedPoint = self:getGo("progress/btnArrow/redPoint")
	self._btnArrow = self:getBtn("progress/btnArrow")
	self._prizeSliderRectTrans = self._prizeSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._prizeSliderRectTrans, 0, 0)

	self._prizeSliderStartOffset = y
	self._prizeSliderEndOffset = 50
	self._prizeWidthSpace = 150
	self._btnMemory = self:getBtn("btnMemory")
	self._memoryRedPoint = self:getGo("btnMemory/redPoint")
	self._btnPiece = self:getBtn("btnPiece")
end

function PowerPillaEnterView:bindEvents()
	PowerPillaEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._btnSign:AddClickListener(self._onClickSignIn, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnStore:AddClickListener(self._onClickStore, self)
	self._btnBoss:AddClickListener(self._onClickBtnBoss, self)
	self._btnMemory:AddClickListener(self._onClickbtnMemory, self)
	self._btnPiece:AddClickListener(self._onClickbtnPiece, self)
end

function PowerPillaEnterView:unbindEvents()
	PowerPillaEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._btnSign:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnBoss:RemoveClickListener()
	self._btnMemory:RemoveClickListener()
	self._btnPiece:RemoveClickListener()
end

function PowerPillaEnterView:onEnter()
	PowerPillaEnterView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetActInfoRes, self._onGetActInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetGameInfoRes, self._onGetGameInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGainStagePrizeRes, self._onGainStagePrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGainDailyPrizeRes, self._onGainDailyPrizeRes, self)

	self._activityId = PowerPillaModel.instance:getActivityId()
	self._stagePlanId = PowerPillaModel.instance:getStagePlanId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MaintainPowerPilla, self._activityId)

	if not isInTime then
		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MaintainPowerPilla, self._activityId)

	self._endTimestamp = endTime

	settimer(1, self._onSecond, self)
	self:_onSecond()
	self:_initReward()
	self:_updateRedPoint()
	self:_updateSideBarRedPoint()
	self:_loadBgEffect()
	MaintainPowerPillaAgent.instance:sendPM_MPPGetActInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointOfBtnTask, 495)
	RedPointController.instance:regRedPoint(self._memoryRedPoint, 686)
	LuyngardeController.instance:unlockChapterStory(466001, 1)
end

function PowerPillaEnterView:onExit()
	PowerPillaEnterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetActInfoRes, self._onGetActInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetGameInfoRes, self._onGetGameInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGainStagePrizeRes, self._onGainStagePrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGainDailyPrizeRes, self._onGainDailyPrizeRes, self)
	removetimer(self._onSecond, self)
	self.scrollList:dispose()
	self:_clearReward()
	self:_removeSideBarEffect()
	self:_clearBgEffect()
	RedPointController.instance:unregRedPoint(self._redPointOfBtnTask)
	RedPointController.instance:unregRedPoint(self._memoryRedPoint)
end

function PowerPillaEnterView:_onClickClose()
	self:close()
end

function PowerPillaEnterView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "powerpillarule")
end

function PowerPillaEnterView:_onClickEnter()
	if not PowerPillaModel.instance:isOpenByCurrentStage(true) then
		return
	end

	UIStateManager.instance:push(ViewName.PowerPillaLevelView, self:_getCurFitStage())
end

function PowerPillaEnterView:_onClickArrow()
	self:_changeArrowState()
end

function PowerPillaEnterView:_getCurFitStage()
	local stage = PowerPillaModel.instance:getStageOfRecord()
	local stageData = PowerPillaConfig.instance:getStageCfgById(self._activityId, stage)

	if stageData then
		if not stageData.mainStageId then
			local mainStageId = 0

			if mainStageId > 0 then
				return mainStageId
			else
				return stage
			end
		end
	end
end

function PowerPillaEnterView:_onGetActInfoRes()
	self:_updateRedPoint()

	local stageId = self:_getCurFitStage()

	MaintainPowerPillaAgent.instance:sendPM_MPPGetGameInfoReq(self._activityId, stageId)
end

function PowerPillaEnterView:_onGetGameInfoRes()
	self:_updateReward()
end

function PowerPillaEnterView:_onGainStagePrizeRes()
	self:_updateReward()
end

function PowerPillaEnterView:_onGainDailyPrizeRes()
	self:_updateRedPoint()
end

function PowerPillaEnterView:_onSecond()
	self:_updateCountdown()
end

function PowerPillaEnterView:_updateCountdown()
	if self._endTimestamp and self._endTimestamp > 0 then
		local leftTime = self._endTimestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))
	end
end

function PowerPillaEnterView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function PowerPillaEnterView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function PowerPillaEnterView:_updateRewardPreview()
	local curStage = self:_getCurFitStage()
	local cfg = PowerPillaConfig.instance:getStageCfg(self._stagePlanId, curStage)

	if not string.nilorempty(cfg.preview) then
		local strList = string.split(cfg.preview, "#")

		self.scrollList:reloadData(strList)
	end
end

function PowerPillaEnterView:_initReward()
	printInfo("test _initReward")
	self:_clearReward()

	local cfgs = PowerPillaConfig.instance:getStageListOfMain(self._activityId)
	local count = #cfgs

	self:_setWorldContentLength(count)

	local posX = 126
	local posY = self._prizeSliderStartOffset

	for i, v in ipairs(cfgs) do
		posY = posY + self._prizeWidthSpace

		local go = self:_getWorldRewardGo()

		go.name = "prizecell" .. i

		goutil.addChildToParent(go, self._prizeContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local cls = GameUtil.AddLuaOnce(go, PPLEnterCell)

		cls:init(v, self, self._prizeview:GetComponent(goutil.Type_RectTransform))
		table.insert(self._prizeItemList, cls)
	end

	self:_setRewardSlider()
	self:_setTxtLevel()
end

function PowerPillaEnterView:_updateReward()
	printInfo("test _updateReward")

	for i, v in ipairs(self._prizeItemList) do
		v:update()
	end

	self:_setRewardSlider()
	self:_updateRewardPreview()
	self:_setTxtLevel()
	self:_updateSideBarRedPoint()

	local lastItem = self._prizeItemList[#self._prizeItemList]
	local lastPos = GameUtil.getAnchoredPos(lastItem.mainGO:GetComponent(goutil.Type_RectTransform))

	for i, v in ipairs(self._prizeItemList) do
		local isCanGet = PowerPillaModel.instance:isRewardCanGet(v._data.stage)

		if isCanGet then
			local pos = GameUtil.getAnchoredPos(v.mainGO:GetComponent(goutil.Type_RectTransform))

			self._prizeViewRect.verticalNormalizedPosition = pos.y / lastPos.y

			break
		end
	end
end

function PowerPillaEnterView:_setWorldContentLength(rewardCount)
	local sliderLength = rewardCount * self._prizeWidthSpace
	local contentTotalLength = self._prizeSliderStartOffset + sliderLength + self._prizeSliderEndOffset

	goutil.setHeight(self._prizeContentRectTrans, contentTotalLength)
	goutil.setWidth(self._prizeSliderRectTrans, sliderLength)
end

function PowerPillaEnterView:_setRewardSlider()
	local curLevel = PowerPillaModel.instance:getCurMaxMainStage()
	local maxLevel = PowerPillaController.instance:getMaxMainStage(self._activityId)

	self._prizeSlider:SetValue((maxLevel ~= 0 or nil) and (PowerPillaModel.instance:isPassStage() and 1 or PowerPillaModel.instance:isPassOfStage(curLevel) and curLevel / maxLevel or (curLevel - 1) / maxLevel))
end

function PowerPillaEnterView:_getWorldRewardGo()
	local count = #self._recyclePrizeGoList

	if count > 0 then
		local go = table.remove(self._recyclePrizeGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._prizecell, self._recycleGo.transform, "worldcell")

		goutil.setActive(go, true)

		return go
	end
end

function PowerPillaEnterView:_recyclePrizeGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recyclePrizeGoList, go)
	end
end

function PowerPillaEnterView:_clearReward()
	for i, v in ipairs(self._prizeItemList) do
		self:_recyclePrizeGo(v:getGo())
		v:clear()
	end

	table.clear(self._prizeItemList)
end

function PowerPillaEnterView:_setTxtLevel()
	local curStage = self:_getCurFitStage()
	local cfg = PowerPillaConfig.instance:getStageCfg(self._stagePlanId, curStage)

	if cfg then
		self._txtLevel.text = cfg.stageName or "无"
	end
end

function PowerPillaEnterView:_initArrowState()
	self._isOpen = false

	self:_clearWorldTween()
	Framework.TransformUtil.SetAnchoredPos(self._progressRectTrans, 182, 0)
	Framework.TransformUtil.SetLocalRotation(self._progressArrow.transform, 0, 0, 0)
end

function PowerPillaEnterView:_changeArrowState()
	self:_clearWorldTween()

	if self._isOpen then
		self._isOpen = false

		local targetPos = Vector2.New(182, 0)

		self._progressTween = self._progressRectTrans:DOAnchorPos(targetPos, 0.2)

		Framework.TransformUtil.SetLocalRotation(self._progressArrow.transform, 0, 0, 0)
	else
		self._isOpen = true

		local targetPos = Vector2.New(-22, 0)

		self._progressTween = self._progressRectTrans:DOAnchorPos(targetPos, 0.2)

		Framework.TransformUtil.SetLocalRotation(self._progressArrow.transform, 0, 0, 180)
	end
end

function PowerPillaEnterView:_clearWorldTween()
	if self._progressTween then
		self._progressTween:Kill()
	end
end

function PowerPillaEnterView:_loadSideBarEffect()
	self:_removeSideBarEffect()

	local path = "20220401/caijingling/fx_ui_kelingqu_cjl.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectBtnArrow.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectBtnArrow.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._sideBarEffect = uiEffect
end

function PowerPillaEnterView:_removeSideBarEffect()
	if self._sideBarEffect then
		UIEffectManager.instance:stopEffect(self._sideBarEffect)

		self._sideBarEffect = nil
	end
end

function PowerPillaEnterView:_updateSideBarRedPoint()
	local isAnyCanGet = PowerPillaModel.instance:isAnyRewardCanGet()

	goutil.setActive(self._progressRedPoint, isAnyCanGet)
end

function PowerPillaEnterView:_onClickSignIn()
	if PowerPillaModel.instance:isSignInDaily() then
		FloatWordMgr.instance:show("已签到")
	else
		MaintainPowerPillaAgent.instance:sendPM_MPPGainDailyPrizeReq(self._activityId)
	end
end

function PowerPillaEnterView:_onClickTask()
	UIStateManager.instance:push(ViewName.FuYaoTaskFrameView, self._activityId)
end

function PowerPillaEnterView:_onClickStore()
	GotoMgr.gotoByString(string.format("func#191#152#%s", self._activityId))
end

function PowerPillaEnterView:_onClickBtnBoss()
	UIStateManager.instance:push(ViewName.PowerPillaBossTipsView)
end

function PowerPillaEnterView:_onClickbtnMemory()
	GotoMgr.gotoByString("func#1152")
end

function PowerPillaEnterView:_onClickbtnPiece()
	UIStateManager.instance:push(ViewName.PowerPillaStoryView)
end

function PowerPillaEnterView:_updateRedPoint()
	goutil.setActive(self._signGet, PowerPillaModel.instance:isSignInDaily())
	goutil.setActive(self._signRedPoint, not PowerPillaModel.instance:isSignInDaily())
end

function PowerPillaEnterView:_loadBgEffect()
	local data = PowerPillaConfig.instance:getActivityCfg(self._activityId)

	if data then
		if not data.bgEff then
			local path

			if not string.nilorempty(path) then
				path = path .. ".prefab"
				self._bgEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

				self._bgEffect:setParent(self._bg.transform)
				self._bgEffect:setScale(1)
				self._bgEffect:setLocalPos(0, 0, 0)
			end
		end
	end
end

function PowerPillaEnterView:_clearBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

return PowerPillaEnterView
