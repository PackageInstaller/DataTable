-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianNormalView.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianNormalView", package.seeall)

local DivineDiShiTianNormalView = class("DivineDiShiTianNormalView", ViewComponent)

function DivineDiShiTianNormalView:ctor()
	DivineDiShiTianNormalView.super.ctor(self)
end

function DivineDiShiTianNormalView:buildUI()
	DivineDiShiTianNormalView.super.buildUI(self)

	self._rectTrans = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._slider = self:getSlider("slider")
	self._txtNum = self:getTxt("slider/Fill Area/Fill/point/txtNum")
	self._rewardGo = self:getGo("reward/node")
	self._canGet = self:getGo("reward/canGet")
	self._geted = self:getGo("reward/geted")
	self._txtRule = self:getTxt("explain/txt")

	local levelsGo = self:getGo("levels")
	local level1 = self:getGo("levels/level1")

	for i = 2, 3 do
		goutil.cloneAndSetParent(level1, levelsGo.transform, "level" .. i)
	end

	self._levelList = {}

	for i = 1, 3 do
		local levelGo = goutil.findChild(levelsGo, "level" .. i)
		local element = {}

		element.go = levelGo
		element.passGo = goutil.findChild(levelGo, "pass")
		element.btnChallenge = goutil.findChild(levelGo, "btnChallenge")

		local fmtList = {}

		for j = 1, 9 do
			local item = {}

			item.go = goutil.findChild(levelGo, string.format("fmt/cell_%d", j))
			item.con = goutil.findChild(levelGo, string.format("fmt/cell_%d/con", j))

			table.insert(fmtList, item)
		end

		element.fmtList = fmtList

		table.insert(self._levelList, element)
	end

	local recordPos = levelsGo:GetComponent(typeof(TestRecordPos))

	recordPos:LoadPlan(0)

	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineDiShiTianNormalView:bindEvents()
	DivineDiShiTianNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._levelList) do
		GameUtil.addClickHandler(v.btnChallenge, GameUtil.handler(self._onClickChallenge, self, i))
	end
end

function DivineDiShiTianNormalView:unbindEvents()
	DivineDiShiTianNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._levelList) do
		GameUtil.rmClickHandler(v.btnChallenge)
	end
end

function DivineDiShiTianNormalView:onEnter()
	DivineDiShiTianNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineDiShiTianClgGainNormalPrizeRes, self._onGainNormalPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._activityType = DivineDiShiTianClgModel.instance:getActivityType()
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self:_updatePlayerScore()
	self:_initLevels()
	self:_initReward()
	self:_initRuleDesc()
end

function DivineDiShiTianNormalView:onExit()
	DivineDiShiTianNormalView.super.onExit(self)
	self:_clearLevels()
	self:_clearReward()
end

function DivineDiShiTianNormalView:_onGainNormalPrizeRes()
	self:_updatePlayerScore()
	self:_updateReward()
end

function DivineDiShiTianNormalView:_onClickChallenge(index)
	local isPass = DivineDiShiTianClgModel.instance:isPassNormalStage(self._activityId, index)

	if isPass then
		FloatWordMgr.instance:show("已通关")
	elseif self._cfgNormalStage then
		DivineDiShiTianClgController.instance:openMissionView(self._activityId, index, self._cfgNormalStage.creepsMasterIds[index])
	end
end

function DivineDiShiTianNormalView:_initLevels()
	local day = GameUtil.getDaysByTimestamp(self._startTime, ServerTime.now())

	self._cfgNormalStage = DivineDiShiTianClgConfig.instance:getNormalStageCfgByDay(self._activityId, day)

	printInfo("test DivineDiShiTianNormalView:_initLevels", day, self._cfgNormalStage.day)

	for i, v in ipairs(self._levelList) do
		GameUtil.SetActive(v.passGo, DivineDiShiTianClgModel.instance:isPassNormalStage(self._activityId, i))

		local creepsMasterId = self._cfgNormalStage.creepsMasterIds[i]
		local cfgCreeps = DivineDiShiTianClgConfig.instance:getCreeps(creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = v.fmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.7, 0.7, 0.7)
				self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

				local bagPetMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end
		end
	end
end

function DivineDiShiTianNormalView:_clearLevels(cell)
	for i1, v1 in ipairs(self._levelList) do
		for i1, v2 in ipairs(v1.fmtList) do
			MaterialMgr.resetAll(v2.con)
			goutil.setActive(v2.go, false)
		end
	end
end

function DivineDiShiTianNormalView:_updatePlayerScore()
	local curProgress = DivineDiShiTianClgModel.instance:getRewardProgress(self._activityId)
	local cfg = self:_getPrizeCfg()
	local maxProgress = cfg.number

	self._txtPlayerScore.text = string.format("%d/%d", curProgress, maxProgress)

	local percent = Mathf.Clamp01(curProgress / maxProgress)

	self._slider:SetValue(percent)

	self._txtNum.text = curProgress
end

function DivineDiShiTianNormalView:_onClickItem()
	local cfg = self:_getPrizeCfg()
	local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)
	local progress = DivineDiShiTianClgModel.instance:getRewardProgress(self._activityId)

	if DivineDiShiTianClgModel.instance:isPlayerRewardCanGet(self._activityId, cfg.prizeId, cfg.number) then
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgGainNormalPrizeReq(self._activityId, cfg.prizeId)
	elseif not goutil.isNil(self._rewardGo) then
		CommonTipsMgr.instance:openMaterialTips(self._rewardGo, matType, id, 0)
	end
end

function DivineDiShiTianNormalView:_initReward()
	local cfg = self:_getPrizeCfg()
	local proxy = MaterialMgr.setCellByCfg(cfg.prize, self._rewardGo)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		self:_onClickItem()
	end)
	self:_playEffect()
	self:_updateReward()
end

function DivineDiShiTianNormalView:_getPrizeCfg()
	local prizeList = DivineDiShiTianClgConfig.instance:getNormalPrizeList(self._activityId)

	return prizeList[1]
end

function DivineDiShiTianNormalView:_updateReward()
	local cfg = self:_getPrizeCfg()
	local isGeted = DivineDiShiTianClgModel.instance:isPlayerRewardGeted(self._activityId, cfg.prizeId)
	local progress = DivineDiShiTianClgModel.instance:getRewardProgress(self._activityId)
	local isCanGet = DivineDiShiTianClgModel.instance:isPlayerRewardCanGet(self._activityId, cfg.prizeId, cfg.number)

	GameUtil.SetActive(self._canGet, isCanGet)
	GameUtil.SetActive(self._geted, isGeted)
end

function DivineDiShiTianNormalView:_clearReward()
	MaterialMgr.resetAll(self._rewardGo)
	self:_clearEffect()
end

function DivineDiShiTianNormalView:_playEffect()
	self:_clearEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._canGet.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rectTrans) then
			eff:setClipping(self._rectTrans)
		end
	end)

	uiEffect:setParent(self._canGet.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect = uiEffect
end

function DivineDiShiTianNormalView:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DivineDiShiTianNormalView:_initRuleDesc()
	self._txtRule.text = DivineDiShiTianClgConfig.instance:getCommonValue("NORMAL_RULE_DESC")
end

return DivineDiShiTianNormalView
