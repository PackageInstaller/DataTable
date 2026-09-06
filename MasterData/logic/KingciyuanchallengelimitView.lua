-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengelimitView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengelimitView", package.seeall)

local KingciyuanchallengelimitView = class("KingciyuanchallengelimitView", ViewComponent)

function KingciyuanchallengelimitView:ctor()
	KingciyuanchallengelimitView.super.ctor(self)
end

function KingciyuanchallengelimitView:unbindEvents()
	KingciyuanchallengelimitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReceive)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnCheck)
end

function KingciyuanchallengelimitView:bindEvents()
	KingciyuanchallengelimitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnReceive, self._onClickReceive, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnCheck, self._onClickCheck, self)
end

function KingciyuanchallengelimitView:buildUI()
	KingciyuanchallengelimitView.super.buildUI(self)

	self._uiLayer = self:getGo("uiLayer")
	self._uiLayerCanvas = self._uiLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._uiLayerCanvasGroup = self._uiLayer:GetComponent(ComponentType.CanvasGroup)
	self._bgLayer = self:getGo("bgLayer")
	self._bgLayerCanvas = self._bgLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._bgEffRoot = self:getGo("bgLayer/bgEffRoot")
	self._blackMask = self:getGo("blackMask")
	self._animLayer = self:getGo("animLayer")
	self._animLayerCanvas = self._animLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._petIcon = self:getGo("animLayer/petIcon")
	self._btnClose = self:getGo("uiLayer/btnClose")
	self._btnTip = self:getGo("uiLayer/btnTip")
	self._btnReceive = self:getGo("uiLayer/btnReceive")
	self._btnReset = self:getGo("uiLayer/btnReset")
	self._btnBuff = self:getGo("uiLayer/btnBuff")
	self._txtReceive = self:getTxt("uiLayer/btnReceive/Text")
	self._txtTime = self:getTxt("uiLayer/time/txt")
	self._txtProgress = self:getTxt("uiLayer/progress/txtProgress")
	self._btnCheck = self:getGo("uiLayer/petCard/btnCheck")
	self._txtPetCardDesc = self:getTxt("uiLayer/petCard/tips/txtTips")
	self._goldBarCon = self:getGo("uiLayer/goldBarCon")
	self._rewardCol = self:getGo("uiLayer/rewardCol")
	self._redBuff = self:getGo("uiLayer/btnBuff/tag")

	local scrollerGo = self:getGo("uiLayer/rewardCol/tableview")
	local cellGo = self:getGo("uiLayer/rewardCol/rewardCell")

	self._rewardScrollerRect = self:getScrollRect("uiLayer/rewardCol/tableview")

	GameUtil.SetActive(cellGo, false)

	self._scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingciyuanchallengelimitView:onExit()
	KingciyuanchallengelimitView.super.onExit(self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageActionRes, self._onActionResp, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageResetRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes, self._onActionResp, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._handleItemPrizeGetEnd, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	self._scrollList:dispose()
	self:_clearSceneEff()
	self:_clearRoleAlphaAnim()
	self:_clearUiLayerAlphaAnim()
	RedPointController.instance:unregRedPoint(self._redBuff)
end

function KingciyuanchallengelimitView:onEnter()
	KingciyuanchallengelimitView.super.onEnter(self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageActionRes, self._onActionResp, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageResetRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanStageChangeBuffRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes, self._onActionResp, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE)
	end

	self._activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(self._activityId)
	self._maxStage = KingCiYuanChallengeConfig.instance:getMaxStage(self._activityConfig.extPlanId)

	RedPointController.instance:regRedPoint(self._redBuff, RedPointModel.ID_KCYC_EXT_BUFF)

	local _, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE, self._activityId)
	local startDate = GameUtil.string2date(self._activityConfig.extChallengeTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	self._txtPetCardDesc.text = KingCiYuanChallengeConfig.instance:getCommonValue("PetCardDesc")

	local showbar = KingCiYuanChallengeConfig.instance:getCommonValue("A11")
	local btnList = {}

	for i, v in ipairs((not string.nilorempty(showbar) or nil) and string.split(showbar, "#")) do
		table.insert(btnList, {
			showAdd = true,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
	self:_setBlackMaskShow(false)
	self:_invalidateAll()
end

function KingciyuanchallengelimitView:_updateCell(view, cell, data, tag)
	local itemPos = goutil.findChild(cell, "itemPos")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	MaterialMgr.resetAll(itemPos)
	MaterialMgr.setCellByCfg(data, itemPos)

	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()
	local stageId = math.min(passStageId + 1, self._maxStage)
	local isPass = KingCiYuanChallengeModel.instance:isJxStagePass(stageId)
	local extChallengeConfig = KingCiYuanChallengeConfig.instance:getExtChallengeConfig(self._activityConfig.extPlanId, stageId)

	GameUtil.SetActive(receiveGo, isPass and extChallengeConfig and extChallengeConfig.resetAward ~= true)
end

function KingciyuanchallengelimitView:_clearCell(cell)
	local itemPos = goutil.findChild(cell, "itemPos")

	MaterialMgr.resetAll(itemPos)
end

function KingciyuanchallengelimitView:_setBlackMaskShow(isShow)
	GameUtil.SetActive(self._blackMask, isShow)
end

function KingciyuanchallengelimitView:_doBlockView(isNeedBlock)
	if isNeedBlock == nil then
		printError("bool值不能为nil")
	end

	self._blockTimes = self._blockTimes or 0
	self._blockTimes = self._blockTimes + (isNeedBlock and 1 or -1)

	ViewBlockMgr.instance:blockClick(self._blockTimes > 0, self)
end

function KingciyuanchallengelimitView:_onActionResp()
	local lastStageId = KingCiYuanChallengeModel.instance:getLastStageId()
	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()

	if lastStageId ~= nil and lastStageId ~= passStageId then
		GlobalDispatcher:addListener(GlobalNotify.OnMaterialPopEnd, self._handleItemPrizeGetEnd, self)

		local changeSetId = KingCiYuanChallengeModel.instance:getChangeSetId()
		local items = MaterialController.instance:showChangeSetInTemp(changeSetId)

		if not items or #items <= 0 then
			self:_handleItemPrizeGetEnd()
		end
	else
		self:_invalidateAll()
	end
end

function KingciyuanchallengelimitView:_invalidateAll()
	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()
	local stageId = math.min(passStageId + 1, self._maxStage)

	self._txtProgress.text = langPara("当前进度：<color=#ffd87c>%s/%s</color>", stageId, self._maxStage)

	local extChallengeConfig = KingCiYuanChallengeConfig.instance:getExtChallengeConfig(self._activityConfig.extPlanId, stageId)

	if extChallengeConfig then
		if string.nilorempty(extChallengeConfig.prize) then
			GameUtil.SetActive(self._rewardCol, false)
		else
			GameUtil.SetActive(self._rewardCol, true)

			local prizes = string.split(extChallengeConfig.prize, "#")
			local tableView = self._scrollList:getView()
			local len = #prizes
			local y = 24

			GameUtil.setLocalPos(tableView.gameObject, len <= 1 and -40 or len == 2 and -91 or -130, y)
			self._scrollList:reloadData(prizes)
			self._scrollList:refresh()
		end

		local btnNames = {
			[KingCiYuanChallengeConfig.StageType_Fight] = lang("进入挑战"),
			[KingCiYuanChallengeConfig.StageType_Buff] = lang("选择祝福"),
			[KingCiYuanChallengeConfig.StageType_Prize] = lang("领取奖励")
		}

		self._txtReceive.text = btnNames[extChallengeConfig.type]
	end

	if passStageId >= self._maxStage then
		GameUtil.SetGray(self._btnReceive, true)

		self._txtReceive.text = "已通关"
	else
		GameUtil.SetGray(self._btnReceive, false)
	end

	self:_invalidatePet()
end

function KingciyuanchallengelimitView:_invalidatePet(callBack)
	self._role = RoleObjectPool.instance:removeRole(self._role)

	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()
	local stageId = math.min(passStageId + 1, self._maxStage)
	local extChallengeConfig = KingCiYuanChallengeConfig.instance:getExtChallengeConfig(self._activityConfig.extPlanId, stageId)

	if extChallengeConfig then
		local x, y, scale = extChallengeConfig.rolePos[1], extChallengeConfig.rolePos[2], extChallengeConfig.rolePos[3]

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, extChallengeConfig.petSkinId, self._petIcon, scale, callBack, false, x, y)
	end
end

function KingciyuanchallengelimitView:_handleItemPrizeGetEnd()
	if MaterialController.instance:isAllGetListEmpty() then
		local lastStageId = KingCiYuanChallengeModel.instance:getLastStageId()
		local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()

		if lastStageId ~= nil and lastStageId ~= passStageId then
			KingCiYuanChallengeModel.instance:resetLastStageId()
			self:_setBlackMaskShow(false)
			GameUtil.SetActive(self._bgLayer, true)
			GameUtil.SetActive(self._animLayer, false)
			GameUtil.SetActive(self._uiLayer, false)
			self:_invalidateAll()
			self:_playSceneEff()
		end
	end
end

function KingciyuanchallengelimitView:_playSceneEff()
	local effParent = self._bgEffRoot
	local pathName = "20230120/kingciyuanchallenge/fx_ui_kingciyuanchallenge_bg.prefab"

	self:_clearSceneEff()

	if effParent and not string.nilorempty(pathName) then
		local function finishHandler(handlerTarget, eff)
			self:_doBlockView(false)
			self:_playAlphaAnim()
		end

		local function loadedHandler(_, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = false

			GoUtil.SetSortingOrder(eff.effGo.gameObject, self._bgLayerCanvas.sortingOrder)
		end

		self:_doBlockView(true)
		GameUtil.SetActive(self._bgLayer, true)

		self._mainEff = UIEffectManager.instance:playEffect(self, pathName, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
	end
end

function KingciyuanchallengelimitView:_playAlphaAnim()
	self:_playUiLayerAlphaAnim()
	self:_playRoleAlphaAnim()
end

function KingciyuanchallengelimitView:_playRoleAlphaAnim(finishCallBack)
	local startVal = 0.3
	local endVal = 1
	local duration = 1.7
	local skeleComps = self._petIcon:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic))
	local color = UnityEngine.Color.New(startVal, startVal, startVal, startVal)

	local function updateHandler(val)
		for i = 0, skeleComps.Length - 1 do
			color.r, color.g, color.b, color.a = val, val, val, val
			skeleComps[i].color = color
			skeleComps[i].timeScale = val
		end
	end

	local function endHandler()
		if finishCallBack then
			finishCallBack()
		end

		self:_doBlockView(false)
	end

	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear

	self:_doBlockView(true)
	GameUtil.SetActive(self._animLayer, true)
	self:_clearRoleAlphaAnim()

	self._roleAlphaTween = TweenUtil.ValueTo(startVal, endVal, duration, updateHandler, endHandler, luaTarget, easeType)
end

function KingciyuanchallengelimitView:_clearRoleAlphaAnim()
	if self._roleAlphaTween then
		self._roleAlphaTween:Kill(true)

		self._roleAlphaTween = nil
	end
end

function KingciyuanchallengelimitView:_playUiLayerAlphaAnim(finishCallBack)
	local startVal = 0.3
	local endVal = 1
	local duration = 1.7

	local function updateHandler(val)
		self._uiLayerCanvasGroup.alpha = val
	end

	local function endHandler()
		if finishCallBack then
			finishCallBack()
		end

		self:_doBlockView(false)
	end

	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear

	self:_doBlockView(true)
	self:_clearUiLayerAlphaAnim()

	self._uiLayerCanvasGroup.alpha = startVal

	GameUtil.SetActive(self._uiLayer, true)

	self._uiLayerAlphaTween = TweenUtil.ValueTo(startVal, endVal, duration, updateHandler, endHandler, luaTarget, easeType)
end

function KingciyuanchallengelimitView:_clearUiLayerAlphaAnim()
	if self._uiLayerAlphaTween then
		self._uiLayerAlphaTween:Kill(true)

		self._uiLayerAlphaTween = nil
	end
end

function KingciyuanchallengelimitView:_clearSceneEff()
	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function KingciyuanchallengelimitView:_onClickRule()
	local ruleKey = KingCiYuanChallengeConfig.instance:getCommonValue("A5")

	if not string.nilorempty(ruleKey) then
		UIStateManager.instance:open(ViewName.RulesView, ruleKey)
	end
end

function KingciyuanchallengelimitView:_onClickReset()
	if KingCiYuanChallengeModel.instance:isJxStagePass(self._maxStage) then
		FloatWordMgr.instance:show(lang("已全部通关，不可重置"))
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否重置挑战进度，重置后进度将回到第1关，目前已获得的祝福效果全部清除？"), function()
			KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanStageResetReq(self._activityId)
		end, nil, lang("重置"))
	end
end

function KingciyuanchallengelimitView:_onClickBuff()
	UIStateManager.instance:push(ViewName.KingciyuanchallengebuffpopupView, self._activityId)
end

function KingciyuanchallengelimitView:_onClickCheck()
	local raceId = KingCiYuanChallengeConfig.instance:getCommonValue("A12", true)

	if raceId > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function KingciyuanchallengelimitView:_onClickReceive()
	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()
	local stageId = math.min(passStageId + 1, self._maxStage)
	local extChallengeConfig = KingCiYuanChallengeConfig.instance:getExtChallengeConfig(self._activityConfig.extPlanId, stageId)

	if passStageId < self._maxStage and extChallengeConfig then
		if extChallengeConfig.type == KingCiYuanChallengeConfig.StageType_Fight then
			KingCiYuanChallengeModel.instance:clearViewInfos()
			KingCiYuanChallengeModel.instance:addViewInfo(ViewName.KingciyuanchallengemainView)
			KingCiYuanChallengeModel.instance:addViewInfo(self._viewPresentor.viewName, self._activityId)

			local fmtMo = KingCiYuanChallengeModel.instance.limitFmtMo

			fmtMo:initParams(self._activityId, extChallengeConfig)
			CustomFmtController.instance:showMissionView(fmtMo)
		elseif extChallengeConfig.type == KingCiYuanChallengeConfig.StageType_Buff then
			UIStateManager.instance:push(ViewName.KingciyuanchallengebuffselectView, self._activityId)
		elseif extChallengeConfig.type == KingCiYuanChallengeConfig.StageType_Prize then
			KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanStageActionReq(self._activityId, passStageId + 1, 0)
		end
	end
end

return KingciyuanchallengelimitView
