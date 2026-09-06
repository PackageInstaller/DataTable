-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianExtremeView.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianExtremeView", package.seeall)

local DivineDiShiTianExtremeView = class("DivineDiShiTianExtremeView", ViewComponent)

function DivineDiShiTianExtremeView:ctor()
	DivineDiShiTianExtremeView.super.ctor(self)
end

function DivineDiShiTianExtremeView:buildUI()
	DivineDiShiTianExtremeView.super.buildUI(self)

	self._rectTrans = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._rewardNode = self:getGo("reward/node")
	self._canGet = self:getGo("reward/canGet")
	self._geted = self:getGo("reward/geted")
	self._txtRule = self:getTxt("reward/txtDesc")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollerGo2 = self:getGo("tableview2")
	self.cellGo2 = self:getGo("tablecell2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineDiShiTianExtremeView:bindEvents()
	DivineDiShiTianExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function DivineDiShiTianExtremeView:unbindEvents()
	DivineDiShiTianExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.addClickHandler(self._btnReset)
end

function DivineDiShiTianExtremeView:onEnter()
	DivineDiShiTianExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineDiShiTianClgExtremeResetRes, self._onExtremeResetRes, self)
	self.addGEvent(self, GlobalNotify.DivineDiShiTianClgExtremeGainPrizeRes, self._onGainPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = DivineDiShiTianClgConfig.instance:getActivityCfg(self._activityId)
	self._curStepId = DivineDiShiTianClgModel.instance:getExtremeCurStep(self._activityId)
	self._curMaxStepId = DivineDiShiTianClgModel.instance:getCurMaxStep(self._activityId)

	self:_initReward()
	self:_initRuleDesc()
	self:_updateTabList()
	self:_updateStagesList()
end

function DivineDiShiTianExtremeView:onExit()
	DivineDiShiTianExtremeView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollList2:dispose()
	self:_clearReward()
end

function DivineDiShiTianExtremeView:_onClickReset()
	if DivineDiShiTianClgModel.instance:isPassExtremeAllStages(self._activityId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if not DivineDiShiTianClgModel.instance:isExtremeStepPassAnyOne(self._activityId, self._curStepId) then
		FloatWordMgr.instance:show("本层未通过任意关卡")

		return
	end

	local text = "是否将本层所有关卡重置为未挑战，所有精灵的血量重置为初始状态"

	TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgExtremeResetReq(self._activityId)
	end)
end

function DivineDiShiTianExtremeView:_onExtremeResetRes()
	self:_updateTabList()
	self:_updateStagesList()
end

function DivineDiShiTianExtremeView:_onGainPrizeRes()
	self:_updateReward()
end

function DivineDiShiTianExtremeView:_onClickItem()
	local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.extremeReward)

	if DivineDiShiTianClgModel.instance:isExtremeCanGetReward(self._activityId) then
		DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgExtremeGainPrizeReq(self._activityId)
	elseif not goutil.isNil(self._rewardNode) then
		CommonTipsMgr.instance:openMaterialTips(self._rewardNode, matType, id, 0)
	end
end

function DivineDiShiTianExtremeView:_initRuleDesc()
	self._txtRule.text = DivineDiShiTianClgConfig.instance:getCommonValue("EXTREME_RULE_DESC")
end

function DivineDiShiTianExtremeView:_initReward()
	local proxy = MaterialMgr.setCellByCfg(self._cfgActivity.extremeReward, self._rewardNode)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		self:_onClickItem()
	end)
	self:_playEffect()
	self:_updateReward()
end

function DivineDiShiTianExtremeView:_updateReward()
	local isGeted = DivineDiShiTianClgModel.instance:isExtremeGetedReward(self._activityId)
	local isCanGet = DivineDiShiTianClgModel.instance:isExtremeCanGetReward(self._activityId)

	GameUtil.SetActive(self._canGet, isCanGet)
	GameUtil.SetActive(self._geted, isGeted)
end

function DivineDiShiTianExtremeView:_clearReward()
	MaterialMgr.resetAll(self._rewardNode)
	self:_clearEffect()
end

function DivineDiShiTianExtremeView:_playEffect()
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

function DivineDiShiTianExtremeView:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DivineDiShiTianExtremeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "btn/txtDesc")
	local passGo = goutil.findChild(cell, "btn/pass")
	local lockGo = goutil.findChild(cell, "btn/lock")
	local txtLock = goutil.findChildTextComponent(cell, "btn/lock/txt")
	local uiChangeGroup = goutil.findChild(cell, "btn"):GetComponent(ComponentType.UIChangeGroup)

	txtDesc.text = string.format("第<size=42>%d</size>关", data.stepId)

	GameUtil.SetActive(passGo, self._curMaxStepId > data.stepId)
	uiChangeGroup:SetState(self._curMaxStepId == data.stepId and 1 or 0)

	local isOpenTime = ServerTime.now() >= GameUtil.string2time(data.openTime)
	local isLock = self._curMaxStepId < data.stepId or not isOpenTime

	GameUtil.SetActive(lockGo, isLock)

	if isLock then
		local date = GameUtil.string2date(data.openTime)

		txtLock.text = string.format("%02d.%02d\n05:00开启", date.month, date.day)
	end
end

function DivineDiShiTianExtremeView:_clearCell(cell)
	return
end

function DivineDiShiTianExtremeView:_updateCell2(view, cell, data, tag)
	local emptyFmtGo = goutil.findChild(cell, "emptyFmt")
	local fmtGo = goutil.findChild(cell, "fmt")
	local passGo = goutil.findChild(cell, "pass")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local isPass = DivineDiShiTianClgModel.instance:isExtremeStepPass(self._activityId, data.stepId, data.stageId)

	GameUtil.SetActive(passGo, isPass)
	GameUtil.addClickHandler(btnChallenge, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		DivineDiShiTianClgController.instance:openExtremeMissionView(self._activityId, data.stepId, data.stageId)
	end)

	if self._openCopy then
		GameUtil.SetActive(emptyFmtGo, true)
		GameUtil.SetActive(fmtGo, false)
	else
		GameUtil.SetActive(emptyFmtGo, false)
		GameUtil.SetActive(fmtGo, true)

		local fmtList = {}

		for i = 1, 9 do
			local item = {}

			item.go = goutil.findChild(cell, string.format("fmt/cell_%d", i))
			item.con = goutil.findChild(cell, string.format("fmt/cell_%d/con", i))
			item.tag = goutil.findChild(cell, string.format("fmt/cell_%d/tag", i))

			table.insert(fmtList, item)
		end

		for i, v in ipairs(fmtList) do
			MaterialMgr.resetAll(v.con)
			goutil.setActive(v.go, false)
			goutil.setActive(v.tag, false)
		end

		local cfgCreeps = DivineDiShiTianClgConfig.instance:getCreeps(data.creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = fmtList[cfgEnemy.posId]

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
				GameUtil.SetActive(item.tag, cfgEnemy.sign > 0)
			end
		end
	end
end

function DivineDiShiTianExtremeView:_clearCell2(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("fmt/cell_%d", i))
		local con = goutil.findChild(cell, string.format("fmt/cell_%d/con", i))
		local tag = goutil.findChild(cell, string.format("fmt/cell_%d/tag", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)
		goutil.setActive(go, false)
	end
end

function DivineDiShiTianExtremeView:_updateTabList()
	local cfgs = DivineDiShiTianClgConfig.instance:getExtremeStepList(self._activityId)

	self._scrollList:reloadData(cfgs)
end

function DivineDiShiTianExtremeView:_updateStagesList()
	local cfg = DivineDiShiTianClgConfig.instance:getExtremeStepCfg(self._activityId, self._curStepId)

	self._openCopy = cfg.openCopy

	local cfgs = DivineDiShiTianClgConfig.instance:getExtremeStageList(self._activityId, self._curStepId)

	self._scrollList2:reloadData(cfgs)

	local index = 1

	for i, v in ipairs(cfgs) do
		local isPass = DivineDiShiTianClgModel.instance:isExtremeStepPass(self._activityId, self._curStepId, v.stageId)

		if not isPass then
			index = i

			break
		end
	end

	self._scrollList2:MoveCellToCenter(index - 1)
end

return DivineDiShiTianExtremeView
