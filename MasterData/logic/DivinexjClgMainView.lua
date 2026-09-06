-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgMainView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgMainView", package.seeall)

local DivinexjClgMainView = class("DivinexjClgMainView", ViewComponent)

function DivinexjClgMainView:ctor()
	DivinexjClgMainView.super.ctor(self)
end

function DivinexjClgMainView:buildUI()
	DivinexjClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
end

function DivinexjClgMainView:bindEvents()
	DivinexjClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickSummon, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickCultivate, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function DivinexjClgMainView:unbindEvents()
	DivinexjClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DivinexjClgMainView:onEnter()
	DivinexjClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineXingJiangClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DivineXingJiangClgModel.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = DivineXingJiangClgConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	DivineXingJiangClgAgent.instance:sendPM_DivineXingJiangClgGetInfoReq(self._activityId)
end

function DivinexjClgMainView:onExit()
	DivinexjClgMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function DivinexjClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divinexjclgmainview_rule")
end

function DivinexjClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function DivinexjClgMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function DivinexjClgMainView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function DivinexjClgMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DivinexjClgMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DivinexjClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DivinexjClgLevelView, self._activityId)
end

function DivinexjClgMainView:_onGetInfoRes()
	return
end

function DivinexjClgMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivinexjClgMainView:_showRoleModel()
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

function DivinexjClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivinexjClgMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function DivinexjClgMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

return DivinexjClgMainView
