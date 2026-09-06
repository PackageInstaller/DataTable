-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanboyieventView.lua

module("logic.extensions.richmanxplan.view.RmxplanboyieventView", package.seeall)

local RmxplanboyieventView = class("RmxplanboyieventView", ViewComponent)

RmxplanboyieventView.Type = {
	Roll = 1,
	Sure = 0
}

function RmxplanboyieventView:ctor()
	RmxplanboyieventView.super.ctor(self)
end

function RmxplanboyieventView:unbindEvents()
	RmxplanboyieventView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function RmxplanboyieventView:bindEvents()
	RmxplanboyieventView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function RmxplanboyieventView:buildUI()
	RmxplanboyieventView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnStart = self:getBtn("btnStart")
	self._btnClose = self:getBtn("btnClose")
	self._txtCost = self:getTxt("txtCost")
	self._blockGo = self:getGo("block")
	self._diceMaskGo = self:getGo("diceCol/diceMask")
	self._diceCol = {}

	local mainGo = goutil.findChild(self.mainGO, "diceCol")

	self._diceCol._mainGo = mainGo
	self._diceCol._diceHandlerList = {}

	for idx = 1, 3 do
		local diceView = goutil.findChild(mainGo, string.format("diceView_%s", 1))
		local diceHandler = RichManXplanDiceHandler.New()

		diceHandler:initFromGo(diceView, 3)

		self._diceCol._diceHandlerList[idx] = diceHandler
	end

	local cameraGo = self:getGo("diceCol/diceView_1/camera")

	self._diceGos = {}

	for idx = 1, cameraGo.transform.childCount do
		self._diceGos[idx] = goutil.findChild(cameraGo, "go_" .. idx)

		goutil.setActive(self._diceGos[idx], false)
	end

	self._clickMask = goutil.findChild(self.mainGO, "uiTopCol/clickMask")
	self._touzi1Change = self:getGo("touzi/touzi1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._touzi2Change = self:getGo("touzi/touzi2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._touzi3Change = self:getGo("touzi/touzi3"):GetComponent(ComponentType.UIImageSpriteChange)
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMat = self:getTxt("matCell/txtMat")
	self._btnTip = self:getBtn("btnTip")
	self._txtRefreshTime = self:getTxt("txtRefreshTime")
end

function RmxplanboyieventView:onExit()
	RmxplanboyieventView.super.onExit(self)
	self._scrollerList:dispose()
	self:_clearDice()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._wineffectHandler then
		UIEffectManager.instance:stopEffect(self._wineffectHandler)

		self._wineffectHandler = nil
	end

	if self._selectEffectHandler then
		UIEffectManager.instance:stopEffect(self._selectEffectHandler)

		self._selectEffectHandler = nil
	end
end

function RmxplanboyieventView:onEnter()
	RmxplanboyieventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)
	self:_buildSelectEffect()

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._params = GameUtil.jsonToTable(self._event.param)
	self._refreshTimes = self._params.refreshTimes or 0
	self._diceValueList = self._params.dices or {}
	self._firstEnter = true
	self._totalDiceValue = 0

	self:_updateUI()
	self:_setEffect()
	goutil.setActive(self._blockGo, false)
	goutil.setActive(self._diceMaskGo, false)
end

function RmxplanboyieventView:_onClickbtnSure()
	if self._refreshTimes <= 0 then
		FloatWordMgr.instance:show("请先开骰")

		return
	end

	self:_playWinEffect()
end

function RmxplanboyieventView:_onClickbtnClose()
	TipsFacade.instance:openPopupWindow("提示", "是否确认退出？", function()
		local t = {
			state = RmxplanboyieventView.Type.Sure
		}

		RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true, GameUtil.jsonToString(t))
	end)
end

function RmxplanboyieventView:_onClickbtnStart()
	local cfg = RichmanxplanConfig.instance:getBoyiEventCfg(self._activityId, self._event.eventId)

	if self._score < cfg.refreshCost then
		if self._firstEnter then
			self._firstEnter = false

			TipsFacade.instance:openTipWindowNoX("提示", "货币不足，参与失败！", function()
				self:_onClickbtnClose()
			end)

			return
		end

		FloatWordMgr.instance:show("货币不足")

		return
	end

	if self._refreshTimes >= cfg.refreshLimit then
		FloatWordMgr.instance:show("次数不足")

		return
	end

	local t = {
		state = RmxplanboyieventView.Type.Roll
	}

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
end

function RmxplanboyieventView:_onClickbtnTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "boyiRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RmxplanboyieventView:_updateUI()
	self:_updateBtnSureState()
	self:_updateCurValue()
	self:_updateMat()
	self:_updateCost()
	self:_updateDesc()
end

function RmxplanboyieventView:_onRichManXPlanEventRes(msg)
	if msg.isEnd then
		self:close()

		return
	end

	if not string.nilorempty(msg.resultParam) then
		self._params = GameUtil.jsonToTable(msg.resultParam)
		self._refreshTimes = self._params.refreshTimes
		self._diceValueList = self._params.dices

		self:_updateBtnSureState()
		self:_playDiceAnim()
	end
end

function RmxplanboyieventView:_blockClick(isNeedBlock)
	GameUtil.SetActive(self._clickMask, isNeedBlock)
end

function RmxplanboyieventView:_playDiceAnim()
	self:_blockClick(true)
	goutil.setActive(self._diceMaskGo, true)
	self._selectEffectHandler:setActive(false)

	for k, v in pairs(self._diceGos) do
		goutil.setActive(v, false)
	end

	local valueList = self._diceValueList

	local function doneCallback()
		self:_updateUI()
		self:_blockClick(false)
		goutil.setActive(self._diceMaskGo, false)
		self._selectEffectHandler:setActive(true)
	end

	local num = #valueList
	local saiziIds = {}

	if num == 1 then
		saiziIds = {
			2
		}
	elseif num == 2 then
		saiziIds = {
			1,
			3
		}
	elseif num == 3 then
		saiziIds = {
			1,
			2,
			3
		}
	end

	for idx, val in ipairs(valueList) do
		local params = {
			autoHideSelfSec = 1,
			bNotPlayAnim = false,
			value = val,
			useSaiZiId = saiziIds[idx],
			doneCallback = doneCallback,
			thisArg = self
		}
		local diceHandler = self:_getDiceHandler(idx)

		if diceHandler then
			diceHandler:play(params)
		else
			printError("缺失")
		end
	end
end

function RmxplanboyieventView:_updateBtnSureState()
	local cfg = RichmanxplanConfig.instance:getBoyiEventCfg(self._activityId, self._event.eventId)

	GameUtil.SetGray(self._btnSure.gameObject, self._refreshTimes <= 0)

	self._txtRefreshTime.text = string.format("剩余开骰次数：%s", cfg.refreshLimit - self._refreshTimes)
end

function RmxplanboyieventView:_getDiceHandler(handlerIdx)
	return self._diceCol._diceHandlerList[handlerIdx]
end

function RmxplanboyieventView:_updateCurValue()
	self._totalDiceValue = 0

	if #self._diceValueList == 3 then
		self._touzi1Change:SetState(self._diceValueList[1] - 1)
		self._touzi2Change:SetState(self._diceValueList[2] - 1)
		self._touzi3Change:SetState(self._diceValueList[3] - 1)

		for i, v in ipairs(self._diceValueList) do
			self._totalDiceValue = self._totalDiceValue + v
		end
	else
		self._touzi1Change:SetState(5)
		self._touzi2Change:SetState(5)
		self._touzi3Change:SetState(5)
	end
end

function RmxplanboyieventView:_clearDice()
	for _, v in ipairs(self._diceCol._diceHandlerList) do
		v:dispose()
	end
end

function RmxplanboyieventView:_updateDesc()
	local cfgs = RichmanxplanConfig.instance:getBoyiItemCfgs(self._activityId, self._event.eventId)

	self._scrollerList:reloadData(cfgs)
end

function RmxplanboyieventView:_updateCell(view, cell, cfg, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local goEffect = goutil.findChild(cell.gameObject, "effect")

	txtDesc.text = string.format("点数%s~%s\n%s", cfg.range[1], cfg.range[2], cfg.desc)

	local showEffect = self._refreshTimes > 0

	showEffect = showEffect and cfg.range[1] <= self._totalDiceValue and self._totalDiceValue <= cfg.range[2]

	goutil.setActive(goEffect, showEffect)

	if showEffect then
		self._selectEffectHandler:setParent(goEffect.transform)
		self._selectEffectHandler:setLocalPos(0, 0, 0)
	end
end

function RmxplanboyieventView:_clearCell(cell)
	return
end

function RmxplanboyieventView:_updateMat()
	self._info = RichmanxplanModel.instance:getInfo(self._activityId)
	self._txtMat.text = self._info.score
end

function RmxplanboyieventView:_updateCost()
	local cfg = RichmanxplanConfig.instance:getBoyiEventCfg(self._activityId, self._event.eventId)

	self._txtCost.text = cfg.refreshCost
end

function RmxplanboyieventView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function RmxplanboyieventView:_playWinEffect()
	goutil.setActive(self._blockGo, true)

	local effName = "20240531/dafuweng/fx_ui_chaopiao2_dfw.prefab"

	self._wineffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self:_playWinEffectFinish()
	end)

	self._wineffectHandler:setEffTime(1.2)
	self._wineffectHandler:setParent(self.mainGO.transform)
	self._wineffectHandler:setScale(1)
	self._wineffectHandler:setLocalPos(0, 0, 0)
end

function RmxplanboyieventView:_playWinEffectFinish()
	local t = {
		state = RmxplanboyieventView.Type.Sure
	}

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
end

function RmxplanboyieventView:_buildSelectEffect()
	local effName = "20240531/dafuweng/fx_ui_kuang_dfw.prefab"

	self._selectEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._selectEffectHandler:setParent(self.mainGO.transform)
	self._selectEffectHandler:setScale(1)
	self._selectEffectHandler:setLocalPos(1000, 0, 0)
end

return RmxplanboyieventView
