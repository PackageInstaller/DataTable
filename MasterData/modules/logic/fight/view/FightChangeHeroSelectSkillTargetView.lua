-- chunkname: @modules/logic/fight/view/FightChangeHeroSelectSkillTargetView.lua

module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetView", package.seeall)

local FightChangeHeroSelectSkillTargetView = class("FightChangeHeroSelectSkillTargetView", BaseViewExtended)

function FightChangeHeroSelectSkillTargetView:onInitView()
	self._block = gohelper.findChildClick(self.viewGO, "block")
end

function FightChangeHeroSelectSkillTargetView:addEvents()
	self.addClickCb(self, self._block, self._onBlock, self)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, self._onChangeSubHeroExSkillReply, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function FightChangeHeroSelectSkillTargetView:removeEvents()
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, self._onChangeSubHeroExSkillReply, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function FightChangeHeroSelectSkillTargetView:_editableInitView()
	return
end

function FightChangeHeroSelectSkillTargetView:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightSkillTargetView then
		self:closeThis()
	end
end

function FightChangeHeroSelectSkillTargetView:_onChangeSubHeroExSkillReply()
	self:closeThis()
end

function FightChangeHeroSelectSkillTargetView:_onBtnEsc()
	return
end

function FightChangeHeroSelectSkillTargetView:_onBlock()
	self._clickCounter = self._clickCounter + 1

	if self._clickCounter >= 5 then
		self:closeThis()
	end
end

function FightChangeHeroSelectSkillTargetView:onOpen()
	self._clickCounter = 0

	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	local skillConfig = self.viewParam.skillConfig
	local fromId = self.viewParam.fromId

	if FightEnum.ShowLogicTargetView[skillConfig.logicTarget] and skillConfig.targetLimit == FightEnum.TargetLimit.MySide then
		local mySideList = FightDataHelper.entityMgr:getMyNormalList()
		local mySideSpList = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
		local mySideEntityCount = #mySideList + #mySideSpList

		if mySideEntityCount > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				mustSelect = true,
				fromId = fromId,
				skillId = skillConfig.id,
				callback = self._onChangeHeroSkillSelected,
				callbackObj = self
			})
		elseif mySideEntityCount == 1 then
			local list = #mySideList > 0 and mySideList or mySideSpList

			FightRpc.instance:sendChangeSubHeroExSkillRequest(list[1].id)
		else
			self:closeThis()
		end
	else
		FightRpc.instance:sendChangeSubHeroExSkillRequest(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function FightChangeHeroSelectSkillTargetView:_onChangeHeroSkillSelected(entityId)
	FightRpc.instance:sendChangeSubHeroExSkillRequest(entityId)
end

function FightChangeHeroSelectSkillTargetView:onClose()
	return
end

function FightChangeHeroSelectSkillTargetView:onDestroyView()
	return
end

return FightChangeHeroSelectSkillTargetView
