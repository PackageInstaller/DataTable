-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeUnitView.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeUnitView", package.seeall)

local DoDragonChallengeUnitView = class("DoDragonChallengeUnitView", ViewComponent)

function DoDragonChallengeUnitView:buildUI()
	DoDragonChallengeUnitView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txt")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")
	self._txtHuozhong = goutil.findChildTextComponent(self.mainGO, "huozhong/txt")

	GameUtil.SetActive(self._partCell, false)

	self._empty = goutil.findChild(self.mainGO, "empty")
	self._blackMask = goutil.findChild(self.mainGO, "guideEffRoot/blackMask")
	self._guideEffRoot = goutil.findChild(self.mainGO, "guideEffRoot")
end

function DoDragonChallengeUnitView:bindEvents()
	DoDragonChallengeUnitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DoDragonChallengeUnitView:unbindEvents()
	DoDragonChallengeUnitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DoDragonChallengeUnitView:onEnter()
	DoDragonChallengeUnitView.super.onEnter(self)

	self._activityId = DoDragonChallengeController.instance:getActivityId()
	self._activityType = DoDragonChallengeController.instance:getActivityType()

	self:_onSetUI()
	self:_onClickBlackMask()

	local storyId = DoDragonChallengeConfig.instance:getDdCommonValue("UNIT_STORYID", true)

	if storyId > 0 then
		local key = "DoDragonStroy" .. self._activityId

		local function firstTimeCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)
	end

	GlobalDispatcher:addListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdate, self)
	self:_onUpdate()
	DoDragonChallengeController.instance:sendPM_DisorderDragonChallengeGetInfoReq(self._activityId)
end

function DoDragonChallengeUnitView:onExit()
	DoDragonChallengeUnitView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdate, self)
	self:_onClearPartCol()
	self:_clearTargetList()
end

function DoDragonChallengeUnitView:_onSetUI()
	self._txtBubble.text = lang(DoDragonChallengeConfig.instance:getDdCommonValue("BUBBLE_TIPS_DKEY", false))
end

function DoDragonChallengeUnitView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
	self:_checkPassAndPop()
end

function DoDragonChallengeUnitView:_onUpdateData()
	self:_onUpdatePartColData()
end

function DoDragonChallengeUnitView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePartColUI()
end

function DoDragonChallengeUnitView:_onUpdatePlaneUI()
	return
end

function DoDragonChallengeUnitView:_checkPassAndPop()
	local result, tips = DoDragonChallengeController.instance:getTryEnteryUnitViewResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		local text = tips

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
	end
end

function DoDragonChallengeUnitView:_playGuideEffIfFirst(targetGoList)
	self:_onClickBlackMask()

	local effParent = self._guideEffRoot
	local pathName = "common/fx_ui_zhiyin_quan_03"

	self:_stopGuideEff()

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._guideEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	GameUtil.SetActive(self._guideEffRoot, true)

	for _, go in ipairs(targetGoList) do
		self:_showTarget(go)
	end
end

function DoDragonChallengeUnitView:_stopGuideEff()
	UIEffectManager.instance:stopEffect(self._guideEff)
end

function DoDragonChallengeUnitView:_onClickBlackMask()
	self:_stopGuideEff()
	self:_clearTargetList()
	GameUtil.SetActive(self._guideEffRoot, false)
end

function DoDragonChallengeUnitView:_showTarget(mainGo)
	if self._targetGoList == nil then
		self._targetGoList = {}
	end

	self._targetGoList[mainGo] = mainGo

	local actState = GameUtil.GetActive(mainGo)

	GameUtil.SetActive(mainGo, true)

	local canvasComp = goutil.addComponentOnce(mainGo, typeof(UnityEngine.Canvas))
	local graphicRaycaster = goutil.addComponentOnce(mainGo, typeof(UnityEngine.UI.GraphicRaycaster))
	local curViewCanvas = UGUIToolHelper.FindCanvas(self.mainGO)

	canvasComp.overrideSorting = true
	canvasComp.sortingOrder = curViewCanvas.sortingOrder + 1

	GameUtil.SetActive(mainGo, actState)
end

function DoDragonChallengeUnitView:_hideTarget(mainGo)
	if not goutil.isNil(mainGo) then
		local graphicRaycaster = mainGo:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster))

		if graphicRaycaster then
			goutil.destroy(graphicRaycaster)
		end

		local canvasComp = mainGo:GetComponent(typeof(UnityEngine.Canvas))

		if canvasComp then
			goutil.destroy(canvasComp)
		end
	end
end

function DoDragonChallengeUnitView:_clearTargetList()
	if self._targetGoList then
		for _, mainGo in pairs(self._targetGoList) do
			self:_hideTarget(mainGo)
		end
	end
end

function DoDragonChallengeUnitView:_onUpdatePartColData()
	local infoList = {}
	local challengeIdList = DoDragonChallengeModel.instance:getChallengeIdListAsUnit(self._activityId)

	for idx, challengeId in ipairs(challengeIdList) do
		local info = {}

		info.data = DoDragonChallengeConfig.instance:getDdAllData(self._activityId, challengeId)
		info.result = DoDragonChallengeModel.instance:getChallengeIdResultAsUnit(self._activityId, challengeId)
		info.idx = idx
		infoList[idx] = info
	end

	self._partInfoList = infoList
end

function DoDragonChallengeUnitView:_getPartInfo(idx)
	return self._partInfoList[idx]
end

function DoDragonChallengeUnitView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for index, info in ipairs(self._partInfoList) do
		if not children[index] then
			local mainGo = goutil.cloneAndSetParent(self._partCell, parentTran)

			self:_updatePartCell(mainGo, info)

			if index == 1 then
				local function firstTimeCallback()
					self:_playGuideEffIfFirst({
						mainGo
					})
				end

				local key = "DoDragonGuideEff" .. self._activityId

				GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)
			end
		end
	end

	self._partView:GetComponent(typeof(TestRecordPos)):LoadPlan(0)

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)
		local info = self:_getPartInfo(idx)

		GameUtil.SetActive(mainGo, not ((info or nil) and info.result == 1))
	end

	local fireNum = DoDragonChallengeModel.instance:getFireNumAsUnit(self._activityId)
	local totalFireNum = DoDragonChallengeConfig.instance:getTotalFireNum(self._activityId)

	self._txtHuozhong.text = string.format("<color=%s>%s</color>/%s", totalFireNum <= fireNum and "#FFE797FF" or "#FFFFFFFF", fireNum, totalFireNum)

	local isAllSuccess = DoDragonChallengeController.instance:isAllSuccessAsUnit(self._activityId)

	GameUtil.SetActive(self._partCol, not isAllSuccess)

	local isAllPass = DoDragonChallengeController.instance:isAllPassAsUnit(self._activityId)

	GameUtil.SetActive(self._empty, isAllPass)
end

function DoDragonChallengeUnitView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		local head = goutil.findChild(mainGo, "head")
		local headIcon = goutil.findChild(mainGo, "head/headIcon")

		GameUtil.rmClickHandler(head)
		MaterialMgr.resetAll(headIcon)
	end

	self:_clearPartEff()
end

function DoDragonChallengeUnitView:_updatePartCell(mainGo, info)
	local data = info.data
	local head = goutil.findChild(mainGo, "head")
	local headIcon = goutil.findChild(mainGo, "head/headIcon")
	local imgFailure = goutil.findChild(mainGo, "head/imgFailure")
	local effRoot = goutil.findChild(mainGo, "head/effRoot")
	local creepsData = DoDragonChallengeConfig.instance:getDdCreepsData(data.creepsMasterId, 1)

	if creepsData then
		local skinId = checknumber(creepsData.faceId)

		if skinId <= 0 then
			skinId = creepsData.raceId
		end

		MaterialMgr.setIcon(headIcon, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.resetAll(headIcon)
	end

	if info.result == 0 then
		self:_playPartEff(effRoot)
	else
		self:_stopPartEff(effRoot)
	end

	GameUtil.SetActive(imgFailure, info.result == -1)
	GameUtil.addClickHandler(head, GameUtil.handler(self._onClickPartCell, self, info.idx))
end

function DoDragonChallengeUnitView:_onClickPartCell(idx)
	local info = self:_getPartInfo(idx)
	local challengeId = info.data.challengeId
	local result, tips = DoDragonChallengeController.instance:getTryUnitBtlResultAndTips(self._activityId, challengeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DoDragonChallengeMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.DoDragonChallengeUnitView, nil)
	DoDragonChallengeController.instance:enterBattleAsUnit(self._activityId, challengeId)
end

function DoDragonChallengeUnitView:_playPartEff(mainGo)
	if self._partEffList == nil then
		self._partEffList = {}
	end

	local effParent = mainGo
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_quan"

	self:_stopPartEff(effParent)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._partEffList[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function DoDragonChallengeUnitView:_stopPartEff(mainGo)
	if self._partEffList then
		UIEffectManager.instance:stopEffect(self._partEffList[mainGo])
	end
end

function DoDragonChallengeUnitView:_clearPartEff()
	if self._partEffList then
		for _, eff in pairs(self._partEffList) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._partEffList = nil
	end
end

return DoDragonChallengeUnitView
