-- chunkname: @modules/logic/fight/view/FightSeasonChangeHeroSelectView.lua

module("modules.logic.fight.view.FightSeasonChangeHeroSelectView", package.seeall)

local FightSeasonChangeHeroSelectView = class("FightSeasonChangeHeroSelectView", BaseViewExtended)

function FightSeasonChangeHeroSelectView:onInitView()
	self._block = gohelper.findChildClick(self.viewGO, "block")
	self._blockTransform = self._block:GetComponent(gohelper.Type_RectTransform)
end

function FightSeasonChangeHeroSelectView:addEvents()
	self.addClickCb(self, self._block, self._onBlock, self)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, self._onReceiveChangeSubHeroReply, self)
end

function FightSeasonChangeHeroSelectView:removeEvents()
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, self._onReceiveChangeSubHeroReply, self)
end

function FightSeasonChangeHeroSelectView:_onReceiveChangeSubHeroReply()
	self:closeThis()
end

function FightSeasonChangeHeroSelectView:_onBlock(param, screenPosition)
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
	local entityId = FightSkillSelectView.getClickEntity(entityList, self._blockTransform, screenPosition)

	if entityId then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if not entityMO then
			return
		end

		if self._curSelectId == entityId then
			FightRpc.instance:sendChangeSubHeroRequest(self._changeId, entityId)
		else
			self._curSelectId = entityId

			FightController.instance:dispatchEvent(FightEvent.SeasonSelectChangeHeroTarget, self._curSelectId)
		end

		return
	end

	self:closeThis()
end

function FightSeasonChangeHeroSelectView:onOpen()
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)

	self._curSelectId = nil
	self._changeId = self.viewParam
end

function FightSeasonChangeHeroSelectView:onClose()
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
end

function FightSeasonChangeHeroSelectView:onDestroyView()
	return
end

return FightSeasonChangeHeroSelectView
