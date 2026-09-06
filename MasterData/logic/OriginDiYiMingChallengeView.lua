-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindiyiming/view/OriginDiYiMingChallengeView.lua

module("logic.extensions.origindiyiming.view.OriginDiYiMingChallengeView", package.seeall)

local OriginDiYiMingChallengeView = class("OriginDiYiMingChallengeView", InfinfuchallengeView)

function OriginDiYiMingChallengeView:buildUI()
	OriginDiYiMingChallengeView.super.buildUI(self)

	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnJump1 = self:getGo("btnJump1")
	self._btnJump2 = self:getGo("btnJump2")
	self._btnJump3 = self:getGo("btnJump3")
	self._btnJump4 = self:getGo("btnJump4")
end

function OriginDiYiMingChallengeView:unbindEvents()
	OriginDiYiMingChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
end

function OriginDiYiMingChallengeView:bindEvents()
	InfinfuchallengeView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(function()
		if not self.stageId then
			return
		end

		if self.isOver then
			FloatWordMgr.instance:show("已通过所有关卡")
		else
			UIStateManager.instance:push(ViewName.OriginDiYiMingLevelsView)
		end
	end, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(InfinitefutureModel.instance.curPetId)
	end, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickJump4, self)
end

function OriginDiYiMingChallengeView:_onClickSkill()
	PetbookController.instance:previewBattle(InfinitefutureModel.instance.curPetId)
end

function OriginDiYiMingChallengeView:_onClickJump1()
	local planCfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	if not string.nilorempty(planCfg.jumpTo1) then
		GotoMgr.gotoByString(planCfg.jumpTo1)
	end
end

function OriginDiYiMingChallengeView:_onClickJump2()
	local planCfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	if not string.nilorempty(planCfg.jumpTo2) then
		GotoMgr.gotoByString(planCfg.jumpTo2)
	end
end

function OriginDiYiMingChallengeView:_onClickJump3()
	local planCfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	if not string.nilorempty(planCfg.jumpTo3) then
		GotoMgr.gotoByString(planCfg.jumpTo3)
	end
end

function OriginDiYiMingChallengeView:_onClickJump4()
	local planCfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	if not string.nilorempty(planCfg.jumpTo4) then
		GotoMgr.gotoByString(planCfg.jumpTo4)
	end
end

return OriginDiYiMingChallengeView
