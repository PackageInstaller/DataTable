-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandScenceView.lua

module("logic.extensions.powerland.view.PowerLandScenceView", package.seeall)

local PowerLandScenceView = class("PowerLandScenceView", ViewComponent)

function PowerLandScenceView:ctor()
	PowerLandScenceView.super.ctor(self)
end

function PowerLandScenceView:buildUI()
	PowerLandScenceView.super.buildUI(self)

	self._blackMask = goutil.findChild(self.mainGO, "blackMask")
	self._blackMaskCanvas = self._blackMask:GetComponent(typeof(UnityEngine.Canvas))
	self._bgLayer = goutil.findChild(self.mainGO, "bgLayer")
	self._bgLayerCanvas = self._bgLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._bgEffRoot = goutil.findChild(self.mainGO, "bgLayer/bgEffRoot")
	self._animLayer = goutil.findChild(self.mainGO, "animLayer")
	self._animLayerCanvas = self._animLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._petIcon = goutil.findChild(self.mainGO, "animLayer/petIcon")
	self._uiLayer = goutil.findChild(self.mainGO, "uiLayer")
	self._uiLayerCanvas = self._uiLayer:GetComponent(typeof(UnityEngine.Canvas))
	self._uiLayerCanvasGroup = self._uiLayer:GetComponent(ComponentType.CanvasGroup)
	self._btnClose = goutil.findChild(self.mainGO, "uiLayer/leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "uiLayer/leftTop/btnTip")
	self._btnPet = goutil.findChild(self.mainGO, "uiLayer/btnPet")
	self._btnTarget = goutil.findChild(self.mainGO, "uiLayer/btnTarget")
	self._btnStage = goutil.findChild(self.mainGO, "uiLayer/btnStage")
	self._btnStageTxt = goutil.findChildTextComponent(self.mainGO, "uiLayer/btnStage/txt")
	self._btnTargetRed = goutil.findChild(self.mainGO, "uiLayer/btnTarget/redPoint")
	self._btnPetRed = goutil.findChild(self.mainGO, "uiLayer/btnPet/redPoint")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "uiLayer/tip/txtDesc")
	self._goldBarCon = goutil.findChild(self.mainGO, "uiLayer/goldBarCon")
	self._goldItemCon = goutil.findChild(self.mainGO, "uiLayer/goldBarCon/goldItemCon")
	self._txtGoldNum = goutil.findChildTextComponent(self.mainGO, "uiLayer/goldBarCon/txtGoldNum")
	self._container = goutil.findChild(self.mainGO, "uiLayer/container")

	GameUtil.SetActive(self._blackMask, true)
	GameUtil.SetActive(self._bgLayer, false)
	GameUtil.SetActive(self._animLayer, false)
	GameUtil.SetActive(self._uiLayer, false)
	GameUtil.SetActive(self._btnTargetRed, false)
	GameUtil.SetActive(self._btnPetRed, false)

	self._bgLayerCanvas.sortingOrder = PowerLandModel.viewLayer.scenceBg
	self._animLayerCanvas.sortingOrder = PowerLandModel.viewLayer.scenceAnim
	self._uiLayerCanvas.sortingOrder = PowerLandModel.viewLayer.scenceUi
	self._blackMaskCanvas.sortingOrder = PowerLandModel.viewLayer.scenceUi + 1
end

function PowerLandScenceView:bindEvents()
	PowerLandScenceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
	GameUtil.addClickHandler(self._btnStage, self._onClickBtnStage, self)
end

function PowerLandScenceView:unbindEvents()
	PowerLandScenceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPet)
	GameUtil.rmClickHandler(self._btnTarget)
	GameUtil.rmClickHandler(self._btnStage)
end

function PowerLandScenceView:destroyUI()
	PowerLandScenceView.super.destroyUI(self)
end

function PowerLandScenceView:onEnter()
	PowerLandScenceView.super.onEnter(self)
	self:_setBlackMaskShow(true)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		self:_setBlackMaskShow(false)
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdateScence, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandStageOverRes, self._onUpdateScence, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdateScence, self)
	self:_onUpdateScence()
	self:showTabAt(self._container, ViewName.TargetColConView)
end

function PowerLandScenceView:onExit()
	PowerLandScenceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdateScence, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandStageOverRes, self._onUpdateScence, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._handleItemPrizeGetEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshShopRes, self._onUpdateScence, self)

	if self._goldItemCon then
		MaterialMgr.resetAll(self._goldItemCon)
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)

	self:_clearHandleItemPrizeGetEnd()
	self:_clearScenceEff()
	self:_clearRoleAlphaAnim()
	self:_clearUiLayerAlphaAnim()
end

function PowerLandScenceView:_onSetUI()
	local itemStr = PowerLandConfig.instance:getPlShowItem()

	if self._goldItemCon and not string.nilorempty(itemStr) then
		local arr = string.split(itemStr, ":")

		MaterialMgr.setIcon(self._goldItemCon, arr[1], arr[2])
	end
end

function PowerLandScenceView:_onUpdateScence()
	if not PowerLandModel.instance:isStartChallenge() then
		self:close()
		FloatWordMgr.instance:show("挑战已完成")

		return
	end

	if PowerLandModel.instance:isInNewStage() then
		self:_setBlackMaskShow(true)
		GameUtil.SetActive(self._bgLayer, true)
		GameUtil.SetActive(self._animLayer, false)
		GameUtil.SetActive(self._uiLayer, false)
		self:_enterNewStage()
	else
		self:_setBlackMaskShow(false)
		GameUtil.SetActive(self._bgLayer, true)
		GameUtil.SetActive(self._animLayer, true)
		GameUtil.SetActive(self._uiLayer, true)
		self:_onUpdate()
	end
end

function PowerLandScenceView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PowerLandScenceView:_onUpdateData()
	return
end

function PowerLandScenceView:_onUpdateUI()
	local curStageId = PowerLandModel.instance:getCurStageId()
	local stageData = PowerLandConfig.instance:getPlStageData(self._activityId, curStageId)
	local totalStageNum = PowerLandConfig.instance:getTotalStageNum(self._activityId)

	self._txtDesc.text = string.format("当前进度\n%d/%d", curStageId, totalStageNum)
	self._txtGoldNum.text = PowerLandModel.instance:getScore()

	local x, y, scale = stageData.rolePos[1], stageData.rolePos[2], stageData.rolePos[3]

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, stageData.skinId, self._petIcon, scale, nil, false, x, y)

	local btnStr = ""
	local curStageType = PowerLandController.instance:getCurStageType()

	if curStageType == 1 then
		btnStr = "参战"
	elseif curStageType == 2 then
		btnStr = "查看商店"
	elseif curStageType == 3 then
		btnStr = "选择精灵"
	end

	self._btnStageTxt.text = btnStr
end

function PowerLandScenceView:_enterNewStage()
	PowerLandModel.instance:setInNewStage(false)
	self:_doPreStageOper()
end

function PowerLandScenceView:_doPreStageOper()
	local curActivityId = PowerLandModel.instance:getCurActivityId()
	local oldStageId = PowerLandModel.instance:getOldStageId()
	local stageType = PowerLandConfig.instance:getStageType(curActivityId, oldStageId)

	if stageType == 1 then
		self:_doNewStageOper()
	elseif stageType == 2 then
		self:_doNewStageOper()
	elseif stageType == 3 then
		self:_doNewStageOper()
	end
end

function PowerLandScenceView:_doNewStageOper()
	self:_onUpdate()

	local stageType = PowerLandController.instance:getCurStageType()

	if stageType == 1 then
		self:_onPlayAnim()
	elseif stageType == 2 then
		self:_onPlayAnim()
	elseif stageType == 3 then
		self:_onPlayAnim()
	end
end

function PowerLandScenceView:_doBlockView(isNeedBlock)
	if isNeedBlock == nil then
		printError("bool值不能为nil")
	end

	self._blockTimes = self._blockTimes or 0
	self._blockTimes = self._blockTimes + (isNeedBlock and 1 or -1)

	ViewBlockMgr.instance:blockClick(self._blockTimes > 0, self)
end

function PowerLandScenceView:_onPlayAnim()
	local curStageId = PowerLandModel.instance:getCurStageId()
	local stageData = PowerLandConfig.instance:getPlStageData(self._activityId, curStageId)

	local function callBack()
		self:_setBlackMaskShow(false)
		self:_playScenceEff()
	end

	local x, y, scale = stageData.rolePos[1], stageData.rolePos[2], stageData.rolePos[3]

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, stageData.skinId, self._petIcon, scale, callBack, false, x, y)
end

function PowerLandScenceView:_playScenceEff()
	local effParent = self._bgEffRoot
	local pathName = "20220602/liliangmijing_bg/fx_ui_liliangmijing_bg"

	self:_clearScenceEff()

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

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

		self._mainEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
	end

	self:_pushPrizeGetHandle()
end

function PowerLandScenceView:_clearScenceEff()
	if self._mainEff == nil then
		return
	end

	UIEffectManager.instance:stopEffect(self._mainEff)

	self._mainEff = nil
end

function PowerLandScenceView:_playAlphaAnim()
	self:_playUiLayerAlphaAnim()
	self:_playRoleAlphaAnim()
end

function PowerLandScenceView:_playRoleAlphaAnim(finishCallBack)
	local startVal = 0.3
	local endVal = 1
	local duration = 1.7
	local skeleComps = self._petIcon:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic))
	local color = UnityEngine.Color.New(startVal, startVal, startVal, startVal)

	local function updateHander(val)
		for i = 0, skeleComps.Length - 1 do
			color.r, color.g, color.b, color.a = val, val, val, val
			skeleComps[i].color = color
			skeleComps[i].timeScale = val
		end
	end

	local function endHander()
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

	self._roleAlphaTween = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
end

function PowerLandScenceView:_clearRoleAlphaAnim()
	if self._roleAlphaTween == nil then
		return
	end

	self._roleAlphaTween:Kill(true)

	self._roleAlphaTween = nil
end

function PowerLandScenceView:_playUiLayerAlphaAnim(finishCallBack)
	local startVal = 0.3
	local endVal = 1
	local duration = 1.7
	local skeleComps = self._petIcon:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic))
	local color = UnityEngine.Color.New(startVal, startVal, startVal, startVal)

	local function updateHander(val)
		self._uiLayerCanvasGroup.alpha = val
	end

	local function endHander()
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

	self._uiLayerAlphaTween = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
end

function PowerLandScenceView:_clearUiLayerAlphaAnim()
	if self._uiLayerAlphaTween == nil then
		return
	end

	self._uiLayerAlphaTween:Kill(true)

	self._uiLayerAlphaTween = nil
end

function PowerLandScenceView:_setBlackMaskShow(isShow)
	GameUtil.SetActive(self._blackMask, isShow)
end

function PowerLandScenceView:_handleItemPrizeGetEnd(matType)
	if matType ~= MatType.Item then
		return
	end

	self:_clearHandleItemPrizeGetEnd()
	self:_doNewStageOper()
end

function PowerLandScenceView:_clearHandleItemPrizeGetEnd()
	PowerLandModel.instance:_clearMatDataList()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._handleItemPrizeGetEnd, self)
end

function PowerLandScenceView:_pushPrizeGetHandle()
	if not PowerLandModel.instance:_isMatDataListHaveContent() then
		return
	end

	local matDataList = PowerLandModel.instance:_getMatDataList()

	if #matDataList > 0 then
		for _, data in ipairs(matDataList) do
			local iconStr = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", data.matType, data.matId)
			local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

			matName = string.format("<color=#F9FB39FF>%s</color>", matName)

			FloatWordMgr.instance:show(string.format("%s  %s x %d", iconStr, matName, data.matNum))
		end
	end

	self:_clearHandleItemPrizeGetEnd()
end

function PowerLandScenceView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(PowerLandConfig.instance:getRuleTipsKey())
end

function PowerLandScenceView:_onClickBtnPet()
	UIStateManager.instance:push(ViewName.PetTargetShowView)
end

function PowerLandScenceView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.TargetDetailsView)
end

function PowerLandScenceView:_onClickBtnStage()
	local curStageType = PowerLandController.instance:getCurStageType()

	if curStageType == 1 then
		PowerLandController.instance:enterStageBattle()
	elseif curStageType == 2 then
		UIStateManager.instance:push(ViewName.StagePetShopView)
	elseif curStageType == 3 then
		UIStateManager.instance:push(ViewName.StagePetSelectionView)
	end
end

return PowerLandScenceView
