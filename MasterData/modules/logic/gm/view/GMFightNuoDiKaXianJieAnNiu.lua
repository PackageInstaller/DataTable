-- chunkname: @modules/logic/gm/view/GMFightNuoDiKaXianJieAnNiu.lua

module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiu", package.seeall)

local GMFightNuoDiKaXianJieAnNiu = class("GMFightNuoDiKaXianJieAnNiu", FightBaseView)

function GMFightNuoDiKaXianJieAnNiu:onInitView()
	self.btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnStart")
end

function GMFightNuoDiKaXianJieAnNiu:addEvents()
	self:com_registClick(self.btnStart, self.onClickStart)
end

function GMFightNuoDiKaXianJieAnNiu:onClickStart()
	self.time = self.time or Time.time

	if Time.time - self.time > self.timeLimit then
		self.time = Time.time

		self:com_sendMsg(FightMsgId.OperationForPlayEffect, self.effectType)
	end
end

function GMFightNuoDiKaXianJieAnNiu:onOpen()
	self.effectType = self.viewParam.effectType
	self.timeLimit = self.viewParam.timeLimit
	self.time = 0
end

function GMFightNuoDiKaXianJieAnNiu:onDestructor()
	return
end

return GMFightNuoDiKaXianJieAnNiu
