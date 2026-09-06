-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanClgView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanClgView", package.seeall)

local DivineTianShanClgView = class("DivineTianShanClgView", ViewComponent)

function DivineTianShanClgView:ctor()
	DivineTianShanClgView.super.ctor(self)
end

function DivineTianShanClgView:unbindEvents()
	DivineTianShanClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump5)
	GameUtil.rmClickHandler(self._btnExtreme)
	GameUtil.rmClickHandler(self._btnNormal)
end

function DivineTianShanClgView:bindEvents()
	DivineTianShanClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump5, self._onClickFirstPass, self)
	GameUtil.addClickHandler(self._btnExtreme, self._onClickBtnExtreme, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickBtnNormal, self)
end

function DivineTianShanClgView:buildUI()
	DivineTianShanClgView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump5 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump5")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._jumpBtnCol_btnJump4_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._btnExtreme = self:getGo("extreme/btn")
	self._bubble = self:getGo("extreme/bubble")
	self._showConBubble = self:getGo("extreme/bubble/showCon")
	self._passBubble = self:getGo("extreme/bubble/pass")
	self._goNormal = self:getGo("normal")
	self._btnNormal = self:getGo("normal/btn")
	self._txtNormalEndTime = self:getTxt("normal/endTime/txt")
end

function DivineTianShanClgView:onExit()
	DivineTianShanClgView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
end

function DivineTianShanClgView:onEnter()
	DivineTianShanClgView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.DivineTianShanClgGetInfo, self._updateUIByInfo, self)
	DivineTianShanClgController.instance:getInfo(self._activityId)
end

function DivineTianShanClgView:_updateUIByCfg()
	self._actCfg = DivineTianShanClgConfig.instance:getActCfgById(self._activityId)
	self._normalCfg = DivineTianShanClgConfig.instance:getNormalClgPlanCfg(self._actCfg.normalClgPlanId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name

	MaterialMgr.setCellByCfg(self._actCfg.prize, self._showConBubble)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)

	goutil.setActive(self._jumpBtnCol_btnJump1, not GameUtil.isEmptyString(self._actCfg.jumpStr1))
	goutil.setActive(self._jumpBtnCol_btnJump2, not GameUtil.isEmptyString(self._actCfg.jumpStr2))
	goutil.setActive(self._jumpBtnCol_btnJump3, not GameUtil.isEmptyString(self._actCfg.jumpStr3))
	goutil.setActive(self._jumpBtnCol_btnJump4, not GameUtil.isEmptyString(self._actCfg.jumpStr4))
	goutil.setActive(self._goNormal, self._actCfg.normalClgPlanId ~= 0)
	goutil.setActive(self._bubble, not GameUtil.isEmptyString(self._actCfg.prize))

	if self._actCfg.normalClgPlanId ~= 0 then
		local dateEnd = GameUtil.string2date(self._normalCfg.endTime)

		self._txtNormalEndTime.text = string.format("%s.%s.%s结束", dateEnd.year, dateEnd.month, dateEnd.day)

		goutil.setActive(self._goNormal, not (ServerTime.now() > GameUtil.string2time(self._normalCfg.endTime)))
	end
end

function DivineTianShanClgView:_updateUIByInfo()
	local info = DivineTianShanClgModel.instance:getBaseInfo(self._activityId)

	if info then
		goutil.setActive(self._passBubble, info.extremeClgInfo.gainPrize)
	end
end

function DivineTianShanClgView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineTianShanClgView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineTianShanClgView:_onClickBtnExtreme()
	UIStateManager.instance:push(ViewName.DivineTianShanClgExtremeView, self._activityId)
end

function DivineTianShanClgView:_onClickBtnNormal()
	UIStateManager.instance:push(ViewName.DivineTianShancClgNormalView, self._activityId)
end

function DivineTianShanClgView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DivineTianShanClgView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function DivineTianShanClgView:_onClickFirstPass()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

return DivineTianShanClgView
