-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingnuoyachallengeView.lua

module("logic.extensions.kingnuoya.view.KingnuoyachallengeView", package.seeall)

local KingnuoyachallengeView = class("KingnuoyachallengeView", ViewComponent)

function KingnuoyachallengeView:ctor()
	KingnuoyachallengeView.super.ctor(self)
end

function KingnuoyachallengeView:unbindEvents()
	KingnuoyachallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnRank)
end

function KingnuoyachallengeView:bindEvents()
	KingnuoyachallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function KingnuoyachallengeView:buildUI()
	KingnuoyachallengeView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnShop = self:getGo("btnShop")
	self._btnLottery = self:getGo("btnLottery")
	self._btnRank = self:getGo("btnRank")
end

function KingnuoyachallengeView:onExit()
	KingnuoyachallengeView.super.onExit(self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	MaterialMgr.resetAll(self._pointRare)
end

function KingnuoyachallengeView:onEnter()
	KingnuoyachallengeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = KingNuoyaChallengeController.instance:getActivityId()
	end

	if not self._activityId then
		self:close()
	end

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.KingNuoyaChallengeUpdate, self._refreshUI, self)
	KingNuoyaChallengeController.instance:sendGetInfo(self._activityId)
end

function KingnuoyachallengeView:_refreshUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId) or {}
	local raceId = cfg.skinId

	self:_showPetSkin(raceId)
end

function KingnuoyachallengeView:_showPetSkin(raceId)
	local skinId = raceId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, function(go)
					return
				end, true, modelCfg[1], y)
				self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

				MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
			end
		end
	end
end

function KingnuoyachallengeView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.KingnuoyachallengeselectView)
end

function KingnuoyachallengeView:_onClickInfo()
	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId)
	local raceId = cfg.skinId

	PetbookController.instance:openPetinfoView(raceId)
end

function KingnuoyachallengeView:_onClickSkill()
	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId)
	local raceId = cfg.skinId

	PetbookController.instance:previewBattle(raceId, self._skinId)
end

function KingnuoyachallengeView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("kingnuoyachallengeview_rules")
end

function KingnuoyachallengeView:_onClickShop()
	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId)
	local str = cfg.shop_jump

	GotoMgr.gotoByString(str)
end

function KingnuoyachallengeView:_onClickLottery()
	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId)
	local str = cfg.lottery_jump

	GotoMgr.gotoByString(str)
end

function KingnuoyachallengeView:_onClickRank()
	local cfg = KingNuoyaChallengeConfig.instance:getActivityCfgById(self._activityId)
	local str = cfg.rank_jump

	GotoMgr.gotoByString(str)
end

return KingnuoyachallengeView
