-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/view/SignindailyView.lua

module("logic.extensions.signindaily.view.SignindailyView", package.seeall)

local SignindailyView = class("SignindailyView", ViewComponent)

function SignindailyView:ctor()
	SignindailyView.super.ctor(self)
end

function SignindailyView:buildUI()
	SignindailyView.super.buildUI(self)

	self._cell = self:getGo("cell")
	self._scrollView = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self._tableview = self._scrollView:GetComponent("UITableview")
	self._bubble = self:getGo("kanbanniang/bubble")
	self._btnMask = self:getBtn("kanbanniang/mask")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "kanbanniang/bubble/txtBubble")
	self._roleModel = goutil.findChild(self.mainGO, "kanbanniang/roleModel")
	self._btnTips = self:getBtn("tipBtn")
	self._effects = {}
end

function SignindailyView:bindEvents()
	SignindailyView.super.bindEvents(self)
	self._btnMask:AddClickListener(self._onClickRoleModel, self)
	self._btnTips:AddClickListener(self._onClickTipRule, self)
end

function SignindailyView:unbindEvents()
	SignindailyView.super.unbindEvents(self)
	self._btnMask:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function SignindailyView:destroyUI()
	SignindailyView.super.destroyUI(self)
end

function SignindailyView:onEnter()
	SignindailyView.super.onEnter(self)
	self._tableview:RegisterOnUpdatePositionCallback(function(a, view)
		self:onUpdatePosition(view)
	end)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)
	SigninDailyController.instance:getInfo(function()
		self:_refresh()
	end)
end

function SignindailyView:onEnterFinished()
	SignindailyView.super.onEnterFinished(self)
end

function SignindailyView:onExit()
	SignindailyView.super.onExit(self)
	self:_resetRoleModel()

	for k, v in pairs(self._effects) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._effects)

	self._canRewardIndex = nil

	self._scrollList:dispose()
end

function SignindailyView:onExitFinished()
	SignindailyView.super.onExitFinished(self)
end

function SignindailyView:_refresh()
	local roundId = SigninDailyModel.instance:getRoundId()

	self._prizeProcess = SigninDailyModel.instance:getPrizeProcess()
	self._hasGainPrize = SigninDailyModel.instance:getGasGainPrize()

	local cfgs = SigninDailyConfig.instance:getSignInCfgById(roundId)

	if cfgs then
		self._canRewardIndex = self._prizeProcess + (self._hasGainPrize and 0 or 1)

		self._scrollList:reloadData(cfgs)
		self:setKanbanNiang(SigninDailyConfig.instance:getKanbanNiangCfg(roundId))
	end
end

function SignindailyView:_updateCell(view, cell, data)
	local txtDay = goutil.findChildTextComponent(cell, "day/txtDay")
	local txtDouble = goutil.findChildTextComponent(cell, "double/txtDouble")
	local goDouble = goutil.findChild(cell, "double")
	local goHasAward = goutil.findChild(cell, "hasAward")
	local btnAward = Framework.ButtonAdapter.Get(goutil.findChild(cell, "btnAward"))
	local icon = goutil.findChild(cell, "icon")
	local effectNode = goutil.findChild(cell, "effect")
	local effectRectTrans = effectNode:GetComponent(goutil.Type_RectTransform)

	txtDay.text = langPara("%d", data.awardNum)

	local isDouble = checknumber(data.vipDouble) ~= 0

	goDouble.gameObject:SetActive(isDouble)

	if isDouble then
		txtDouble.text = langPara("VIP%d双倍", data.vipDouble)
	end

	local isShowHasReward = false
	local isCanAward = self._prizeProcess + 1 == data.awardNum and not self._hasGainPrize

	btnAward.gameObject:SetActive(isCanAward)

	if isCanAward then
		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectNode, 0, 0, true, nil, nil, function(self2, uiEffect)
			uiEffect:setScrollRectClipping(self._scrollRect)
			uiEffect:setParent(cell.transform)
			uiEffect:setScale(0.8)

			uiEffect.hideEffWhileNotOnTop = true

			if self._effects[cell] then
				UIEffectManager.instance:stopEffect(self._effects[cell])
			end

			self._effects[cell] = uiEffect
		end)

		btnAward:AddClickListener(function()
			self:_gainPrize(cell)
		end)
	elseif data.awardNum <= self._prizeProcess then
		isShowHasReward = true
	end

	if not isCanAward then
		UIEffectManager.instance:stopEffect(self._effects[cell])
	end

	goHasAward.gameObject:SetActive(isShowHasReward)
	MaterialMgr.setCellByCfg(data.reward, icon)
end

function SignindailyView:_clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)

	local btnAward = Framework.ButtonAdapter.Get(goutil.findChild(cell, "btnAward"))

	btnAward:RemoveClickListener()
	UIEffectManager.instance:stopEffect(self._effects[cell])
end

function SignindailyView:onUpdatePosition(view)
	return
end

function SignindailyView:_onReloadFinish()
	if checknumber(self._canRewardIndex) > 0 then
		local centerIndex = self._canRewardIndex + 9

		if centerIndex > 29 then
			centerIndex = 29
		end

		self._tableview:MoveCellToCebter(centerIndex - 5)
	end
end

function SignindailyView:_gainPrize(cell)
	SigninDailyController.instance:gainPrize(function()
		self:_refresh()
		UIEffectManager.instance:stopEffect(self._effects[cell])
	end)
end

function SignindailyView:setKanbanNiang(cfgs)
	local cfg

	for k, v in pairs(cfgs) do
		local time = string.split(v.time, "#")

		if GameUtil.checkIsInTimePeriod(time[1], time[2]) then
			cfg = v
		end
	end

	if cfg then
		self._bubble.gameObject:SetActive(false)

		self._txtBubble.text = cfg.des

		GameUtil.setLocalPos(self._roleModel, cfg.pos[1], cfg.pos[2], 1)
		GameUtil.setLocalScale(self._roleModel, cfg.scale[1], cfg.scale[2], 1)

		local scale = 0.5

		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, cfg.raceId, self._roleModel, scale, nil, nil, 0, 0)
	end
end

function SignindailyView:_onClickRoleModel()
	self._bubble.gameObject:SetActive(true)
end

function SignindailyView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SignindailyView:_showEffect()
	return
end

function SignindailyView:_onClickTipRule()
	local ruleCo = RulesConfig.instance:getRuleCo("signindaily_tip")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

return SignindailyView
