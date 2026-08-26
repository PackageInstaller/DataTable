-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightRoundEnd.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundEnd", package.seeall)

local WaitGuideActionFightRoundEnd = class("WaitGuideActionFightRoundEnd", BaseGuideAction)

function WaitGuideActionFightRoundEnd:onStart(context)
	WaitGuideActionFightRoundEnd.super.onStart(self, context)

	self.msgItem = FightMsgMgr.registMsg(FightMsgId.CheckGuideBeforeOperate, self.onCheckGuideBeforeOperate, self)
	self.msgItem1 = FightMsgMgr.registMsg(FightMsgId.ContinueGuideBeforeOperate, self.onContinueGuideBeforeOperate, self)
end

function WaitGuideActionFightRoundEnd:onCheckGuideBeforeOperate()
	FightMsgMgr.replyMsg(FightMsgId.CheckGuideBeforeOperate, self.guideId)
end

function WaitGuideActionFightRoundEnd:onContinueGuideBeforeOperate()
	self:onDone(true)
end

function WaitGuideActionFightRoundEnd:clearWork()
	FightMsgMgr.removeMsg(self.msgItem)
	FightMsgMgr.removeMsg(self.msgItem1)
end

return WaitGuideActionFightRoundEnd
