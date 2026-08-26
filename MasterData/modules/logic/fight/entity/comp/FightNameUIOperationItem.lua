-- chunkname: @modules/logic/fight/entity/comp/FightNameUIOperationItem.lua

module("modules.logic.fight.entity.comp.FightNameUIOperationItem", package.seeall)

local FightNameUIOperationItem = class("FightNameUIOperationItem", FightBaseView)

function FightNameUIOperationItem:onInitView()
	self._imgMat = gohelper.findChildImage(self.viewGO, "imgMat")
	self._imgTag = gohelper.findChildImage(self.viewGO, "imgTag")
	self._imgBgs = self:newUserDataTable()
	self._imgBgGos = self:newUserDataTable()

	for i = 0, 4 do
		self._imgBgs[i] = gohelper.findChildImage(self.viewGO, "imgBg/" .. i)
		self._imgBgGos[i] = gohelper.findChild(self.viewGO, "imgBg/" .. i)
	end

	self._imgBg2 = gohelper.findChildImage(self.viewGO, "forbid/mask")

	if isDebugBuild then
		self._imgTag.raycastTarget = true

		self:com_registClick(gohelper.getClick(self.viewGO), self._onClickOp)
	end

	self.topPosRectTr = gohelper.findChildComponent(self.viewGO, "topPos", gohelper.Type_RectTransform)
	self.viewGOEmitNormal = gohelper.findChild(self.viewGO, "#emit_normal")
	self.viewGOEmitUitimate = gohelper.findChild(self.viewGO, "#emit_uitimate")
	self.animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self:com_registFightEvent(FightEvent.OnSelectMonsterCardMo, self.onSelectMonsterCardMo)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
	self:com_registFightEvent(FightEvent.OnExPointChange, self._onExPointChange)
	self:com_registFightEvent(FightEvent.OnExSkillPointChange, self._onExSkillPointChange)
end

function FightNameUIOperationItem:refreshItemData(cardData)
	self._cardData = cardData
	self._entityMO = FightDataHelper.entityMgr:getById(cardData.uid)

	local skillCO = lua_skill.configDict[cardData.skillId]

	gohelper.setActive(self.viewGO, skillCO ~= nil)

	if not skillCO then
		return
	end

	local skillId = self._cardData.skillId
	local entityId = self._entityMO.uid

	self._isBigSkill = FightCardDataHelper.isBigSkill(skillId)

	local skillLv = FightCardDataHelper.getSkillLv(entityId, skillId)

	skillLv = self._isBigSkill and FightEnum.UniqueSkillCardLv or skillLv == FightEnum.UniqueSkillCardLv and 1 or skillLv

	UISpriteSetMgr.instance:setFightSprite(self._imgTag, "jnk_gj" .. skillCO.showTag)

	for level, img in pairs(self._imgBgs) do
		gohelper.setActive(img.gameObject, level == skillLv)
	end

	if self._imgBg2 and self._imgBgs[skillLv] then
		self._imgBg2.sprite = self._imgBgs[skillLv].sprite
	end

	gohelper.setActive(self._imgTag.gameObject, skillLv ~= FightEnum.UniqueSkillCardLv)

	self._lastAniName = nil
	self._lastCanUse = true

	self:_refreshAni()
end

function FightNameUIOperationItem:_refreshAni()
	self._canUse = FightViewHandCardItemLock.canUseCardSkill(self._entityMO.id, self._cardData.skillId)

	if self._isBigSkill and self._canUse then
		self._canUse = self._entityMO.exPoint >= self._entityMO:getUniqueSkillPoint()
	end

	self._curAniName = self._canUse and "fightname_op_in" or "fightname_forbid_in"

	if self._curAniName ~= self._lastAniName then
		if not self._lastCanUse and self._canUse then
			self._curAniName = "fightname_forbid_unlock"

			if self.viewGO.activeInHierarchy then
				self.animator:Play(self._curAniName, self._refreshAni, self)
			end
		elseif self.viewGO.activeInHierarchy then
			self.animator:Play(self._curAniName, nil, nil)
		end
	end

	self._lastAniName = self._curAniName
	self._lastCanUse = self._canUse
end

function FightNameUIOperationItem:onSelectMonsterCardMo(cardMo)
	local select = FightHelper.compareData(cardMo, self._cardData)
	local isBigSkill = FightCardDataHelper.isBigSkill(self._cardData.skillId)

	gohelper.setActive(self.viewGOEmitNormal, select and not isBigSkill)
	gohelper.setActive(self.viewGOEmitUitimate, select and isBigSkill)
end

function FightNameUIOperationItem:onCloseView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		gohelper.setActive(self.viewGOEmitNormal, false)
		gohelper.setActive(self.viewGOEmitUitimate, false)
	end
end

function FightNameUIOperationItem:_onClickOp()
	if self._cardData then
		logNormal(self._cardData.skillId .. " " .. lua_skill.configDict[self._cardData.skillId].name)
	end
end

function FightNameUIOperationItem:_onExSkillPointChange(entityId)
	if entityId == self._entityMO.id and self._isBigSkill then
		self:_refreshAni()
	end
end

function FightNameUIOperationItem:_onExPointChange(entityId)
	if entityId == self._entityMO.id and self._isBigSkill then
		self:_refreshAni()
	end
end

function FightNameUIOperationItem:onDestructor()
	for level, img in pairs(self._imgBgs) do
		img.material = nil
	end
end

return FightNameUIOperationItem
