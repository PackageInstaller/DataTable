-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeprizeView.lua

module("logic.extensions.roguelike.view.RoguelikeprizeView", package.seeall)

local RoguelikeprizeView = class("RoguelikeprizeView", ViewComponent)

function RoguelikeprizeView:ctor()
	RoguelikeprizeView.super.ctor(self)
end

function RoguelikeprizeView:unbindEvents()
	RoguelikeprizeView.super.unbindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end

	self._btnClose:RemoveClickListener()
	self._btnGetAll:RemoveClickListener()
end

function RoguelikeprizeView:bindEvents()
	RoguelikeprizeView.super.bindEvents(self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onSwitchList, self, i))
	end

	self._btnClose:AddClickListener(self.close, self)
	self._btnGetAll:AddClickListener(self._onClickGetAll, self)
end

function RoguelikeprizeView:buildUI()
	RoguelikeprizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGetAll = self:getBtn("btnGetAll")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._switchBtns = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.change = goutil.findChild(cell.go, "bg"):GetComponent("UIChangeGroup")
		self._switchBtns[i] = cell
	end

	self._itemGroups = {}
	self._scroll = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
end

function RoguelikeprizeView:onExit()
	RoguelikeprizeView.super.onExit(self)
	self._tableview:dispose()
end

function RoguelikeprizeView:onEnter()
	RoguelikeprizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoguelikeGainNormalPrizeRes, self._onRoguelikeGainNormalPrizeRes, self)

	self._activityId = self:getFirstParam() or RoguelikeModel.instance:getActivityId()
	self._curSwitchId = nil

	self:_onSwitchList(1)
end

function RoguelikeprizeView:_onClickGetAll()
	if self._curSwitchId then
		local gainedStageId = RoguelikeModel.instance:getNormalMaxGainedStageId(self._activityId, self._curSwitchId)
		local toStageId = RoguelikeModel.instance:getNormalPassNum(self._activityId, self._curSwitchId)

		if toStageId <= gainedStageId then
			FloatWordMgr.instance:show("无可领取奖励")

			return
		end

		RoguelikeAgent.instance:sendPM_RoguelikeGainNormalPrizeReq(self._activityId, self._curSwitchId, toStageId)
	end
end

function RoguelikeprizeView:_updateCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local goPrizeCom = goutil.findChild(cell, "prizeCom")
	local goCell = goutil.findChild(cell, "cell")
	local prizeLayout = goPrizeCom:GetComponent(ComponentType.UILayoutSingleLine)
	local isGain = self._maxGainedStageId >= data.stageId
	local isCanGain = not isGain and self._maxGainedStageId < data.stageId and self._maxPassStageId > 0 and self._maxPassStageId >= data.stageId
	local prizeList = string.split(data.prize, "#")
	local itemGroup = self._itemGroups[cell]

	txtRank.text = string.format("第 %d 关", data.stageId)

	if not itemGroup then
		itemGroup = ItemGroup.New(goPrizeCom, goCell, nil, nil, true, self._clearGroupItem, self)
		self._itemGroups[cell] = itemGroup
	end

	itemGroup:updateWithMoArray(prizeList, function(item, cfgStr)
		self:_updateItem(item, cfgStr, data.stageId, isGain, isCanGain)
	end)
	prizeLayout:Layout()
end

function RoguelikeprizeView:_updateItem(item, cfgStr, stageId, isGain, isCanGain)
	local goCon = goutil.findChild(item.mainGO, "con")
	local goEffect = goutil.findChild(item.mainGO, "effect")
	local goPass = goutil.findChild(item.mainGO, "pass")

	GameUtil.SetActive(goPass, isGain)
	MaterialMgr.resetAll(goCon)

	local proxy = MaterialMgr.setCellByCfg(cfgStr, goCon)

	proxy.binder:setAutoTips(not isCanGain)

	if isCanGain then
		proxy.binder:setCallBack(function()
			RoguelikeAgent.instance:sendPM_RoguelikeGainNormalPrizeReq(self._activityId, self._curSwitchId, stageId)
		end)
	else
		proxy.binder:setCallBack(nil)
	end

	if isCanGain then
		self:_playEffect(goEffect, self._scroll)
	else
		self:_clearEffect(goEffect)
	end
end

function RoguelikeprizeView:_clearGroupItem(item)
	local goEffect = goutil.findChild(item.mainGO, "effect")

	self:_clearEffect(goEffect)
end

function RoguelikeprizeView:_clearCell(cell)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local prizeCom = goutil.findChild(cell, "prizeCom")

	MaterialMgr.resetAll(prizeCom)

	if self._itemGroups[cell] then
		self._itemGroups[cell]:dispose()
	end
end

function RoguelikeprizeView:_onSwitchList(id)
	printInfo("test RoguelikeprizeView:_onSwitchList = ", id)

	self._curSwitchId = id
	self._maxGainedStageId = RoguelikeModel.instance:getNormalMaxGainedStageId(self._activityId, id)
	self._maxPassStageId = RoguelikeModel.instance:getNormalMaxPassedStageId(self._activityId, id)

	for i = 1, #self._switchBtns do
		local cell = self._switchBtns[i]

		cell.change:SetState(self._curSwitchId == i and 1 or 0)
	end

	if self._curSwitchId == 1 then
		local var_14_0 = RoguelikeConfig.instance:getNormalStageList(self._activityId, 1)

		if not var_14_0 then
			var_14_0 = RoguelikeConfig.instance:getNormalStageList(self._activityId, 2)

			local stageCfgs = var_14_0

			self._tableview:reloadData(stageCfgs)
		end
	end
end

function RoguelikeprizeView:_onRoguelikeGainNormalPrizeRes()
	self:_onSwitchList(self._curSwitchId)
end

function RoguelikeprizeView:_playEffect(effGo, srollRect)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setScrollRectClipping(srollRect)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function RoguelikeprizeView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return RoguelikeprizeView
