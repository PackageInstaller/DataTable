-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuchallengeView.lua

module("logic.extensions.infinitefuture.view.InfinfuchallengeView", package.seeall)

local InfinfuchallengeView = class("InfinfuchallengeView", ViewComponent)

function InfinfuchallengeView:ctor()
	InfinfuchallengeView.super.ctor(self)
end

function InfinfuchallengeView:unbindEvents()
	InfinfuchallengeView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
end

function InfinfuchallengeView:bindEvents()
	InfinfuchallengeView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(function()
		if not self.stageId then
			return
		end

		if self.isOver then
			FloatWordMgr.instance:show("已通过所有关卡")
		else
			self:_openChallengeView()
		end
	end, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(InfinitefutureModel.instance.curPetId)
	end, self)
end

function InfinfuchallengeView:buildUI()
	InfinfuchallengeView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnBuff = self:getBtn("btnBuff")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._sprintRareGo = self:getGo("petInfo/pointRare")
	self._buffText = self:getTxt("btnBuff/txtBuff")
	self._buffRed = self:getGo("btnBuff/redPoint")
	self._challengeRed = self:getGo("btnChallenge/redPoint")
	self._txtName = self:getTxt("petInfo/txtName")
end

function InfinfuchallengeView:onExit()
	InfinfuchallengeView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)
	MaterialMgr.resetAll(self._sprintRareGo)
end

function InfinfuchallengeView:onEnter()
	InfinfuchallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)

	self.curActId = InfinitefutureModel.instance.curActId
	self.totalCount = InfinitefutureConfig.instance:getStageCount(self.curActId)

	InfinitefutureController.instance:sendInfoReq(self.curActId)
	self:_showSpriteRawInfo()
	self:_showUIEff()
end

function InfinfuchallengeView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId
	self.isOver = self.stageId > self.totalCount

	local cfgs = InfinitefutureConfig.instance:getSignCfgs(self.curActId)
	local buffcfg

	if cfgs then
		self.isTop = InfinitefutureModel.instance.curDailySignId >= #cfgs
		buffcfg = cfgs[InfinitefutureModel.instance.curDailySignId]
	else
		self.isTop = true
		buffcfg = nil
	end

	self._buffText.text = buffcfg == nil and "未获得加成" or buffcfg.desc

	self._buffRed:SetActive(not InfinitefutureModel.instance.isSignToday and not self.isTop)
	self._challengeRed:SetActive(not self.isOver)
end

function InfinfuchallengeView:_onClickBuff()
	if self.isTop then
		FloatWordMgr.instance:show("已达到签到加成上限")

		return
	end

	if InfinitefutureModel.instance.isSignToday then
		FloatWordMgr.instance:show("今日已签到")

		return
	end

	InfinitefutureController.instance:sendSignInReq(self.curActId)
end

function InfinfuchallengeView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, InfinitefutureModel.instance.curPetId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, InfinitefutureModel.instance.curPetId, self._sprintGo, scale, nil, true, x, y)
	self._txtName.text = PetSkinConfig.instance:getPetSkinName(InfinitefutureModel.instance.curPetId)
end

function InfinfuchallengeView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function InfinfuchallengeView:_openChallengeView()
	UIStateManager.instance:push(ViewName.InfinfulevelsView)
end

return InfinfuchallengeView
