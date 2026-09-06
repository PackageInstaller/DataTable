-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonchallengeView.lua

module("logic.extensions.infinitefuture.view.FiredragonchallengeView", package.seeall)

local FiredragonchallengeView = class("FiredragonchallengeView", ViewComponent)

function FiredragonchallengeView:ctor()
	FiredragonchallengeView.super.ctor(self)
end

function FiredragonchallengeView:unbindEvents()
	FiredragonchallengeView.super.unbindEvents(self)
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnChallenge3:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
end

function FiredragonchallengeView:bindEvents()
	FiredragonchallengeView.super.bindEvents(self)
	self._btnChallenge1:AddClickListener(self._onClickGo1, self)
	self._btnChallenge2:AddClickListener(self._onClickGo2, self)
	self._btnChallenge3:AddClickListener(self._onClickGo3, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self.petId)
	end, self)
end

function FiredragonchallengeView:buildUI()
	FiredragonchallengeView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._btnChallenge3 = self:getBtn("btnChallenge3")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._sprintRareGo = self:getGo("petInfo/pointRare")
end

function FiredragonchallengeView:onExit()
	FiredragonchallengeView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)

	if self._roleModel then
		RoleObjectPool.instance:removeRole(self._roleModel)
	end
end

function FiredragonchallengeView:onEnter()
	FiredragonchallengeView.super.onEnter(self)

	self.petId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_pet"))

	self:_showSpriteRawInfo()
	self:_showUIEff()
end

function FiredragonchallengeView:onRefreshUI()
	return
end

function FiredragonchallengeView:_onClickGo1()
	local str = InfinitefutureConfig.instance:getCommonCfg("challenge_firedragon_1")
	local arr = string.split(str, "#")
	local viewName = arr[1]
	local actId = arr[2]

	InfinitefutureController.instance:checkOpenLevelView(actId, viewName)
end

function FiredragonchallengeView:_onClickGo2()
	local str = InfinitefutureConfig.instance:getCommonCfg("challenge_firedragon_2")
	local arr = string.split(str, "#")
	local viewName = arr[1]
	local actId = arr[2]

	InfinitefutureController.instance:checkOpenLevelView(actId, viewName)
end

function FiredragonchallengeView:_onClickGo3()
	local str = InfinitefutureConfig.instance:getCommonCfg("challenge_firedragon_3")
	local arr = string.split(str, "#")
	local viewName = arr[1]
	local actId = arr[2]

	InfinitefutureController.instance:checkOpenLevelView(actId, viewName)
end

function FiredragonchallengeView:_onClickGo()
	local npcId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_map"))

	UIStateManager.instance:clear(true)

	local plotId = checknumber(InfinitefutureConfig.instance:getCommonCfg("challenge_plot"))

	if not GameUtil.getUserData("infinfuchallengeplotid" .. plotId) then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, plotId, StoryModel.StoryType.SCCopy)
		GameUtil.saveUserData("infinfuchallengeplotid" .. plotId, "1")
	else
		TaskController.instance:gotoNpc(npcId)
	end
end

function FiredragonchallengeView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self.petId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self.petId, self._sprintGo, scale, nil, true, x, y)
end

function FiredragonchallengeView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

return FiredragonchallengeView
