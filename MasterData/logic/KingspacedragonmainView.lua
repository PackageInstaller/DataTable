-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonmainView.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonmainView", package.seeall)

local KingspacedragonmainView = class("KingspacedragonmainView", ViewComponent)

function KingspacedragonmainView:buildUI()
	KingspacedragonmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnInfo")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._passGo = self:getGo("btnChallenge/pass")
end

function KingspacedragonmainView:bindEvents()
	KingspacedragonmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function KingspacedragonmainView:unbindEvents()
	KingspacedragonmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnChallenge:RemoveClickListener()
end

function KingspacedragonmainView:onEnter()
	KingspacedragonmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KingSpaceDragonClgGetInfoRes, self._updateUI, self)

	local actId = checknumber(self:getFirstParam())

	self._activityId = actId > 0 and actId or 350001

	KingspacedragonModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = KingspacedragonConfig.instance:getActCfg(self._activityId)

	self:_updateUI()
	self:_hideAoqiGodNodes()
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgGetInfoReq(self._activityId)
	KingspacedragonController.instance:recordDailyEnter()
end

function KingspacedragonmainView:onExit()
	KingspacedragonmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function KingspacedragonmainView:_updateUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local isPass = KingspacedragonController.instance:isChallengePass(self._activityId)

	goutil.setActive(self._passGo, isPass)
end

function KingspacedragonmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingspacedragonmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KingspacedragonmainView:_getRaceId()
	return KingspacedragonController.instance:getRaceId(self._activityId)
end

function KingspacedragonmainView:_getSkinId()
	return KingspacedragonConfig.instance:getSkinId(self._activityId)
end

function KingspacedragonmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function KingspacedragonmainView:_onClickBtnTip()
	local key = KingspacedragonConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function KingspacedragonmainView:_onClickbtnChallenge()
	local isPass = KingspacedragonController.instance:isChallengePass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.KingspacedragonlevelsView)
end

function KingspacedragonmainView:_hideAoqiGodNodes()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	goutil.setActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
end

return KingspacedragonmainView
