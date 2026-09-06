-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityGameView.lua

module("logic.extensions.guardcity.view.GuardCityGameView", package.seeall)

local GuardCityGameView = class("GuardCityGameView", ViewComponent)

GuardCityGameView.OrderSilerPath = 4
GuardCityGameView.LoadListMax = 1

function GuardCityGameView:ctor()
	GuardCityGameView.super.ctor(self)
end

function GuardCityGameView:buildUI()
	GuardCityGameView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnCancelHelp = self:getBtn("btnCanelHelp")
	self._btnRule = self:getBtn("btnRule")
	self._goldBarCon = self:getGo("goldBar")
	self._matBarCon = self:getGo("matBarCon")
	self._txtRefreshCost = self:getTxt("btnRefresh/cost")
	self._refreshCostBg = self:getGo("btnRefresh/costBg")
	self._conRefreshCost = self:getGo("btnRefresh/cost/con")
	self._txtRefreshFree = self:getTxt("btnRefresh/costFree")
	self._txtScore = self:getTxt("score/txtScore")
	self._scorcCon = self:getGo("score/txtScore/scoreIcon")
	self._txtCost = self:getTxt("goldBarCon/costTabCell/TxtC_Num")
	self._btnAddCost = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/Btn_Add"))
	self._btnShowCostTip = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/showTipRaycast"))
	self._costTip = self:getGo("goldBarCon/costTip")
	self._customInput = UICustomInput.Get(self._costTip)
	self._points = self:getGo("points")
	self._pathGos = {}

	for i = 1, self._points.transform.childCount do
		local go = self:getGo("points/path_" .. i)
		local recordPos = go:GetComponent("TestRecordPos")
		local group = ItemGroup.New(go)

		self._pathGos[i] = {
			go = go,
			recordPos = recordPos,
			group = group
		}
	end

	self._cityGo = self:getGo("city")
	self._imgChangeCity = goutil.findChildComponent(self.mainGO, "city", "UIImageSpriteChange")
	self._masters = self:getGo("masters")
	self._masterCon = self:getGo("masters/masterCon")
	self._masterGroup = ItemGroup.New(self._masters, self._masterCon)
	self._hpContent = self:getGo("hpContent")
	self._hpCell = self:getGo("hpContent/imgHp")
	self._hpItemGroup = ItemGroup.New(self._hpContent, self._hpCell)
	self._txtCostTip = self:getTxt("goldBarCon/costTip/txtTip")
	self._tipHelpGo = self:getGo("helpTip")
	self._effcetGo = self:getGo("effect")
end

function GuardCityGameView:bindEvents()
	GuardCityGameView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnCancelHelp, self._onClickCancelHelp, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
end

function GuardCityGameView:unbindEvents()
	GuardCityGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnCancelHelp)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	self._customInput:RemoveListener()
end

function GuardCityGameView:onEnter()
	GuardCityGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityRefreshRes, self._PM_GuardCityRefreshRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityGameMasterLoadEnd, self._onLoadMastersEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityConveneFriendRes, self._PM_GuardCityConveneFriendRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)

	self._activityId = self:getFirstParam()
	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)
	self._pathsCfg = GuardCityConfig.instance:getPathCfgs(self._actCfg.pathPlanId)

	for i, v in ipairs(self._pathsCfg) do
		self._pathGos[i].group:updateWithLen(v.pathLength, self._updatePathPoint, self)
		self._pathGos[i].recordPos:LoadPlan(0)
	end

	self._effects = {}

	local rounEffectPath = "20230303/zhounianqing/fx_ui_zhounianqing_fengwei.prefab"

	self._effects.round = UIEffectManager.instance:playEffect(self, rounEffectPath, nil, 0, 0, true)

	self._effects.round:setParent(self._effcetGo.transform)
	self._effects.round:setScale(1)
	self._effects.round:setLocalPos(0, 0, 0)

	self._roleObjs = {}
	self._tweeners = {}
	self._moveTween = {}

	self:_refreshHelpStatu()
	self:_setTopGoldBar()
	GameUtil.SetActive(self._costTip, false)
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)

	local scoreMatType, scoreMatId, num = MaterialMgr.getMatParams(self._actCfg.scoreMaterials)

	MaterialMgr.setIcon(self._scorcCon, scoreMatType, scoreMatId)
end

function GuardCityGameView:onEnterFinished()
	if not GuardCiytModel.instance:getOpenRuleFlage() then
		GuardCiytModel.instance:saveOpenRuleFlag()
		self:_onClickRule()
	end
end

function GuardCityGameView:onExit()
	GuardCityGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityRefreshRes, self._PM_GuardCityRefreshRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityGameMasterLoadEnd, self._onLoadMastersEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityConveneFriendRes, self._PM_GuardCityConveneFriendRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)

	for i, v in pairs(self._effects) do
		UIEffectManager.instance:stopEffect(v)

		v = nil
	end

	for i, v in pairs(self._moveTween) do
		v:removeListener()

		v = nil
	end

	self._masterGroup:dispose(self._clearPetCon, self)
	self._hpItemGroup:dispose()

	for i, v in ipairs(self._pathGos) do
		v.group:dispose()
	end

	for i, v in pairs(self._roleObjs) do
		RoleObjectPool.instance:removeRole(v)
	end

	for i, v in pairs(self._tweeners) do
		v:Kill()
	end

	removetimer(self._onClockCost, self)
	MaterialMgr.resetAll(self._scorcCon)
end

function GuardCityGameView:_refreshView()
	local maxTime = GuardCityConfig.instance:getCommonValue("DAILY_FREE_REFRESH_TIMES", true)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshMaterials)

	if maxTime >= GuardCiytModel.instance:getRefreshTimes() then
		GameUtil.SetActive(self._refreshCostBg, true)
		GameUtil.SetActive(self._txtRefreshCost, false)
		GameUtil.SetActive(self._txtRefreshFree, true)

		self._txtRefreshFree.text = langPara("（%d/%d）", maxTime - GuardCiytModel.instance:getRefreshTimes(), maxTime)
	else
		GameUtil.SetActive(self._refreshCostBg, false)
		GameUtil.SetActive(self._txtRefreshCost, false)
		GameUtil.SetActive(self._txtRefreshFree, false)

		self._txtRefreshCost.text = matNum

		MaterialMgr.resetAll(self._conRefreshCost)
		MaterialMgr.setIcon(self._conRefreshCost, matType, matId)
	end

	self._txtScore.text = langPara("守护积分：<color=#FFD87CFF>%d</color>", GuardCiytModel.instance:getCurScore())
	self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))

	for i, v in pairs(self._moveTween) do
		v:removeListener()

		v = nil
	end

	if GuardCityController.instance:getIsFromBattle() == true then
		self:_onBattleEnter()
	else
		self:_refreshCurView()
	end

	self:_onClockCost()
	removetimer(self._onClockCost, self)
	settimer(1, self._onClockCost, self, true)
end

function GuardCityGameView:_refreshCurView()
	local info = GuardCiytModel.instance:getAllMasterInfo()
	local masterList = {}

	for i, v in pairs(info or {}) do
		table.insert(masterList, v)
	end

	for i, v in pairs(self._roleObjs) do
		RoleObjectPool.instance:removeRole(v)
	end

	self._roleObjs = {}
	self._masterLoadCount = 0
	self._needLoadCount = #masterList

	self._masterGroup:updateWithMoArray(masterList, self._updateMasterCell, self)

	local itemList = self._masterGroup:getItems()

	for i = 1, #itemList do
		local maxYGo = itemList[i].mainGO
		local targetindex = i

		for j = i + 1, #itemList do
			local maxYGoPos = GameUtil.getAnchoredPos(maxYGo)
			local tagGoPos = GameUtil.getAnchoredPos(itemList[j].mainGO)

			if maxYGoPos.y > tagGoPos.y then
				maxYGo = itemList[j].mainGO
				targetindex = j
			end
		end

		maxYGo.transform:SetAsFirstSibling()

		itemList[i] = itemList[targetindex]
		itemList[targetindex] = itemList[i]
	end

	self._curHp = GuardCiytModel.instance:getCurCityHp()
	self._hpDisappearList = {}

	self:updataHpView(self._curHp)
end

function GuardCityGameView:_onBattleEnter()
	self._needMove = {}
	self._needAttack = {}
	self._deadCon = nil

	local preData = GuardCiytModel.instance:getPreData()

	self._isInAmin = true

	local isKillBoss = GuardCityController.instance:getIsKillBoss()
	local attackId = checknumber(GuardCityController.instance:getAttackId())
	local masterList = {}

	for i, v in pairs(preData.masterInfo) do
		table.insert(masterList, v)
	end

	for i, v in pairs(self._roleObjs) do
		RoleObjectPool.instance:removeRole(v)
	end

	self._roleObjs = {}

	self._masterGroup:updateWithMoArray(masterList, self._updateMasterCell, self)

	local items = self._masterGroup:getItems()

	if not GuardCityController.instance:getIsWin() and not GuardCityController.instance:getIsFail() then
		for i, masterInfo in ipairs(masterList) do
			if masterInfo.pos ~= 1 and (not isKillBoss or checknumber(masterInfo.masterUniqueId) ~= attackId) then
				local fromPoint = self:_getPathGo(masterInfo.pathId, masterInfo.pos)
				local toPoint = self:_getPathGo(masterInfo.pathId, masterInfo.pos - 1)

				table.insert(self._needMove, {
					go = items[i].mainGO,
					form = fromPoint,
					to = toPoint
				})
			end
		end
	end

	for i, masterInfo in ipairs(masterList) do
		if masterInfo.pos == 1 and (not isKillBoss or checknumber(masterInfo.masterUniqueId) ~= attackId) then
			table.insert(self._needAttack, {
				go = items[i].mainGO
			})
		end

		if checknumber(masterInfo.masterUniqueId) == attackId and isKillBoss == true then
			self._deadCon = items[i].mainGO
		end
	end

	self._masterLoadCount = 0
	self._needLoadCount = #masterList
	self._curHp = preData.cityHp
	self._hpDisappearList = {}

	self:updataHpView(self._curHp)
end

function GuardCityGameView:_onMoveStart()
	if GuardCityController.instance:getIsKillBoss() == true and self._deadCon and self._deadCon then
		self:playAnimation(self._deadCon, "die", false, function()
			GameUtil.SetActive(self._deadCon, false)
		end, true)
	end

	for i, v in ipairs(self._needMove) do
		UnityTweens.TweenPosition.StartTween(v.go, GameUtil.getAnchoredPos(v.form), GameUtil.getAnchoredPos(v.to), 0.3, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
	end

	if self._deadCon then
		settimer(2, self._onMoveEnd, self, false)
	elseif #self._needMove > 0 then
		settimer(1, self._onMoveEnd, self, false)
	else
		self:_onMoveEnd()
	end
end

function GuardCityGameView:_onMoveEnd()
	self._needAttackCount = 0

	for i, v in pairs(self._moveTween) do
		v:removeListener()

		v = nil
	end

	for i, v in ipairs(self._needAttack) do
		self._needAttackCount = self._needAttackCount + 1

		local moveTween = UnityTweens.TweenPosition.StartTween(v.go, GameUtil.getAnchoredPos(v.go), GameUtil.getAnchoredPos(self._cityGo), 0.3, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

		moveTween:RemoveListener()
		moveTween:AddListener(function()
			local lastHp = self._curHp

			self._curHp = self._curHp - 1

			if self._curHp < 0 then
				self._curHp = 0
			end

			self:updataHpView(lastHp)
			self:playAnimation(v.go, "die", false, function()
				self._needAttackCount = self._needAttackCount - 1

				self:_onAttackCount()
				GameUtil.SetActive(v.go, false)
			end, true)

			self._moveTween[self._needAttack] = nil

			moveTween:RemoveListener()
		end)

		self._moveTween[self._needAttack] = moveTween
	end

	if #self._needAttack > 0 then
		-- block empty
	else
		self:_onAttackEnd()
	end
end

function GuardCityGameView:_onAttackEnd()
	if GuardCityController.instance:getIsWin() == true then
		self:_onGameRoundEnd()
	elseif GuardCityController.instance:getIsFail() == true then
		self:_onGameRoundEnd()
	else
		self:_onTurnNextRoundEnd()
	end
end

function GuardCityGameView:_onGameRoundEnd()
	self._effects.changeMap = UIEffectManager.instance:playEffect(self, "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_yun.prefab", nil, 0, 0, false)

	self._effects.changeMap:setParent(self._effcetGo.transform)
	self._effects.changeMap:setScale(1)
	self._effects.changeMap:setLocalPos(0, 0, 0)
	self:_onTurnNextRoundEnd()
end

function GuardCityGameView:_onTurnNextRoundEnd()
	GuardCityController.instance:onEndBattleAnim()
	GameUtil.SetActive(self._deadCon, false)

	self._deadCon = nil
	self._isInAmin = false
	self._needMove = {}
	self._needAttack = {}

	self:_refreshCurView()
end

function GuardCityGameView:_onClickRefresh()
	if self._isInAmin == true then
		return
	end

	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help then
		FloatWordMgr.instance:show(lang("请先退出求助模式"))

		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityRefresh)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshMaterials)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) == true or GuardCiytModel.instance:getRefreshTimes() < GuardCityConfig.instance:getCommonValue("DAILY_FREE_REFRESH_TIMES", true) then
		local content = "刷新后好友收到的协助邀请也将被清空 本关卡也将结束是否继续？"

		TipsFacade.instance:openPopupWindow(lang("tip"), lang(content), function()
			GuardCityAgent.instance:sendPM_GuardCityRefreshReq(GuardCiytModel.instance:getCurActId())
		end)
	else
		FloatWordMgr.instance:show(lang("今日刷新次数已用完"))
	end
end

function GuardCityGameView:_onClickClose()
	if self._isInAmin == true then
		return
	end

	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help then
		FloatWordMgr.instance:show(lang("请先退出求助模式"))

		return
	end

	self:close()
end

function GuardCityGameView:_onAttackCount()
	if checknumber(self._needAttackCount) <= 0 then
		settimer(0.2, self._onAttackEnd, self, false)
	end
end

function GuardCityGameView:_refreshHelpStatu()
	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help then
		GameUtil.SetActive(self._btnHelp, false)
		GameUtil.SetActive(self._btnCancelHelp, true)
		GameUtil.SetActive(self._tipHelpGo, true)
	else
		GameUtil.SetActive(self._btnHelp, true)
		GameUtil.SetActive(self._btnCancelHelp, false)
		GameUtil.SetActive(self._tipHelpGo, false)
	end
end

function GuardCityGameView:_updateMasterCell(cell, data, i)
	local go = cell.mainGO
	local status = goutil.findChildComponent(go, "status", "UIImageSpriteChange")
	local star = goutil.findChild(go, "star")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")
	local petCon = goutil.findChild(go, "petCon")
	local btnChallenge = GameUtil.asBtn(goutil.findChild(go, "btnChallenge"))
	local helpSend = goutil.findChild(go, "star/imgSend")
	local cfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, data.creepsMasterId)
	local creepsCfg = GuardCityConfig.instance:getCreepsCfg(data.creepsMasterId)

	txtStar.text = cfg.star
	go.name = "masterCon_" .. data.masterUniqueId

	local bossMaxHp = 0
	local bossCurHp = 0

	for i, v in pairs(creepsCfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}
		local monsterHp = checknumber(attrs[FightingPowerFormula.instance:getAttrTypeByName("生命")])

		bossMaxHp = bossMaxHp + monsterHp
		bossCurHp = not data.enemyStage[v.creepsId] and bossCurHp + monsterHp or bossCurHp + data.enemyStage[v.creepsId] * 0.0001 * monsterHp
	end

	local hp = math.ceil(bossCurHp / bossMaxHp * 100)

	if hp < 30 then
		status:SetState(0)
	elseif hp > 80 then
		status:SetState(2)
	else
		status:SetState(1)
	end

	if self._roleObjs[petCon] then
		RoleObjectPool.instance:removeRole(self._roleObjs[petCon])
	end

	local path = GameUrl.getLihuiSpineUIUrl(cfg.resName)

	self._roleObjs[petCon] = RoleObjectPool.instance:addSpineToParent(self._roleObjs[petCon], path, petCon, 0.015, function(go)
		self:_loadMasterEnd(go, petCon)

		self._masterLoadCount = checknumber(self._masterLoadCount) + 1

		if self._masterLoadCount >= self._needLoadCount then
			GlobalDispatcher:dispatch(GlobalNotify.GuardCityGameMasterLoadEnd)
		end
	end)

	local starPos = GameUtil.getLocalPos(star)

	if data.pathId >= GuardCityGameView.OrderSilerPath then
		GameUtil.setLocalScale(petCon, -3, 3, 3)
		GameUtil.setLocalPos(star, Mathf.Abs(starPos.x), starPos.y, starPos.z)
	else
		GameUtil.setLocalScale(petCon, 3, 3, 3)
		GameUtil.setLocalPos(star, -Mathf.Abs(starPos.x), starPos.y, starPos.z)
	end

	local pathGo = self:_getPathGo(data.pathId, data.pos)

	if pathGo then
		local pos = GameUtil.getPos(pathGo)

		GameUtil.setPos(go, pos.x, pos.y, pos.z)
	end

	UnityTweens.TweenPosition.StopTween(go)

	if self._tweeners[petCon] ~= nil then
		self._tweeners[petCon]:Kill()

		self._tweeners[petCon] = nil
	end

	GameUtil.setLocalPos(petCon, 0, 0, 0)

	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help and data.hadAttack == true then
		self._tweeners[petCon] = petCon.transform:DOPunchPosition(Vector3(5, 0, 0), 0.2, 0, 1, false)

		self._tweeners[petCon]:SetLoops(-1)

		if self._hadSendPetId[data.masterUniqueId] == true then
			GameUtil.SetActive(helpSend, true)
		else
			GameUtil.SetActive(helpSend, false)
		end
	else
		GameUtil.SetActive(helpSend, false)
	end

	btnChallenge:RemoveClickListener()
	btnChallenge:AddClickListener(function()
		self:_onClickPet(data.masterUniqueId)
	end)
end

function GuardCityGameView:_clearPetCon(cell)
	local go = cell.mainGO
	local btnChallenge = GameUtil.asBtn(goutil.findChild(go, "btnChallenge"))
	local petCon = goutil.findChild(go, "petCon")

	btnChallenge:RemoveClickListener()

	if self._roleObjs[petCon] then
		RoleObjectPool.instance:removeRole(self._roleObjs[petCon])

		self._roleObjs[petCon] = nil
	end
end

function GuardCityGameView:_loadMasterEnd(go, petCon)
	if go.activeInHierarchy then
		self:playAnimation(go, "idle", true, nil, false)
	else
		go.transform:SetParent(nil)
		self:playAnimation(go, "idle", true, nil, false)
		go.transform:SetParent(petCon.transform)
	end

	GoUtil.SetVisible(go, true)
end

function GuardCityGameView:playAnimation(go, animName, loop, callBack, reStart)
	if not go then
		return
	end

	local graphic = go:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if reStart then
				graphic.AnimationState:ClearTracks()
			end

			if ani ~= nil then
				graphic:Initialize(true)

				graphic.startingAnimation = animName

				graphic.AnimationState:SetAnimation(0, animName, loop)

				graphic.freeze = false

				graphic:Update(0)

				local onComplete

				function onComplete()
					GameUtil.callBack(callBack)

					graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
				end

				graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
			end
		end
	end
end

function GuardCityGameView:_onLoadMastersEnd()
	if self._isInAmin == true then
		settimer(0.5, self._onMoveStart, self, false)
	end

	self._needLoadCount = 0
	self._masterLoadCount = 0
end

function GuardCityGameView:_getPathGo(pathId, pos)
	if self._pathGos[pathId] then
		local groupItems = self._pathGos[pathId].group:getItems()

		if groupItems[pos] then
			return groupItems[pos].mainGO
		end
	end

	return nil
end

function GuardCityGameView:_updateHpCell(cell, i)
	local go = cell.mainGO
	local uiImageChange = go:GetComponent(ComponentType.UIImageColorChange)

	if i > self._curHp then
		uiImageChange:SetState(1)
	else
		uiImageChange:SetState(0)
	end

	local effectKey = "hpDisappearList_" .. i

	if self._hpDisappearList[i] == true and not self._effects[effectKey] then
		self._effects[effectKey] = UIEffectManager.instance:playEffect(self, "20230303/zhounianqing/fx_ui_zhounianqing_shuijinpo.prefab", self._effcetGo, 0, 0, false, nil, function()
			self._effects[effectKey] = nil
			self._hpDisappearList[i] = false
		end, function()
			self._effects[effectKey]:setParent(go.transform)
			self._effects[effectKey]:setLocalPos(0, 0, 0)
			self._effects[effectKey].effGo.transform:SetParent(self._effcetGo.transform, true)
			self._effects[effectKey]:setScale(1)
		end)

		if not self._effects.fail then
			self._effects.fail = UIEffectManager.instance:playEffect(self, "20230303/zhounianqing/fx_ui_zhounianqing_dianji.prefab", nil, 0, 0, false, nil, function()
				self._effects.fail = nil
			end)

			self._effects.fail:setParent(self._effcetGo.transform)
			self._effects.fail:setScale(1)
			self._effects.fail:setLocalPos(0, 0, 0)
		end
	end
end

function GuardCityGameView:updataHpView(lastHp)
	local maxHp = GuardCityConfig.instance:getCommonValue("CITY_HP_LIMIT", true)

	self._hpDisappearList = self._hpDisappearList or {}

	for i = self._curHp + 1, lastHp do
		self._hpDisappearList[i] = true
	end

	self._hpItemGroup:updateWithLen(maxHp, self._updateHpCell, self)

	if self._curHp <= 1 then
		self._imgChangeCity:SetState(2)
	elseif self._curHp <= 2 then
		self._imgChangeCity:SetState(1)
	else
		self._imgChangeCity:SetState(0)
	end
end

function GuardCityGameView:_onClickHelp()
	if self._isInAmin == true then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.GuardCityCon)

	self._readySendId = nil
	self._hadSendPetId = {}

	GuardCityController.instance:startHelp()
	self:_refreshHelpStatu()
	self:_refreshCurView()
end

function GuardCityGameView:_onClickCancelHelp()
	if self._isInAmin == true then
		return
	end

	self._readySendId = nil
	self._hadSendPetId = {}

	GuardCityController.instance:endHelp()
	self:_refreshHelpStatu()
	self:_refreshCurView()
end

function GuardCityGameView:_onClickRule()
	if self._isInAmin == true then
		return
	end

	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help then
		FloatWordMgr.instance:show(lang("请先退出求助模式"))

		return
	end

	UIStateManager.instance:open(ViewName.RulesView, GuardCityConfig.instance:getCommonValue("GAME_RULE_KEY", false), self._btnRule.gameObject)
end

function GuardCityGameView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._actCfg.refreshMaterials
	})
	MainUIController.instance:showGlodBar(self._matBarCon, self._viewPresentor, btn_list, false)
end

function GuardCityGameView:_onClickAddCost()
	if self._isInAmin == true then
		return
	end

	local times = GuardCiytModel.instance:getBuyStrengthTimesToday() + 1
	local buyCfgs = GuardCityConfig.instance:getBuyStrengthPlans(self._actCfg.strengthPurchasePlanId)

	if times > #buyCfgs then
		times = #buyCfgs
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(buyCfgs[times].cost)
	local privilege = MaterialModel.instance:IsEnough(MatType.ACTIVITY_ITEM, self._actCfg.privilegeMaterialId, 1)
	local privilegeTimes = GuardCityConfig.instance:getCommonValue("PRIVILEGE_FREE_TIMES", true)
	local usePrivilegeTimes = GuardCiytModel.instance:getPrivilegeBuyTimesToday()

	if privilege == true and usePrivilegeTimes < privilegeTimes then
		local content = langPara("每日前%d次恢复疲劳无需消耗\n（今日剩余次数：%d）", privilegeTimes, privilegeTimes - usePrivilegeTimes)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end)

		return
	end

	local content = langPara("花费%d%s购买%d疲劳", matNum, MaterialMgr.getMaterialsName(matType, matId), GuardCityConfig.instance:getCommonValue("STRENGTH_PURCHASE_RECOVERY", false))

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		if GuardCiytModel.instance:getBuyStrengthTimesToday() >= #buyCfgs then
			FloatWordMgr.instance:show(lang("无剩余次数"))
		elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
			FloatWordMgr.instance:show(lang("所需材料不足"))
		else
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end
	end)
end

function GuardCityGameView:_onClickPet(masterUniqueId)
	if self._isInAmin == true then
		return
	end

	local info = GuardCiytModel.instance:getMasterInfo(masterUniqueId)

	if GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Help then
		if info.hadAttack == true then
			GuardCityController.instance:readySendHelp(info.masterUniqueId)

			self._readySendId = info.masterUniqueId

			ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发起求助"))
		else
			FloatWordMgr.instance:show(lang("该恶灵未被挑战过不能进行分享"))
		end
	elseif GuardCityController.instance:getHelpMode() == GuardCityController.HMode_Default then
		UIStateManager.instance:push(ViewName.GuardCityChallengeView, self._activityId, info.masterUniqueId)
	end
end

function GuardCityGameView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function GuardCityGameView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function GuardCityGameView:_updatePathPoint(cell, index)
	local go = cell.mainGO

	go.name = "pointCell" .. index
end

function GuardCityGameView:_onClockCost()
	if GuardCiytModel.instance:getCurStrength() >= GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) then
		if self._txtCostTip then
			self._txtCostTip.text = langPara("每<color=#FFD87CFF>%dmin</color>恢复<color=#FFD87CFF>1</color>点\n疲劳已经达到上限", checkint(GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) / 60))
		end
	else
		local lack = GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) - GuardCiytModel.instance:getCurStrength()
		local needSec = lack * GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true)
		local targetTime = GuardCiytModel.instance:getStrengthStamp() + needSec - ServerTime.now()
		local nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()

		if nextTime <= 0 then
			GuardCityController.instance:onCostAutoChange()

			nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()
		end

		local totalDate = GameUtil.FormatTimeWords(targetTime)
		local nextDate = GameUtil.FormatTimeWords(nextTime, isNotHour)

		if self._txtCostTip then
			self._txtCostTip.text = langPara("下次恢复疲劳:%s\n完全恢复疲劳:%s", nextDate, totalDate)
		end
	end
end

function GuardCityGameView:_onMasterDeadByOther()
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
end

function GuardCityGameView:_onCostChange()
	if self._txtCost then
		self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))
	end
end

function GuardCityGameView:_PM_GuardCityConveneFriendRes()
	if checknumber(self._readySendId) > 0 then
		self._hadSendPetId[self._readySendId] = true
	end

	self._readySendId = nil

	if self._hadSendPetId then
		self:_refreshCurView()
	end
end

function GuardCityGameView:_PM_GuardCityRefreshRes()
	self._effects.changeMap = UIEffectManager.instance:playEffect(self, "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_yun.prefab", nil, 0, 0, false)

	self._effects.changeMap:setParent(self._effcetGo.transform)
	self._effects.changeMap:setScale(1)
	self._effects.changeMap:setLocalPos(0, 0, 0)
	self:_refreshView()
end

function GuardCityGameView:_PM_GuardCityBuyStrengthRes()
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
end

return GuardCityGameView
