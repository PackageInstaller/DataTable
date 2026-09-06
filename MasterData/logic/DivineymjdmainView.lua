-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdmainView.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdmainView", package.seeall)

local DivineymjdmainView = class("DivineymjdmainView", ViewComponent)

function DivineymjdmainView:buildUI()
	DivineymjdmainView.super.buildUI(self)

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
	self._redPointGo = self:getGo("btnBuff/redPoint")
	self._btnBuffGo = self:getGo("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
end

function DivineymjdmainView:bindEvents()
	DivineymjdmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function DivineymjdmainView:unbindEvents()
	DivineymjdmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	self._btnChallenge:RemoveClickListener()
end

function DivineymjdmainView:onEnter()
	DivineymjdmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KingSpaceDragonClgGetInfoRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 350002
	end

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
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgGetInfoReq(self._activityId)
	KingspacedragonController.instance:recordDailyEnter()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnBuffGo, function(param)
		goutil.setActive(self._redPointGo, param.isCanGain)

		local buffCfg = param.buffCfg

		self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.des
	end)
end

function DivineymjdmainView:onExit()
	DivineymjdmainView.super.onExit(self)

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

	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnBuffGo)
end

function DivineymjdmainView:_updateUI()
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

function DivineymjdmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineymjdmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineymjdmainView:_getRaceId()
	return KingspacedragonController.instance:getRaceId(self._activityId)
end

function DivineymjdmainView:_getSkinId()
	return KingspacedragonConfig.instance:getSkinId(self._activityId)
end

function DivineymjdmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineymjdmainView:_onClickBtnTip()
	local key = KingspacedragonConfig.instance:getRuleKey(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function DivineymjdmainView:_onClickbtnChallenge()
	local isPass = KingspacedragonController.instance:isChallengePass(self._activityId)

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineymjdlevelsView)
end

return DivineymjdmainView
