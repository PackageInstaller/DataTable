-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgmainView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgmainView", package.seeall)

local ShadowdragonclgmainView = class("ShadowdragonclgmainView", ViewComponent)

function ShadowdragonclgmainView:buildUI()
	ShadowdragonclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/name/imgRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnInfo")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/name/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._passGo = self:getGo("btnClg/passGo")
	self._bubble = self:getGo("extreme/bubble")
	self._showConBubble = self:getGo("extreme/bubble/showCon")
	self._txtBubble = self:getTxt("extreme/bubble/txt")
end

function ShadowdragonclgmainView:bindEvents()
	ShadowdragonclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function ShadowdragonclgmainView:unbindEvents()
	ShadowdragonclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function ShadowdragonclgmainView:onEnter()
	ShadowdragonclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ShadowDragonClgGetInfoRes, self._updateUI, self)

	self._activityType = GameEnum.ActivityType.ShadowDragonClg
	self._activityId = self:_getActivityId()

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = ShadowdragonclgConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgGetInfoReq(self._activityId)
end

function ShadowdragonclgmainView:onExit()
	ShadowdragonclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
end

function ShadowdragonclgmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function ShadowdragonclgmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function ShadowdragonclgmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function ShadowdragonclgmainView:_getSkinId()
	return ShadowdragonclgConfig.instance:getSkinId(self._activityId)
end

function ShadowdragonclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function ShadowdragonclgmainView:_onClickBtnClg()
	local timeStr = self._actCfg.openTime
	local isOpen = GameUtil.string2time(timeStr) <= ServerTime.now()

	if not isOpen then
		FloatWordMgr.instance:show(string.format("%s开启", timeStr))

		return
	end

	UIStateManager.instance:push(ViewName.ShadowdragonclgstageView, self._activityId)
end

function ShadowdragonclgmainView:_onClickBtnTip()
	local challengeCfg = ShadowdragonclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function ShadowdragonclgmainView:_updateUI()
	self._info = ShadowdragonclgModel.instance:getInfo(self._activityId)

	goutil.setActive(self._passGo, false)
end

function ShadowdragonclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.nowTierPrize)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	MaterialMgr.setCellByCfg(self._actCfg.nowTierPrize, self._showConBubble)

	self._txtBubble.text = string.format("每层通关得\n%s%s", matNum, matName)
end

function ShadowdragonclgmainView:_getActivityId()
	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	return activityId
end

return ShadowdragonclgmainView
