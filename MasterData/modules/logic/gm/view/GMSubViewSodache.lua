-- chunkname: @modules/logic/gm/view/GMSubViewSodache.lua

module("modules.logic.gm.view.GMSubViewSodache", package.seeall)

local GMSubViewSodache = class("GMSubViewSodache", GMSubViewBase)
local attrIdToName = {
	[30004] = "顶层视野",
	[30014] = "成功cost",
	[30013] = "失败cost",
	[30019] = "第一步消耗",
	[30003] = "视野",
	[30012] = "成功cost",
	[40002] = "基础骰子数量",
	[30018] = "事件消耗修正",
	[40006] = "检定骰子数量修正",
	[60001] = "移动丢弃物资",
	[60002] = "移动丢弃冒险",
	[30017] = "移动消耗修正",
	[30001] = "当前行动力",
	[50001] = "邪恶等级",
	[60003] = "移动使用冒险",
	[30016] = "行动力上限",
	[30015] = "失败cost",
	[40005] = "黑市价格修正",
	[40004] = "商店价格修正",
	[40003] = "黑市解锁",
	[30021] = "移动固定消耗",
	[30005] = "供奉卡牌数量",
	[40001] = "基地经验修正",
	[30020] = "每一步消耗"
}

function GMSubViewSodache:ctor()
	self.tabName = "搜打撤"
end

function GMSubViewSodache:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewSodache:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewSodache:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("搜打撤玩法")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "进入玩法", self.enterGame, self)
	self.addButton(self, self:getLineGroup(), "进入局内", self.enterGameFast, self)
	self.addButton(self, self:getLineGroup(), "机器人测试", self.autoRun, self)
	self:addTitleSplitLine("GM")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "加很多金币", self.addCoins, self)
	self.addButton(self, self:getLineGroup(), "加所有道具", self.addAllItems, self)
	self.addButton(self, self:getLineGroup(), "清空背包", self.clearBag, self)
	self.addButton(self, self:getLineGroup(), "遗物拉满", self.relicOneKey, self)
	self.addButton(self, self:getLineGroup(), "建筑拉满", self.buildingOneKey, self)
	self.addButton(self, self:getLineGroup(), "一键解锁所有条件", self.funcOneKey, self)
	self:addLineIndex()

	self._txtEventId = self:addInputText(self:getLineGroup(), nil, "事件ID")

	self.addButton(self, self:getLineGroup(), "生成事件", self.createEvent, self)
	self:addLineIndex()

	self._txtItemId = self:addInputText(self:getLineGroup(), nil, "道具ID")
	self._txtItemNum = self:addInputText(self:getLineGroup(), nil, "道具数量")

	self.addButton(self, self:getLineGroup(), "加道具", self.addItem, self)

	self._txtOpenId = self:addInputText(self:getLineGroup(), nil, "功能ID")

	self.addButton(self, self:getLineGroup(), "解锁功能", self.openFunction, self)

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if outSideMo then
		self._isNewLine = true

		self:addTitleSplitLine("属性")

		for k, v in ipairs(lua_sodache_attr.configList) do
			local attrId = v.id

			if attrIdToName[attrId] then
				self:addAttrInput(attrIdToName[attrId], attrId)
			end
		end

		for k, v in ipairs(lua_sodache_attr.configList) do
			local attrId = v.id

			if not attrIdToName[attrId] then
				self:addAttrInput("属性", attrId)
			end
		end
	end
end

function GMSubViewSodache:addInputText(...)
	local input = GMSubViewSodache.super.addInputText(self, ...)
	local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")

	input.inputField.lineType = System.Enum.Parse(type_linetype, "SingleLine")

	return input
end

function GMSubViewSodache:addAttrInput(name, attrId)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		return
	end

	if self._isNewLine then
		self:addLineIndex()
	end

	self._isNewLine = not self._isNewLine

	self:addLabel(self:getLineGroup(), string.format("%s(%s)", name, attrId))
	self.addInputText(self, self:getLineGroup(), outSideMo.attrContainer:getAttr(attrId), nil, function(_, val)
		if not tonumber(val) then
			return
		end

		GMRpc.instance:sendGMRequest("soAttr " .. attrId .. " " .. tonumber(val))
	end, self)
end

function GMSubViewSodache:enterGame()
	SodacheController.instance:enterScene()
	self:closeThis()
end

function GMSubViewSodache:enterGameFast()
	SodacheOutsideRpc.instance:sendSodacheOutsideGetScene(self._onRecvMsg, self)
end

function GMSubViewSodache:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		if SodacheUtil.isInside() then
			self:enterGame()
		else
			if SodacheUtil.isRookie() then
				SodacheInsideRpc.instance:sendSodacheInsideEnterScene(90000, 9000001, self.enterGame, self)

				return
			end

			SodacheInsideRpc.instance:sendSodacheInsideEnterScene(10001, 1000104, self.enterGame, self)
		end
	end
end

function GMSubViewSodache:addCoins()
	GMRpc.instance:sendGMRequest("soadditem 10000000 999999")
end

function GMSubViewSodache:addAllItems()
	GMRpc.instance:sendGMRequest("soaddallitem 1")
end

function GMSubViewSodache:addItem()
	GMRpc.instance:sendGMRequest(string.format("soadditem %s %s", self._txtItemId:GetText(), self._txtItemNum:GetText()))
end

function GMSubViewSodache:createEvent()
	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		GameFacade.showToastString("不在局内!")

		return
	end

	GMRpc.instance:sendGMRequest(string.format("socreateUnit %s %s", self._txtEventId:GetText(), insideMo.player.locationId))
end

function GMSubViewSodache:openFunction()
	GMRpc.instance:sendGMRequest(string.format("soopenFunction %s", self._txtOpenId:GetText()))
end

function GMSubViewSodache:clearBag()
	GMRpc.instance:sendGMRequest("soclearBag")
end

function GMSubViewSodache:relicOneKey()
	GMRpc.instance:sendGMRequest("sorelicOneKey")
end

function GMSubViewSodache:buildingOneKey()
	GMRpc.instance:sendGMRequest("sobuildingOneKey")
end

function GMSubViewSodache:funcOneKey()
	GMRpc.instance:sendGMRequest("soopenFunction 0")
end

function GMSubViewSodache:autoRun()
	if SodacheModel.instance.____gmfastrun then
		SodacheModel.instance.____gmfastrun = false

		return
	end

	SodacheModel.instance.____gmfastrun = true

	self:beginAutoRun()
end

function GMSubViewSodache:_autoRunMsgRecv(cmd, resultCode, msg)
	if resultCode ~= 0 then
		SodacheModel.instance.____gmfastrun = false

		return
	end

	self:_delayRun()
end

function GMSubViewSodache:_delayRun()
	TaskDispatcher.runDelay(self.beginAutoRun, self, 0)
end

function GMSubViewSodache:beginAutoRun()
	if not SodacheModel.instance.____gmfastrun then
		return
	end

	local outSideMo = SodacheModel.instance:getOutsideMo()

	if not outSideMo then
		SodacheOutsideRpc.instance:sendSodacheOutsideGetScene(self._autoRunMsgRecv, self)

		return
	end

	if not SodacheUtil.isInside() then
		SodacheInsideRpc.instance:sendSodacheInsideEnterScene(10001, 1000104, self._autoRunMsgRecv, self)

		return
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		SodacheInsideRpc.instance:sendSodacheInsideGetScene(self._delayRun, self)

		return
	end

	if insideMo.prop.status == SodacheEnum.InsideSceneStatus.SelectTime then
		local arr = string.splitToNumber(insideMo.copyCo.time, "#") or {}
		local selectItemId = arr[math.random(1, #arr)]

		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.SelectTime, tostring(selectItemId), self._autoRunMsgRecv, self)

		return
	elseif insideMo.prop.status == SodacheEnum.InsideSceneStatus.ShopAndOffering then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.LeaveBorn, "", self._autoRunMsgRecv, self)

		return
	elseif insideMo.prop.status == SodacheEnum.InsideSceneStatus.SelectCard then
		SodacheInsideRpc.instance:sendSodacheInsideSubmitMaterialSettle({}, self._autoRunMsgRecv, self)

		return
	end

	local battleStatu = insideMo.prop.battleInfo.status

	if battleStatu == SodacheEnum.FightStatus.ShowPanel then
		CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)

		local heroMo = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

		if not heroMo then
			logError("遇到战斗事件，并且没有任何角色去进入战斗")

			SodacheModel.instance.____gmfastrun = false

			return
		end

		local fightParam = FightModel.instance:getFightParam() or FightParam.New()

		fightParam.mySideUids = fightParam.mySideUids or {}
		fightParam.mySideUids[1] = heroMo.uid

		DungeonRpc.instance:sendStartDungeonRequest(1374701, SodacheEnum.EpisodeId, fightParam)
		GMRpc.instance:sendGMRequest("set fight 1")
		SodacheInsideRpc.instance:sendSodacheInsideGetScene(self._delayRun, self)

		return
	elseif battleStatu ~= SodacheEnum.FightStatus.None then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.FightEnd, "", self._autoRunMsgRecv, self)

		return
	end

	local panelMo = insideMo.panelBox.currPanel

	if panelMo.type > 0 then
		if math.random(1, 100) > 60 then
			SodacheInsideRpc.instance:sendSodacheInsideClosePanel(self._autoRunMsgRecv, self)
		else
			local options = panelMo.options
			local randomChoice = options[math.random(1, #options)]

			SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.SelectChoice, tostring(randomChoice), self._delayRun, self)
		end

		return
	end

	local units = insideMo:getUnitsByNodeId(insideMo.player.locationId)

	if #units <= 0 or math.random(1, 100) > 30 then
		local toIds = {}

		for k, v in pairs(insideMo.mapCo.lineDict[insideMo.player.locationId]) do
			table.insert(toIds, k)
		end

		local toId = toIds[math.random(1, #toIds)]

		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Move, tostring(toId), self._autoRunMsgRecv, self)
	else
		local unit = units[math.random(1, #units)]

		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Interaction, tostring(unit.uid), self._delayRun, self)
	end
end

function GMSubViewSodache:onClose()
	SodacheModel.instance.____gmfastrun = false

	GMSubViewSodache.super.onClose(self)
end

return GMSubViewSodache
