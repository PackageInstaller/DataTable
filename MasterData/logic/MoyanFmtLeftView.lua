-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanFmtLeftView.lua

module("logic.extensions.timelimitedchallenge.view.moyan.mission.MoyanFmtLeftView", package.seeall)

local MoyanFmtLeftView = class("MoyanFmtLeftView", FormationLeftView)

function MoyanFmtLeftView:onEnter()
	MoyanFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:_setActiveBtnFormationUse(false)

	local params = self._viewPresentor:getFirstParam()

	self:setBtnCutePetActive(true)

	if params and params.type == MoyanModel.TYPE_1 then
		self:setBtnCutePetActive(false)
	end
end

function MoyanFmtLeftView:onExit()
	MoyanFmtLeftView.super.onExit(self)

	local fmo = self:_getCurFormation()

	fmo:setExtGetPetFunc(nil)
end

function MoyanFmtLeftView:_getCurFormation()
	local params = self._viewPresentor:getFirstParam()
	local fmo = MoyanController.instance:GetCurFormation(params)

	fmo:setExtGetPetFunc(GameUtil.handler(self._getPet, self))

	return fmo
end

function MoyanFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local params = self._viewPresentor:getFirstParam()
	local hpVal = MoyanController.instance:getPetHpById(params, petId)

	if hpVal <= 0 then
		return false
	end

	return true
end

function MoyanFmtLeftView:_getPet(id)
	local list = self:getAllShowPetList()

	for i, v in ipairs(list) do
		if v.petId == id then
			return v
		end
	end
end

function MoyanFmtLeftView:getAllShowPetList()
	local params = self._viewPresentor:getFirstParam()

	return MoyanController.instance:getPetListInMission(params)
end

function MoyanFmtLeftView:_getItemSeatCls()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local type = params.type
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)

		if checknumber(cfg.systemPetPlan) > 0 then
			MoyanItemSeat.curGetPetCallBack = GameUtil.handler(self._getPet, self)

			return MoyanItemSeat
		end
	end

	return ItemSeat
end

return MoyanFmtLeftView
