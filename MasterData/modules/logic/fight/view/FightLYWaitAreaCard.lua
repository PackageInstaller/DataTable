-- chunkname: @modules/logic/fight/view/FightLYWaitAreaCard.lua

module("modules.logic.fight.view.FightLYWaitAreaCard", package.seeall)

local FightLYWaitAreaCard = class("FightLYWaitAreaCard", UserDataDispose)

FightLYWaitAreaCard.LY_CardPath = "ui/viewres/fight/fight_liangyuecardview.prefab"
FightLYWaitAreaCard.LY_MAXPoint = 6

function FightLYWaitAreaCard.Create(go)
	local card = FightLYWaitAreaCard.New()

	card:init(go)

	return card
end

function FightLYWaitAreaCard:init(go)
	self:__onInit()

	self.loaded = false
	self.goContainer = go
	self.LYLoader = PrefabInstantiate.Create(self.goContainer)

	self.LYLoader:startLoad(self.getResPath(), self.onLoadLYCardDone, self)
end

function FightLYWaitAreaCard.getResPath()
	local skin = FightDataHelper.entityMgr:getHeroSkin(FightEnum.HeroId.LY)
	local co = skin and lua_fight_sp_card_ly.configDict[skin]

	co = co or lua_fight_sp_card_ly.configList[1]

	return string.format("ui/viewres/fight/%s.prefab", co.path)
end

function FightLYWaitAreaCard:onLoadLYCardDone(loader)
	self.loaded = true
	self.LY_instanceGo = self.LYLoader:getInstGO()
	self.rectTr = self.LY_instanceGo:GetComponent(gohelper.Type_RectTransform)
	self.animator = gohelper.findChildComponent(self.LY_instanceGo, "current", gohelper.Type_Animator)
	self.LY_goCardBack = gohelper.findChild(self.LY_instanceGo, "current/back")

	gohelper.setActive(self.LY_goCardBack, true)

	self.goSkillList = self:getUserDataTb_()

	for i = 1, 3 do
		table.insert(self.goSkillList, gohelper.findChild(self.LY_goCardBack, tostring(i)))
	end

	self.LY_pointItemList = {}

	for i = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local pointItem = self:getUserDataTb_()

		pointItem.go = gohelper.findChild(self.LY_instanceGo, "current/font/energy/" .. i)
		pointItem.goRed = gohelper.findChild(pointItem.go, "red")
		pointItem.goBlue = gohelper.findChild(pointItem.go, "green")
		pointItem.goBoth = gohelper.findChild(pointItem.go, "both")
		pointItem.animator = pointItem.go:GetComponent(gohelper.Type_Animator)

		table.insert(self.LY_pointItemList, pointItem)
	end

	self:refreshLYCard()
	self:setAnchorX(self.recordAnchorX)
	self:setScale(self.scale)
	self.addEventCb(self, FightController.instance, FightEvent.LY_HadRedAndBluePointChange, self.onPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.LY_PointAreaSizeChange, self.refreshLYCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.LY_TriggerCountSkill, self.onTriggerSkill, self)
end

function FightLYWaitAreaCard:onPointChange(pointList, preLen)
	if not self.loaded then
		return
	end

	local serverPointList = FightDataHelper.LYDataMgr:getPointList()

	if not serverPointList then
		gohelper.setActive(self.goContainer, false)

		return
	end

	gohelper.setActive(self.goContainer, true)

	local areaSize = FightDataHelper.LYDataMgr.LYPointAreaSize

	self:resetAllPoint()

	areaSize = math.min(math.max(0, areaSize), FightLYWaitAreaCard.LY_MAXPoint)

	if not FightViewRedAndBlueArea.PointIndexList[areaSize + 1] then
		local pointIndexList = {}

		for i = 1, areaSize do
			local index = pointIndexList[i]
			local pointItem = index and self.LY_pointItemList[index]

			gohelper.setActive(pointItem.go, true)

			local color = serverPointList[i]

			gohelper.setActive(pointItem.goRed, color == FightEnum.CardColor.Red)
			gohelper.setActive(pointItem.goBlue, color == FightEnum.CardColor.Blue)
			gohelper.setActive(pointItem.goBoth, color == FightEnum.CardColor.Both)

			if preLen < i and color and color ~= FightEnum.CardColor.None then
				pointItem.animator:Play("active", 0, 0)
			else
				pointItem.animator:Play("empty", 0, 0)
			end
		end

		self.animator:Play("rotate_02", 0, 1)
	end
end

function FightLYWaitAreaCard:resetAllPoint()
	for i = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local pointItem = self.LY_pointItemList[i]

		gohelper.setActive(pointItem.go, false)
	end
end

function FightLYWaitAreaCard:onSkillPlayFinish(entity, skillId)
	if self.waitSkillId == skillId then
		FightDataHelper.LYDataMgr:refreshPointList(true)
		self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)

		self.waitSkillId = nil

		if self.loaded then
			self:refreshLYCard()
			AudioMgr.instance:trigger(20250501)
			self.animator:Play("rotate_02", 0, 0)
		end
	end
end

function FightLYWaitAreaCard:onTriggerSkill(redPoint, bluePoint, skillId)
	self.waitSkillId = skillId

	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)

	if not self.loaded then
		return
	end

	for _, go in ipairs(self.goSkillList) do
		gohelper.setActive(go, false)
	end

	if redPoint == bluePoint then
		gohelper.setActive(self.goSkillList[1], true)
	elseif redPoint < bluePoint then
		gohelper.setActive(self.goSkillList[2], true)
	else
		gohelper.setActive(self.goSkillList[3], true)
	end

	self.animator:Play("rotate_01", 0, 0)
	AudioMgr.instance:trigger(20250500)
end

function FightLYWaitAreaCard:refreshLYCard()
	if not self.loaded then
		return
	end

	local serverPointList = FightDataHelper.LYDataMgr:getPointList()

	if not serverPointList then
		gohelper.setActive(self.goContainer, false)

		return
	end

	gohelper.setActive(self.goContainer, true)

	local areaSize = FightDataHelper.LYDataMgr.LYPointAreaSize

	for i = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local pointItem = self.LY_pointItemList[i]

		if areaSize < i then
			gohelper.setActive(pointItem.go, false)

			break
		end

		local color = serverPointList[i]

		gohelper.setActive(pointItem.go, true)
		gohelper.setActive(pointItem.goRed, color == FightEnum.CardColor.Red)
		gohelper.setActive(pointItem.goBlue, color == FightEnum.CardColor.Blue)
		gohelper.setActive(pointItem.goBoth, color == FightEnum.CardColor.Both)
	end
end

function FightLYWaitAreaCard:resetState()
	self.animator:Play("rotate_02", 0, 1)
end

function FightLYWaitAreaCard:playAnim(animName)
	self.animator:Play(animName, 0, 0)
end

function FightLYWaitAreaCard:setAnchorX(anchorX)
	self.recordAnchorX = anchorX or 0

	if not self.loaded then
		return
	end

	recthelper.setAnchorX(self.rectTr, self.recordAnchorX)
end

function FightLYWaitAreaCard:setScale(scale)
	self.scale = scale or 1

	if not self.loaded then
		return
	end

	transformhelper.setLocalScale(self.rectTr, self.scale, self.scale, self.scale)
end

function FightLYWaitAreaCard:dispose()
	if self.LYLoader then
		self.LYLoader:dispose()

		self.LYLoader = nil
	end

	self:__onDispose()
end

return FightLYWaitAreaCard
