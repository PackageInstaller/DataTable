-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgMainView.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgMainView", package.seeall)

local YinZhiClgMainView = class("YinZhiClgMainView", ViewComponent)

function YinZhiClgMainView:ctor()
	YinZhiClgMainView.super.ctor(self)
end

function YinZhiClgMainView:unbindEvents()
	YinZhiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnFight)
end

function YinZhiClgMainView:bindEvents()
	YinZhiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
end

function YinZhiClgMainView:buildUI()
	YinZhiClgMainView.super.buildUI(self)

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
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._pass = self:getGo("fight/pass")
	self._btnFight = self:getGo("fight/btn")
end

function YinZhiClgMainView:onExit()
	YinZhiClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function YinZhiClgMainView:onEnter()
	YinZhiClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 486001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.YinZhiClgGetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	YinZhiClgController.instance:getInfo(self._activityId)
end

function YinZhiClgMainView:_updateUIByCfg()
	self._actCfg = YinZhiClgConfig.instance:getActCfgById(self._activityId)
	self._phaseCfgs = YinZhiClgConfig.instance:getPhaseCfgsById(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name
end

function YinZhiClgMainView:_updateUIByInfo()
	goutil.setActive(self._pass, false)

	local curFirstPassPhaseId = YinZhiClgController.instance:getFirstPassPhaseId(self._activityId)

	if curFirstPassPhaseId >= #self._phaseCfgs then
		goutil.setActive(self._pass, true)
	end
end

function YinZhiClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if key == "jumpStr4" then
		if string.nilorempty(jumpToStr) then
			self:_onClickFirstPass()
		else
			GotoMgr.gotoByString(jumpToStr)
		end
	else
		GotoMgr.gotoByString(jumpToStr)
	end
end

function YinZhiClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function YinZhiClgMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function YinZhiClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function YinZhiClgMainView:_onClickFirstPass()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

function YinZhiClgMainView:_onClickFight()
	UIStateManager.instance:push(ViewName.YinZhiClgStageView, self._activityId)
end

return YinZhiClgMainView
