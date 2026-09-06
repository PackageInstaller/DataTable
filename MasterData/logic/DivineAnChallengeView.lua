-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnChallengeView.lua

module("logic.extensions.divinean.view.DivineAnChallengeView", package.seeall)

local DivineAnChallengeView = class("DivineAnChallengeView", InfinfuchallengeView)

function DivineAnChallengeView:buildUI()
	DivineAnChallengeView.super.buildUI(self)

	self._challengePass = self:getGo("btnChallenge/pass")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
end

function DivineAnChallengeView:unbindEvents()
	DivineAnChallengeView.super.unbindEvents(self)
	self._btnSkill:RemoveClickListener()
end

function DivineAnChallengeView:bindEvents()
	DivineAnChallengeView.super.bindEvents(self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
end

function DivineAnChallengeView:_openChallengeView()
	UIStateManager.instance:push(ViewName.DivineAnLevelsView)
end

function DivineAnChallengeView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId
	self.isOver = self.stageId > self.totalCount

	local cfgs = InfinitefutureConfig.instance:getSignCfgs(self.curActId)

	self.isTop = InfinitefutureModel.instance.curDailySignId >= #cfgs

	local buffcfg = cfgs[InfinitefutureModel.instance.curDailySignId]

	self._buffText.text = buffcfg == nil and "未获得加成" or buffcfg.desc

	self._buffRed:SetActive(not InfinitefutureModel.instance.isSignToday and not self.isTop)
	goutil.setActive(self._challengePass, self.isOver)
end

function DivineAnChallengeView:_onClickBtnSkill()
	if InfinitefutureModel.instance.curPetId then
		PetCvController.instance:turnOffCurCv()
		PetbookController.instance:previewBattle(InfinitefutureModel.instance.curPetId)
	end
end

return DivineAnChallengeView
