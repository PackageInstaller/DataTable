-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossMissionView.lua

module("logic.extensions.worldboss.view.WorldBossMissionView", package.seeall)

local WorldBossMissionView = class("WorldBossMissionView", MissionView)

function WorldBossMissionView:buildUI()
	WorldBossMissionView.super.buildUI(self)

	self._fmtRightRect = self:getGo("FmtRight"):GetComponent("RectTransform")

	local parentNode = self.mainGO
	local res = rescache:GetResourceNoLoadIfNotExists("ui/views/worldboss/worldbossmissionview.prefab")
	local mainAsset = res:GetMainAsset()

	self._worldBossNode = goutil.cloneAndSetParent(mainAsset, parentNode.transform, "WorldBossNode")
	self._btnClearTiredGo = goutil.findChild(self._worldBossNode, "btnClearTired")
	self._btnClearTired = Framework.UIClickTrigger.Get(self._btnClearTiredGo)
	self._itemClearTired = goutil.findChild(self._worldBossNode, "btnClearTired/itemClearTired")
	self._txtClearTiredValue = goutil.findChildTextComponent(self._worldBossNode, "btnClearTired/txtClearTiredValue")
	self._clickMask = goutil.findChild(self._worldBossNode, "ClickMask")
	self._txtClearTiredRemind = goutil.findChild(self._worldBossNode, "txtClearTiredRemind")

	local tiredRes = rescache:GetResourceNoLoadIfNotExists("ui/views/worldboss/worldbosstiredview.prefab")

	mainAsset = tiredRes:GetMainAsset()
	self._worldBossTriedNode = goutil.cloneAndSetParent(mainAsset, parentNode.transform, "WorldBossTriedNode")

	local _btnTired = goutil.findChild(self._worldBossTriedNode, "imgTired")

	WorldBossController.instance:setBtnTiredGo(_btnTired)
end

function WorldBossMissionView:bindEvents()
	WorldBossMissionView.super.bindEvents(self)
	self._btnClearTired:AddClickListener(self._onClickClearTired, self)
end

function WorldBossMissionView:unbindEvents()
	WorldBossMissionView.super.unbindEvents(self)
	self._btnClearTired:RemoveClickListener()
end

function WorldBossMissionView:onEnter()
	self._rightTeamInfoRectTrans:SetAsLastSibling()
	goutil.findChildComponent(self.mainGO, "Nego_Left", "RectTransform"):SetAsLastSibling()

	self._fightType = self:getFirstParam()

	local bossId = WorldBossController.instance:getTodayBossId()

	BulletScreenModel.instance:setEnum(GameEnum.BulletScene.Formation)
	BulletScreenModel.instance:setKey(string.format("wb_%s", bossId))
	self:onEnterInherit()
	self._clickMask:SetActive(false)
	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._isReady = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_updateClearTiredValue()
	self:_updateItem()
	self:_updateTiredInfo()
	self:_setDescStr("世界魔王")
	MissionModel.instance:setForceResetOneKey(true)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateClearTiredValue, self)
	GlobalDispatcher:addListener(GlobalNotify.WorldBossMedicine, self._updateTiredInfo, self)
	FastFormation.instance:setGetCurPetList(function()
		return WorldBossModel.instance:getAllShowPetList()
	end)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function WorldBossMissionView:onEnterFinished()
	self:_procLRTxt()

	local _enemyTeamInfo = WorldBossController.instance:getEnemyTeamInfo(WorldBossController.instance:getTodayBossId())
	local ruleDesc = _enemyTeamInfo.description

	self:_setDescStr(nil, nil, ruleDesc)
	self:setRuleDesc()
end

function WorldBossMissionView:onExit()
	WorldBossMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateClearTiredValue, self)
	GlobalDispatcher:removeListener(GlobalNotify.WorldBossMedicine, self._updateTiredInfo, self)
end

function WorldBossMissionView:_updateTiredInfo()
	local _bossInfo = WorldBossController.instance:getWorldBossInfo()

	if not _bossInfo then
		return
	end

	local _, _itemNum = WorldBossController.instance:getMedicineItemInfo()
	local _commonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()

	if _commonConfig.CLEAR_UNLOCK_SWITCH.value ~= "FALSE" and _bossInfo.lockPetIds and #_bossInfo.lockPetIds > 0 and (_itemNum > 0 or ShopModel.instance:getGoodsCount(801) > 0) then
		self._txtClearTiredRemind.gameObject:SetActive(true)
		self._btnClearTiredGo:SetActive(true)
	else
		self._txtClearTiredRemind.gameObject:SetActive(false)
		self._btnClearTiredGo:SetActive(false)
		MissionModel.instance:setForceResetOneKey(true)
	end
end

function WorldBossMissionView:_onClickClearTired()
	WorldBossController.instance:onClickClearTired()
end

function WorldBossMissionView:_updateClearTiredValue()
	local _, _itemNum = WorldBossController.instance:getMedicineItemInfo()

	self._txtClearTiredValue.text = _itemNum or 0
end

function WorldBossMissionView:_updateItem()
	local _itemInfo, _itemNum = WorldBossController.instance:getMedicineItemInfo()

	if not _itemInfo or not _itemNum then
		return
	end

	MaterialMgr.resetAll(self._itemClearTired)

	local proxy = MaterialMgr.setCellByCfg(_itemInfo .. ":" .. _itemNum, self._itemClearTired)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
end

function WorldBossMissionView:_startNow()
	WorldBossMissionView.super._startNow(self)

	local _bossId = WorldBossController.instance:getTodayBossId()

	BattleFacade.instance:startWorldBoss(_bossId)
end

function WorldBossMissionView:_onClickStart()
	if self._isReady then
		return
	end

	WorldBossMissionView.super._onClickStart(self)
end

function WorldBossMissionView:_onMissionBattleResBack(status)
	WorldBossMissionView.super._onMissionBattleResBack(self, status)

	if status ~= 0 and not goutil.isNil(self._clickMask) then
		self._clickMask:SetActive(false)
	end
end

function WorldBossMissionView:_enterBattle()
	if self._isReady then
		return
	end

	self._clickMask:SetActive(WorldBossController.instance:isInBossCanFightTime())

	self._isReady = true

	if not WorldBossController.instance:isInBossCanFightTime() then
		FloatWordMgr.instance:show(lang("world_Boss_tip14"))
		self:_onClickClose()
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.WroldBoss, nil)

	if self._fightType == WorldBossController.FightTypeChallenge then
		WorldBossAgent.instance:sendPM_WorldBossChallengeReq()
	else
		WorldBossAgent.instance:sendPM_WorldBossSimulateChallengeReq()
	end
end

function WorldBossMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(pet)
		if WorldBossController.instance:isLockPetIds(pet.petId) then
			return false
		end

		return true
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function WorldBossMissionView:_getCurFormation()
	return WorldBossModel.instance:_getCurFormation()
end

return WorldBossMissionView
