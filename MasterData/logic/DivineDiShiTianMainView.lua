-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/view/DivineDiShiTianMainView.lua

module("logic.extensions.divinedishitianclg.view.DivineDiShiTianMainView", package.seeall)

local DivineDiShiTianMainView = class("DivineDiShiTianMainView", ViewComponent)

function DivineDiShiTianMainView:ctor()
	DivineDiShiTianMainView.super.ctor(self)
end

function DivineDiShiTianMainView:buildUI()
	DivineDiShiTianMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnDivine = self:getBtn("btnDivine")
	self._btnMonth = self:getBtn("btnMonth")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._btnRank = self:getBtn("btnRank")
	self._btnNormal = self:getBtn("btnNormal")
	self._btnExtreme = self:getBtn("btnExtreme")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._normalPass = self:getGo("btnNormal/pass")
	self._extremePass = self:getGo("btnExtreme/pass")
	self._normalRedPoint = self:getGo("btnNormal/redPoint")
	self._extremeRedPoint = self:getGo("btnExtreme/redPoint")
end

function DivineDiShiTianMainView:bindEvents()
	DivineDiShiTianMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnDivine, self._onClickDivine, self)
	GameUtil.addClickHandler(self._btnMonth, self._onClickMonth, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickCultivate, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnExtreme, self._onClickExtreme, self)
end

function DivineDiShiTianMainView:unbindEvents()
	DivineDiShiTianMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnDivine)
	GameUtil.rmClickHandler(self._btnMonth)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnExtreme)
end

function DivineDiShiTianMainView:onEnter()
	DivineDiShiTianMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineDiShiTianClgInfoRes, self._onGetInfoRes, self)

	self._activityId = DivineDiShiTianClgModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = DivineDiShiTianClgConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	self:_updatePassState()
	self:_updateRedPoint()
	DivineDiShiTianClgAgent.instance:sendPM_DivineDiShiTianClgInfoReq(self._activityId)
end

function DivineDiShiTianMainView:onExit()
	DivineDiShiTianMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function DivineDiShiTianMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divinedishitianmainview_rule")
end

function DivineDiShiTianMainView:_onClickDivine()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function DivineDiShiTianMainView:_onClickMonth()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function DivineDiShiTianMainView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function DivineDiShiTianMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function DivineDiShiTianMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DivineDiShiTianMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DivineDiShiTianMainView:_onClickNormal()
	if DivineDiShiTianClgModel.instance:isPassNormalAll(self._activityId) then
		FloatWordMgr.instance:show("已通关")
	else
		UIStateManager.instance:push(ViewName.DivineDiShiTianNormalView, self._activityId)
	end
end

function DivineDiShiTianMainView:_onClickExtreme()
	if DivineDiShiTianClgModel.instance:isPassExtremeAll(self._activityId) then
		FloatWordMgr.instance:show("已通关")
	else
		UIStateManager.instance:push(ViewName.DivineDiShiTianExtremeView, self._activityId)
	end
end

function DivineDiShiTianMainView:_onGetInfoRes()
	self:_updatePassState()
	self:_updateRedPoint()
end

function DivineDiShiTianMainView:_showRoleModel()
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

function DivineDiShiTianMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineDiShiTianMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivineDiShiTianMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function DivineDiShiTianMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function DivineDiShiTianMainView:_updatePassState()
	GameUtil.SetActive(self._normalPass, DivineDiShiTianClgModel.instance:isPassNormalAll(self._activityId))
	GameUtil.SetActive(self._extremePass, DivineDiShiTianClgModel.instance:isPassExtremeAll(self._activityId))
end

function DivineDiShiTianMainView:_updateRedPoint()
	GameUtil.SetActive(self._normalRedPoint, DivineDiShiTianClgModel.instance:isAnyNormalRewardCanGet(self._activityId))
	GameUtil.SetActive(self._extremeRedPoint, DivineDiShiTianClgModel.instance:isExtremeCanGetReward(self._activityId))
end

return DivineDiShiTianMainView
