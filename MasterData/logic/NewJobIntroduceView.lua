-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/NewJobIntroduceView.lua

module("logic.extensions.operationsummary.view.NewJobIntroduceView", package.seeall)

local NewJobIntroduceView = class("NewJobIntroduceView", ViewComponent)

function NewJobIntroduceView:ctor()
	NewJobIntroduceView.super.ctor(self)
end

function NewJobIntroduceView:unbindEvents()
	NewJobIntroduceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPeriod)
end

function NewJobIntroduceView:bindEvents()
	NewJobIntroduceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPeriod, self._onClickBtnPeriod, self)
end

function NewJobIntroduceView:buildUI()
	NewJobIntroduceView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPeriod = self:getGo("btnPeriod")
end

function NewJobIntroduceView:onExit()
	NewJobIntroduceView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function NewJobIntroduceView:onEnter()
	NewJobIntroduceView.super.onEnter(self)

	self._curChallengeId = checknumber(self:getFirstParam())

	if self._curChallengeId <= 0 then
		self._curChallengeId = self:getDefaultChallengeId()
	end

	self:_updateUIByCfg()
end

function NewJobIntroduceView:_updateUIByCfg()
	self._challengeCfg = PetCollegeConfig.instance:getChallegenCfg(self._curChallengeId)

	local faceId = self._challengeCfg.faceId
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(faceId)

	if petSkinCfg then
		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", faceId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, faceId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function NewJobIntroduceView:getDefaultChallengeId()
	return 64
end

function NewJobIntroduceView:_onClickBtnTip()
	local ruleKey = string.format("NewJobIntroduce_%s", self._curChallengeId)

	TipsFacade.instance:openRulesView(ruleKey)
end

function NewJobIntroduceView:_onClickBtnPeriod()
	UIStateManager.instance:push(ViewName.PetcollegeView, self._curChallengeId)
end

return NewJobIntroduceView
