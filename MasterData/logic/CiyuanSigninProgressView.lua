-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninProgressView.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninProgressView", package.seeall)

local CiyuanSigninProgressView = class("CiyuanSigninProgressView", ViewComponent)
local _conditionPassColor = Framework.ColorUtil.ParseColor("#20b376")
local _conditionFailColor = Framework.ColorUtil.ParseColor("#eb4642")
local _normalCellBgColor = Framework.ColorUtil.ParseColor("#FFFFFF00")
local _bigPrizeCellBgColor = Framework.ColorUtil.ParseColor("#FF000033")

function CiyuanSigninProgressView:ctor()
	CiyuanSigninProgressView.super.ctor(self)
end

function CiyuanSigninProgressView:bindEvents()
	CiyuanSigninProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnResign, self._onClickResign, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrizeShow, self._onClickPrizeShow, self)
end

function CiyuanSigninProgressView:unbindEvents()
	CiyuanSigninProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnResign)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrizeShow)
end

function CiyuanSigninProgressView:buildUI()
	CiyuanSigninProgressView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._goCon = self:getGo("goCon")
	self._imgHasPet = self:getGo("rightShow/hasItem/hasPet/imgHasPet"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgHasHeart = self:getGo("rightShow/hasItem/hasHeart/imgHasHeart"):GetComponent(ComponentType.UIImageSpriteChange)
	self._hasHeart = self:getGo("rightShow/hasItem/hasHeart")
	self._txtHasPet = self:getTxt("rightShow/hasItem/hasPet/txt")
	self._txtHasHeart = self:getTxt("rightShow/hasItem/hasHeart/txt")
	self._txtDesc = self:getTxt("rightShow/CurrentRight/txtDesc")
	self._txtTotalSignDay = self:getTxt("CanGetAtThirty/txtTotalSignDay")
	self._btnResign = self:getGo("btnResign")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableView/tableCell")
	self._txtCanGetDesc = self:getTxt("CanGetAtThirty/txt")
	self._canGetTableview = self:getGo("CanGetAtThirty/canGetTableview")
	self._canGetTablecell = self:getGo("CanGetAtThirty/canGetTableview/canGetTablecell")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateTableCell, self), GameUtil.handler(self._clearTableCell, self))
	self._finalRewardList = ScrollerList.create(self._canGetTableview, self._canGetTablecell, GameUtil.handler(self._updateFinalRewardCell, self), GameUtil.handler(self._clearFinalRewardCell, self))
	self._effectHandlers = {}
	self._tableScrollRect = self._tableView:GetComponent(ComponentType.ScrollRect)
	self._btnPrizeShow = self:getGo("btnPrizeShow")
end

function CiyuanSigninProgressView:refreshUI()
	local activityCfg = CiyuanSigninConfig.instance:getActivityCfg(self._activityId)
	local raceId = activityCfg and activityCfg.ciyuanDragonRaceId
	local signedDayCount = CiyuanSigninModel.instance:getSignedDayCount(self._activityId)
	local maxSignDay = CiyuanSigninConfig.instance:getMaxSignDay(self._activityId)
	local playerType = CiyuanSigninController.instance:getPlayerType(self._activityId)
	local rewardCount = CiyuanSigninConfig.instance:getSignRewardCount(self._activityId, playerType)
	local canBuyMakeUp = CiyuanSigninController.instance:canBuyMakeUp(self._activityId)
	local hasPet = HandbookModel.instance:isHasPet(raceId)
	local hasHeart = CiyuanSigninController.instance:hasDimensionHeartBenefit(self._activityId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._goCon, nil, nil, true, nil, nil)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId) or ""

	self._imgHasPet:SetState(hasPet and 1 or 0)
	self._imgHasHeart:SetState(hasHeart and 1 or 0)
	GameUtil.SetActive(self._hasHeart, not hasPet)

	if hasPet then
		self._txtHasPet.color = _conditionPassColor or _conditionFailColor
	end

	if hasHeart then
		self._txtHasHeart.color = _conditionPassColor or _conditionFailColor
	end

	self._txtDesc.text = CiyuanSigninController.instance:getBenefitDesc(self._activityId)
	self._txtCanGetDesc.text = langPara("当前权益下，第%s天可领取", rewardCount)

	self._tableList:reloadData(CiyuanSigninController.instance:getSignRewardList(self._activityId))
	self._tableList:MoveCellInView(math.max(signedDayCount - 1, 0), false)
	self._finalRewardList:reloadData(self:_getFinalRewardList(maxSignDay))

	self._txtTotalSignDay.text = langPara("已累计签到 <color=#43edff>%s</color> 天", signedDayCount, maxSignDay)

	goutil.setActive(self._btnResign, canBuyMakeUp)
end

function CiyuanSigninProgressView:destroyUI()
	CiyuanSigninProgressView.super.destroyUI(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function CiyuanSigninProgressView:_updateFinalRewardCell(view, cell, data)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function CiyuanSigninProgressView:_updateTableCell(view, cell, data)
	local go = cell.gameObject
	local goHighLight = goutil.findChild(go, "goHighLight")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local itemCon = goutil.findChild(go, "itemcon")
	local pass = goutil.findChild(go, "pass")
	local btn = goutil.findChild(go, "btn")
	local img = goutil.findChildComponent(go, "img", "Image")

	if string.nilorempty(data.showPrize) then
		if not data.prize then
			local prize = data.showPrize

			prize = not string.nilorempty(prize) and string.split(prize, "#")[1] or prize

			local canGain = CiyuanSigninController.instance:canGainPrizeDay(self._activityId, data.day)
			local hasGain = CiyuanSigninController.instance:isGainPrizeDay(self._activityId, data.day)

			txtNum.text = data.day

			MaterialMgr.resetAll(itemCon)
			MaterialMgr.setCellByCfg(prize, itemCon)

			if data.isBigPrize == true then
				img.color = _bigPrizeCellBgColor or _normalCellBgColor
			end

			GameUtil.rmClickHandler(btn)
			goutil.setActive(btn, canGain)
			goutil.setActive(pass, hasGain)
			goutil.setActive(goHighLight, canGain)
			self:_playCellEffect(goHighLight, canGain)

			if canGain then
				GameUtil.addClickHandler(btn, self._onClickGainPrize, self)
			end
		end
	end
end

function CiyuanSigninProgressView:_clearTableCell(cell)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemcon")
	local pass = goutil.findChild(go, "pass")
	local btn = goutil.findChild(go, "btn")
	local goHighLight = goutil.findChild(go, "goHighLight")
	local img = goutil.findChildComponent(go, "img", "Image")

	MaterialMgr.resetAll(itemCon)

	img.color = _normalCellBgColor

	goutil.setActive(pass, false)
	goutil.setActive(btn, false)
	goutil.setActive(goHighLight, false)
	self:_removeCellEffect(goHighLight)
	GameUtil.rmClickHandler(btn)
end

function CiyuanSigninProgressView:_playCellEffect(goEffect, canGain)
	self:_removeCellEffect(goEffect)

	if not canGain then
		return
	end

	local effName = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true, nil, nil, function(_, eff)
		if eff then
			::label_11_0::

			local var_11_0 = eff.effGo

			if eff.effGo then
				local sizeGo = goutil.findChild(eff.effGo, "size")

				GameUtil.setLocalScale(sizeGo, 1.25, 1.25, 1.5)

				if self._tableScrollRect then
					eff:setScrollRectClipping(self._tableScrollRect)
				end
			end
		end
	end)

	self._effectHandlers[goEffect] = handler

	handler:setParent(goEffect.transform)
	handler:setLocalPos(0, 0, 0)
	handler:setScale(1)
end

function CiyuanSigninProgressView:_removeCellEffect(goEffect)
	local handler = self._effectHandlers[goEffect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandlers[goEffect] = nil
end

function CiyuanSigninProgressView:_clearFinalRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function CiyuanSigninProgressView:_getFinalRewardList(maxSignDay)
	local rewardCfg = CiyuanSigninController.instance:getSignRewardDayCfg(self._activityId, maxSignDay)

	if rewardCfg then
		if not rewardCfg.prize then
			local prize = ""

			return string.nilorempty(prize) and {} or string.split(prize, "#")
		end
	end
end

function CiyuanSigninProgressView:_onClickGainPrize()
	if not CiyuanSigninController.instance:canGainAnyPrize(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("暂无可领取奖励"))

		return
	end

	CiyuanSigninController.instance:sendPM_CiyuanSigninGainPrizeReq(self._activityId)
end

function CiyuanSigninProgressView:_onClickResign()
	local remainingMakeUpDays = CiyuanSigninController.instance:getRemainingMakeUpDayCount(self._activityId)

	if remainingMakeUpDays <= 0 then
		TipsFacade.instance:openCommonTips(lang("暂无可补签天数"))

		return
	end

	local costInfo = CiyuanSigninController.instance:getMakeUpCostInfo(self._activityId, 1)

	if checknumber(costInfo.matType) <= 0 or checknumber(costInfo.matId) <= 0 or checknumber(costInfo.matNum) <= 0 then
		TipsFacade.instance:openCommonTips(lang("补签消耗配置有误"))

		return
	end

	ViewMgr.instance:open(ViewName.CiyuanSigninResignConfimView, {
		autoOpenSource = false,
		defaultNum = 1,
		matType = costInfo.matType,
		matId = costInfo.matId,
		matNum = costInfo.matNum,
		maxNum = remainingMakeUpDays,
		contentCallBack = function(selectNum)
			local totalCostInfo = CiyuanSigninController.instance:getMakeUpCostInfo(self._activityId, selectNum)
			local matName = MaterialMgr.getMaterialsName(totalCostInfo.matType, totalCostInfo.matId)

			return langPara("是否消耗%s%s购买%s天补签？\n补签可获得以下奖励：", totalCostInfo.matNum, matName, selectNum)
		end,
		rewardCallBack = function(selectNum)
			return CiyuanSigninController.instance:getMakeUpRewardList(self._activityId, selectNum)
		end,
		beforeSureCallBack = function()
			if not CiyuanSigninModel.instance:hadTodaySignIn(self._activityId) then
				TipsFacade.instance:openCommonTips(lang("请先完成今日签到"))

				return false
			end

			return true
		end,
		successCallBack = function(selectNum)
			CiyuanSigninController.instance:sendPM_CiyuanSigninBuyMakeUpReq(self._activityId, selectNum)
		end
	})
end

function CiyuanSigninProgressView:_onGainPrizeRes()
	local changeSetId = CiyuanSigninModel.instance:getRecentChangeSetId(self._activityId)

	if changeSetId > 0 then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function CiyuanSigninProgressView:onEnter()
	CiyuanSigninProgressView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 616001
	end

	self.addGEvent(self, GlobalNotify.CiyuanSigninGetInfoRes, self.refreshUI, self)
	self.addGEvent(self, GlobalNotify.CiyuanSigninGainPrizeRes, self._onGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.CiyuanSigninGainPrizeRes, self.refreshUI, self)
	self.addGEvent(self, GlobalNotify.CiyuanSigninBuyMakeUpRes, self._onGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.HandBookInit, self.refreshUI, self)
	self:refreshUI()
	CiyuanSigninController.instance:sendPM_CiyuanSigninGetInfoReq(self._activityId)
end

function CiyuanSigninProgressView:onExit()
	CiyuanSigninProgressView.super.onExit(self)

	if self._effectHandlers then
		for goEffect, _ in pairs(self._effectHandlers) do
			self:_removeCellEffect(goEffect)
		end
	end

	if self._tableList then
		self._tableList:dispose()
	end

	if self._finalRewardList then
		self._finalRewardList:dispose()
	end
end

function CiyuanSigninProgressView:_onClickTip()
	local activityCfg = CiyuanSigninConfig.instance:getActivityCfg(self._activityId)
	local key = activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function CiyuanSigninProgressView:_onClickPrizeShow()
	UIStateManager.instance:push(ViewName.CiyuanSigninPrizeShowView, self._activityId)
end

return CiyuanSigninProgressView
