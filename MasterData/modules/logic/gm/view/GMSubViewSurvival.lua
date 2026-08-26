-- chunkname: @modules/logic/gm/view/GMSubViewSurvival.lua

module("modules.logic.gm.view.GMSubViewSurvival", package.seeall)

local GMSubViewSurvival = class("GMSubViewSurvival", GMSubViewBase)

function GMSubViewSurvival:ctor()
	self.tabName = "3.1探索"
end

function GMSubViewSurvival:addLineIndex()
	if self.lineIndex then
		self.lineIndex = self.lineIndex + 1 or 1
	end
end

function GMSubViewSurvival:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewSurvival:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addTitleSplitLine("业务")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "进入主界面", self.openSurvivalView, self)
	self:addTitleSplitLine("避难所")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "一键添加所有NPC", self.addAllNPC, self)

	self._txtDay = self:addInputText(self:getLineGroup(), "1")

	self.addButton(self, self:getLineGroup(), "设置天数", self.setDay, self)
	self:addTitleSplitLine("探索")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "一键进入探索", self.enterSurvival, self)
	self.addButton(self, self:getLineGroup(), "一键开启迷雾", self.openFog, self)
	self.addButton(self, self:getLineGroup(), "看昼夜效果", self.testAmbient, self)

	self._txtEventId = self:addInputText(self:getLineGroup())

	self.addButton(self, self:getLineGroup(), "创建事件", self.addEvent, self)
	self:addLineIndex()

	local list = {
		"普通雨",
		"垃圾雨",
		"苦力怕雨"
	}

	self._rainDrop = self.addDropDown(self, self:getLineGroup(), "暴雨类型", list, self._onRainDropChange, self)

	self._rainDrop:SetValue(self:getCurRainId() - 1)

	self._txtItemId = self:addInputText(self:getLineGroup())

	self.addButton(self, self:getLineGroup(), "加10个道具", self.addItem, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "清空周围所有事件", self.clearUnit, self)

	local list2 = {
		"瘴气",
		"泥沼",
		"岩浆",
		"冰面",
		"水域"
	}

	self._spBlockDrop = self:addDropDown(self:getLineGroup(), "特殊地形", list2)

	self.addButton(self, self:getLineGroup(), "设置周围地形类型", self.setBlockType, self)
	self:addTitleSplitLine("通用")
	self:addLineIndex()

	self._txtCurrency = self:addInputText(self:getLineGroup(), "10000")

	self.addButton(self, self:getLineGroup(), "添加所有货币", self.addCurrency, self)
	self.addButton(self, self:getLineGroup(), "清空背包", self.clearBag, self)
	self.addButton(self, self:getLineGroup(), "添加快捷道具", self.addQuick, self)
	self:addTitleSplitLine("属性-避难所")
	self:addAttrInput("无法被治疗复活", 104, true)
	self:addAttrInput("健康度上限", 105)
	self:addTitleSplitLine("属性-掉落")
	self:addAttrInput("掉落数量", 201, true)
	self:addAttrInput("掉落可选数量", 202)
	self:addTitleSplitLine("属性-价值属性")
	self:addAttrInput("购买价格", 301, true)
	self:addAttrInput("出售价格", 302)
	self:addAttrInput("建筑购买价值", 303, true)
	self:addAttrInput("建筑出售价值", 304)
	self:addTitleSplitLine("属性-健康度")
	self:addAttrInput("健康度减少", 501, true)
	self:addAttrInput("探索战斗失败", 502)
	self:addAttrInput("避难所战斗失败", 503, true)
	self:addAttrInput("探索超时", 504)
	self:addAttrInput("处于毒圈", 505, true)
	self:addAttrInput("健康度增加", 601)
	self:addTitleSplitLine("属性-平衡属性")
	self:addAttrInput("平衡角色等级", 701, true)
	self:addAttrInput("平衡共鸣等级", 702)
	self:addAttrInput("平衡心相等级", 703, true)
	self:addTitleSplitLine("属性-探索属性")
	self:addAttrInput("视野范围", 801, true)
	self:addAttrInput("玩法最大天数", 802)
	self:addAttrInput("移动耗时", 803, true)
	self:addAttrInput("撤离损失", 805)
	self:addAttrInput("探索角色数量", 806, true)
	self:addAttrInput("探索Npc数量", 807)
	self:addAttrInput("世界等级", 808, true)
	self:addAttrInput("招募价值修正", 810)
	self:addAttrInput("选项消耗时间修正", 811, true)
	self:addAttrInput("角色战斗等级", 812)
	self:addAttrInput("额外负重", 813, true)
	self:addAttrInput("金币转换率", 814)
	self:addAttrInput("不会被警戒发现", 817, true)
	self:addAttrInput("视野范围2", 818)
	self:addAttrInput("额外搜刮金币", 820, true)
	self:addAttrInput("快捷道具复制率", 821)
	self:addAttrInput("快捷道具复制率修正", 822, true)
	self:addAttrInput("探索商店购买修正", 823)
	self:addAttrInput("探索出售修正", 824, true)
	self:addAttrInput("声望修正", 825)
	self:addAttrInput("怪物视野", 826, true)
	self:addTitleSplitLine("属性-载具")
	self:addAttrInput("瘴气车", 1001, true)
	self:addAttrInput("沼泽车", 1002)
	self:addAttrInput("耐热车", 1003, true)
	self:addAttrInput("履带车", 1004)
	self:addAttrInput("动力船", 1005, true)
	self:addTitleSplitLine("属性-难度")
	self:addAttrInput("警戒范围修正", 1201, true)
	self:addAttrInput("解码进度修正", 1202)
	self:addAttrInput("是否有云雾", 1203, true)
end

function GMSubViewSurvival:addAttrInput(name, attrId, isNewLine)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	if isNewLine then
		self:addLineIndex()
	end

	self:addLabel(self:getLineGroup(), string.format("%s(%s)", name, attrId))
	self.addInputText(self, self:getLineGroup(), weekInfo:getAttrRaw(attrId), nil, function(_, val)
		if not tonumber(val) then
			return
		end

		GMRpc.instance:sendGMRequest("surAttr " .. attrId .. " " .. val)
	end, self)
end

function GMSubViewSurvival:setDay()
	GMRpc.instance:sendGMRequest("surChangeDay " .. self._txtDay:GetText())
end

function GMSubViewSurvival:openSurvivalView()
	SurvivalController.instance:openSurvivalView(true)
end

function GMSubViewSurvival:addAllNPC()
	GMRpc.instance:sendGMRequest("surAddNpc 0")
end

function GMSubViewSurvival:clearBag()
	GMRpc.instance:sendGMRequest("surDeleteAllBag")
end

function GMSubViewSurvival:addCurrency()
	local num = tonumber(self._txtCurrency:GetText()) or 10000

	for i = 1, 1 do
		GMRpc.instance:sendGMRequest("surAddItem " .. i .. " " .. num)
	end
end

function GMSubViewSurvival:addQuick()
	for _, v in ipairs(lua_survival_item.configList) do
		if v.type == SurvivalEnum.ItemType.Quick then
			GMRpc.instance:sendGMRequest("surAddItem " .. v.id .. " " .. 99)
		end
	end
end

function GMSubViewSurvival:addEvent()
	GMRpc.instance:sendGMRequest("surCreateUnit " .. self._txtEventId:GetText())
end

function GMSubViewSurvival:addItem()
	GMRpc.instance:sendGMRequest("surAddItem " .. self._txtItemId:GetText() .. " " .. 10)
end

function GMSubViewSurvival:addAllItem()
	GMRpc.instance:sendGMRequest("surAddAllItem 10000")
end

function GMSubViewSurvival:enterSurvival()
	local isOneKeyEnter = false

	local function recvCb(cb, cmd, resultCode, msg)
		if resultCode == 0 then
			cb()
		end
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(recvCb, function()
		local function enterSurvivalCb()
			local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

			if weekInfo.inSurvival then
				SurvivalController.instance:enterSurvivalMap()
			else
				if weekInfo:isInFight() then
					SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
				end

				local initGroup = SurvivalMapModel.instance:getInitGroup()

				initGroup:init()

				initGroup.selectMapIndex = 0

				if not initGroup.allSelectHeroMos[1] then
					CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)

					for _, heroMo in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
						if weekInfo:getHeroMo(heroMo.heroId).health > 0 then
							initGroup.allSelectHeroMos[1] = heroMo

							break
						end
					end
				end

				if not initGroup.allSelectHeroMos[1] then
					ToastController.instance:showToastWithString("一个角色都没有???")

					return
				end

				SurvivalController.instance:enterSurvivalMap(initGroup, 0)

				if isOneKeyEnter then
					TaskDispatcher.runDelay(function()
						GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, nil)
					end, self, 2)
				end
			end
		end

		local function enterWeek()
			local weekMo = SurvivalShelterModel.instance:getWeekInfo()

			if weekMo.day > 0 then
				enterSurvivalCb()
			else
				SurvivalWeekRpc.instance:sendSurvivalChooseBooty(nil, nil, recvCb, enterSurvivalCb)
			end
		end

		if not SurvivalModel.instance:getOutSideInfo().inWeek then
			isOneKeyEnter = true

			SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(1, nil, SurvivalModel.instance:getDefaultRoleId(), recvCb, enterWeek)
		else
			SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(recvCb, enterSurvivalCb)
		end
	end)
	self:closeThis()
end

function GMSubViewSurvival:openFog()
	if not SurvivalMapHelper.instance:getScene() then
		ToastController.instance:showToastWithString("不在探索场景中")

		return
	end

	GMRpc.instance:sendGMRequest("surOneKeyVision")
end

function GMSubViewSurvival:testAmbient()
	self:closeThis()
	ZProj.TweenHelper.DOTweenFloat(0, 1440, 10, function(_, value)
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		sceneMo.gameTime = value + sceneMo.addTime

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapGameTimeUpdate, SurvivalEnum.GameTimeUpdateReason.Normal)
		GameSceneMgr.instance:getCurScene().ambient:_onTweenFrame(1)
	end, nil, {}, nil, EaseType.Linear)
end

function GMSubViewSurvival:_onRainDropChange(index)
	local rainId = index + 1

	if rainId == self:getCurRainId() then
		return
	end

	local fogComp = SurvivalMapHelper.instance:getSceneFogComp()

	if not fogComp then
		return
	end

	if not fogComp._rainEntity then
		return
	end

	fogComp._rainEntity:setCurRain(rainId)

	for i, v in ipairs(lua_survival_rain.configList) do
		if v.type == rainId then
			GMRpc.instance:sendGMRequest("surSetRainId " .. v.id)

			break
		end
	end
end

function GMSubViewSurvival:getCurRainId()
	local fogComp = SurvivalMapHelper.instance:getSceneFogComp()

	if not fogComp then
		return 1
	end

	if not fogComp._rainEntity then
		return 1
	end

	return fogComp._rainEntity._rainId
end

function GMSubViewSurvival:clearUnit()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if not sceneMo then
		return
	end

	for k, v in pairs(SurvivalHelper.instance:getAllPointsByDis(sceneMo.player.pos, 10)) do
		local units = sceneMo:getUnitByPos(v, true, true)

		for _, vv in pairs(units) do
			GMRpc.instance:sendGMRequest("surDelUnit " .. vv.id)
		end
	end

	for k, v in pairs(sceneMo.blocks) do
		if SurvivalHelper.instance:getDistance(v.pos, sceneMo.player.pos) <= 10 then
			GMRpc.instance:sendGMRequest("surDelUnit " .. v.id)
		end
	end
end

function GMSubViewSurvival:setBlockType()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if not sceneMo then
		return
	end

	local blockId = self._spBlockDrop:GetValue() + 70001

	self:clearUnit()

	local mapCo = SurvivalMapModel.instance:getCurMapCo()
	local playerPos = sceneMo.player.pos

	for k, v in pairs(SurvivalHelper.instance:getAllPointsByDis(playerPos, 3)) do
		if SurvivalHelper.instance:getValueFromDict(mapCo.rawWalkables, v) then
			GMRpc.instance:sendGMRequest("surCreateUnitAtPos " .. blockId .. " " .. v.q .. " " .. v.r)
		end
	end
end

return GMSubViewSurvival
