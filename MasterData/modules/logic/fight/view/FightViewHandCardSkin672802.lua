-- chunkname: @modules/logic/fight/view/FightViewHandCardSkin672802.lua

module("modules.logic.fight.view.FightViewHandCardSkin672802", package.seeall)

local FightViewHandCardSkin672802 = class("FightViewHandCardSkin672802", FightBaseClass)

function FightViewHandCardSkin672802:onConstructor()
	self.loader = self:addComponent(FightLoaderComponent)

	self:com_registMsg(FightMsgId.GetCardSkin672802Mgr, self.onGetCardSkin672802Mgr)
	self:com_registFightEvent(FightEvent.AfterEffectWorkDone, self.onAfterEffectWorkDone)
	self:com_registMsg(FightMsgId.GetCardSkin672802FloorEffect, self.onGetCardSkin672802FloorEffect)
end

function FightViewHandCardSkin672802:onGetCardSkin672802FloorEffect()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672802FloorEffect, self.floorEffect)
end

function FightViewHandCardSkin672802:onAfterEffectWorkDone()
	gohelper.setActive(self.floorEffect, true)
end

function FightViewHandCardSkin672802:onGetCardSkin672802Mgr()
	FightMsgMgr.replyMsg(FightMsgId.GetCardSkin672802Mgr, self)
end

function FightViewHandCardSkin672802:setFloorEffect(floorEffect)
	self.floorEffect = floorEffect
	self.floorAnimator = gohelper.onceAddComponent(floorEffect, gohelper.Type_Animator)
end

function FightViewHandCardSkin672802:onDestructor()
	return
end

return FightViewHandCardSkin672802
