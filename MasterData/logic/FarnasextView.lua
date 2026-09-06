-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextView.lua

module("logic.extensions.farnas.view.FarnasextView", package.seeall)

local FarnasextView = class("FarnasextView", ViewComponent)

function FarnasextView:buildUI()
	FarnasextView.super.buildUI(self)

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
	self._ruleCol_prize_btnGet = goutil.findChild(self.mainGO, "ruleCol/prize/btnGet")
	self._ruleCol_prize_imgHasGain = goutil.findChild(self.mainGO, "ruleCol/prize/imgHasGain")
	self._ruleCol_imgPetEmpty = goutil.findChild(self.mainGO, "ruleCol/imgPetEmpty")
	self._ruleCol_petCol = goutil.findChild(self.mainGO, "ruleCol/petCol")

	local petScrollerview = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollerview")
	local petScrollercell = goutil.findChild(self.mainGO, "ruleCol/petCol/petScrollercell")

	self._petScrollList = ScrollerList.create(petScrollerview, petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTarget = self:getTxt("ruleCol/txtTarget")
	self._txtEnemyBuff = self:getTxt("ruleCol/txtEnemyBuff")
	self._txtMyBuff = self:getTxt("ruleCol/txtMyBuff")
	self._btnMyDetail = self:getBtn("ruleCol/btnMyDetail")
	self._btnChallengeimgGo = self:getGo("btnChallenge/img")
	self._txtStage = self:getTxt("ruleCol/txtStage")
	self._conGo = self:getGo("con")
	self._maskTempMat = self:getGo("maskTemp"):GetComponent(goutil.Type_UIImage).material
end

function FarnasextView:bindEvents()
	FarnasextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._ruleCol_prize_btnGet, self._onClickBtnPrizeGet, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnMyDetail:AddClickListener(self._onClickbtnMyDetail, self)
end

function FarnasextView:unbindEvents()
	FarnasextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._ruleCol_prize_btnGet)
	self._btnChallenge:RemoveClickListener()
	self._btnMyDetail:RemoveClickListener()
end

function FarnasextView:onEnter()
	FarnasextView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = FarnasController.instance:getActivityType()

	local isInTime = FarnasController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actData = FarnasConfig.instance:getActCfg(self._activityId)
	self._selectStageId = 0

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.FarnasClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.FarnasClgExtremeFightRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.FarnasClgResetExtremeClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.FarnasClgGainExtremePrizeRes, self._onUpdate, self)
	FarnasChallengeAgent.instance:sendPM_FarnasClgGetInfoReq(self._activityId)
end

function FarnasextView:onExit()
	FarnasextView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._prizeEff)
	self:_onClearPartCol()
	self:_onClearRuleCol()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function FarnasextView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	self:_setRole()
end

function FarnasextView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()

	if self._selectStageId > 0 then
		self:_onClickPartCell(self._selectStageId)
	end
end

function FarnasextView:_onUpdateData()
	return
end

function FarnasextView:_onUpdateUI()
	local result = FarnasController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	if result == GameEnum.ResultCode.Success then
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

	local isHasGain = FarnasController.instance:isHasGainExtremeClgPrize()

	GameUtil.SetActive(self._ruleCol_prize_imgHasGain, isHasGain)
	self:_onUpdatePartColUI()
end

function FarnasextView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local cfgs = FarnasConfig.instance:getExtStageCfgs(self._activityId)
	local isPass
	local stageId = 0

	for idx, data in ipairs(cfgs) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(self._partCell, parentTran, string.format("%s_%s", self._partCell.name, idx))

			local x = -532 + (idx - 1) * 145
			local y = -253
			local scale = 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, scale)
		end

		if not self:_updatePartCell(mainGo, data) and stageId <= 0 then
			stageId = data.stageId
		end
	end

	if self._selectStageId == 0 then
		if stageId > 0 then
			self:_onClickPartCell(stageId)
		else
			self:_onClickPartCell(cfgs[#cfgs].stageId)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #cfgs)
	end
end

function FarnasextView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function FarnasextView:_updatePartCell(mainGo, data)
	local stageId = data.stageId
	local isPass = FarnasController.instance:isPassOfExtStage(self._activityId, stageId)
	local stageData = FarnasConfig.instance:getExtStageCfg(self._activityId, stageId)
	local rootGo = goutil.findChild(mainGo, "root")
	local imgHead = goutil.findChild(mainGo, "root/imgHead")
	local imgHead_icon = goutil.findChild(mainGo, "root/imgHead/icon")
	local imgPass = goutil.findChild(mainGo, "root/imgHead/imgPass")
	local txtRule = goutil.findChildTextComponent(mainGo, "root/txtRule")
	local selectGo = goutil.findChild(mainGo, "select")

	txtRule.text = string.format("闪避:%s次", stageData.dodgeCount)

	self:_loadBigBg(imgHead_icon, data.iconPath)
	GameUtil.SetActive(imgPass, isPass)
	GameUtil.addClickHandler(imgHead, GameUtil.handler(self._onClickPartCell, self, stageId))
	goutil.setActive(selectGo, self._selectStageId == stageId)

	return isPass
end

function FarnasextView:_clearPartCell(mainGo)
	local imgHead = goutil.findChild(mainGo, "root/imgHead")
	local imgHead_icon = goutil.findChild(mainGo, "root/imgHead/icon")

	GameUtil.rmClickHandler(imgHead)
	self:_unLoadBigBg(imgHead_icon)
end

function FarnasextView:_onClickPartCell(stageId)
	self._selectStageId = stageId

	self:_onUpdatePartColUI()
	self:_onUpdateRuleColUI()

	self._txtStage.text = string.format("第%s关", stageId)

	local isPass = FarnasController.instance:isPassOfExtStage(self._activityId, stageId)

	GameUtil.SetGray(self._btnChallengeimgGo, isPass)
end

function FarnasextView:_onClickbtnChallenge()
	if self._selectStageId <= 0 then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	local result, tips = FarnasController.instance:getTryFightExtClgResultAndTips(self._activityId, self._selectStageId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	FarnasController.instance:enterBattleOfExtClg(self._activityId, self._selectStageId)
end

function FarnasextView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			bgGo:GetComponent(goutil.Type_UIImage).material = self._maskTempMat

			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function FarnasextView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function FarnasextView:_onUpdateRuleColUI()
	self:_updateLockPets()

	local stageCfg = FarnasConfig.instance:getExtStageCfg(self._activityId, self._selectStageId)

	self._txtTarget.text = string.format("我方精灵闪避总次数达到%s", stageCfg.dodgeCount)
	self._txtEnemyBuff.text = stageCfg.enemyBuffDesc
	self._txtMyBuff.text = self:_getMyBuffDesc()
end

function FarnasextView:_updateLockPets()
	local allLockedRaceId = FarnasController.instance:getLockedRaceIdOfExtStage(self._activityId, self._selectStageId)

	self._petScrollList:reloadData(allLockedRaceId)
	self._petScrollList:MoveCellInView(0, true)

	local isEmpty = #allLockedRaceId <= 0

	GameUtil.SetActive(self._ruleCol_petCol, not isEmpty)
	GameUtil.SetActive(self._ruleCol_imgPetEmpty, isEmpty)
end

function FarnasextView:_onClearRuleCol()
	self._petScrollList:dispose()
end

function FarnasextView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function FarnasextView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function FarnasextView:_onClickBtnTip()
	local key = FarnasConfig.instance:getRuleKey(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

function FarnasextView:_onClickBtnRefresh()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	local result, tips = FarnasController.instance:getTryRefreshExtClgResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	if self._selectStageId <= 0 then
		return
	end

	local tipsContent = "是否重置挑战记录，解锁本关封印的精灵，我方加成会降低"

	local function okFunc()
		FarnasChallengeAgent.instance:sendPM_FarnasClgResetExtremeClgReq(self._activityId, self._selectStageId)
	end

	local function cencelFunc()
		return
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", alignment)
end

function FarnasextView:_onClickBtnPrizeGet()
	local result, tips = FarnasController.instance:getTryGetPrizeExtClgResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end
end

function FarnasextView:_getMyBuffDesc()
	local lockNum = FarnasModel.instance:getAllLockNums(self._activityId)
	local cfg = FarnasConfig.instance:getExtBuff(self._activityId, lockNum)

	if cfg then
		return cfg.desc
	end

	return "暂无加成"
end

function FarnasextView:_onClickbtnMyDetail()
	UIStateManager.instance:push(ViewName.FarnasextbuffdetailView, self._activityId)
end

function FarnasextView:_setRole()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._conGo, nil, nil, true, nil, nil)
end

function FarnasextView:_getSkinId()
	return FarnasConfig.instance:getSkinId(self._activityId)
end

return FarnasextView
