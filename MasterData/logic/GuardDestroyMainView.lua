-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyMainView.lua

module("logic.extensions.guarddestroy.view.GuardDestroyMainView", package.seeall)

local GuardDestroyMainView = class("GuardDestroyMainView", ViewComponent)

function GuardDestroyMainView:ctor()
	GuardDestroyMainView.super.ctor(self)
end

function GuardDestroyMainView:unbindEvents()
	GuardDestroyMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGetEqual)
	GameUtil.rmClickHandler(self._btnEqualTips)
	GameUtil.rmClickHandler(self._buffBuff)
end

function GuardDestroyMainView:bindEvents()
	GuardDestroyMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnGetEqual, self._onClickGetEqual, self)
	GameUtil.addClickHandler(self._btnEqualTips, self._onClickTip, self)
	GameUtil.addClickHandler(self._buffBuff, self._onClickBuff, self)
end

function GuardDestroyMainView:buildUI()
	GuardDestroyMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("rankInfo/btnRank")
	self._txtTime = self:getTxt("time/txtTime")
	self._guardProgressBar = self:getSlider("guardTableView/progressBar")
	self._guardTablecell = self:getGo("guardTablecell")
	self._guardTableView = self:getGo("guardTableView")
	self._guardTableViewport = self:getGo("guardTableView/viewport")
	self._guardTableList = ScrollerList.create(self._guardTableView, self._guardTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._guardTableList:regValueChanged(function(tableview)
		self:_onScrollValueChange(tableview, -0.00181, 0.2372, 147, "content", self._guardProgressBar, 1)
	end)

	self._destroyProgressBar = self:getSlider("destroyTableView/progressBar")
	self._destroyTableView = self:getGo("destroyTableView")
	self._destroyTablecell = self:getGo("destroyTablecell")
	self._destroyTableViewport = self:getGo("destroyTableView/viewport")
	self._destroyTableList = ScrollerList.create(self._destroyTableView, self._destroyTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._destroyTableList:regValueChanged(function(tableview)
		self:_onScrollValueChange(tableview, 0.00179, -0.2395, -120, "content", self._destroyProgressBar, 2)
	end)

	self._txtGuardScore = self:getTxt("guardScroe/txtScore")
	self._txtDestroyScore = self:getTxt("destroyScroe/txtScore")
	self._txtName = self:getTxt("rankInfo/txtName")
	self._firstHeadIcon = self:getGo("rankInfo/headIcon")
	self._equalItemCon = self:getGo("equalInfo/itemCon")
	self._btnEqualTips = self:getGo("equalInfo/btnEqualTips")
	self._equalReceived = self:getGo("equalInfo/received")
	self._equalEffect = self:getGo("equalInfo/effect")
	self._btnGetEqual = self:getGo("equalInfo/canGet")
	self._buffBuff = self:getGo("signBuff/btnBuff")
	self._txtBuff = self:getTxt("signBuff/txtBuff")
	self._redPointBuff = self:getGo("signBuff/redpoint")
end

function GuardDestroyMainView:onExit()
	GuardDestroyMainView.super.onExit(self)
	self._guardTableList:dispose()
	self._destroyTableList:dispose()
	self:_clearEffect(self._equalEffect)
	HeadItemController.instance:resetHeadCell(self._firstHeadIcon)

	self._guardScoreSliderOffset = nil
	self._destroySliderOffset = nil
end

function GuardDestroyMainView:onEnter()
	GuardDestroyMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GuardDestroyGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 474001
	end

	self._guardScoreSliderOffset = nil
	self._destroySliderOffset = nil
	self._activityCfg = GuardDestroyConfig.instance:getActivityCfg(self._activityId)

	GuardDestroyAgent.instance:sendPM_GuardDestroyGetInfoReq(self._activityId)
end

function GuardDestroyMainView:_refreshView()
	local list_1 = GuardDestroyConfig.instance:getProgressPrizeCfgs(self._activityId, 1)
	local list_2 = GuardDestroyConfig.instance:getProgressPrizeCfgs(self._activityId, 2)

	self._guardTableList:reloadData(list_1)
	self._destroyTableList:reloadData(list_2)

	local guardScore = GuardDestroyModel.instance:getProgress(self._activityId, 1)
	local destroyScore = GuardDestroyModel.instance:getProgress(self._activityId, 2)

	self._guardScoreSliderOffset = self:calcSliderOffset(guardScore, list_1, self._guardTableList:getView())
	self._destroySliderOffset = self:calcSliderOffset(destroyScore, list_2, self._destroyTableList:getView())
	self._txtGuardScore.text = guardScore
	self._txtDestroyScore.text = destroyScore
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.GuardDestroyClg, self._activityId)

	local canGetIndex = 0

	for i, v in ipairs(list_1) do
		if guardScore >= v.progress and not GuardDestroyModel.instance:getGainProgress(self._activityId, 1, v.prizeId) then
			canGetIndex = i
		end
	end

	if canGetIndex ~= 0 then
		self._guardTableList:MoveCellToCenter(canGetIndex - 1)
	end

	canGetIndex = 0

	for i, v in ipairs(list_2) do
		if destroyScore >= v.progress and not GuardDestroyModel.instance:getGainProgress(self._activityId, 2, v.prizeId) then
			canGetIndex = i
		end
	end

	if canGetIndex ~= 0 then
		self._destroyTableList:MoveCellToCenter(canGetIndex - 1)
	end

	self:_refreshEqualItem()
	self:_refreshRankInfo()

	local curBuffLevel = GuardDestroyModel.instance:getSignBuffLevel(self._activityId)
	local buffCfgs = GuardDestroyConfig.instance:getSignInBuffCfgs(self._activityCfg.signInPlanId)

	self._txtBuff.text = curBuffLevel == 0 and lang("未激活") or buffCfgs[curBuffLevel].desc

	GameUtil.SetActive(self._redPointBuff, not GuardDestroyModel.instance:isSignInDay(self._activityId) and curBuffLevel < #buffCfgs)
end

function GuardDestroyMainView:calcSliderOffset(score, list, tabelView)
	local reachIndex = 0

	for i, v in ipairs(list) do
		if score >= v.progress then
			reachIndex = i
		else
			break
		end
	end

	local nextRate = 99

	if list[reachIndex + 1] then
		if list[reachIndex] then
			if not list[reachIndex].progress then
				do
					local reachIndexProgressScore = 0

					nextRate = (score - reachIndexProgressScore) / (list[reachIndex + 1].progress - reachIndexProgressScore)
				end

				local tagetOffset = 0

				if reachIndex >= 1 then
					local cellOffset = tabelView:GetOffsetByIndex(reachIndex - 1)

					tagetOffset = cellOffset + tabelView.cellOffset.y + tabelView:GetOffset()

					if nextRate < 1 then
						local nextCellOffset = tabelView:GetOffsetByIndex(reachIndex) + tabelView.cellOffset.y + tabelView:GetOffset()

						tagetOffset = (nextCellOffset - tagetOffset) * nextRate + tagetOffset
					elseif nextRate == 0 then
						-- block empty
					else
						tagetOffset = tagetOffset + tagetOffset
					end
				end

				if tagetOffset ~= 0 then
					-- block empty
				end

				return tagetOffset
			end
		end
	end
end

function GuardDestroyMainView:getSliderOffset(type)
	if type == 1 then
		return self._guardScoreSliderOffset
	elseif type == 2 then
		return self._destroySliderOffset
	end

	return 0
end

function GuardDestroyMainView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local item = goutil.findChild(content, "item")
	local received = goutil.findChild(content, "received")
	local txtScore = goutil.findChildTextComponent(content, "txtScore")
	local txtGetScore = goutil.findChildTextComponent(content, "txtGetScore")
	local canGet = goutil.findChild(content, "canGet")
	local effect = goutil.findChild(content, "effect")
	local imgBg = goutil.findChild(content, "imgBg")
	local score = GuardDestroyModel.instance:getProgress(self._activityId, data.stageType)
	local isCanGet = score >= data.progress
	local isGainPrize = GuardDestroyModel.instance:getGainProgress(self._activityId, data.stageType, data.prizeId)

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%d", data.progress)
	txtGetScore.text = langPara("%d", data.progress)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	GameUtil.SetActive(txtScore, not isGainPrize)
	GameUtil.SetActive(txtGetScore, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect, data.stageType)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
	GameUtil.SetGray(imgBg, isGainPrize)
end

function GuardDestroyMainView:_onClickGetPrize(data)
	local isCanGet = GuardDestroyModel.instance:getProgress(self._activityId, data.stageType) >= data.progress
	local isGainPrize = GuardDestroyModel.instance:getGainProgress(self._activityId, data.stageType, data.prizeId)

	if isCanGet and not isGainPrize then
		GuardDestroyAgent.instance:sendPM_GuardDestroyGainProgressPrizeReq(self._activityId, data.stageType, data.prizeId)
	end
end

function GuardDestroyMainView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local content = goutil.findChild(go, "content")
	local effect = goutil.findChild(content, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function GuardDestroyMainView:_playEffect(effGo, type)
	self:_clearEffect(effGo)

	local uiEffect

	if type == 1 then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
			eff:setClipping(self._guardTableViewport.transform)
		end)
	elseif type == 2 then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
			eff:setClipping(self._destroyTableViewport.transform)
		end)
	else
		local effPath = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

		uiEffect = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true)
	end

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function GuardDestroyMainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function GuardDestroyMainView:_refreshEqualItem()
	local isCanGet = GuardDestroyModel.instance:isCanGainEqualPrize(self._activityId)
	local isGainPrize = GuardDestroyModel.instance:getGainEqualPrize(self._activityId)

	GameUtil.SetActive(self._btnGetEqual, isCanGet and not isGainPrize)
	GameUtil.SetActive(self._equalReceived, isGainPrize)
	self:_clearEffect(self._equalEffect)

	if isCanGet and not isGainPrize then
		self:_playEffect(self._equalEffect, 0)
	end

	MaterialMgr.resetAll(self._equalItemCon)
	MaterialMgr.setCellByCfg(self._activityCfg.balancePrize, self._equalItemCon)
end

function GuardDestroyMainView:_refreshRankInfo()
	local firstRankInfo = GuardDestroyModel.instance:getFirstRankInfo(self._activityId)

	if firstRankInfo then
		self._txtName.text = firstRankInfo.headInfo.userName

		HeadItemController.instance:resetHeadCell(self._firstHeadIcon)

		local proxy = HeadItemController.instance:setHeadCellByInfo(self._firstHeadIcon, firstRankInfo.headInfo)

		if proxy then
			proxy:setCallBack(function()
				if firstRankInfo.headInfo.userId then
					self:_onHeadClick(firstRankInfo.headInfo.userId, self._firstHeadIcon)
				end
			end)
		end
	else
		self._txtName.text = lang("暂时无人上榜")

		HeadItemController.instance:resetHeadCell(self._firstHeadIcon)
	end
end

function GuardDestroyMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.GuardDestroyStageView, self._activityId)
end

function GuardDestroyMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.GuardDestroyRankView, self._activityId)
end

function GuardDestroyMainView:_onClickGetEqual()
	if GuardDestroyModel.instance:isCanGainEqualPrize(self._activityId) == true then
		GuardDestroyAgent.instance:sendPM_GuardDestroyGainBalancePrizeReq(self._activityId)
	else
		FloatWordMgr.instance:show(lang("未达成条件"))
	end
end

function GuardDestroyMainView:_onClickBuff()
	local buffCfgs = GuardDestroyConfig.instance:getSignInBuffCfgs(self._activityCfg.signInPlanId)
	local curBuffLevel = GuardDestroyModel.instance:getSignBuffLevel(self._activityId)

	if curBuffLevel >= #buffCfgs then
		FloatWordMgr.instance:show(lang("已达到最高加成"))
	elseif GuardDestroyModel.instance:isSignInDay(self._activityId) then
		FloatWordMgr.instance:show(lang("今日已领取"))
	else
		GuardDestroyAgent.instance:sendPM_GuardDestroyUpgradeSignInBuffReq(self._activityId)
	end
end

function GuardDestroyMainView:_onClickTip()
	TipsFacade.instance:openRulesView("guard_destroy_rule")
end

function GuardDestroyMainView:_onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function GuardDestroyMainView:_onScrollValueChange(tableview, osffsetA, offsetX, offsetY, cellContentName, progressSlider, type)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local _, conY, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local visualHeight = GameUtil.getHeight(viewPortTrans)
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local yy = locy + conY
			local xx = osffsetA * yy * yy + offsetX * yy + offsetY
			local cellContent = goutil.findChild(cell, cellContentName)

			GameUtil.setLocalPos(cellContent.transform, xx, 0, 0)

			local canvasGroup = cellContent:GetComponent(ComponentType.CanvasGroup)
			local effectGo = goutil.findChild(cellContent, "effect")
			local downLimitRate = 0
			local upLimitRate = 0.95
			local downGradientSize = 0.05
			local upGradientSize = 0.05

			GameUtil.SetActive(effectGo, true)

			if canvasGroup then
				local cellPosRateInView = yy / visualHeight

				if cellPosRateInView < downLimitRate or upLimitRate < cellPosRateInView then
					canvasGroup.alpha = 0

					GameUtil.SetActive(effectGo, false)
				else
					canvasGroup.alpha = cellPosRateInView < downLimitRate + downGradientSize and (cellPosRateInView - downLimitRate) / downGradientSize or cellPosRateInView > upLimitRate - upGradientSize and cellPosRateInView < upLimitRate and (upLimitRate - cellPosRateInView) / upGradientSize or 1
				end
			end
		end
	end

	local sliderOffset = self:getSliderOffset(type)

	if sliderOffset and progressSlider then
		local progressGo = progressSlider.gameObject
		local height = GameUtil.getHeight(progressGo)
		local tarHeight = sliderOffset + height / 2 + conY - (GameUtil.getLocalPos(progressGo) - GameUtil.getLocalPos(viewPortTrans.gameObject)).y
		local tarHeight = math.max(tarHeight, 0)
		local tarHeight = math.min(tarHeight, height)

		progressSlider:SetValue(tarHeight / height)
	end
end

return GuardDestroyMainView
