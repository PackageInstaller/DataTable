-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulasmainView.lua

module("logic.extensions.gulas.view.GulasmainView", package.seeall)

local GulasmainView = class("GulasmainView", ViewComponent)

function GulasmainView:buildUI()
	GulasmainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._redClg1 = self:getGo("clgBtnCol/btnClg1/btn/redPoint")
	self._passClg1 = self:getGo("clgBtnCol/btnClg1/btn/imgPass")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._redClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._passClg2 = self:getGo("clgBtnCol/btnClg2/btn/imgPass")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnAttr = self:getGo("btnAttr")
	self._imgAttr = self:getGo("btnAttr/img")
	self._redpointAttr = self:getGo("btnAttr/redPoint")
	self._buffRoot = self:getGo("buffRoot")
end

function GulasmainView:bindEvents()
	GulasmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._btnAttr, self._onClickbtnAttr, self)
end

function GulasmainView:unbindEvents()
	GulasmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnAttr)
end

function GulasmainView:onExit()
	GulasmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.clearIcon(self._imgAttr)
end

function GulasmainView:onEnter()
	GulasmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = GulasController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = GulasConfig.instance:getActivityCfgById(self._activityId) or {}

	self:_setActTime()
	self:_setRole()
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	self.addGEvent(self, GlobalNotify.GULAS_CLG_INFO_UPDATE, self._updateUI, self)
	GulasController.instance:sendGetInfo(self._activityId)
	self:_updateUI()
	GulasController.instance:tryShowChangeSet()
end

function GulasmainView:_getSkinId()
	return checknumber(self._actCfg.skinId)
end

function GulasmainView:_upateRed()
	return
end

function GulasmainView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function GulasmainView:_setRole()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setIcon(self._imgAttr, MatType.PET_SKIN, skinId)
end

function GulasmainView:_updateUI()
	self._info = GulasModel.instance:getInfo(self._activityId) or {}

	local list = GulasConfig.instance:getPhaseCfgListById(self._activityId) or {}

	GameUtil.SetActive(self._passClg1, checknumber(self._info.passPhaseId) >= #list)
	self:_updateSuperBubble()
	self:_upateRed()
end

function GulasmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function GulasmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function GulasmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function GulasmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if enableDebug and string.nilorempty(jumpToStr) then
		TipsFacade.instance:openCommonTips("缺少配置( 看清楚！)： " .. key)
	end

	GotoMgr.gotoByString(jumpToStr)
end

function GulasmainView:_onClickBtnClg1()
	self._info = GulasModel.instance:getInfo(self._activityId) or {}

	if not self._info.clgInfo then
		local list = GulasConfig.instance:getPhaseCfgListById(self._activityId) or {}

		if checknumber(self._info.passPhaseId) < #list then
			UIStateManager.instance:push(ViewName.GulaslevelsView, self._activityId)
		else
			TipsFacade.instance:openCommonTips("已全部通关")
		end
	end
end

function GulasmainView:_onClickBtnClg2()
	return
end

function GulasmainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("gulasmainview_rule")
end

function GulasmainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._itemcellGo)

	if self._actCfg then
		MaterialMgr.setCellByCfg(self._actCfg.bubbleItem, self._itemcellGo)
	end
end

function GulasmainView:_onClickbtnAttr()
	return
end

return GulasmainView
