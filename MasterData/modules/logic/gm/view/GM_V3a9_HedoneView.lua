-- chunkname: @modules/logic/gm/view/GM_V3a9_HedoneView.lua

module("modules.logic.gm.view.GM_V3a9_HedoneView", package.seeall)

local GM_V3a9_HedoneView = class("GM_V3a9_HedoneView", GMSubViewBase)

function GM_V3a9_HedoneView:onOpen()
	self._subViewGo = gohelper.clone(self._goSubViewTemplate, self._goSubViews, "赫多涅角色活动")
	self._content = gohelper.findChild(self._subViewGo, "viewport/content")

	gohelper.setActive(self._subViewGo, false)
end

function GM_V3a9_HedoneView:showSubView()
	gohelper.setActive(self._subViewGo, true)
	self:initViewContent()
end

function GM_V3a9_HedoneView:initViewContent()
	if self._isInit then
		return
	end

	local i = 1

	while true do
		local func = self["_initL" .. i]

		if not func then
			break
		end

		func(self)

		i = i + 1
	end

	self._isInit = true
end

function GM_V3a9_HedoneView:_getAlivePlayerMO()
	local playerMO = HedoneGameModel.instance:getPlayerMO()

	if not playerMO or not playerMO:getIsAlive() then
		GameFacade.showToastString("玩家未存活")

		return
	end

	return playerMO
end

function GM_V3a9_HedoneView:_initL1()
	local LStr = "L1"

	self:addTitleSplitLine("作弊指令")

	local subLStr1 = LStr .. 1

	self.addButton(self, subLStr1, "玩家升级", self._onClickLevelUp, self)
	self.addButton(self, subLStr1, "回满血量", self._onClickHealHp, self)
	self.addButton(self, subLStr1, "一键胜利", self._onClickWin, self)
	self.addButton(self, subLStr1, "白板玩家", self._onClickClearPlayer, self)

	local subLStr2 = LStr .. 2

	self:addLabel(subLStr2, "添加技能")

	self._addSkillIdText = self:addInputText(subLStr2, nil, "技能ID#技能ID#...")

	self.addButton(self, subLStr2, "确定", self._onClickAddSkill, self)
	self:addLabel(subLStr2, "添加BUFF")

	self._addBuffIdText = self:addInputText(subLStr2, nil, "BUFF ID")

	self.addButton(self, subLStr2, "确定", self._onClickAddBuff, self)
end

function GM_V3a9_HedoneView:_onClickLevelUp()
	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	local needExp = playerMO:getLevelUpNeedExp()
	local curExp = playerMO:getCurExp()

	HedoneGameController.instance:playerAddExp(needExp - curExp)
end

function GM_V3a9_HedoneView:_onClickHealHp()
	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	local hpCap = playerMO:getAttrValue(HedoneGameEnum.Attribute.HpCap)

	playerMO:changeHp(hpCap)
end

function GM_V3a9_HedoneView:_onClickWin()
	HedoneGameModel.instance:setGameEnd()
	HedoneController.instance:openGameResultView(true)
	self:closeThis()
end

function GM_V3a9_HedoneView:_onClickClearPlayer()
	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	local playerUid = HedoneGameEnum.Const.PlayerUid

	playerMO:ctor({
		skipDefaultCDSkill = true,
		uid = playerUid,
		id = playerUid
	})

	HedoneGameModel.instance._cdSkillDamageDict = {}

	HedoneGameController.instance:dispatchEvent(HedoneEvent.RefreshGameView)
end

function GM_V3a9_HedoneView:_onClickAddSkill()
	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	local strSkillIds = self._addSkillIdText:GetText()
	local skillIdList = string.splitToNumber(strSkillIds, "#")

	for _, skillId in ipairs(skillIdList) do
		local skillCfg = HedoneConfig.instance:getHedoneSkillCfg(skillId, true)

		if not skillCfg then
			GameFacade.showToastString(string.format("技能配置不存在:%s", skillId))

			return
		end

		HedoneSkillMgr.instance:playerAddSkill(skillId)
	end
end

function GM_V3a9_HedoneView:_onClickAddBuff()
	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	local buffId = tonumber(self._addBuffIdText:GetText())
	local skillCfg = HedoneConfig.instance:getHedoneBuffCfg(buffId, true)

	if not skillCfg then
		GameFacade.showToastString(string.format("BUFF配置不存在:%s", buffId))

		return
	end

	playerMO:addBuff(buffId)
end

function GM_V3a9_HedoneView:_initL2()
	local LStr = "L2"

	self:addTitleSplitLine("打印信息")

	local subLStr1 = LStr .. 1

	self.addButton(self, subLStr1, "玩家属性", self._onClickPrintPlayerAttr, self)
	self.addButton(self, subLStr1, "技能信息", self._onClickPrintSkillInfo, self)
	self.addButton(self, subLStr1, "BUFF信息", self._onClickPrintBuffInfo, self)
	self:addLabel(subLStr1, "怪物属性")

	self._monsterUidText = self:addInputText(subLStr1, nil, "怪物UID")

	self.addButton(self, subLStr1, "确定", self._onClickPrintMonsterAttr, self)

	local subLStr2 = LStr .. 2

	self:addLabel(subLStr2, "直接设置玩家等级（不获取技能）")

	self._lvText = self:addInputText(subLStr2, nil, "玩家等级")

	self.addButton(self, subLStr2, "确定", self._onClickSetPlayerLevel, self)

	local subLStr3 = LStr .. 3

	self:addLabel(subLStr3, "游戏时间")

	self._timeText = self:addInputText(subLStr3, nil, "")

	self.addButton(self, subLStr3, "确定", self._onClickSetGameTime, self)
end

local OwnerTypeStrMap = {
	[HedoneGameEnum.AttributeOwnerType.Skill] = "技能类型",
	[HedoneGameEnum.AttributeOwnerType.Effect] = "效果组"
}

function GM_V3a9_HedoneView:_getAttrList(mo)
	local attrSet = mo and mo:getAttrSetMO()

	if not attrSet then
		return
	end

	local attrList = {}
	local maxAttrPrefixLen = 0
	local valueDict = attrSet:getValueDict()

	for attrId, data in pairs(valueDict) do
		if type(data) == "table" then
			local ownerType = HedoneConfig.instance:getHedoneAttributeOwnerType(attrId)

			if not OwnerTypeStrMap[ownerType] then
				local ownerTypeStr = ""

				for subId, value in pairs(data) do
					local baseVal = attrSet:getAttrBaseValue(attrId, subId)
					local strPrefix = string.format("\n%s:<color=yellow>%s</color>", ownerTypeStr, subId)

					maxAttrPrefixLen = self:_addAttrData(attrId, subId, strPrefix, baseVal, value, maxAttrPrefixLen, attrList)
				end
			end
		else
			local name = HedoneConfig.instance:getHedoneAttributeName(attrId)
			local strPrefix = string.format("\n%s-%s", attrId, name)
			local baseVal = attrSet:getAttrBaseValue(attrId)

			maxAttrPrefixLen = self:_addAttrData(attrId, nil, strPrefix, baseVal, data, maxAttrPrefixLen, attrList)
		end
	end

	table.sort(attrList, function(a, b)
		local aOwnerType = HedoneConfig.instance:getHedoneAttributeOwnerType(a.id)
		local bOwnerType = HedoneConfig.instance:getHedoneAttributeOwnerType(b.id)

		if aOwnerType ~= bOwnerType then
			return aOwnerType < bOwnerType
		end

		if a.id ~= b.id then
			return a.id < b.id
		end

		return a.subId < b.subId
	end)

	return attrList, maxAttrPrefixLen
end

function GM_V3a9_HedoneView:_addAttrData(attrId, subId, strPrefix, baseVal, val, maxAttrPrefixLen, refAttrList)
	local charArr = GameUtil.getUCharArrWithoutRichTxt(strPrefix)
	local prefixLen = #charArr

	refAttrList[#refAttrList + 1] = {
		id = attrId,
		subId = subId,
		prefix = strPrefix,
		prefixLen = prefixLen,
		baseVal = baseVal,
		val = val
	}

	return maxAttrPrefixLen < prefixLen and prefixLen or maxAttrPrefixLen
end

function GM_V3a9_HedoneView:_getAttrLog(attrList, maxPrefixLen)
	local log = ""
	local lastAttrId, lastSubId

	for _, attrData in ipairs(attrList) do
		local curAttrId = attrData.id
		local curSubId = attrData.subId

		if lastAttrId ~= curAttrId then
			if curSubId then
				local name = HedoneConfig.instance:getHedoneAttributeName(curAttrId)

				log = log .. string.format("\n\n%s-%s", curAttrId, name)
			elseif lastSubId then
				log = log .. "\n"
			end
		end

		local strVal = string.format("基础值:<color=green>%s</color> 生效值:<color=green>%s</color>", tostring(attrData.baseVal), tostring(attrData.val))

		log = log .. attrData.prefix .. string.rep(" ", (maxPrefixLen - attrData.prefixLen) * 4) .. strVal
		lastAttrId = curAttrId
		lastSubId = curSubId
	end

	return log
end

function GM_V3a9_HedoneView:_onClickPrintPlayerAttr()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local attrList, maxAttrPrefixLen = self:_getAttrList(playerMO)

	if not attrList then
		return
	end

	local log = "============================玩家属性============================"

	log = log .. self:_getAttrLog(attrList, maxAttrPrefixLen) .. "\n"

	logError(log)
end

function GM_V3a9_HedoneView:_onClickPrintSkillInfo()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local skillSet = playerMO and playerMO:getSkillSetMO()

	if not skillSet then
		return
	end

	local sortedSkillIds = {}
	local skillId2UidList = skillSet:getSkillId2UidList()

	for skillId in pairs(skillId2UidList) do
		sortedSkillIds[#sortedSkillIds + 1] = skillId
	end

	table.sort(sortedSkillIds)

	local log = "============================玩家技能============================"
	local copySkillIdList = {}

	for _, skillId in ipairs(sortedSkillIds) do
		local skillName = HedoneConfig.instance:getHedoneSkillName(skillId)
		local uidList = skillId2UidList[skillId]

		log = log .. string.format("\n<color=green>%s</color>-%s-数量:<color=green>%s</color>  uids:", skillId, skillName, #uidList)

		for _, uid in ipairs(uidList) do
			log = log .. string.format(" %s", uid)
			copySkillIdList[#copySkillIdList + 1] = skillId
		end
	end

	local copySkillIds = table.concat(copySkillIdList, "#")

	if not string.nilorempty(copySkillIds) then
		ZProj.UGUIHelper.CopyText(copySkillIds)
	end

	log = log .. "\n"

	logError(log)
end

function GM_V3a9_HedoneView:_onClickPrintBuffInfo()
	local playerMO = HedoneGameModel.instance:getPlayerMO()
	local buffSet = playerMO and playerMO:getBuffSetMO()

	if not buffSet then
		return
	end

	local buffId2UidList = buffSet:getBuffId2UidList()
	local sortedBuffIds = {}

	for buffId in pairs(buffId2UidList) do
		sortedBuffIds[#sortedBuffIds + 1] = buffId
	end

	table.sort(sortedBuffIds)

	local log = "============================玩家BUFF============================"

	for _, buffId in ipairs(sortedBuffIds) do
		local uidList = buffId2UidList[buffId]
		local lifeType = HedoneConfig.instance:getHedoneBuffLifeRule(buffId)

		log = log .. string.format("\n%s-数量:<color=green>%s</color>", buffId, #uidList)

		local isPermanent = lifeType == HedoneGameEnum.BuffLifeRule.Permanent

		for _, uid in ipairs(uidList) do
			if isPermanent then
				log = log .. string.format("\n    uid:%s <color=green>永久</color>", uid)
			else
				local buff = buffSet:getBuffInSet(uid)

				if buff then
					local maxLife = buff:getMaxLife()
					local consumedLife = buff:getConsumedLife()
					local remainLife = maxLife - consumedLife

					log = log .. string.format("\n    uid:%s 生命周期:<color=green>%s</color> 消耗值:<color=green>%s</color> 剩余值:<color=green>%s</color>", uid, maxLife, consumedLife, remainLife)
				end
			end
		end

		log = log .. "\n"
	end

	logError(log)
end

function GM_V3a9_HedoneView:_onClickPrintMonsterAttr()
	local uid = tonumber(self._monsterUidText:GetText())
	local mo = HedoneGameModel.instance:getEntityMO(uid)

	if not mo then
		GameFacade.showToastString(string.format("怪物不存在:%s", uid))

		return
	end

	local attrList, maxAttrPrefixLen = self:_getAttrList(mo)

	if not attrList then
		return
	end

	local entityType = mo:getEntityType()
	local id = mo:getId()
	local log = string.format("============================ %s-%s-%s 属性============================", entityType, id, uid)

	log = log .. self:_getAttrLog(attrList, maxAttrPrefixLen) .. "\n"

	logError(log)
end

function GM_V3a9_HedoneView:_onClickSetPlayerLevel()
	local lv = tonumber(self._lvText:GetText())

	if not lv then
		return
	end

	local playerMO = self:_getAlivePlayerMO()

	if not playerMO then
		return
	end

	playerMO._lv = lv

	HedoneGameController.instance:dispatchEvent(HedoneEvent.RefreshGameView)
end

function GM_V3a9_HedoneView:_onClickSetGameTime()
	local time = tonumber(self._timeText:GetText())

	HedoneGameModel.instance._gameTime = math.max(0, time or 0)

	HedoneGameController.instance:dispatchEvent(HedoneEvent.RefreshGameView)
end

function GM_V3a9_HedoneView:_initL3()
	local LStr = "L3"

	self:addTitleSplitLine("怪物测试")

	local subLStr1 = LStr .. 1

	self:addLabel(subLStr1, "召唤波次")

	self._addWaveIdText = self:addInputText(subLStr1, nil, "波次ID")

	self.addButton(self, subLStr1, "确定", self._onClickSummonWave, self)
	self:addLabel(subLStr1, "召唤怪物组")

	self._addMonsterGroupIdText = self:addInputText(subLStr1, nil, "怪物组ID")

	self.addButton(self, subLStr1, "确定", self._onClickSummonMonsterGroup, self)

	local subLStr2 = LStr .. 2

	self:addLabel(subLStr2, "召唤怪物")

	self._addMonsterText = self:addInputText(subLStr2, nil, "(怪物组ID#)怪物ID", nil, nil, {
		w = 400,
		h = 80
	})

	self.addButton(self, subLStr2, "确定", self._onClickSummonMonster, self)

	self._logDamageToggle = self.addToggle(self, subLStr2, "输出伤害日志", self._onLogDamageToggleValueChange, self)
	self._logDamageToggle.isOn = HedoneGameModel.instance:getIsLogDamage()
end

function GM_V3a9_HedoneView:_onClickSummonWave()
	local gmAddWaveId = tonumber(self._addWaveIdText:GetText())
	local waveCfg = HedoneConfig.instance:getHedoneWaveCfg(gmAddWaveId)

	if not waveCfg then
		GameFacade.showToastString(string.format("波次配置不存在:%s", gmAddWaveId))

		return
	end

	HedoneGameController.instance:_checkMonsterWave(gmAddWaveId)
end

function GM_V3a9_HedoneView:_onClickSummonMonsterGroup()
	local groupId = tonumber(self._addMonsterGroupIdText:GetText())
	local groupCfg = HedoneConfig.instance:getHedoneMonsterGroupCfg(groupId)

	if not groupCfg then
		GameFacade.showToastString(string.format("怪物组配置不存在:%s", groupId))

		return
	end

	local idPool = HedoneGameController.instance:_buildMonsterIdPool(groupId)

	HedoneGameController.instance:_spawnMonsterWave(groupId, idPool)
end

function GM_V3a9_HedoneView:_onClickSummonMonster()
	local groupId, monsterId
	local data = string.splitToNumber(self._addMonsterText:GetText(), "#")

	if #data > 1 then
		groupId = data[1]

		local groupCfg = HedoneConfig.instance:getHedoneMonsterGroupCfg(data[1])

		if not groupCfg then
			GameFacade.showToastString(string.format("怪物组配置不存在:%s", groupId))

			return
		end

		monsterId = data[2]
	else
		groupId = lua_activity220_hedone_monster_group.configList[1].id
		monsterId = data[1]
	end

	local monsterCfg = HedoneConfig.instance:getHedoneMonsterCfg(monsterId)

	if not monsterCfg then
		GameFacade.showToastString(string.format("怪物配置不存在:%s", monsterId))

		return
	end

	local monsterXRange = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterXRange, false, true, "#")

	if monsterXRange then
		if not monsterXRange[1] then
			local startX = 0
			local yLevelPosList = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterYLevel, false, true, "|")
			local randomYLevel = math.random(1, #yLevelPosList)
			local monsterData = {
				id = monsterId,
				posX = startX,
				posY = yLevelPosList[randomYLevel],
				yLevel = randomYLevel,
				entityType = HedoneGameEnum.EntityType.Monster,
				groupId = groupId
			}

			HedoneGameController.instance:addEntityList({
				monsterData
			})
		end
	end
end

function GM_V3a9_HedoneView:_onLogDamageToggleValueChange(param, isOn)
	HedoneGameModel.instance:setIsLogDamage(isOn)
end

function GM_V3a9_HedoneView:closeSubView()
	gohelper.setActive(self._subViewGo, false)
	HedoneGameController.instance:resumeGame(HedoneGameEnum.StopSource.GMPanel)
end

function GM_V3a9_HedoneView:onDestroyView()
	self:closeSubView()
end

return GM_V3a9_HedoneView
