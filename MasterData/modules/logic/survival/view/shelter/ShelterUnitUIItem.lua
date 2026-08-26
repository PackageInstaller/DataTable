-- chunkname: @modules/logic/survival/view/shelter/ShelterUnitUIItem.lua

module("modules.logic.survival.view.shelter.ShelterUnitUIItem", package.seeall)

local ShelterUnitUIItem = class("ShelterUnitUIItem", LuaCompBase)

function ShelterUnitUIItem:ctor(param)
	self.unitType = param.unitType
	self.unitId = param.unitId
	self.root1 = param.root1
	self.root2 = param.root2
	self.bubbleIconName = -1
end

function ShelterUnitUIItem:init(go)
	self.go = go
	self.trans = go.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)

	self.rootGO = gohelper.findChild(go, "root")
	self.animator = self.rootGO:GetComponent(gohelper.Type_Animator)
	self.imagebubble = gohelper.findChildImage(self.rootGO, "#image_bubble")
	self.imageicon = gohelper.findChildImage(self.rootGO, "#image_icon")
	self.cgImg = gohelper.findChildComponent(self.rootGO, "#image_icon", typeof(UnityEngine.CanvasGroup))
	self.goBuildLevelup = gohelper.findChild(self.rootGO, "#go_levelUp")
	self.goCanBuild = gohelper.findChild(self.rootGO, "#go_canBuild")
	self.goRest = gohelper.findChild(self.rootGO, "#go_rest")
	self.goRecruitFinish = gohelper.findChild(self.rootGO, "#go_finish")
	self.goBuildInfo = gohelper.findChild(self.rootGO, "#go_Info")
	self.animGoBuildInfo = self.goBuildInfo:GetComponent(gohelper.Type_Animation)
	self.txtBuildInfo = gohelper.findChildTextMesh(self.rootGO, "#go_Info/Info/#txt_Info")
	self.image_level_reputation = gohelper.findChildImage(self.rootGO, "#go_Info/Info/#txt_Info/#image_level")
	self.go_reddot = gohelper.findChild(self.rootGO, "#go_Info/Info/#txt_Info/#go_reddot")
	self.goMonster = gohelper.findChild(self.rootGO, "monster")
	self.sImageMonsterIcon = gohelper.findChildSingleImage(self.rootGO, "monster/#go_monsterHeadIcon")
	self.goMonsterTime = gohelper.findChild(self.rootGO, "monster/Time")
	self.txtTime = gohelper.findChildTextMesh(self.rootGO, "monster/Time/#txt_LimitTime")
	self.goHero = gohelper.findChild(self.rootGO, "hero")
	self._simage_hero = gohelper.findChildImage(self.rootGO, "hero/#simage_hero")
	self.goarrow = gohelper.findChild(self.rootGO, "arrow")
	self.goarrowright = gohelper.findChild(self.rootGO, "arrow/right")
	self.goarrowtop = gohelper.findChild(self.rootGO, "arrow/top")
	self.goarrowleft = gohelper.findChild(self.rootGO, "arrow/left")
	self.goarrowbottom = gohelper.findChild(self.rootGO, "arrow/bottom")
	self.goRaycast = gohelper.findChild(self.rootGO, "goRaycast")

	self:initClick()
	self:initFollower()
	self:initBg()
	self:refreshInfo()
	self:refreshRedDot()
end

function ShelterUnitUIItem:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function ShelterUnitUIItem:addEventListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationExpReply, self.refreshReputation, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnDelayPopupFinishEvent, self.onDelayPopupFinishEvent, self)
end

function ShelterUnitUIItem:initClick()
	local needClick = SurvivalEnum.ShelterUnitType.Build == self.unitType or SurvivalEnum.ShelterUnitType.Monster == self.unitType or SurvivalEnum.ShelterUnitType.Player == self.unitType

	gohelper.setActive(self.goRaycast, needClick)

	if not needClick or self.click then
		return
	end

	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClick, self)
end

function ShelterUnitUIItem:initFollower()
	if self._uiFollower then
		return
	end

	local entity = self:getEntity()

	if not entity then
		return
	end

	local canShowRange = false

	if self.unitType == SurvivalEnum.ShelterUnitType.Player then
		canShowRange = true
	elseif self.unitType == SurvivalEnum.ShelterUnitType.Npc then
		canShowRange = true
	end

	if not canShowRange then
		gohelper.setActive(self.goarrow, false)

		self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))
	else
		gohelper.setActive(self.goarrow, true)

		self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollowerInRange))

		self._uiFollower:SetBoundArrow(self.goarrowleft, self.goarrowright, self.goarrowtop, self.goarrowbottom)

		local root = ViewMgr.instance:getUIRoot().transform
		local screenRightX = recthelper.getWidth(root)
		local screenTopY = recthelper.getHeight(root)

		screenTopY = screenRightX / screenTopY < 1.7777777777777777 and 1080 or screenTopY

		local halfScreenWidth = screenRightX / 2
		local halfScreenHeight = screenTopY / 2

		self._uiFollower:SetRange(-halfScreenWidth + 250, halfScreenWidth - 150, -halfScreenHeight + 110, halfScreenHeight - 110)
		self._uiFollower:SetArrowCallback(self.onArrowCallback, self)
	end

	self._uiFollower:SetEnable(true)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform
	local transform = entity:getFolowerTransform()

	self._uiFollower:Set(mainCamera, uiCamera, plane, transform, 0, 0.4, 0, 0, 0)
end

function ShelterUnitUIItem:onArrowCallback(isVisible)
	if self.unitType == SurvivalEnum.ShelterUnitType.Player then
		if isVisible then
			self:setVisible(true)
		else
			self:refreshPlayerInfo()
		end
	else
		gohelper.setActive(self.imagebubble, not isVisible)
	end

	if isVisible then
		gohelper.addChildPosStay(self.root2, self.go)
	else
		gohelper.addChildPosStay(self.root1, self.go)
	end
end

function ShelterUnitUIItem:onClick()
	if SurvivalEnum.ShelterUnitType.Player == self.unitType then
		local entity = self:getEntity()

		if entity then
			entity:onClickPlayer()
		end
	end

	local survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()

	if survivalBubbleComp and survivalBubbleComp:isPlayerBubbleIntercept() then
		return
	end

	SurvivalMapHelper.instance:gotoUnit(self.unitType, self.unitId)
end

local unitTypeToBgName = {
	[SurvivalEnum.ShelterUnitType.Monster] = "survival_map_bubble_red"
}

function ShelterUnitUIItem:initBg()
	local unitType = self.unitType

	if not unitTypeToBgName[unitType] then
		UISpriteSetMgr.instance:setSurvivalSprite(self.imagebubble, unitTypeToBgName[unitType])
	end
end

function ShelterUnitUIItem:refreshInfo()
	local unitType = self.unitType

	if unitType == SurvivalEnum.ShelterUnitType.Player then
		self:refreshPlayerInfo()
	elseif unitType == SurvivalEnum.ShelterUnitType.Build then
		self:refreshBuildingInfo()
	elseif unitType == SurvivalEnum.ShelterUnitType.Monster then
		self:refreshMonsterInfo()
	elseif unitType == SurvivalEnum.ShelterUnitType.Npc then
		self:refreshNpcInfo()
	end
end

function ShelterUnitUIItem:refreshNpcInfo()
	local entity = self:getEntity()

	if not entity then
		return
	end

	local isVisible = not entity:isInPlayerPos()

	if isVisible then
		local behaviorConfig = SurvivalMapHelper.instance:getShelterNpcPriorityBehavior(self.unitId)

		isVisible = behaviorConfig and behaviorConfig.isMark == 1 or false
	end

	self:setVisible(isVisible)
	self:setBubbleIcon("survival_map_icon_1")
end

function ShelterUnitUIItem:refreshMonsterInfo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local masterFight = weekInfo:getMonsterFight()

	if masterFight.fightCo == nil then
		self:setVisible(false)

		return
	end

	local entity = self:getEntity()

	if not entity then
		return
	end

	local isVisible = not entity:isInPlayerPos()

	self:setVisible(isVisible)

	if not isVisible then
		return
	end

	gohelper.setActive(self.goMonster, true)
	gohelper.setActive(self.goMonsterTime, false)

	local smallIcon = masterFight.fightCo.smallheadicon

	if smallIcon and (self._lastSmallIcon == nil or smallIcon ~= self._lastSmallIcon) then
		self.sImageMonsterIcon:LoadImage(ResUrl.monsterHeadIcon(smallIcon))

		self._lastSmallIcon = smallIcon
	end
end

function ShelterUnitUIItem:refreshPlayerInfo()
	local entity = self:getEntity()
	local isVisible = entity and entity:isVisible() or false

	self:setVisible(not isVisible)
	gohelper.setActive(self.goHero, true)
	gohelper.setActive(self.imagebubble, false)
	self:setBubbleIcon()

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local path = lua_survival_role.configDict[survivalShelterRoleMo.roleId].moveHead

	UISpriteSetMgr.instance:setSurvivalSprite2(self._simage_hero, path)
end

function ShelterUnitUIItem:refreshBuildingInfo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.unitId)

	if not buildingInfo then
		self:setVisible(false)

		return
	end

	local buildingLevel = buildingInfo:getLevel()
	local hasBuild = buildingInfo:isBuild()

	if not hasBuild then
		local unlock = weekInfo:isBuildingUnlock(buildingInfo.buildingId, buildingLevel + 1)

		if not unlock then
			self:setVisible(false)

			return
		end
	end

	self:setVisible(true)

	local isShowInfo = buildingInfo.baseCo.unName ~= 1

	gohelper.setActive(self.goBuildInfo, hasBuild and isShowInfo)

	local canLevup = weekInfo:isBuildingCanLevup(buildingInfo, buildingLevel + 1, false)

	if not hasBuild then
		self:setBubbleIcon(canLevup and "survival_map_bubble_add")
		gohelper.setActive(self.imagebubble, false)

		return
	end

	self.txtBuildInfo.text = buildingInfo.isSingleLevel and buildingInfo.baseCo.name or string.format("%s\n<size=28>Lv.%s</size>", buildingInfo.baseCo.name, buildingLevel)

	gohelper.setActive(self.goBuildLevelup, canLevup)

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Npc) then
		self:setBubbleIcon("survival_map_icon_20")

		local recruitInfo = weekInfo:getRecruitInfo()
		local isInRecruit = recruitInfo:isInRecruit()
		local isCanSelectNpc = recruitInfo:isCanSelectNpc()

		gohelper.setActive(self.goRest, isInRecruit)

		self.cgImg.alpha = isInRecruit and 0.6 or 1

		gohelper.setActive(self.goRecruitFinish, isCanSelectNpc)
		gohelper.setActive(self.goCanBuild, not isInRecruit and not isCanSelectNpc)
		gohelper.setActive(self.imagebubble, true)

		return
	elseif buildingInfo:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		local reputationId = buildingInfo.survivalReputationPropMo.prop.reputationId
		local reputationLevel = buildingInfo.survivalReputationPropMo.prop.reputationLevel
		local path = SurvivalConfig.instance:getBuildReputationIcon(reputationId, reputationLevel)

		self:setBubbleIcon(path)
		gohelper.setActive(self.imagebubble, true)
		self:refreshReputation(false)

		return
	elseif buildingInfo:isEqualType(SurvivalEnum.BuildingType.Shop) then
		self:setBubbleIcon("survival_map_icon_15")
		gohelper.setActive(self.imagebubble, true)

		return
	end

	self:setBubbleIcon()
	gohelper.setActive(self.imagebubble, false)
end

function ShelterUnitUIItem:OnReceiveSurvivalReputationExpReply()
	self:refreshReputation(true)
end

function ShelterUnitUIItem:onDelayPopupFinishEvent()
	self:refreshReputation(true)
end

function ShelterUnitUIItem:refreshReputation(isCheckChange)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.unitId)

	if not buildingInfo then
		return
	end

	local survivalReputationPropMo = buildingInfo.survivalReputationPropMo
	local isReputationShop = buildingInfo:isEqualType(SurvivalEnum.BuildingType.ReputationShop)

	gohelper.setActive(self.image_level_reputation, isReputationShop)

	if isReputationShop then
		local curLevel = survivalReputationPropMo.prop.reputationLevel
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()
		local clientData = weekMo.clientData
		local shopId = buildingInfo.survivalReputationPropMo.survivalShopMo.id
		local lastLevel = clientData:getReputationShopHUDUILevel(shopId)

		UISpriteSetMgr.instance:setSurvivalSprite(self.image_level_reputation, string.format("survival_level_icon_%s", lastLevel))

		if isCheckChange and lastLevel < curLevel then
			UISpriteSetMgr.instance:setSurvivalSprite(self.image_level_reputation, string.format("survival_level_icon_%s", curLevel))
			self.animGoBuildInfo:Play()
			clientData:setReputationShopHUDUILevel(shopId, curLevel)
		end
	end
end

function ShelterUnitUIItem:refreshRedDot()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.unitId)

	if buildingInfo then
		if buildingInfo:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
			local redDotType = SurvivalConfig.instance:getReputationRedDotType(buildingInfo.buildingId)

			RedDotController.instance:addRedDot(self.go_reddot, redDotType)
		elseif buildingInfo:isEqualType(SurvivalEnum.BuildingType.Tech) then
			RedDotController.instance:addRedDot(self.go_reddot, RedDotEnum.DotNode.SurvivalTeach)
		end
	end
end

function ShelterUnitUIItem:setBubbleIcon(iconName)
	if not self._isVisible then
		return
	end

	if iconName == self.bubbleIconName then
		return
	end

	self.bubbleIconName = iconName

	if not iconName or string.nilorempty(iconName) then
		gohelper.setActive(self.imageicon, false)

		return
	end

	gohelper.setActive(self.imageicon, true)
	UISpriteSetMgr.instance:setSurvivalSprite(self.imageicon, iconName, true)
end

function ShelterUnitUIItem:setVisible(visible)
	if self._isVisible == visible then
		return
	end

	self._isVisible = visible

	gohelper.setActive(self.rootGO, visible)
end

function ShelterUnitUIItem:getEntity()
	return SurvivalMapHelper.instance:getShelterEntity(self.unitType, self.unitId)
end

function ShelterUnitUIItem:dispose()
	gohelper.destroy(self.go)
end

function ShelterUnitUIItem:playAnim(animName)
	if not self._isVisible then
		return
	end

	self.animator:Play(animName, 0, 0)
end

function ShelterUnitUIItem:onDestroy()
	if self.click then
		self.click:RemoveClickListener()
	end

	self._lastSmallIcon = nil
end

return ShelterUnitUIItem
