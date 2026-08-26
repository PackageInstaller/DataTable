-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightRoundBegin.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundBegin", package.seeall)

local WaitGuideActionFightRoundBegin = class("WaitGuideActionFightRoundBegin", BaseGuideAction)

function WaitGuideActionFightRoundBegin:onStart(context)
	WaitGuideActionFightRoundBegin.super.onStart(self, context)

	self.msgItem = FightMsgMgr.registMsg(FightMsgId.CheckGuideBeforeOperate, self.onCheckGuideBeforeOperate, self)
	self.msgItem1 = FightMsgMgr.registMsg(FightMsgId.ContinueGuideBeforeOperate, self.onContinueGuideBeforeOperate, self)
end

function WaitGuideActionFightRoundBegin:onCheckGuideBeforeOperate()
	FightMsgMgr.replyMsg(FightMsgId.CheckGuideBeforeOperate, self.guideId)
end

function WaitGuideActionFightRoundBegin:onContinueGuideBeforeOperate()
	self:clearWork()
	self:onDone(true)
end

function WaitGuideActionFightRoundBegin:clearWork()
	FightMsgMgr.removeMsg(self.msgItem)
	FightMsgMgr.removeMsg(self.msgItem1)
end

return WaitGuideActionFightRoundBegin
