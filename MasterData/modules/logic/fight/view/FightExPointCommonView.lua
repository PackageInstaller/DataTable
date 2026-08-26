-- chunkname: @modules/logic/fight/view/FightExPointCommonView.lua

module("modules.logic.fight.view.FightExPointCommonView", package.seeall)

local FightExPointCommonView = class("FightExPointCommonView", FightBaseView)

function FightExPointCommonView:onConstructor(entityData)
	self.entityData = entityData
end

function FightExPointCommonView:onInitView()
	return
end

function FightExPointCommonView:addEvents()
	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
end

function FightExPointCommonView:removeEvents()
	return
end

function FightExPointCommonView:onGetExPointView(entityId)
	if entityId == self.entityData.id and self.commonExPoint and not self.commonExPoint:checkNeedShieldExPoint() then
		self.com_replyMsg(self, FightMsgId.GetExPointView, self)
	end
end

function FightExPointCommonView:onOpen()
	local entity = FightHelper.getEntity(self.entityData.id)

	if not entity then
		return
	end

	self.commonExPoint = FightNameUIExPointMgr.New()

	self.commonExPoint:initMgr(self.viewGO, entity)
end

function FightExPointCommonView:onClose()
	if self.commonExPoint then
		self.commonExPoint:beforeDestroy()
	end
end

function FightExPointCommonView:onDestroyView()
	return
end

return FightExPointCommonView
