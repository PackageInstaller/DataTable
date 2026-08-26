-- chunkname: @modules/logic/fight/view/FightEnemyActionView.lua

module("modules.logic.fight.view.FightEnemyActionView", package.seeall)

local FightEnemyActionView = class("FightEnemyActionView", BaseView)
local BuffOutLinePath = "buff/buff_outline"

function FightEnemyActionView:onInitView()
	self._txtskillname = gohelper.findChildText(self.viewGO, "skill/#txt_skillname")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "skill/#scroll_skill")
	self._txtskilldec = gohelper.findChildText(self.viewGO, "skill/#scroll_skill/viewport/content/#txt_skilldec")
	self._btnclose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "card/#scroll_card")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightEnemyActionView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function FightEnemyActionView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function FightEnemyActionView:_btncloseOnClick()
	self:closeThis()
end

function FightEnemyActionView:_editableInitView()
	local resPath = self.viewContainer:getSetting().otherRes[1]

	self.cardPrefab = self.viewContainer:getRes(resPath)
	self.goCardItem = gohelper.findChild(self.viewGO, "card/#scroll_card/viewport/content/carditem")

	gohelper.setActive(self.goCardItem, false)

	self.cardItemList = {}
	self.unitCamera = CameraMgr.instance:getUnitCamera()
	self.tempVector4 = Vector4(0, 0, 0, 0)
	self.startVector3 = Vector3(0, 0, 0)
	self.targetVector3 = Vector3(0, 0, 0)

	self:initRate()
	self:initLine()
	self:initSelectItem()
	SkillHelper.addHyperLinkClick(self._txtskilldec)
	self.addEventCb(self, FightController.instance, FightEvent.OnEnemyActionStatusChange, self.onEnemyActionStatusChange, self)
end

function FightEnemyActionView:initRate()
	local targetRate = 1.7777777777777777
	local curWidth = UnityEngine.Screen.width
	local curHeight = UnityEngine.Screen.height
	local curRate = curWidth / curHeight

	if curRate - targetRate > 0.01 then
		local viewHeight = recthelper.getHeight(self.viewGO.transform)

		self.halfPxHeight = viewHeight / 2
		self.hRate = viewHeight / curHeight

		local widthPx = curRate * viewHeight

		self.halfPxWidth = widthPx / 2
		self.wRate = widthPx / curWidth
	else
		local viewWidth = recthelper.getWidth(self.viewGO.transform)

		self.halfPxWidth = viewWidth / 2
		self.wRate = viewWidth / curWidth

		local heightPx = viewWidth / curRate

		self.halfPxHeight = heightPx / 2
		self.hRate = heightPx / curHeight
	end
end

function FightEnemyActionView:initLine()
	self.goRedFullLine = gohelper.findChild(self.viewGO, "lineContainer/red_fullline")

	gohelper.setActive(self.goRedFullLine, false)

	self.goRedDottedLine = gohelper.findChild(self.viewGO, "lineContainer/red_dottedline")

	gohelper.setActive(self.goRedDottedLine, false)

	self.goYellowFullLine = gohelper.findChild(self.viewGO, "lineContainer/yellow_fullline")

	gohelper.setActive(self.goYellowFullLine, false)

	self.goYellowDottedLine = gohelper.findChild(self.viewGO, "lineContainer/yellow_dottedline")

	gohelper.setActive(self.goYellowDottedLine, false)

	self.redFullLineList = self:getUserDataTb_()

	table.insert(self.redFullLineList, self.goRedFullLine)

	self.redDottedLineList = self:getUserDataTb_()

	table.insert(self.redDottedLineList, self.goRedDottedLine)

	self.yellowFullLineList = self:getUserDataTb_()

	table.insert(self.yellowFullLineList, self.goYellowFullLine)

	self.yellowDottedLineList = self:getUserDataTb_()

	table.insert(self.yellowDottedLineList, self.goYellowDottedLine)

	self.fullLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = self.redFullLineList,
		[FightEnum.SkillLineColor.Yellow] = self.yellowFullLineList
	}
	self.dottedLineColor2LineList = {
		[FightEnum.SkillLineColor.Red] = self.redDottedLineList,
		[FightEnum.SkillLineColor.Yellow] = self.yellowDottedLineList
	}
end

function FightEnemyActionView:initSelectItem()
	self.goSelectContainer = gohelper.findChild(self.viewGO, "selectcontainer")

	gohelper.setActive(self.goSelectContainer, true)

	self.selectContainerTr = self.goSelectContainer:GetComponent(gohelper.Type_RectTransform)
	self.goSelectItem = gohelper.findChild(self.viewGO, "selectcontainer/selectitem")
	self.selectGoList = self:getUserDataTb_()

	table.insert(self.selectGoList, self.goSelectItem)
end

function FightEnemyActionView:onEnemyActionStatusChange(status)
	if status == FightEnum.EnemyActionStatus.Select then
		return
	end

	self:closeThis()
end

function FightEnemyActionView:onOpen()
	self.entityId2Effect = {}
	self._matDict = self:getUserDataTb_()

	FightViewPartVisible.set(false, false, false, false, false)
	self:initBossList()

	local roundData = FightDataHelper.roundMgr:getRoundData()
	local cardList = roundData and roundData:getAIUseCardMOList() or {}

	self.cardList = tabletool.copy(cardList)

	self:filterValidCard()
	self:refreshCardList()
	self:selectCard(self.cardList[1])
end

function FightEnemyActionView:filterValidCard()
	local len = #self.cardList

	for i = len, 1, -1 do
		local cardMo = self.cardList[i]
		local entityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

		if not entityMo then
			table.remove(self.cardList, i)
		end
	end
end

function FightEnemyActionView:initBossList()
	local battleId = FightModel.instance:getBattleId()
	local battleCo = battleId and lua_battle.configDict[battleId]
	local groupIds = battleCo and battleCo.monsterGroupIds

	if not string.nilorempty(groupIds) then
		self.groupBossIdList = {}

		local groupIdList = string.splitToNumber(groupIds, "#")

		for index, groupId in ipairs(groupIdList) do
			local monsterGroupConfig = lua_monster_group.configDict[groupId]

			self.groupBossIdList[index] = monsterGroupConfig and string.splitToNumber(monsterGroupConfig.bossId, "#")
		end
	end
end

function FightEnemyActionView:refreshCardList()
	for _, cardMo in ipairs(self.cardList) do
		local entityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

		if entityMo then
			local cardItem = self:getCardItem(cardMo)

			self:refreshCardItem(cardItem)
		end
	end
end

function FightEnemyActionView:getCardItem(cardMo)
	local cardItem = self:getUserDataTb_()

	cardItem.go = gohelper.cloneInPlace(self.goCardItem)

	gohelper.setActive(cardItem.go, true)

	cardItem.imageQualityBg = gohelper.findChildImage(cardItem.go, "go_enemy/#image_qualitybg")
	cardItem.simageHeadIcon = gohelper.findChildSingleImage(cardItem.go, "go_enemy/#simage_enemyicon")
	cardItem.imageHeadIcon = gohelper.findChildImage(cardItem.go, "go_enemy/#simage_enemyicon")
	cardItem.imageQualityBg = gohelper.findChildImage(cardItem.go, "go_enemy/#image_qualitybg")
	cardItem.goSelectBig = gohelper.findChild(cardItem.go, "select_big")
	cardItem.goSelectSmall = gohelper.findChild(cardItem.go, "select_small")
	cardItem.click = gohelper.findChildClickWithDefaultAudio(cardItem.go, "clickarea")

	cardItem.click:AddClickListener(self.onClickCard, self, cardMo)

	cardItem.goCard = gohelper.findChild(cardItem.go, "go_card")

	local innerCardGo = gohelper.clone(self.cardPrefab, cardItem.goCard)

	cardItem.actionCardItem = FightEnemyActionCardItem.get(innerCardGo, cardMo)
	cardItem.cardMo = cardMo

	table.insert(self.cardItemList, cardItem)

	return cardItem
end

function FightEnemyActionView:refreshCardItem(cardItem)
	local cardMo = cardItem.cardMo
	local entityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

	if not entityMo then
		logError("刷新卡牌未找到entity 数据 : " .. tostring(cardMo.uid))

		return
	end

	local skinId = entityMo.skin
	local modelId = entityMo.modelId

	if skinId then
		::label_15_0::

		local skinConfig = FightConfig.instance:getSkinCO(skinId)

		if skinConfig then
			cardItem.simageHeadIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

			if not FightEntityDataHelper.isPlayerUid(entityMo.id) then
				local monsterCo = entityMo:getCO()
				local matPath = IconMaterialMgr.instance:getMaterialPathWithRound(monsterCo.heartVariantId)

				IconMaterialMgr.instance:loadMaterialAddSet(matPath, cardItem.imageHeadIcon)
			end
		end

		local bgName = self:isBoss(modelId) and "fight_enemyaction_headbg3" or "fight_enemyaction_headbg1"

		UISpriteSetMgr.instance:setFightSprite(cardItem.imageQualityBg, bgName)
		cardItem.actionCardItem:refreshCard()
	end
end

function FightEnemyActionView:isBoss(monsterId)
	if not self.groupBossIdList then
		return false
	end

	local curWave = FightModel.instance:getCurWaveId()
	local bossIdList = self.groupBossIdList[curWave]

	if not bossIdList then
		return false
	end

	for _, bossId in ipairs(bossIdList) do
		if monsterId == bossId then
			return true
		end
	end

	return false
end

function FightEnemyActionView:selectCard(cardMo)
	if FightHelper.isSameCardMo(cardMo, self.selectCardMo) then
		return
	end

	self.selectCardMo = cardMo

	FightController.instance:dispatchEvent(FightEvent.OnSelectMonsterCardMo, self.selectCardMo)
	self:refreshSelectStatus()
	self:refreshSelectText()
	self:refreshSelectLine()
	self:refreshEnemyOutLine()
end

function FightEnemyActionView:refreshSelectStatus()
	for index, cardInfoMo in ipairs(self.cardList) do
		local cardItem = self.cardItemList[index]

		if cardItem then
			local select = cardInfoMo == self.selectCardMo

			if select then
				local isBigSkill = cardInfoMo:isBigSkill()

				gohelper.setActive(cardItem.goSelectBig, isBigSkill)
				gohelper.setActive(cardItem.goSelectSmall, not isBigSkill)
			else
				gohelper.setActive(cardItem.goSelectBig, false)
				gohelper.setActive(cardItem.goSelectSmall, false)
			end
		end
	end
end

function FightEnemyActionView:refreshSelectText()
	local skillCo = lua_skill.configDict[self.selectCardMo.skillId]

	if not skillCo then
		return
	end

	local entityMo = FightDataHelper.entityMgr:getById(self.selectCardMo.uid)

	self._txtskillname.text = skillCo.name
	self._txtskilldec.text = SkillHelper.getSkillDesc(entityMo and entityMo:getEntityName() or nil, skillCo)
end

function FightEnemyActionView:refreshSelectLine()
	local skillCo = lua_skill.configDict[self.selectCardMo.skillId]

	if not skillCo then
		return
	end

	local targetType = self:getTargetType()

	self:hideAllLine()
	self:hideAllSelectUI()

	if targetType == FightEnum.SkillTargetType.Single then
		self:drawSingleLine()
	elseif targetType == FightEnum.SkillTargetType.Multi then
		self:drawMultiLine(skillCo.targetLimit)
	elseif targetType == FightEnum.SkillTargetType.Side then
		self:drawSideLine(skillCo.targetLimit)
	else
		logError("暂不支持全场")
	end
end

function FightEnemyActionView:refreshEnemyOutLine()
	if not self.selectCardMo then
		return
	end

	self:hideAllOutLine()

	local entity = FightHelper.getEntity(self.selectCardMo.uid)

	if not entity then
		return
	end

	local entityId = entity.id

	if not self.entityId2Effect[entityId] and entity.effect then
		local effectWrap = entity.effect:addHangEffect(BuffOutLinePath, ModuleEnum.SpineHangPointRoot, nil, nil, nil, true)

		self.entityId2Effect[entityId] = effectWrap

		effectWrap:setLocalPos(0, 0, 0)

		if gohelper.isNil(effectWrap.effectGO) then
			effectWrap:setCallback(function()
				self:_setOutlineWidth(entityId)
			end)
		else
			self:_setOutlineWidth(entityId)
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)
	end

	if self.entityId2Effect[entityId] then
		self.entityId2Effect[entityId]:setActive(true)
	end
end

local KeyWord = "_OutlineWidth"

function FightEnemyActionView:_setOutlineWidth(entityId)
	local mat = self._matDict[entityId]

	if not mat then
		local effectWrap = self.entityId2Effect[entityId]

		if effectWrap and not gohelper.isNil(effectWrap.effectGO) then
			local renderer = gohelper.findChildComponent(effectWrap.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer))

			if renderer then
				mat = renderer.material

				if renderer.material then
					self._matDict[entityId] = mat
				else
					logError("outline material not found")
				end
			else
				logError("outline render not found")
			end
		end
	end

	if mat then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO then
			::label_23_0::

			local var_23_0 = entityMO.skin

			if entityMO.skin then
				local skinCO = lua_monster_skin.configDict[entityMO.skin]
				local value = skinCO and skinCO.outlineWidth

				if value and value > 0 then
					mat:SetFloat(KeyWord, value)
				else
					mat:SetFloat(KeyWord, 0.0075)
				end
			end
		end
	end
end

function FightEnemyActionView:hideAllOutLine()
	for k, effectWrap in pairs(self.entityId2Effect) do
		effectWrap:setActive(false)
	end
end

function FightEnemyActionView:getTargetType()
	local skillCo = lua_skill.configDict[self.selectCardMo.skillId]

	if not skillCo then
		return FightEnum.SkillTargetType.Single
	end

	local logicTarget = skillCo.logicTarget
	local aiMonsterCo = logicTarget and lua_ai_monster_target.configDict[logicTarget]
	local targetNumber = aiMonsterCo and aiMonsterCo.targetNumber

	return targetNumber or FightEnum.SkillTargetType.Single
end

function FightEnemyActionView:getLineColor()
	local skillCo = lua_skill.configDict[self.selectCardMo.skillId]

	if not skillCo then
		return FightEnum.SkillLineColor.Red
	end

	local showTag = skillCo.showTag
	local cardTagCo = showTag and lua_ai_monster_card_tag.configDict[showTag]

	return (cardTagCo or nil) and (cardTagCo.lineColor or FightEnum.SkillLineColor.Red)
end

FightEnemyActionView.StartParam = UnityEngine.Shader.PropertyToID("_StartVec")
FightEnemyActionView.TargetParam = UnityEngine.Shader.PropertyToID("_EndVec")

function FightEnemyActionView:drawSingleLine()
	local targetEntityId = self.selectCardMo.targetUid
	local startPos = self:getCardScreenPos(self.selectCardMo)
	local targetPos = self:getEntityTopScreenPos(targetEntityId)

	if not startPos or not targetPos then
		return
	end

	local lineColor = self:getLineColor()
	local canUse = self:canUseSkill(self.selectCardMo)

	if canUse then
		if not self.fullLineColor2LineList[lineColor] then
			local lineList = self.dottedLineColor2LineList[lineColor]
			local lineGo = self:getLineGo(1, lineList)

			self:drawLine(lineGo, startPos, targetPos)
			self:showSelectUI(1, targetEntityId)
		end
	end
end

function FightEnemyActionView:drawMultiLine(targetLimit)
	local startPos = self:getCardScreenPos(self.selectCardMo)

	if not startPos then
		return
	end

	local side
	local entityMgr = FightGameMgr.entityMgr

	side = targetLimit == FightEnum.TargetLimit.EnemySide and entityMgr:getTagList(SceneTag.UnitPlayer) or entityMgr:getTagList(SceneTag.UnitMonster)

	local lineColor = self:getLineColor()
	local canUse = self:canUseSkill(self.selectCardMo)
	local count = 0

	for entityId, entity in ipairs(side) do
		if not entity.isSub then
			if canUse and self.selectCardMo.targetUid == entityId then
				if not self.fullLineColor2LineList then
					local lineDict = self.dottedLineColor2LineList
					local lineList = lineDict[lineColor]
					local targetPos = self:getEntityTopScreenPos(entityId)

					if targetPos then
						count = count + 1

						local lineGo = self:getLineGo(count, lineList)

						self:drawLine(lineGo, startPos, targetPos)
						self:showSelectUI(count, entity.id)
					end
				end
			end
		end
	end
end

function FightEnemyActionView:drawSideLine(targetLimit)
	local startPos = self:getCardScreenPos(self.selectCardMo)

	if not startPos then
		return
	end

	local side
	local entityMgr = FightGameMgr.entityMgr

	side = targetLimit == FightEnum.TargetLimit.EnemySide and entityMgr:getTagList(SceneTag.UnitPlayer) or entityMgr:getTagList(SceneTag.UnitMonster)

	local lineColor = self:getLineColor()
	local canUse = self:canUseSkill(self.selectCardMo)
	local count = 0

	for entityId, entity in ipairs(side) do
		if not entity.isSub then
			if canUse then
				if not self.fullLineColor2LineList[lineColor] then
					local lineList = self.dottedLineColor2LineList[lineColor]
					local targetPos = self:getEntityTopScreenPos(entityId)

					if targetPos then
						count = count + 1

						local lineGo = self:getLineGo(count, lineList)

						self:drawLine(lineGo, startPos, targetPos)
						self:showSelectUI(count, entity.id)
					end
				end
			end
		end
	end
end

function FightEnemyActionView:drawLine(lineGo, startPos, targetPos)
	self:setArrowPosition(lineGo, startPos, targetPos)

	startPos, targetPos = self:getFormatPos(startPos, targetPos)

	local effectGo = gohelper.findChild(lineGo, "fulllineeffect")

	if not gohelper.isNil(effectGo) then
		local render = effectGo:GetComponent(typeof(UnityEngine.Renderer))
		local mat = render and render.material

		if mat then
			self:setMatByScreenPos(mat, FightEnemyActionView.StartParam, startPos)
			self:setMatByScreenPos(mat, FightEnemyActionView.TargetParam, targetPos)
		end
	end

	local render = lineGo:GetComponent(typeof(UnityEngine.Renderer))
	local mat = render.material

	self:setMatByScreenPos(mat, FightEnemyActionView.StartParam, startPos)
	self:setMatByScreenPos(mat, FightEnemyActionView.TargetParam, targetPos)
end

FightEnemyActionView.Orient = {
	Right = 1,
	Left = 2
}
FightEnemyActionView.RotationZ = 140

function FightEnemyActionView:setArrowPosition(lineGo, startPos, targetPos)
	local goTou = gohelper.findChild(lineGo, "#tou")

	if goTou then
		if startPos.x <= targetPos.x then
			if not FightEnemyActionView.Orient.Right then
				local orient = FightEnemyActionView.Orient.Left

				if orient == FightEnemyActionView.Orient.Right then
					if not -FightEnemyActionView.RotationZ then
						local rotation = FightEnemyActionView.RotationZ

						transformhelper.setLocalRotation(goTou.transform, 0, 0, rotation)

						local localPosX, localPosY = recthelper.screenPosToAnchorPos2(targetPos, lineGo.transform)

						recthelper.setAnchor(goTou.transform, localPosX, localPosY)
					end
				end
			end
		end
	end
end

function FightEnemyActionView:setMatByScreenPos(mat, param, pos)
	local x = pos.x * self.wRate - self.halfPxWidth
	local y = pos.y * self.hRate - self.halfPxHeight

	self.tempVector4:Set(x, y, 0, 0)
	mat:SetVector(param, self.tempVector4)
end

function FightEnemyActionView:getFormatPos(startPos, targetPos)
	if startPos.x > targetPos.x then
		return targetPos, startPos
	end

	return startPos, targetPos
end

function FightEnemyActionView:getLineGo(index, lineList)
	local lineGo = lineList[index]

	if not lineGo then
		lineGo = gohelper.cloneInPlace(lineList[1])

		table.insert(lineList, lineGo)
	end

	gohelper.setActive(lineGo, true)

	return lineGo
end

function FightEnemyActionView:getCardScreenPos(cardMo)
	local entity = FightHelper.getEntity(cardMo.uid)

	if not entity then
		return
	end

	local itemList = FightMsgMgr.sendMsg(FightMsgId.GetEnemyAiUseCardItemList, entity.id)

	if not itemList then
		return
	end

	for _, item in ipairs(itemList) do
		if FightHelper.isSameCardMo(item.cardData, cardMo) then
			local topRectTr = item.topPosRectTr
			local x, y = recthelper.uiPosToScreenPos2(topRectTr)

			self.startVector3:Set(x, y)

			return self.startVector3
		end
	end
end

function FightEnemyActionView:getEntityTopScreenPos(entityId)
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local nameUi = entity.nameUI

	if not nameUi then
		return
	end

	local topRectTr = nameUi.careerTopRectTr
	local x, y = recthelper.uiPosToScreenPos2(topRectTr)

	self.targetVector3:Set(x, y)

	return self.targetVector3
end

function FightEnemyActionView:hideAllLine()
	self:hideLineList(self.redFullLineList)
	self:hideLineList(self.redDottedLineList)
	self:hideLineList(self.yellowFullLineList)
	self:hideLineList(self.yellowDottedLineList)
end

function FightEnemyActionView:hideLineList(lineList)
	for _, goLine in ipairs(lineList) do
		gohelper.setActive(goLine, false)
	end
end

function FightEnemyActionView:hideAllSelectUI()
	for _, goSelect in ipairs(self.selectGoList) do
		gohelper.setActive(goSelect, false)
	end
end

function FightEnemyActionView:showSelectUI(index, entityId)
	local go = self.selectGoList[index]

	if not go then
		go = gohelper.cloneInPlace(self.goSelectItem)

		table.insert(self.selectGoList, go)
	end

	local entity = FightHelper.getEntity(entityId)

	if not entity then
		gohelper.setActive(go, false)

		return
	end

	gohelper.setActive(go, true)

	local rectTr = go:GetComponent(gohelper.Type_RectTransform)

	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local worldPosX, worldPosY, worldPosZ = transformhelper.getPos(entity.go.transform)
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(worldPosX + config.selectPos[1], worldPosY + config.selectPos[2], worldPosZ, self.selectContainerTr)

		recthelper.setAnchor(rectTr, rectPosX, rectPosY)

		return
	end

	local mountMiddleGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

	if mountMiddleGO and mountMiddleGO.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local worldPosX, worldPosY, worldPosZ = transformhelper.getPos(mountMiddleGO.transform)
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(worldPosX, worldPosY, worldPosZ, self.selectContainerTr)

		recthelper.setAnchor(rectTr, rectPosX, rectPosY)

		return
	end

	local rectPos1X, rectPos1Y, rectPos2X, rectPos2Y = self:_calcRect(entity)

	recthelper.setAnchor(rectTr, (rectPos1X + rectPos2X) / 2, (rectPos1Y + rectPos2Y) / 2)
end

function FightEnemyActionView:_calcRect(entity)
	local bodyStaticGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)
	local bodyPosX, bodyPosY, bodyPosZ = transformhelper.getPos(bodyStaticGO.transform)
	local size, _ = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local sideOp = entity:isMySide() and 1 or -1
	local rectPos1X, rectPos1Y = recthelper.worldPosToAnchorPosXYZ(bodyPosX - size.x * 0.5, bodyPosY - size.y * 0.5 * sideOp, bodyPosZ, self.selectContainerTr)
	local rectPos2X, rectPos2Y = recthelper.worldPosToAnchorPosXYZ(bodyPosX + size.x * 0.5, bodyPosY + size.y * 0.5 * sideOp, bodyPosZ, self.selectContainerTr)

	return rectPos1X, rectPos1Y, rectPos2X, rectPos2Y
end

function FightEnemyActionView:canUseSkill(cardMo)
	local skillId = cardMo.skillId
	local entity = FightHelper.getEntity(cardMo.uid)

	if not entity then
		return true
	end

	local entityMO = entity:getMO()
	local canUse = FightViewHandCardItemLock.canUseCardSkill(entity.id, skillId)
	local isBigSkill = FightCardDataHelper.isBigSkill(skillId)

	if isBigSkill then
		local exPoint = entityMO.exPoint
		local uniqueSkillCost = entityMO:getUniqueSkillPoint()

		canUse = canUse and uniqueSkillCost <= exPoint
	end

	return canUse
end

function FightEnemyActionView:onClickCard(cardMo)
	self:selectCard(cardMo)
end

function FightEnemyActionView:onClose()
	FightViewPartVisible.set(true, true, true, false, false)

	for entityId, effectWrap in pairs(self.entityId2Effect) do
		local entity = FightHelper.getEntity(entityId)

		if entity then
			FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)
			entity.effect:removeEffect(effectWrap)
		end
	end
end

function FightEnemyActionView:onDestroyView()
	for _, cardItem in ipairs(self.cardItemList) do
		cardItem.click:RemoveClickListener()
		cardItem.simageHeadIcon:UnLoadImage()
		cardItem.actionCardItem:destroy()
	end
end

return FightEnemyActionView
