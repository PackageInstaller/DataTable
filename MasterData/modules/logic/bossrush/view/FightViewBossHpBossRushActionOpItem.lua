-- chunkname: @modules/logic/bossrush/view/FightViewBossHpBossRushActionOpItem.lua

module("modules.logic.bossrush.view.FightViewBossHpBossRushActionOpItem", package.seeall)

local FightViewBossHpBossRushActionOpItem = class("FightViewBossHpBossRushActionOpItem", FightBaseView)

function FightViewBossHpBossRushActionOpItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewBossHpBossRushActionOpItem:addEvents()
	self:com_registFightEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, self._onForbidBossRushHpChannelSkillOpItem)
end

function FightViewBossHpBossRushActionOpItem:removeEvents()
	return
end

function FightViewBossHpBossRushActionOpItem:_editableInitView()
	return
end

function FightViewBossHpBossRushActionOpItem:onOpen()
	return
end

function FightViewBossHpBossRushActionOpItem:_onForbidBossRushHpChannelSkillOpItem(data)
	if data == self._data then
		self:refreshUI(self.viewGO, data)
	end
end

function FightViewBossHpBossRushActionOpItem:refreshUI(obj, data)
	self.viewGO = obj
	self._data = data

	local noAct = gohelper.findChild(self.viewGO, "root/noAct")
	local act = gohelper.findChild(self.viewGO, "root/act")
	local skillId = data.skillId

	gohelper.setActive(act, skillId ~= 0)
	gohelper.setActive(noAct, skillId == 0)

	if skillId == 0 then
		return
	end

	local round = gohelper.findChild(self.viewGO, "root/act/round")
	local num = gohelper.findChildText(self.viewGO, "root/act/round/num")
	local var_7_0 = gohelper.findChild(self.viewGO, "root/act/forbid")

	gohelper.setActive(forbid, data.isChannelPosedSkill and data.forbidden)
	gohelper.setActive(round, data.isChannelSkill)

	num.text = data.round or 0
	self.opItemView = self.opItemView or self:com_openSubView(FightBossRushHpTrackAIUseCardsItem, act)

	local cardData = FightCardInfoData.New(FightDef_pb.CardInfo())

	cardData.uid = self.PARENT_VIEW._bossEntityMO.uid
	cardData.skillId = skillId

	self.opItemView:onRefreshItemData(cardData)
end

function FightViewBossHpBossRushActionOpItem:onClose()
	return
end

function FightViewBossHpBossRushActionOpItem:onDestroyView()
	return
end

return FightViewBossHpBossRushActionOpItem
