-- chunkname: @modules/logic/fight/view/FightBossRushHpTrackAIUseCardsItem.lua

module("modules.logic.fight.view.FightBossRushHpTrackAIUseCardsItem", package.seeall)

local FightBossRushHpTrackAIUseCardsItem = class("FightBossRushHpTrackAIUseCardsItem", FightBaseView)

function FightBossRushHpTrackAIUseCardsItem:onInitView()
	local go = self.viewGO

	self.go = go
	self.tr = self.viewGO.transform
	self._imgMat = gohelper.findChildImage(go, "imgMat")
	self._imgTag = gohelper.findChildImage(go, "imgTag")
	self._imgBgs = self:getUserDataTb_()
	self._imgBgGos = self:getUserDataTb_()

	for i = 0, 4 do
		self._imgBgs[i] = gohelper.findChildImage(go, "imgBg/" .. i)
		self._imgBgGos[i] = gohelper.findChild(go, "imgBg/" .. i)
	end

	self._imgBg2 = gohelper.findChildImage(go, "forbid/mask")

	if isDebugBuild then
		self._imgTag.raycastTarget = true
		self._click = gohelper.getClick(self.go)

		self:com_registClick(self._click, self._onClickOp)
	end

	self.topPosRectTr = gohelper.findChildComponent(go, "topPos", gohelper.Type_RectTransform)
	self.goEmitNormal = gohelper.findChild(go, "#emit_normal")
	self.goEmitUitimate = gohelper.findChild(go, "#emit_uitimate")
end

function FightBossRushHpTrackAIUseCardsItem:addEvents()
	return
end

function FightBossRushHpTrackAIUseCardsItem:onRefreshItemData(data)
	self.cardData = data
	self.entityId = self.cardData.uid
	self.skillId = self.cardData.skillId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
	self.isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	if lua_skill_next.configDict[self.skillId] then
		self.isBigSkill = false
	end

	self:refreshCanUseCardState()

	local skillCO = lua_skill.configDict[data.skillId]

	gohelper.setActive(self.go, skillCO ~= nil)

	if not skillCO then
		return
	end

	local skillLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	skillLv = self.isBigSkill and FightEnum.UniqueSkillCardLv or skillLv == FightEnum.UniqueSkillCardLv and 1 or skillLv

	UISpriteSetMgr.instance:setFightSprite(self._imgTag, "jnk_gj" .. skillCO.showTag)

	for level, img in pairs(self._imgBgs) do
		gohelper.setActive(img.gameObject, level == skillLv)
	end

	if self._imgBg2 and self._imgBgs[skillLv] then
		self._imgBg2.sprite = self._imgBgs[skillLv].sprite
	end

	gohelper.setActive(self._imgTag.gameObject, skillLv ~= FightEnum.UniqueSkillCardLv)
end

function FightBossRushHpTrackAIUseCardsItem:refreshCanUseCardState()
	self.canUseCard = true
end

function FightBossRushHpTrackAIUseCardsItem:onDestructor()
	for level, img in pairs(self._imgBgs) do
		img.material = nil
	end
end

return FightBossRushHpTrackAIUseCardsItem
