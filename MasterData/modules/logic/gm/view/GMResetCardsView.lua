-- chunkname: @modules/logic/gm/view/GMResetCardsView.lua

module("modules.logic.gm.view.GMResetCardsView", package.seeall)

local GMResetCardsView = class("GMResetCardsView", BaseView)

function GMResetCardsView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._btnOK = gohelper.findChildButtonWithAudio(self.viewGO, "btnOK")
end

function GMResetCardsView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnOK:AddClickListener(self._onClickOK, self)
end

function GMResetCardsView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnOK:RemoveClickListener()
end

function GMResetCardsView:onOpen()
	local oldHandCardList = {}
	local handCards = FightDataHelper.handCardMgr.handCard

	for _, one in ipairs(handCards) do
		table.insert(oldHandCardList, {
			oldEntityId = one.uid,
			oldSkillId = one.skillId
		})
	end

	local model1 = GMResetCardsModel.instance:getModel1()

	model1:setList(oldHandCardList)

	local entitySkillList = {}
	local entitys = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	for _, one in ipairs(entitys) do
		local entityMO = one:getMO()

		for _, skillId in ipairs(entityMO.skillGroup1) do
			table.insert(entitySkillList, {
				entityId = one.id,
				skillId = skillId
			})
		end

		for _, skillId in ipairs(entityMO.skillGroup2) do
			table.insert(entitySkillList, {
				entityId = one.id,
				skillId = skillId
			})
		end

		table.insert(entitySkillList, {
			entityId = one.id,
			skillId = entityMO.exSkill
		})
	end

	local model2 = GMResetCardsModel.instance:getModel2()

	model2:setList(entitySkillList)
end

function GMResetCardsView:_onClickOK()
	local model1 = GMResetCardsModel.instance:getModel1()
	local p = ""
	local count = model1:getCount()

	for i, one in ipairs(model1:getList()) do
		p = p .. (one.newSkillId or one.oldSkillId)

		if i < count then
			p = p .. "#"
		end
	end

	GMRpc.instance:sendGMRequest("fight resetCards " .. p)
	self:closeThis()
end

return GMResetCardsView
