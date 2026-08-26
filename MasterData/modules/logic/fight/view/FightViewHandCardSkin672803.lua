-- chunkname: @modules/logic/fight/view/FightViewHandCardSkin672803.lua

module("modules.logic.fight.view.FightViewHandCardSkin672803", package.seeall)

local FightViewHandCardSkin672803 = class("FightViewHandCardSkin672803", FightBaseClass)

function FightViewHandCardSkin672803:onConstructor()
	self.loader = self:addComponent(FightLoaderComponent)

	self:com_registMsg(FightMsgId.GetCardSkin672803Mgr, self.onGetCardSkin672803Mgr)
	self:com_registFightEvent(FightEvent.AfterEffectWorkDone, self.onAfterEffectWorkDone)
	self:com_registMsg(FightMsgId.GetCardSkin672803FloorEffect, self.onGetCardSkin672803FloorEffect)
end

function FightViewHandCardSkin672803:onGetCardSkin672803FloorEffect()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672803FloorEffect, self.floorEffect)
end

function FightViewHandCardSkin672803:onAfterEffectWorkDone()
	gohelper.setActive(self.floorEffect, true)
end

function FightViewHandCardSkin672803:onGetCardSkin672803Mgr()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672803Mgr, self)
end

function FightViewHandCardSkin672803:setFloorEffect(floorEffect)
	self.floorEffect = floorEffect
	self.floorAnimator = gohelper.onceAddComponent(floorEffect, gohelper.Type_Animator)
end

function FightViewHandCardSkin672803:onDestructor()
	return
end

return FightViewHandCardSkin672803
