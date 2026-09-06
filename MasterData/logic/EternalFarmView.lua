-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmView.lua

module("logic.extensions.eternalfarm.view.EternalFarmView", package.seeall)

local EternalFarmView = class("EternalFarmView", ViewComponent)

function EternalFarmView:ctor()
	EternalFarmView.super.ctor(self)
end

function EternalFarmView:unbindEvents()
	EternalFarmView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRewrad)
	GameUtil.rmClickHandler(self._btnPlant)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnActive)
	GameUtil.rmClickHandler(self._btnAccelerate)
	GameUtil.rmClickHandler(self._btnCloseRule)
end

function EternalFarmView:bindEvents()
	EternalFarmView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRewrad, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnPlant, self._onClickPlant, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOnKey, self)
	GameUtil.addClickHandler(self._btnActive, self._onClickActive, self)
	GameUtil.addClickHandler(self._btnAccelerate, self._onClickAccelerate, self)
	GameUtil.addClickHandler(self._btnCloseRule, self._onClickRuleClose, self)
	GameUtil.addClickHandler(self._btnGotoLeftYard, self._onClickGotoLeftYard, self)
	GameUtil.addClickHandler(self._btnGotoRightYard, self._onClickGotoRightYard, self)
	GameUtil.addClickHandler(self._btnAllPlant, self._onClickBtnAllPlant, self)
	GameUtil.addClickHandler(self._btnChangeShop, self._onClickBtnChangeShop, self)
end

function EternalFarmView:buildUI()
	EternalFarmView.super.buildUI(self)

	self._rule = self:getGo("rule")
	self._btnActive = self:getGo("plant")
	self._shopCon = self:getGo("btnShop/con")
	self._rewardCon = self:getGo("btnReward/effect")
	self._redPoint = self:getGo("btnShop/redPoint")
	self._dailyReceive = self:getGo("btnReward/receive")
	self._txtTime = self:getTxt("time/txt")
	self._btnTip = self:getBtn("btnTip")
	self._btnShop = self:getBtn("btnShop")
	self._btnClose = self:getBtn("btnClose")
	self._btnRewrad = self:getBtn("btnReward")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnCloseRule = self:getBtn("rule/btnClose")
	self._btnPlant = self:getBtn("plant/btnPlant")
	self._btnAccelerate = self:getBtn("plant/btnAccelerate")
	self._btnAllPlant = self:getGo("btnAllPlant")
	self._redPointAllPlant = self:getGo("btnAllPlant/redPoint")
	self._btnChangeShop = self:getGo("btnChangeShop")
	self._coinbar = self:getGo("coinbars")
	self._billboards = self:getGo("billboards")
	self._btnGotoLeftYard = self:getGo("btnGotoLeftYard")
	self._btnGotoRightYard = self:getGo("btnGotoRightYard")
	self._redPointLeft = self:getGo("btnGotoLeftYard/redPoint")
	self._redPointRight = self:getGo("btnGotoRightYard/redPoint")
	self._bg3 = self:getGo("bg3")
	self._bg2 = self:getGo("bg2")
	self._billboardList = {}

	for i = 1, self._billboards.transform.childCount do
		local billboard = {}

		billboard.go = goutil.findChild(self._billboards, "zone" .. i .. "_billboard")
		billboard.txtBillboard = goutil.findChildTextComponent(billboard.go, "txtBillboard")

		table.insert(self._billboardList, billboard)
	end

	self._multipleTip = self:getGo("multipleTip")
	self._tagEmptyMultipleTip = self:getGo("multipleTip/tagEmpty")
	self._props = self:getGo("multipleTip/props")
	self._propCells = {}

	for idx = 1, self._props.transform.childCount do
		local mainGo = self._props.transform:GetChild(idx - 1).gameObject

		table.insert(self._propCells, mainGo)
	end
end

function EternalFarmView:onExit()
	EternalFarmView.super.onExit(self)
	EternalFarmController.instance:resetField()
	removetimer(self._refreshAccelerate, self)
	removetimer(self._refreshCrop, self)

	if self._rewardEffect then
		UIEffectManager.instance:stopEffect(self._rewardEffect)
	end

	for _, v in pairs(self._fieldCellCls) do
		for _, cell in pairs(v) do
			GameUtil.RemoveLua(cell, EternalFarmFieldCell)
		end
	end

	if self._effectList then
		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end

	for idx, cell in ipairs(self._propCells) do
		MaterialMgr.clearIcon(cell)
	end

	RedPointController.instance:unregRedPoint(self._redPoint)
end

function EternalFarmView:onEnter()
	EternalFarmView.super.onEnter(self)

	self._isShowRule = GameUtil.getUserData(ViewName.EternalFarmView)

	GameUtil.SetActive(self._rule, not self._isShowRule)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)
	self._yardId = 1

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EternalFarm, self._activityId)

	self._txtTime.text = string.format("%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	self:_initZone()
	GameUtil.SetActive(self._btnActive.gameObject, false)
	GameUtil.SetActive(self._dailyReceive, false)
	GameUtil.SetActive(self._btnOneKey.gameObject, false)
	self.addGEvent(self, GlobalNotify.EternalFarmGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EternalFarmGainTodayPrizeRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.EternalFarmFarming, self._farming, self)
	self.addGEvent(self, GlobalNotify.EternalFarmHarvest, self._refreshCrop, self)
	self.addGEvent(self, GlobalNotify.EternalFarmOneKey, self._onClickOnKey, self)
	self.addGEvent(self, GlobalNotify.EternalFarmHarvestRes, self._refreshHarvest, self)
	self.addGEvent(self, GlobalNotify.EternalFarmSowRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.EternalFarmUseFertilizerRes, self._accelerate, self)
	self.addGEvent(self, GlobalNotify.PM_EternalFarmOneKeySowRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.ItemGetViewDoClosed, self._refreshChangeYard, self)
	self:_sendGetInfoReq()

	self._selectFieldInfo = nil
	self._fieldCellCls = {}
	self._effectList = {}
	self._isFarming = false
	self._isHarvesting = false
	self._yardNum = EternalFarmConfig.instance:getYardNum(self._activityId)
	self._multipleZoneId = EternalFarmController.instance:getMultipleZoneId(self._activityId)

	self:_setMultiPleUI()
	self:_setChangeYardUI()
	self:_showGoldBar()
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_O19, RedPointModel.ID_ETERNAL_FARM_SELL)
end

function EternalFarmView:_setMultiPleUI()
	local zoneIdCount = #self._multipleZoneId

	for idx, cell in ipairs(self._propCells) do
		if idx <= zoneIdCount then
			local zoneId = self._multipleZoneId[idx]
			local cropCfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, zoneId)
			local matName = MaterialMgr.getMaterialsNameByCfg(cropCfg.commonPrize)
			local matType, matId, matNum = MaterialMgr.getMatParams(cropCfg.commonPrize)

			MaterialMgr.setIcon(cell, matType, matId, nil, nil)
			GameUtil.SetActive(cell, true)
		else
			MaterialMgr.clearIcon(cell)
			GameUtil.SetActive(cell, false)
		end
	end

	GameUtil.SetActive(self._props, zoneIdCount > 0)
	GameUtil.SetActive(self._tagEmptyMultipleTip, zoneIdCount <= 0)
end

function EternalFarmView:_setChangeYardUI()
	GameUtil.SetActive(self._btnGotoRightYard, true)
	GameUtil.SetActive(self._btnGotoLeftYard, false)
end

function EternalFarmView:_sendGetInfoReq()
	EternalFarmController.instance:sendPM_EternalFarmInfoReq(self._activityId)
end

function EternalFarmView:_showGoldBar()
	for i, cfg in ipairs(self._zoneCfg) do
		local coinBarGo = self:getGo("coinbars/coin_" .. i)
		local coinIcon = self:getGo("coinbars/coin_" .. i .. "/icon")
		local txtNum = self:getTxt("coinbars/coin_" .. i .. "/txtNum")
		local cropCfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, i)
		local matType, matId, matNum = MaterialMgr.getMatParams(cropCfg.commonPrize)

		MaterialMgr.setIcon(coinIcon, matType, matId)

		txtNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)

		GameUtil.SetActive(coinBarGo, cfg.showYardId == self._yardId)
	end
end

function EternalFarmView:_initZone()
	self._zoneData = {}
	self._zoneCfg = EternalFarmConfig.instance:getZoneCfg(self._activityId)

	for _, cfg in ipairs(self._zoneCfg) do
		local zone = {}

		zone.go = self:getGo("zone_" .. cfg.zoneId)
		zone.field = self:getGo("zone_" .. cfg.zoneId .. "/field")
		zone.lock = self:getGo("zone_" .. cfg.zoneId .. "/lock")
		zone.txtLock = self:getTxt("zone_" .. cfg.zoneId .. "/lock/txt")

		table.insert(self._zoneData, zone)
		GameUtil.SetActive(zone.lock, true)
		GameUtil.SetActive(zone.field, false)
		GameUtil.SetActive(zone.go, cfg.showYardId == self._yardId)

		zone.txtLock.text = EternalFarmController.instance:lockCondition(self._activityId, cfg.zoneId)
	end

	for i = 1, #self._zoneCfg do
		local cfg = self._zoneCfg[i]
		local billboard = self._billboardList[i]

		GameUtil.SetActive(billboard.go, cfg.showYardId == self._yardId)

		billboard.txtBillboard.text = cfg.name or ""
	end
end

function EternalFarmView:_refreshZone()
	for zoneId, zone in ipairs(self._zoneData) do
		local isUnLock = EternalFarmController.instance:isUnLock(zoneId)
		local zoneInfo = EternalFarmModel.instance:getZoneInfoById(zoneId)

		GameUtil.SetActive(zone.lock, not isUnLock)
		GameUtil.SetActive(zone.field, isUnLock)

		if isUnLock then
			local fieldCount = EternalFarmConfig.instance:getZoneCfgById(self._activityId, zoneId).indexNum

			if self._fieldCellCls[zoneId] == nil then
				self._fieldCellCls[zoneId] = {}
			end

			for indexId = 1, fieldCount do
				local cropInfo = EternalFarmModel.instance:getCropInfoById(zoneId, indexId)
				local cls
				local go = goutil.findChild(zone.field.transform, "cell_" .. indexId)

				if go then
					self._fieldCellCls[zoneId][indexId] = go

					GameUtil.AddLuaOnce(go, EternalFarmFieldCell):init(cropInfo)
				end
			end
		end
	end
end

function EternalFarmView:_refresh()
	self._isHarvesting = false

	self:_showGoldBar()
	self:_refreshZone()
	self:_refreshCrop()

	if self._isShowRule then
		self:_refreshDailyReward()
	end

	self:_refreshChangeYard()
end

function EternalFarmView:_refreshChangeYard()
	local canGainCropItems = self:getAllOneKeyPlantItems()
	local canHarvestYardIds = self:getCanHarvestYardIds()
	local nextYardId = self:_getNextYardId(1)
	local preYardId = self:_getNextYardId(-1)

	GameUtil.SetActive(self._bg, self._yardId ~= 2)
	GameUtil.SetActive(self._bg2, self._yardId == 2)
	GameUtil.SetActive(self._bg3, self._yardId == 2)
	GameUtil.SetActive(self._redPointAllPlant, #canGainCropItems > 0)
	GameUtil.SetActive(self._redPointLeft, table.indexof(canHarvestYardIds, preYardId))
	GameUtil.SetActive(self._redPointRight, table.indexof(canHarvestYardIds, nextYardId))
end

function EternalFarmView:_refreshCrop()
	local isCanGain = EternalFarmController.instance:isCanGainCrop()
	local curYardCanHarvest = self:getCanHarvestZoneIds()

	GameUtil.SetActive(self._btnOneKey.gameObject, isCanGain and not self._isFarming and #curYardCanHarvest > 0)

	if isCanGain then
		removetimer(self._refreshCrop, self)
	end
end

function EternalFarmView:_accelerate()
	settimer(0.6, self._refreshAccelerate, self, false)
end

function EternalFarmView:_refreshAccelerate()
	self:_sendGetInfoReq()
	removetimer(self._refreshAccelerate, self)
end

function EternalFarmView:_refreshDailyReward()
	local isGainDaily = EternalFarmModel.instance:isGainDailyReward()

	if self._rewardEffect then
		UIEffectManager.instance:stopEffect(self._rewardEffect)
	end

	if not isGainDaily then
		local path = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self._rewardEffect = UIEffectManager.instance:playEffect(self, path, self._rewardCon, 0, 0, true, nil, nil, function(target, eff)
			eff:setClipping(self._rewardCon:GetComponent(goutil.Type_RectTransform))
		end, self)

		self._rewardEffect:setParent(self._rewardCon.transform)
		self._rewardEffect:setLocalPos(0, 0, 0)
		self._rewardEffect:setScale(1)
	end

	GameUtil.SetActive(self._dailyReceive, isGainDaily)
end

function EternalFarmView:_onClickTip()
	TipsFacade.instance:openRulesView("eternalfram_rule")
end

function EternalFarmView:_onClickShop()
	UIStateManager.instance:push(ViewName.EternalFarmShopView)
end

function EternalFarmView:_onClickReward()
	if EternalFarmModel.instance:isGainDailyReward() then
		FloatWordMgr.instance:show("今日奖励已领取哦~")

		return
	end

	EternalFarmController.instance:sendPM_EternalFarmGainTodayPrizeReq(self._activityId)
end

function EternalFarmView:_farming(state, info)
	self._isFarming = true

	GameUtil.SetActive(self._btnActive.gameObject, true)
	GameUtil.SetActive(self._btnOneKey.gameObject, false)
	GameUtil.SetActive(self._btnPlant.gameObject, state == 1)
	GameUtil.SetActive(self._btnAccelerate.gameObject, state == 2)
end

function EternalFarmView:_cancelFarming()
	local selectZoneId, selectIndexId = EternalFarmModel.instance:getSelectId()
	local cls = GameUtil.GetLua(self._fieldCellCls[selectZoneId][selectIndexId], EternalFarmFieldCell)

	cls:cancelFarming()
end

function EternalFarmView:_refreshHarvest()
	local ultimateCropCount = EternalFarmController.instance:ultimateCropCount()

	if ultimateCropCount > 0 then
		UIStateManager.instance:push(ViewName.EternalFarmLuckyView)
	end

	local needRefreshField = EternalFarmModel.instance:getRefreshField()

	for _, field in ipairs(needRefreshField) do
		local cls = GameUtil.GetLua(self._fieldCellCls[field.zoneId][field.indexId], EternalFarmFieldCell)

		cls:init(field)
	end

	self:_sendGetInfoReq()
end

function EternalFarmView:_onClickPlant()
	self._isFarming = false

	GameUtil.SetActive(self._btnActive.gameObject, false)

	local selectZoneId, selectIndexId = EternalFarmModel.instance:getSelectId()
	local cfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, selectZoneId)
	local matType, matId = MaterialMgr.getMatParams(cfg.seed)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local seedCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if seedCount <= 0 then
		local tipStr = string.format("%s数量不足，无法播种哦~", matName)

		FloatWordMgr.instance:show(tipStr)
		self:_cancelFarming()
		self:_refreshCrop()

		return
	end

	EternalFarmController.instance:sendPM_EternalFarmSowReq(self._activityId, selectZoneId, selectIndexId, cfg.cropId)
	self:_refreshCrop()
end

function EternalFarmView:_onClickOnKey()
	local curCanHarvestZoneIds = self:getCanHarvestZoneIds()

	EternalFarmController.instance:sendPM_EternalFarmHarvestReq(self._activityId, curCanHarvestZoneIds)
end

function EternalFarmView:_onClickActive()
	self._isFarming = false

	GameUtil.SetActive(self._btnActive.gameObject, false)
	self:_cancelFarming()
	self:_refreshCrop()
end

function EternalFarmView:_onClickAccelerate()
	self._isFarming = false

	local selectZoneId, selectIndexId = EternalFarmModel.instance:getSelectId()
	local cfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, selectZoneId)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.fertilizer)
	local fertilizerCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	GameUtil.SetActive(self._btnActive.gameObject, false)

	if fertilizerCount <= 0 or fertilizerCount < matNum then
		FloatWordMgr.instance:show("肥料数量不足，无法加速哦~")
		self:_cancelFarming()

		return
	end

	EternalFarmController.instance:sendPM_EternalFarmUseFertilizerReq(self._activityId, selectZoneId, selectIndexId)

	local cls = GameUtil.GetLua(self._fieldCellCls[selectZoneId][selectIndexId], EternalFarmFieldCell)
	local parent = cls:getEffectGo()

	self:_playEffect(parent)
end

function EternalFarmView:_playEffect(parent)
	local effectPath = "20230825/yonghengguodu/fx_yonghengnongchang_jiasu.prefab"

	self._effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, false, nil, nil, nil, self)

	self._effect:setParent(parent.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
	table.insert(self._effectList, self._effect)
end

function EternalFarmView:_onClickRuleClose()
	GameUtil.saveUserData(ViewName.EternalFarmView, true)

	self._isShowRule = true

	GameUtil.SetActive(self._rule, false)
	self:_refreshDailyReward()
end

function EternalFarmView:_onClickGotoLeftYard()
	self:_changeYard(1)
	self:_refresh()
	GameUtil.SetActive(self._btnGotoRightYard, true)
	GameUtil.SetActive(self._btnGotoLeftYard, false)
end

function EternalFarmView:_onClickGotoRightYard()
	self:_changeYard(-1)
	self:_refresh()
	GameUtil.SetActive(self._btnGotoRightYard, false)
	GameUtil.SetActive(self._btnGotoLeftYard, true)
end

function EternalFarmView:_onClickBtnAllPlant()
	local openPlantView = 1

	UIStateManager.instance:push(ViewName.EternalFarmShopView, openPlantView)
end

function EternalFarmView:_onClickBtnChangeShop()
	local actCfg = EternalFarmConfig.instance:getActCfgById(self._activityId)

	if actCfg.jumpTo == nil then
		printError("缺少配置jumpTo字段，请dd策划大佬")
	end

	GotoMgr.gotoByString(actCfg.jumpTo)
end

function EternalFarmView:_changeYard(delta)
	local afterChangeNum = self._yardId + delta

	afterChangeNum = afterChangeNum > 0 and afterChangeNum or self._yardNum
	self._yardId = afterChangeNum <= self._yardNum and afterChangeNum or afterChangeNum % self._yardNum

	EternalFarmController.instance:setYardId(self._yardId)
	self:_initZone()
end

function EternalFarmView:_getNextYardId(delta)
	local afterChangeNum = self._yardId + delta

	afterChangeNum = afterChangeNum > 0 and afterChangeNum or self._yardNum

	return afterChangeNum <= self._yardNum and afterChangeNum or afterChangeNum % self._yardNum
end

function EternalFarmView:getAllOneKeyPlantItems()
	local itemList = {}

	for _, cfg in ipairs(self._zoneCfg) do
		if cfg.showYardId == self._yardId then
			local zoneId = cfg.zoneId
			local indexNum = cfg.indexNum
			local cropCfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, zoneId)
			local matType, matId = MaterialMgr.getMatParams(cropCfg.seed)
			local seedCount = MaterialModel.instance:getMaterialsNumber(matType, matId)
			local cropId = cropCfg.cropId

			for idx = 1, indexNum do
				local cls = GameUtil.GetLua(self._fieldCellCls[zoneId][idx], EternalFarmFieldCell)
				local fieldGrowpState = cls:fieldGrowpState()

				if fieldGrowpState == EternalFarmModel.FieldState.Empty and seedCount > 0 then
					local oneKeySowItem = {}

					oneKeySowItem.zoneId = zoneId
					oneKeySowItem.indexId = idx
					oneKeySowItem.cropId = cropId

					table.insert(itemList, oneKeySowItem)

					seedCount = seedCount - 1
				end
			end
		end
	end

	return itemList
end

function EternalFarmView:getCanHarvestYardIds()
	local yardIdList = {}

	for _, cfg in ipairs(self._zoneCfg) do
		local zoneId = cfg.zoneId
		local indexNum = cfg.indexNum

		for idx = 1, indexNum do
			local cls = EternalFarmController.instance:getField(zoneId, idx)
			local fieldGrowpState = cls:fieldGrowpState()

			if fieldGrowpState == EternalFarmModel.FieldState.Mature and not table.indexof(yardIdList, cfg.showYardId) then
				table.insert(yardIdList, cfg.showYardId)
			end
		end
	end

	return yardIdList
end

function EternalFarmView:getCanHarvestZoneIds()
	local zoneIdList = {}

	for _, cfg in ipairs(self._zoneCfg) do
		local zoneId = cfg.zoneId
		local indexNum = cfg.indexNum
		local cropCfg = EternalFarmConfig.instance:getCropCfgById(self._activityId, zoneId)

		if cfg.showYardId == self._yardId then
			for idx = 1, indexNum do
				local cls = EternalFarmController.instance:getField(zoneId, idx)

				if cls then
					local fieldGrowpState = cls:fieldGrowpState()

					if fieldGrowpState == EternalFarmModel.FieldState.Mature and not table.indexof(zoneIdList, cfg.zoneId) then
						table.insert(zoneIdList, cfg.zoneId)
					end
				end
			end
		end
	end

	return zoneIdList
end

return EternalFarmView
