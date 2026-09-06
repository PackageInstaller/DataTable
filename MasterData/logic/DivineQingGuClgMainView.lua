-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/view/DivineQingGuClgMainView.lua

module("logic.extensions.divineqingguclg.view.DivineQingGuClgMainView", package.seeall)

local DivineQingGuClgMainView = class("DivineQingGuClgMainView", ViewComponent)

function DivineQingGuClgMainView:ctor()
	DivineQingGuClgMainView.super.ctor(self)
end

function DivineQingGuClgMainView:buildUI()
	DivineQingGuClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
end

function DivineQingGuClgMainView:bindEvents()
	DivineQingGuClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickSummon, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function DivineQingGuClgMainView:unbindEvents()
	DivineQingGuClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DivineQingGuClgMainView:onEnter()
	DivineQingGuClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineQingGuClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 372001
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = DivineQingGuClgConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	DivineQingGuClgAgent.instance:sendPM_DivineQingGuClgGetInfoReq(self._activityId)
end

function DivineQingGuClgMainView:onExit()
	DivineQingGuClgMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function DivineQingGuClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divineqingguclgmainview_rule")
end

function DivineQingGuClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function DivineQingGuClgMainView:_onClickShop()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function DivineQingGuClgMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function DivineQingGuClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DivineQingGuClgLevelView, self._activityId)
end

function DivineQingGuClgMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DivineQingGuClgMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DivineQingGuClgMainView:_onGetInfoRes()
	return
end

function DivineQingGuClgMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function DivineQingGuClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineQingGuClgMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivineQingGuClgMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function DivineQingGuClgMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

return DivineQingGuClgMainView
