-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyamainView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyamainView", package.seeall)

local MiraclenuoyamainView = class("MiraclenuoyamainView", ViewComponent)

function MiraclenuoyamainView:buildUI()
	MiraclenuoyamainView.super.buildUI(self)

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
	self._goBtnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._redClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._passClg2 = self:getGo("clgBtnCol/btnClg2/btn/imgPass")
	self._bubble = self:getGo("clgBtnCol/bubble")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnAttr = self:getGo("btnAttr")
	self._imgAttr = self:getGo("btnAttr/img")
	self._redpointAttr = self:getGo("btnAttr/redPoint")
end

function MiraclenuoyamainView:bindEvents()
	MiraclenuoyamainView.super.bindEvents(self)
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

function MiraclenuoyamainView:unbindEvents()
	MiraclenuoyamainView.super.unbindEvents(self)
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

function MiraclenuoyamainView:onExit()
	MiraclenuoyamainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.clearIcon(self._imgAttr)
end

function MiraclenuoyamainView:onEnter()
	MiraclenuoyamainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MiracleNuoyaController.instance:getActivityId()
	end

	self._activityType = MiracleNuoyaController.instance:getActivityType()

	local isInTime = MiracleNuoyaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = MiracleNuoyaConfig.instance:getActivityCfgById(self._activityId)

	self:_setActTime()
	self:_setRole()
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._bubble, not self._isAoqiGodProcessType)

	if GameUtil.GetActive(self._goBtnClg2) then
		GameUtil.SetActive(self._clgBtnCol_btnClg2, not self._isAoqiGodProcessType)
	end

	self.addGEvent(self, GlobalNotify.MiracleNuoYaInfoUpdate, self._updateUI, self)
	MiracleNuoyaController.instance:sendGetInfo(self._activityId)
	self:_updateUI()
end

function MiraclenuoyamainView:_getSkinId()
	return checknumber(self._actCfg.skinId)
end

function MiraclenuoyamainView:_upateRed()
	return
end

function MiraclenuoyamainView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function MiraclenuoyamainView:_setRole()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setIcon(self._imgAttr, MatType.PET_SKIN, skinId)
end

function MiraclenuoyamainView:_updateUI()
	self:_updateSuperBubble()
	self:_upateRed()
end

function MiraclenuoyamainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function MiraclenuoyamainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function MiraclenuoyamainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function MiraclenuoyamainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = self._actCfg[key]

	if enableDebug and string.nilorempty(jumpToStr) then
		TipsFacade.instance:openCommonTips("缺少配置：" .. key)
	end

	GotoMgr.gotoByString(jumpToStr)
end

function MiraclenuoyamainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.MiraclenuoyamapView, self._activityId)
end

function MiraclenuoyamainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.MiraclenuoyanorView, self._activityId)
end

function MiraclenuoyamainView:_onClickBtnTip()
	local ruleKey = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(ruleKey)
end

function MiraclenuoyamainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._itemcellGo)

	if self._actCfg then
		MaterialMgr.setCellByCfg(self._actCfg.bubbleItem, self._itemcellGo)
	end

	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.extremeClgInfo then
		local extremeClgInfo = {}

		if not extremeClgInfo.extremeClgPassedBlockId then
			local passedBlockIdList = {}
			local mapCfg = MiracleNuoyaConfig.instance:getMapCfgById(self._activityId) or {}

			goutil.setActive(self._imgHasGainGo, #passedBlockIdList >= #mapCfg + 1)
		end
	end
end

function MiraclenuoyamainView:_onClickbtnAttr()
	UIStateManager.instance:push(ViewName.DivinelongyanshowView, self._activityId)
end

return MiraclenuoyamainView
