-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmExtremeView.lua

module("logic.extensions.kingmengmeng.view.KingmmExtremeView", package.seeall)

local KingmmExtremeView = class("KingmmExtremeView", ViewComponent)

function KingmmExtremeView:ctor()
	KingmmExtremeView.super.ctor(self)
end

function KingmmExtremeView:buildUI()
	KingmmExtremeView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnElement = self:getBtn("element/btn")
	self._btnGuard = self:getBtn("guard/btn")
	self._btnBoss = self:getBtn("boss/btn")
	self._txtTime = self:getTxt("time/txt")
	self._txtElementNum = self:getTxt("element/txtNum")
	self._txtGuardNum = self:getTxt("guard/txtNum")
	self._passElement = self:getGo("element/pass")
	self._passGuard = self:getGo("guard/pass")
	self._passBoss = self:getGo("boss/pass")
	self._rewardCon = self:getGo("info/reward/con")
	self._effectGo = self:getGo("info/reward/effect")
	self._cellGo = self:getGo("info/cell")
	self._getedGo = self:getGo("info/reward/get")
	self._reward = self:getGo("info/reward")
	self._godPrizeTag = self:getGo("info/godPrizeTag")
	self.scrollerGo1 = self:getGo("info/tableview1")
	self.scrollList1 = ScrollerList.create(self.scrollerGo1, self._cellGo, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self.clearCell1, self))
	self.scrollerGo2 = self:getGo("info/tableview2")
	self.scrollList2 = ScrollerList.create(self.scrollerGo2, self._cellGo, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self.clearCell2, self))
	self._rectTrans = self:getGo("info"):GetComponent(goutil.Type_RectTransform)
	self._con = self:getGo("con")
end

function KingmmExtremeView:bindEvents()
	KingmmExtremeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnElement:AddClickListener(self._onClickElement, self)
	self._btnGuard:AddClickListener(self._onClickGuard, self)
	self._btnBoss:AddClickListener(self._onClickBoss, self)
end

function KingmmExtremeView:unbindEvents()
	KingmmExtremeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnElement:RemoveClickListener()
	self._btnGuard:RemoveClickListener()
	self._btnBoss:RemoveClickListener()
end

function KingmmExtremeView:onEnter()
	KingmmExtremeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._activityType = KingmmController.instance:getActivityType()

	local isInTime = KingmmController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._cfgActivity = KingmmConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_initGameObject()
	self:_updateChallengeProgress()
	self:_initBossReward()
	self:_updateBossRewardState()
	self:_showRoleModel()
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGetExtremeInfoRes, self._onGetExtremeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGainPassPrizeRes, self._onGainPassPrizeRes, self)
	self:_onGetExtremeInfoRes()
end

function KingmmExtremeView:onExit()
	KingmmExtremeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGetExtremeInfoRes, self._onGetExtremeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGainPassPrizeRes, self._onGainPassPrizeRes, self)
	self:_clearBossReward()
	self:_resetRoleModel()
	self.scrollList1:dispose()
	self.scrollList2:dispose()
end

function KingmmExtremeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "kingmmextremeview_rule")
end

function KingmmExtremeView:_onClickElement()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if KingmmModel.instance:isPassElement(self._activityId) or KingmmModel.instance:isPassBoss() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.KingmmLevelView, self._activityId, KingmmModel.ElementChallenge)
end

function KingmmExtremeView:_onClickGuard()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if KingmmModel.instance:isPassGuard(self._activityId) or KingmmModel.instance:isPassBoss() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.KingmmLevelView, self._activityId, KingmmModel.GuardChallenge)
end

function KingmmExtremeView:_onClickBoss()
	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	if KingmmModel.instance:isPassBoss() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	KingmmController.instance:openExtremeMissionView(self._activityId, KingmmModel.BossChallenge, 0, self._cfgActivity.bossMasterId)
end

function KingmmExtremeView:_onGetExtremeInfoRes()
	self:_updateChallengeProgress()
	self:_updateBuffInfo()
	self:_updateBossRewardState()
end

function KingmmExtremeView:_onGainPassPrizeRes()
	self:_updateBossRewardState()
end

function KingmmExtremeView:_initGameObject()
	goutil.setActive(self._effectGo, false)
	goutil.setActive(self._getedGo, false)
end

function KingmmExtremeView:_updateChallengeProgress()
	local maxElementCount = #KingmmConfig.instance:getElementCfgList(self._activityId)
	local maxGuardCount = #KingmmConfig.instance:getGuardCfgList(self._activityId)
	local curElementPassNum = KingmmModel.instance:getPassElementNum()
	local curGuardPassNum = KingmmModel.instance:getPassGuardNum()
	local isPassElement = maxElementCount <= curElementPassNum
	local isPassGuard = maxGuardCount <= curGuardPassNum
	local isPassBoss = KingmmModel.instance:isPassBoss()

	goutil.setActive(self._passElement, isPassElement or isPassBoss)
	goutil.setActive(self._passGuard, isPassGuard or isPassBoss)
	goutil.setActive(self._passBoss, isPassBoss)

	self._txtElementNum.text = string.format("已获得：%d/%d", curElementPassNum, maxElementCount)
	self._txtGuardNum.text = string.format("已击败：%d/%d", curGuardPassNum, maxGuardCount)
end

function KingmmExtremeView:_initBossReward()
	local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.bossPrize)
	local proxy = MaterialMgr.setCellByCfg(self._cfgActivity.bossPrize, self._rewardCon)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		if KingmmModel.instance:isCanGetPassPrize() then
			KingmmAgent.instance:sendPM_KMMChallengeGainPassPrizeReq(self._activityId)
		elseif not goutil.isNil(self._rewardCon) then
			CommonTipsMgr.instance:openMaterialTips(self._rewardCon, matType, id, 0)
		end
	end)
	proxy.binder:setGray(KingmmModel.instance:isGainPassPrize())

	self._proxy = proxy

	GameUtil.SetActive(self._reward, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._godPrizeTag, self._isAoqiGodProcessType)
end

function KingmmExtremeView:_clearBossReward()
	self._proxy = nil

	MaterialMgr.resetAll(self._rewardCon)
	self:_clearBossRewardEffect()
end

function KingmmExtremeView:_updateBossRewardState()
	local isGeted = KingmmModel.instance:isGainPassPrize()
	local isShowEffect = KingmmModel.instance:isCanGetPassPrize()

	if self._proxy then
		self._proxy.binder:setGray(isGeted)
	end

	if not self._effectGo.activeSelf and isShowEffect then
		self:_loadBossRewardEffect()
	end

	goutil.setActive(self._effectGo, isShowEffect)
	goutil.setActive(self._getedGo, isGeted)
end

function KingmmExtremeView:_loadBossRewardEffect()
	self:_clearBossRewardEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._effectGo.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rectTrans) then
			eff:setClipping(self._rectTrans)
		end
	end)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect = uiEffect
end

function KingmmExtremeView:_clearBossRewardEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function KingmmExtremeView:_updateBuffInfo()
	local list1 = KingmmConfig.instance:getElementCfgList(self._activityId)

	self.scrollList1:reloadData(list1)

	local list2 = KingmmConfig.instance:getGuardCfgList(self._activityId)

	self.scrollList2:reloadData(list2)
end

function KingmmExtremeView:_updateCell1(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local mask = goutil.findChild(cell, "mask")
	local txt = goutil.findChildTextComponent(cell, "mask/txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = "未激活"

	local isPassStage = KingmmModel.instance:isPassElementStage(data.stageId)

	goutil.setActive(mask, not isPassStage)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.buffIcon))
	btn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.KingmmExtremeBuffView, self._activityId, KingmmModel.ElementChallenge)
	end)
end

function KingmmExtremeView:clearCell1(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function KingmmExtremeView:_updateCell2(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local mask = goutil.findChild(cell, "mask")
	local txt = goutil.findChildTextComponent(cell, "mask/txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = "已失效"

	local isPassStage = KingmmModel.instance:isPassGuardStage(data.stageId)

	goutil.setActive(mask, isPassStage)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.buffIcon))
	btn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.KingmmExtremeBuffView, self._activityId, KingmmModel.GuardChallenge)
	end)
end

function KingmmExtremeView:clearCell2(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function KingmmExtremeView:_showRoleModel()
	local curFaceId = self._cfgActivity.raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function KingmmExtremeView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function KingmmExtremeView:_checkPassAoqiGodProcessResult()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return false
		end
	end

	return true
end

return KingmmExtremeView
