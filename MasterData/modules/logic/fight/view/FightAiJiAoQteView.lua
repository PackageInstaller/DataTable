-- chunkname: @modules/logic/fight/view/FightAiJiAoQteView.lua

module("modules.logic.fight.view.FightAiJiAoQteView", package.seeall)

local FightAiJiAoQteView = class("FightAiJiAoQteView", FightBaseView)

function FightAiJiAoQteView:onInitView()
	return
end

function FightAiJiAoQteView:addEvents()
	return
end

function FightAiJiAoQteView:removeEvents()
	return
end

function FightAiJiAoQteView:onConstructor()
	return
end

function FightAiJiAoQteView:_onBtnEsc()
	return
end

function FightAiJiAoQteView:onOpen()
	FightController.instance:dispatchEvent(FightEvent.StopCardCameraAnimator)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	if self.logicView then
		self.logicView:disposeSelf()
	end

	local fromId = self.viewParam.fromId
	local toId = self.viewParam.toId

	self.logicView = self:com_openSubView(FightAiJiAoQteLogicView, "ui/viewres/fight/fightaijiaoqteview.prefab", self.viewGO, fromId, toId)
end

function FightAiJiAoQteView:onUpdateParam()
	self:onOpen()
end

function FightAiJiAoQteView:onDestroyView()
	return
end

function FightAiJiAoQteView.autoQte(fromId, toId)
	local aiJiAoAutoSequenceForGM = FightDataModel.instance.aiJiAoAutoSequenceForGM

	if aiJiAoAutoSequenceForGM then
		local autoSequence = aiJiAoAutoSequenceForGM.autoSequence

		if autoSequence and #autoSequence > 0 then
			local index = aiJiAoAutoSequenceForGM.index + 1

			if not autoSequence[index] then
				index = 1
			end

			aiJiAoAutoSequenceForGM.index = index

			local selectType = autoSequence[index]

			FightRpc.instance:sendUseClothSkillRequest(selectType, fromId, toId, FightEnum.ClothSkillType.EzioBigSkill)

			return
		end
	end

	local entityData = FightDataHelper.entityMgr:getById(toId)

	if entityData then
		local curHp = entityData.currentHp
		local maxHp = entityData.attrMO.hp

		if curHp / maxHp >= 0.5 then
			FightRpc.instance:sendUseClothSkillRequest(2, fromId, toId, FightEnum.ClothSkillType.EzioBigSkill)
		else
			FightRpc.instance:sendUseClothSkillRequest(1, fromId, toId, FightEnum.ClothSkillType.EzioBigSkill)
		end
	end
end

return FightAiJiAoQteView
