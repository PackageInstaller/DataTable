-- chunkname: @modules/logic/fight/view/FightToughBattleSkillItem.lua

module("modules.logic.fight.view.FightToughBattleSkillItem", package.seeall)

local FightToughBattleSkillItem = class("FightToughBattleSkillItem", LuaCompBase)

function FightToughBattleSkillItem:init(go)
	self.go = go
	self._ani = go:GetComponent(gohelper.Type_Animator)
	go = gohelper.findChild(go, "anchoroffset")
	self._goselect = gohelper.findChild(go, "#go_Selected")
	self._btn = gohelper.getClickWithDefaultAudio(go, "btn")
	self._gonum = gohelper.findChild(go, "#go_Num")
	self._txtnum = gohelper.findChildTextMesh(go, "#go_Num/#txt_Num")
	self._simagechar = gohelper.findChildSingleImage(go, "#simage_Char")
	self._iconImage = gohelper.findChildImage(go, "#simage_Char")
	self._goDetails = gohelper.findChild(go, "#go_details")
	self._txtDetailTitle = gohelper.findChildTextMesh(self._goDetails, "details/#scroll_details/Viewport/Content/#txt_title")
	self._txtDetailContent = gohelper.findChildTextMesh(self._goDetails, "details/#scroll_details/Viewport/Content/#txt_details")
end

function FightToughBattleSkillItem:addEventListeners()
	self._btn:AddClickListener(self.clickIcon, self)

	self._long = SLFramework.UGUI.UILongPressListener.Get(self._btn.gameObject)

	self._long:SetLongPressTime({
		0.5,
		99999
	})
	self._long:AddLongPressListener(self._onLongPress, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self.updateSkillRound, self)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, self.checkHeroIsDead, self)
	FightController.instance:registerCallback(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen, self)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self.updateSkillRound, self)
end

function FightToughBattleSkillItem:removeEventListeners()
	self._btn:RemoveClickListener()
	self._long:RemoveLongPressListener()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self.updateSkillRound, self)
	FightController.instance:unregisterCallback(FightEvent.OnEntityDead, self.checkHeroIsDead, self)
	FightController.instance:unregisterCallback(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen, self)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, self.updateSkillRound, self)
end

function FightToughBattleSkillItem:setCo(co)
	self._co = co

	self:refreshView()
end

function FightToughBattleSkillItem:refreshView()
	if not self._co then
		return
	end

	gohelper.setActive(self._gonum, false)
	self._simagechar:LoadImage(ResUrl.getHandbookheroIcon(self._co.icon))

	if self._co.type == ToughBattleEnum.HeroType.Hero then
		self._trialId = tonumber(self._co.param) or 0

		self:checkHeroIsDead()
	elseif self._co.type == ToughBattleEnum.HeroType.Rule then
		self._ani:Play("passive", 0, 0)
	elseif self._co.type == ToughBattleEnum.HeroType.Skill then
		local arr = string.splitToNumber(self._co.param, "#")

		self._skillId = arr[1] or 0

		self:updateSkillRound()
	end

	self._txtDetailTitle.text = self._co.name
	self._txtDetailContent.text = HeroSkillModel.instance:skillDesToSpot(self._co.desc)
end

function FightToughBattleSkillItem:checkHeroIsDead()
	if not self._co or self._co.type ~= ToughBattleEnum.HeroType.Hero then
		return
	end

	local entityMOs = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)
	local findEntityMO

	for _, entityMO in ipairs(entityMOs) do
		if entityMO.trialId == self._trialId then
			findEntityMO = entityMO

			break
		end
	end

	local color = findEntityMO and "#FFFFFF" or "#c8c8c8"

	SLFramework.UGUI.GuiHelper.SetColor(self._simagechar.gameObject:GetComponent(gohelper.Type_Image), color)

	if findEntityMO then
		self._ani:Play("passive", 0, 0)
	elseif self.go.activeInHierarchy then
		self._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(self._destoryThis, self, 0.667)
	else
		self._isDeaded = true
	end
end

function FightToughBattleSkillItem:onEnable()
	if self._isDeaded and self._ani then
		self._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(self._destoryThis, self, 0.667)
	end
end

function FightToughBattleSkillItem:_destoryThis()
	gohelper.destroy(self.go)
end

function FightToughBattleSkillItem:onDestroy()
	TaskDispatcher.cancelTask(self._destoryThis, self)
end

function FightToughBattleSkillItem:updateSkillRound()
	if not self._co or self._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	local cd = self:getCd()

	if cd > 0 then
		gohelper.setActive(self._gonum, true)

		self._txtnum.text = cd
	else
		gohelper.setActive(self._gonum, false)
	end

	local color = cd <= 0 and "#FFFFFF" or "#808080"

	SLFramework.UGUI.GuiHelper.SetColor(self._simagechar.gameObject:GetComponent(gohelper.Type_Image), color)

	if cd <= 0 then
		self._ani:Play("active", 0, 0)
	else
		self._ani:Play("cooling", 0, 0)
	end
end

function FightToughBattleSkillItem:getCd()
	local cd = 0
	local clothSkillList = FightModel.instance:getClothSkillList()

	if clothSkillList and #clothSkillList > 0 then
		for _, skill in pairs(clothSkillList) do
			if skill.skillId == self._skillId then
				cd = skill.cd

				break
			end
		end
	end

	return cd
end

function FightToughBattleSkillItem:clickIcon()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if not self._co or self._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	if self:getCd() > 0 then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getOpList()

	if #ops > 0 then
		FightRpc.instance:sendResetRoundRequest()
	end

	FightRpc.instance:sendUseClothSkillRequest(self._skillId, nil, nil, FightEnum.ClothSkillType.ClothSkill)
end

function FightToughBattleSkillItem:_onLongPress()
	gohelper.setActive(self._goDetails, true)
end

function FightToughBattleSkillItem:_onTouchFightViewScreen()
	gohelper.setActive(self._goDetails, false)
end

return FightToughBattleSkillItem
