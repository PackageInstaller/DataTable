-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/OperationSummaryView.lua

module("logic.extensions.operationsummary.view.OperationSummaryView", package.seeall)

local OperationSummaryView = class("OperationSummaryView", ViewComponent)

function OperationSummaryView:ctor()
	OperationSummaryView.super.ctor(self)
end

function OperationSummaryView:buildUI()
	OperationSummaryView.super.buildUI(self)

	self._bg = self:getGo("canvas180/bg")
	self._cell = self:getGo("cell")
	self._scrollView = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._effect = self:getGo("effect")
end

function OperationSummaryView:bindEvents()
	OperationSummaryView.super.bindEvents(self)
end

function OperationSummaryView:unbindEvents()
	OperationSummaryView.super.unbindEvents(self)
end

function OperationSummaryView:destroyUI()
	OperationSummaryView.super.destroyUI(self)
end

function OperationSummaryView:onEnter()
	OperationSummaryView.super.onEnter(self)

	self.activityId = self:getFirstParam()

	if self.activityId then
		self.mainCfg = OperationSummaryConfig.instance:getSummaryCfgById(self.activityId)

		if self.mainCfg then
			local bgPlanId = self.mainCfg.bgPlanId
			local bgCfg = OperationSummaryConfig.instance:getBgCfg(bgPlanId)

			if bgCfg then
				for k, cfg in pairs(bgCfg) do
					if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
						uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getHuoDongUrl(cfg.bgName))

						if not string.nilorempty(cfg.effect) then
							self:_showEffect(cfg.effect)
						end
					end
				end
			end

			self.itemCfgList = OperationSummaryConfig.instance:getItemCfg(self.activityId)

			self._scrollList:reloadData(self.itemCfgList)
		end
	else
		UIStateManager.instance:pop()
	end
end

function OperationSummaryView:onEnterFinished()
	OperationSummaryView.super.onEnterFinished(self)
end

function OperationSummaryView:onExit()
	OperationSummaryView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)

	if self._centerEffect then
		UIEffectManager.instance:stopEffect(self._centerEffect)

		self._centerEffect = nil
	end
end

function OperationSummaryView:onExitFinished()
	OperationSummaryView.super.onExitFinished(self)
end

function OperationSummaryView:_refreshALL()
	if self.itemCfgList and #self.itemCfgList > 0 then
		self._scrollList:refresh(self.itemCfgList)
	end
end

function OperationSummaryView:_showEffect(effectPath)
	if self._centerEffect then
		UIEffectManager.instance:stopEffect(self._centerEffect)

		self._centerEffect = nil
	end

	local path = effectPath .. ".prefab"

	self._centerEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._centerEffect:setParent(self._effect.transform)
	self._centerEffect:setScale(1)

	self._centerEffect.hideEffWhileNotOnTop = true
end

function OperationSummaryView:_updateCell(view, cell, data)
	local go = goutil.findChild(cell, "node")
	local icon = goutil.findChild(cell, "node/icon")
	local bgIcon = goutil.findChild(cell, "node/name")
	local redPoint = goutil.findChild(cell, "node/imgRed")
	local btnJump = Framework.ButtonAdapter.Get(go.gameObject)
	local txtTab = goutil.findChildTextComponent(cell, "node/tab/txt")
	local goTxtTab = goutil.findChild(cell, "node/tab")
	local txtName = goutil.findChildTextComponent(cell, "node/name/txtName")
	local isShow = false

	if data ~= nil then
		local form = checknumber(data.form)

		if form == 0 then
			if checknumber(data.activityType) > 0 then
				local actCfg = ActivityDefineController.instance:getActivityCfgByType(data.activityType)

				isShow = FuncOpenController.instance:getConditionReached(data.openCondition) and actCfg ~= nil
			else
				isShow = FuncOpenController.instance:getConditionReached(data.openCondition)
			end
		elseif form == 1 then
			local timePeriod = ActivityDefineController.instance:getActivityPeriodByType(data.activityType)

			isShow = timePeriod ~= GameUtil.afterTimePeriod
		end
	end

	if isShow then
		goutil.setActive(go, true)
		goutil.setActive(goTxtTab, not string.nilorempty(data.tips))

		txtTab.text = data.tips

		btnJump:AddClickListener(function()
			self:_jumpToFunction(data)
		end)

		txtName.text = data.name

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.icon))
		uGuiUtil.setSpriteToImage(bgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.bgIcon))
		GameUtil.setLocalPos(go, data.pos[1], data.pos[2], 1)
	else
		goutil.setActive(go, false)
	end
end

function OperationSummaryView:_clearCell(cell)
	local go = goutil.findChild(cell, "node")
	local icon = goutil.findChild(cell, "node/icon")
	local bgIcon = goutil.findChild(cell, "node/name")
	local btnJump = Framework.ButtonAdapter.Get(go.gameObject)
	local redPoint = goutil.findChild(cell, "node/imgRed")

	btnJump:RemoveClickListener()
	uGuiUtil.clearImage(icon)
	uGuiUtil.clearImage(bgIcon)
end

function OperationSummaryView:_jumpToFunction(data)
	if checknumber(data.funcId) > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)

		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
		else
			GotoMgr.gotoByString(string.format("func#%s#%s", data.funcId, data.params))
		end
	elseif not string.nilorempty(data.viewname) then
		SurveyController.instance:reportBehavior(data.reportBehavior)
		FuncOpenController.instance:openFuncByViewName(data.viewname)
	else
		FloatWordMgr.instance:show("未配置!!!")
	end
end

return OperationSummaryView
