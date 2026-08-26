-- chunkname: @modules/logic/survival/controller/work/SummaryAct/SurvivalSummaryActBuildPlayerWork.lua

module("modules.logic.survival.controller.work.SummaryAct.SurvivalSummaryActBuildPlayerWork", package.seeall)

local SurvivalSummaryActBuildPlayerWork = class("SurvivalSummaryActBuildPlayerWork", BaseWork)

function SurvivalSummaryActBuildPlayerWork:ctor(param)
	self:initParam(param)
end

function SurvivalSummaryActBuildPlayerWork:initParam(param)
	self.goBubble = param.goBubble
end

function SurvivalSummaryActBuildPlayerWork:onStart()
	local scene = SurvivalMapHelper.instance:getScene()

	self.playerEntity = scene.actProgress.playerEntity

	self:buildBubble(self.playerEntity)
	self:onDone(true)
end

function SurvivalSummaryActBuildPlayerWork:setPos(q, r, dir)
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(q, r)

	transformhelper.setLocalPos(self.playerEntity.trans, x, y, z)
	transformhelper.setLocalRotation(self.playerEntity.trans, 0, dir * 60, 0)
end

function SurvivalSummaryActBuildPlayerWork:buildBubble(entity)
	self.playerBubble = MonoHelper.addNoUpdateLuaComOnceToGo(self.goBubble, SurvivalDecreeVoteUIItem, entity.go)

	AudioMgr.instance:trigger(AudioEnum3_1.Survival.ui_mingdi_tansuo_talks_eject)
end

function SurvivalSummaryActBuildPlayerWork:clearBubble()
	if self.playerBubble then
		self.playerBubble:dispose()

		self.playerBubble = nil
	end
end

function SurvivalSummaryActBuildPlayerWork:onDestroy()
	gohelper.destroy(self.playerEntity.go)

	self.playerEntity = nil

	self:clearBubble()
	SurvivalSummaryActBuildPlayerWork.super.onDestroy(self)
end

return SurvivalSummaryActBuildPlayerWork
