-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GroupRechargeProgressView.lua

module("logic.extensions.grouprecharge.view.GroupRechargeProgressView", package.seeall)

local GroupRechargeProgressView = class("GroupRechargeProgressView", ViewComponent)

function GroupRechargeProgressView:buildUI()
	GroupRechargeProgressView.super.buildUI(self)

	self._btnReCharge = self:getGo("btnRecharge")
	self._btnGainAll = self:getGo("btnGainAll")
	self._btnRank = self:getGo("btnRank")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._clipRect = goutil.findChild(self._goTableview, "Viewport"):GetComponent(goutil.Type_RectTransform)
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtProgress = self:getTxt("txtProgress")
	self._txtCharge = self:getTxt("txtCharge")
	self._slider = self:getSlider("slider")
	self._showcell = self:getGo("showcell")
	self._showcellTxtNum = goutil.findChildTextComponent(self._showcell, "txtNum")
	self._showcellItemcon = goutil.findChild(self._showcell, "itemcon")
	self._bg = self:getGo("bg")
	self._changeGroup = self:getGo("changeGroup"):GetComponent("UIChangeGroup")
end

function GroupRechargeProgressView:bindEvents()
	GroupRechargeProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReCharge, self._onClickRecharge, self)
	GameUtil.addClickHandler(self._btnGainAll, self._onClickGainAll, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function GroupRechargeProgressView:unbindEvents()
	GroupRechargeProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReCharge)
	GameUtil.rmClickHandler(self._btnGainAll)
	GameUtil.rmClickHandler(self._btnRank)
end

function GroupRechargeProgressView:onEnter()
	GroupRechargeProgressView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._tabConf = params[1]
	self._prizeType = checknumber(params[2])

	self._changeGroup:SetState(self._prizeType - 1)

	local controller = GroupRechargeController.instance

	controller:registerLocalNotify(GroupRechargeController.E_InfoRes, self._refreshViewByInfo, self)
	controller:registerLocalNotify(GroupRechargeController.E_ProgressPrizeChanged, self._refreshViewByInfo, self)
	self:_refreshViewByCfg()
	uGuiUtil.clearImage(self._bg)
	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("grouprecharge", self._tabConf.bg))
end

function GroupRechargeProgressView:onExit()
	GroupRechargeProgressView.super.onExit(self)

	local controller = GroupRechargeController.instance

	controller:unregisterLocalNotify(GroupRechargeController.E_InfoRes, self._refreshViewByInfo, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_ProgressPrizeChanged, self._refreshViewByInfo, self)
	MaterialMgr.resetAll(self._showcellItemcon)
	self._tableview:dispose()
	self:_removeAllEffect()

	self._showId = nil

	uGuiUtil.clearImage(self._bg)
end

function GroupRechargeProgressView:_onClickGainPrize(data)
	local model = GroupRechargeModel.instance

	if model:isGainChargePrize(self._prizeType, data.id) then
		return
	end

	if model:isReach2GainCurPrize(self._prizeType, data) then
		if self._prizeType == GroupRechargeConfig.Team and checknumber(model:getMyRechargeNum()) < checknumber(model.activityConf.teamPrizeNeedRecharge) then
			self:_showTeamGainPrizeCondition()

			return
		end

		GroupRechargeController.instance:reqGainPrize(self._prizeType, data.id)
	end
end

function GroupRechargeProgressView:_showTeamGainPrizeCondition()
	local model = GroupRechargeModel.instance
	local content = langPara("充值%d元后可领取组队奖励", model.activityConf.teamPrizeNeedRecharge)

	TipsFacade.instance:openTipWindow(lang("tip"), content, function()
		self:_onClickRecharge()
	end, lang("前往充值"))
end

function GroupRechargeProgressView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	changeGroup = goCell:GetComponent("UIChangeGroup")

	changeGroup:SetState(self._prizeType - 1)

	local proxyArr = MaterialMgr.setCellListByCfg(data.gift, cell.itemcon)

	cell.txtNum.text = data.consumeMoney

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickGainPrize, self, data))

	local model = GroupRechargeModel.instance

	if model:isReach2GainCurPrize(self._prizeType, data) and not model:isGainChargePrize(self._prizeType, data.id) then
		goutil.setActive(cell.btn, true)
		goutil.setActive(cell.eff, true)

		for i = 1, #proxyArr do
			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.effcon, cell.go, true, self._clipRect, i)
		end
	else
		goutil.setActive(cell.mark, model:isGainChargePrize(self._prizeType, data.id))
	end

	self:_refreshShowCell(self._tableview._tableview:GetCurrentIndex() + 1)
end

function GroupRechargeProgressView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.itemcon = goutil.findChild(cell.go, "itemcon")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.eff = goutil.findChild(cell.go, "eff")
	cell.effcon = goutil.findChild(cell.go, "effcon")
	cell.mark = goutil.findChild(cell.go, "mark")

	GameUtil.rmClickHandler(cell.btn)
	goutil.setActive(cell.btn, false)
	goutil.setActive(cell.eff, false)
	goutil.setActive(cell.mark, false)
	MaterialMgr.resetAll(cell.itemcon)
	self:_removeEffect(cell.go)

	return cell
end

function GroupRechargeProgressView:_refreshShowCell(dataId)
	if self._prizeCfgs[dataId] then
		if self._showId ~= self._prizeCfgs[dataId] then
			self._showId = self._prizeCfgs[dataId]

			local data = self._prizeCfgs[self._showId]

			if data then
				MaterialMgr.resetAll(self._showcellItemcon)
				MaterialMgr.setCellListByCfg(data.gift, self._showcellItemcon)

				self._showcellTxtNum.text = data.consumeMoney

				goutil.setActive(self._showcell, true)
			else
				goutil.setActive(self._showcell, false)
			end
		end
	end
end

function GroupRechargeProgressView:_refreshViewByCfg()
	local model = GroupRechargeModel.instance

	self._actCfg = model.activityConf
	self._prizeCfgs = GroupRechargeConfig.instance:getRechargePrizeConfigs(self._prizeType, model:getRechargePrizePlanId(self._prizeType))

	self:_refreshViewByInfo()
end

function GroupRechargeProgressView:_refreshViewByInfo()
	self:refreshProgressInfo()
	self._tableview:reloadData(self._prizeCfgs)
end

function GroupRechargeProgressView:refreshProgressInfo()
	local model = GroupRechargeModel.instance
	local chargeNum = model:getChargeNum(self._prizeType)
	local nextCfg

	for _, v in ipairs(self._prizeCfgs) do
		if StringUtil.CompareTwoNumber(v.consumeMoney, chargeNum) then
			nextCfg = v

			break
		end
	end

	if nextCfg then
		self._txtProgress.text = langPara("%s/%s", chargeNum, nextCfg.consumeMoney)

		self._slider:SetValue(checknumber(chargeNum) / checknumber(nextCfg.consumeMoney))
	else
		self._txtProgress.text = langPara("%s/%s", chargeNum, self._prizeCfgs[#self._prizeCfgs].consumeMoney)

		self._slider:SetValue(1)
	end

	self._txtCharge.text = langPara("当前充值\n<size=24><color=#7afb80>%s</color></size>", chargeNum)
end

function GroupRechargeProgressView:_onClickRecharge()
	PayShopController.instance:openView(GameEnum.PayShopEasyJump.GodDiamond)
end

function GroupRechargeProgressView:_onClickGainAll()
	local idsT = GroupRechargeModel.instance:getCanGainPrizeIds(self._prizeType, true)
	local ids = GroupRechargeModel.instance:getCanGainPrizeIds(self._prizeType, false)

	if #ids > 0 then
		GroupRechargeController.instance:reqOneKeyGainPrize(self._prizeType)
	elseif #idsT > 0 and self._prizeType == GroupRechargeConfig.Team then
		self:_showTeamGainPrizeCondition()
	else
		FloatWordMgr.instance:show("没有可领取的奖励")
	end
end

function GroupRechargeProgressView:_createEff(effPath, effParent, effKey, isLoop, clipRect, id)
	self._existEffs = self._existEffs or {}

	if not effParent then
		return
	end

	self:_removeEffect(key)

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end
	end)

	self._existEffs[effKey] = self._existEffs[effKey] or {}

	if id then
		self._existEffs[effKey][id] = newEff
	else
		self._existEffs[effKey][1] = newEff
	end
end

function GroupRechargeProgressView:_removeAllEffect()
	if self._existEffs then
		for k, eff in pairs(self._existEffs) do
			self:_removeEffect(k)
		end

		self._existEffs = nil
	end
end

function GroupRechargeProgressView:_removeEffect(key)
	if self._existEffs then
		if self._existEffs then
			for _, eff in pairs(self._existEffs) do
				UIEffectManager.instance:stopEffect(eff)
			end

			self._existEffs[key] = nil
		end
	end
end

function GroupRechargeProgressView:_onClickRank()
	UIStateManager.instance:push(ViewName.ChargeCostRankView, 0, self._actId)
end

return GroupRechargeProgressView
