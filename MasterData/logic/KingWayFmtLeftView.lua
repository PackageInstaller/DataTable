-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayFmtLeftView.lua

module("logic.extensions.kingway.view.KingWayFmtLeftView", package.seeall)

local KingWayFmtLeftView = class("KingWayFmtLeftView", FormationLeftView)

function KingWayFmtLeftView:onEnter()
	KingWayFmtLeftView.super.onEnter(self)

	if checknumber(KingWayModel.instance:getVerifyPlanId()) ~= 0 then
		self.batId = KingWayModel.instance:GetKingBattleAndStageId()

		local cfgChallenge = KingWayConfig.instance:GetWayBaseCfg(self.batId)
		local param = {}

		if cfgChallenge then
			param.name = cfgChallenge.challengeName or ""
		end

		param.tipDesc = "王者之路今日不再自动提示"

		ViewMgr.instance:openAt(self:getGo("lefttop"), ViewName.PetverifybtnView, self._viewPresentor, param, checknumber(KingWayModel.instance:getVerifyPlanId()))
	end
end

return KingWayFmtLeftView
