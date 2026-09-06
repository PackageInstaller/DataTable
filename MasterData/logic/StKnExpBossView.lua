-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBossView.lua

module("logic.extensions.stknexp.view.StKnExpBossView", package.seeall)

local StKnExpBossView = class("StKnExpBossView", ViewComponent)

function StKnExpBossView:ctor()
	StKnExpBossView.super.ctor(self)
end

function StKnExpBossView:buildUI()
	StKnExpBossView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnMining = self:getGo("btnCol/btnMining")
	self._btnBuff = self:getGo("btnCol/btnBuff")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._txtDesc = self:getTxt("infoCol/txtDesc")
	self._imgPass = self:getGo("infoCol/fmt/imgPass")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")

	local buffScrView = self:getGo("infoCol/buffCol/scrView")
	local buffScrCell = self:getGo("infoCol/buffCol/scrCell")

	self._buffScrollList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollerClipGo = self:getGo("prizeCol/scrView/Viewport")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txt")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnSimulate = self:getGo("infoCol/btnSimulate")
	self._btnClg = self:getGo("infoCol/btnClg/btn")
	self._txtTimesClg = self:getTxt("infoCol/btnClg/times/txt")
end

function StKnExpBossView:bindEvents()
	StKnExpBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSimulate, self._onClickBtnSimulate, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnMining, self._onClickBtnMining, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function StKnExpBossView:unbindEvents()
	StKnExpBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSimulate)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnMining)
	GameUtil.rmClickHandler(self._btnBuff)
end

function StKnExpBossView:onEnter()
	StKnExpBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._actData = StKnExpConfig.instance:getActData(self._activityId)
	self._zoneData = StKnExpConfig.instance:getZoneData(self._activityId, self._zoneId)

	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SaintKnightExpeditionBossBuffSelect, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionGainBossPrizeRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = self._zoneData.skinId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)

				self:_onUpdate()
			end
		end
	end
end

function StKnExpBossView:onExit()
	StKnExpBossView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClearPrizeCol()
	self._buffScrollList:dispose()
end

function StKnExpBossView:_onUpdate()
	self:_onUpdatePrizeCol()

	self._txtDesc.text = self._zoneData.bossDesc

	local islandBuffIdList = {}
	local maxBuffNum = self._subMo:getMaxBossBuffNum()
	local selectBuffIdList = self._subMo:getSelectBuffsInZone(self._zoneId)

	for idx = 1, maxBuffNum do
		islandBuffIdList[idx] = selectBuffIdList[idx] or 0
	end

	self._buffScrollList:reloadData(islandBuffIdList)

	local cur = self._subMo:getDailyBossTimes(self._zoneId)
	local max = self._subMo:getMaxDailyBossTimes(self._zoneId)
	local left = Mathf.Max(max - cur, 0)

	self._txtTimesClg.text = string.format("%s/%s", left, max)

	local zoneData = StKnExpConfig.instance:getZoneData(self._activityId, self._zoneId)

	if zoneData then
		if not zoneData.creepsMasterId then
			local creepsMasterId = 0
			local creepsCfg = StKnExpConfig.instance:getCreepsCfg(creepsMasterId) or {}

			for posId = 1, self._fmtView.transform.childCount do
				local go = self._fmtView.transform:GetChild(posId - 1)
				local mask = goutil.findChild(go, "mask")
				local icon = goutil.findChild(go, "mask/icon")
				local creepsData

				for _, cData in ipairs(creepsCfg) do
					if cData.posId == posId then
						creepsData = cData

						break
					end
				end

				GameUtil.SetActive(mask, creepsData ~= nil)

				if creepsData then
					local petMo = FightingPowerPetMo.New()

					petMo:fromChallengeCreepCo(creepsData, creepsCfg)

					petMo.creepName = creepsData.creepName

					MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId)
					GameUtil.addClickHandler(go, function()
						CommonTipsMgr.instance:showPetTips(petMo)
					end)
				else
					MaterialMgr.clearIcon(icon)
				end
			end
		end
	end
end

function StKnExpBossView:_updateBuffCell(view, cell, islandBuffId, tag)
	local data = StKnExpConfig.instance:getIslandBuffClientData(self._activityId, islandBuffId)

	if data then
		if not data.skinId then
			local skinId = 0
			local isEmpty = data == nil
			local mainGo = cell.gameObject
			local icon = goutil.findChild(mainGo, "icon")
			local tagAdd = goutil.findChild(mainGo, "tagAdd")

			if skinId > 0 then
				MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
			else
				MaterialMgr.clearIcon(icon)
			end

			GameUtil.SetActive(icon, not isEmpty)
			GameUtil.SetActive(tagAdd, isEmpty)
			GameUtil.addClickHandler(mainGo, function()
				UIStateManager.instance:push(ViewName.StKnExpBuffSelectView, self._activityId, self._zoneId)
			end)
		end
	end
end

function StKnExpBossView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function StKnExpBossView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = MmUtil.formatNumber(curProgress, MmUtil.Units_CN)
end

function StKnExpBossView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function StKnExpBossView:_getProgressDataList()
	return StKnExpConfig.instance:getBossPrizeCfg(self._activityId, self._zoneId) or {}
end

function StKnExpBossView:_getSliderComp()
	return self._sliderComp
end

function StKnExpBossView:_getScrollClipGo()
	return self._prizeScrollerClipGo
end

function StKnExpBossView:_getCurProgress()
	return self._subMo:getTotalDamage(self._zoneId)
end

function StKnExpBossView:_getProgressByData(data)
	return checknumber(data.damage)
end

function StKnExpBossView:_getPrizeIdByData(data)
	return data.prizeId
end

function StKnExpBossView:_getPrizeStrByData(data)
	return data.prize
end

function StKnExpBossView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeInBoss(self._zoneId, prizeId)
end

function StKnExpBossView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrizeInBoss(self._zoneId, prizeId)
end

function StKnExpBossView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrizeInBoss(self._zoneId, prizeId)
end

function StKnExpBossView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local clipGo = self:_getScrollClipGo()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = MmUtil.formatNumber(progress, MmUtil.Units_CN)
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, clipGo, true, nil, nil)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function StKnExpBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function StKnExpBossView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	StKnExpController.instance:sendPM_SaintKnightExpeditionGainBossPrizeReq(self._activityId, self._zoneId, prizeId)
end

function StKnExpBossView:_onClickBtnSimulate()
	StKnExpController.instance:enterBattleInBoss(self._activityId, self._zoneId, true)
end

function StKnExpBossView:_onClickBtnClg()
	if not self._subMo:isEnoughBossTimes(self._zoneId) then
		FloatWordMgr.instance:show("剩余挑战次数不足")

		return
	end

	local function successFunc()
		StKnExpController.instance:enterBattleInBoss(self._activityId, self._zoneId, false)
	end

	local maxBuffNum = self._subMo:getMaxBossBuffNum()
	local selectBuffIdList = self._subMo:getSelectBuffsInZone(self._zoneId)
	local activeBuffNum = self._subMo:getActiveBuffNum()
	local fitNum = Mathf.Min(activeBuffNum, maxBuffNum)

	if fitNum > #selectBuffIdList then
		local key = string.format("StKnExpBoss_EnterClg_%s", self._activityId)

		if not GameUtil.getUserDayData(key) then
			local togText = lang("今日不再提示")
			local title = lang("提示")
			local text = lang("当前仍有圣骑祝福可先选择，是否放弃且进入战斗布阵？")

			local function funcTog()
				GameUtil.saveUserDayData(key, true)
			end

			TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, successFunc, funcTog, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
		else
			successFunc()
		end
	else
		successFunc()
	end
end

function StKnExpBossView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.StKnExpRankTabFatherView, self._activityId, StKnExpEnum.ClgType_Boss, self._zoneId)
end

function StKnExpBossView:_onClickBtnMining()
	UIStateManager.instance:push(ViewName.StKnExpMiningView, self._activityId)
end

function StKnExpBossView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.StKnExpBuffSelectView, self._activityId, self._zoneId)
end

return StKnExpBossView
