-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtView.lua

module("logic.extensions.wudiclg.view.WuDiClgExtView", package.seeall)

local WuDiClgExtView = class("WuDiClgExtView", ViewComponent)

function WuDiClgExtView:buildUI()
	WuDiClgExtView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnRefresh = goutil.findChild(self.mainGO, "btnRefresh")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._ruleCol = goutil.findChild(self.mainGO, "ruleCol")
	self._ruleCol_prize = goutil.findChild(self.mainGO, "ruleCol/prize")
	self._ruleCol_prize_eff = goutil.findChild(self.mainGO, "ruleCol/prize/eff")
	self._ruleCol_prize_item = goutil.findChild(self.mainGO, "ruleCol/prize/item")
	self._ruleCol_prize_btnGet = goutil.findChild(self.mainGO, "ruleCol/prize/btnGet")
	self._ruleCol_prize_imgHasGain = goutil.findChild(self.mainGO, "ruleCol/prize/imgHasGain")
	self._ruleCol_btnTip = goutil.findChild(self.mainGO, "ruleCol/btnTip")
	self._ruleCol_godPrizeTag = goutil.findChild(self.mainGO, "ruleCol/godPrizeTag")
	self._ruleCol_descScrollerview = goutil.findChild(self.mainGO, "ruleCol/descScrollerview/Viewport/Content")
	self._ruleCol_descCell = goutil.findChild(self.mainGO, "ruleCol/descCell")

	GameUtil.SetActive(self._ruleCol_descCell, false)

	self._ruleCol_imgPetEmpty = goutil.findChild(self.mainGO, "ruleCol/imgPetEmpty")
	self._ruleCol_petCol = goutil.findChild(self.mainGO, "ruleCol/petCol")

	local petScrollerview = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollerview")
	local petScrollercell = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollercell")

	self._petScrollList = ScrollerList.create(petScrollerview, petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self:_recordGoDefaultActive(self._ruleCol_prize)
	self:_recordGoDefaultActive(self._ruleCol_godPrizeTag)
end

function WuDiClgExtView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function WuDiClgExtView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function WuDiClgExtView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function WuDiClgExtView:bindEvents()
	WuDiClgExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._ruleCol_prize_btnGet, self._onClickBtnPrizeGet, self)
	GameUtil.addClickHandler(self._ruleCol_btnTip, self._onClickBtnRuleTip, self)
end

function WuDiClgExtView:unbindEvents()
	WuDiClgExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._ruleCol_prize_btnGet)
	GameUtil.rmClickHandler(self._ruleCol_btnTip)
end

function WuDiClgExtView:onEnter()
	WuDiClgExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = WuDiClgController.instance:getActivityType()

	local isInTime = WuDiClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actData = WuDiClgConfig.instance:getWdcActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.WuDiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgExtremeFightConfirmRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgResetExtremeClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.WuDiClgGainExtremePrizeRes, self._onUpdate, self)
	WuDiClgController.instance:sendPM_WuDiClgGetInfoReq(self._activityId)
end

function WuDiClgExtView:onExit()
	WuDiClgExtView.super.onExit(self)
	MaterialMgr.resetAll(self._ruleCol_prize_item)
	UIEffectManager.instance:stopEffect(self._prizeEff)
	self:_onClearPartCol()
	self:_onClearRuleCol()
end

function WuDiClgExtView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	MaterialMgr.setCellByCfg(self._actData.extremeClgPrize, self._ruleCol_prize_item)
end

function WuDiClgExtView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function WuDiClgExtView:_onUpdateData()
	return
end

function WuDiClgExtView:_onUpdateUI()
	local result = WuDiClgController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	if ((self._isAoqiGodProcessType or nil) and GameEnum.ResultCode.Error) == GameEnum.ResultCode.Success then
		local effParent = self._ruleCol_prize_eff
		local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

		UIEffectManager.instance:stopEffect(self._prizeEff)

		if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
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

			self._prizeEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end

		GameUtil.SetActive(self._ruleCol_prize_btnGet, true)
	else
		UIEffectManager.instance:stopEffect(self._prizeEff)
		GameUtil.SetActive(self._ruleCol_prize_btnGet, false)
	end

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._ruleCol_prize, false)
		GameUtil.SetActive(self._ruleCol_godPrizeTag, false)
	else
		self:_refreshDefaultActive(self._ruleCol_prize)
		self:_refreshDefaultActive(self._ruleCol_godPrizeTag)
	end

	local isHasGain = WuDiClgController.instance:isHasGainExtremeClgPrize()

	GameUtil.SetActive(self._ruleCol_prize_imgHasGain, isHasGain)
	self:_onUpdatePartColUI()
	self:_onUpdateRuleColUI()
end

function WuDiClgExtView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local cfg = WuDiClgConfig.instance:getWdcExtStageCfg(self._activityId)

	for idx, data in ipairs(cfg) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(self._partCell, parentTran, string.format("%s_%s", self._partCell.name, idx))

			local pos = data.pos

			if not pos[3] then
				local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(mainGo, x, y, 0)
				GameUtil.setLocalScale(mainGo, pos[3])
			end
		end

		self:_updatePartCell(mainGo, data)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #cfg)
	end
end

function WuDiClgExtView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function WuDiClgExtView:_updatePartCell(mainGo, data)
	local stageId = data.stageId
	local isPass = WuDiClgController.instance:isPassOfExtStage(stageId)
	local stageData = WuDiClgConfig.instance:getWdcExtStageData(self._activityId, stageId)
	local imgHead = goutil.findChild(mainGo, "imgHead")
	local imgHead_icon = goutil.findChild(mainGo, "imgHead/icon")
	local imgPass = goutil.findChild(mainGo, "imgHead/imgPass")
	local txtStage = goutil.findChildTextComponent(mainGo, "imgHead/txtStage/txt")
	local txtRule = goutil.findChildTextComponent(mainGo, "txtRule")

	txtStage.text = stageId
	txtRule.text = string.format("群攻目标:%s", stageData.groupAttackCount)

	self:_loadBigBg(imgHead_icon, data.iconPath)
	GameUtil.SetActive(imgPass, isPass)
	GameUtil.addClickHandler(imgHead, GameUtil.handler(self._onClickPartCell, self, stageId))
end

function WuDiClgExtView:_clearPartCell(mainGo)
	local imgHead = goutil.findChild(mainGo, "imgHead")
	local imgHead_icon = goutil.findChild(mainGo, "imgHead/icon")

	GameUtil.rmClickHandler(imgHead)
	self:_unLoadBigBg(imgHead_icon)
end

function WuDiClgExtView:_onClickPartCell(stageId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = WuDiClgController.instance:getTryFightExtClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	WuDiClgController.instance:enterBattleOfExtClg(self._activityId, stageId)
end

function WuDiClgExtView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function WuDiClgExtView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function WuDiClgExtView:_onUpdateRuleColUI()
	local parentTran = self._ruleCol_descScrollerview.transform
	local childGo = self._ruleCol_descCell
	local children = GameUtil.getChildren(parentTran)
	local ruleDescArray = WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "extRuleDesc")
	local length = #ruleDescArray

	for idx, ruleDesc in ipairs(ruleDescArray) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

		txtDesc.text = ruleDesc
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(parentTran:GetComponent(goutil.Type_RectTransform))

	local allLockedRaceId = WuDiClgController.instance:getAllLockedRaceIdOfExtStage(self._activityId)

	self._petScrollList:reloadData(allLockedRaceId)
	self._petScrollList:MoveCellInView(0, true)

	local isEmpty = #allLockedRaceId <= 0

	GameUtil.SetActive(self._ruleCol_petCol, not isEmpty)
	GameUtil.SetActive(self._ruleCol_imgPetEmpty, isEmpty)
end

function WuDiClgExtView:_onClearRuleCol()
	self._petScrollList:dispose()
end

function WuDiClgExtView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function WuDiClgExtView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function WuDiClgExtView:_onClickBtnTip()
	local key = WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

function WuDiClgExtView:_onClickBtnRefresh()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = WuDiClgController.instance:getTryRefreshExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否重置所有关卡记录，同时解锁封印的所有精灵？"

	local function okFunc()
		WuDiClgController.instance:sendPM_WuDiClgResetExtremeClgReq(self._activityId)
	end

	local function cencelFunc()
		return
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", alignment)
end

function WuDiClgExtView:_onClickBtnPrizeGet()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = WuDiClgController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	WuDiClgController.instance:sendPM_WuDiClgGainExtremePrizeReq(self._activityId)
end

function WuDiClgExtView:_onClickBtnRuleTip()
	UIStateManager.instance:push(ViewName.WuDiClgExtDetailView)
end

return WuDiClgExtView
