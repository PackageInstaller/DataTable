-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/view/DragonManClgMainView.lua

module("logic.extensions.dragonmanclg.view.DragonManClgMainView", package.seeall)

local DragonManClgMainView = class("DragonManClgMainView", ViewComponent)

function DragonManClgMainView:ctor()
	DragonManClgMainView.super.ctor(self)
end

function DragonManClgMainView:unbindEvents()
	DragonManClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._btnClg)
end

function DragonManClgMainView:bindEvents()
	DragonManClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, self._onClickBtnJump1, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, self._onClickBtnJump2, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, self._onClickBtnJump3, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function DragonManClgMainView:buildUI()
	DragonManClgMainView.super.buildUI(self)

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
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._showCon = self:getGo("bubble/showCon")
	self._passBubble = self:getGo("bubble/pass")
	self._txtBubble = self:getTxt("bubble/txt")
	self._btnClg = self:getGo("btnClg")
	self._markPass = self:getGo("pass")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function DragonManClgMainView:onExit()
	DragonManClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function DragonManClgMainView:onEnter()
	DragonManClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 552001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DragonManClgController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.PM_DragonManClgInfoRes, self._updateUIByInfo, self)
	DragonManClgController.instance:showCI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function DragonManClgMainView:_updateUIByCfg()
	self._actCfg = DragonManClgConfig.instance:getActivityCfg(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name

	MaterialMgr.setCellByCfg(self._actCfg.prize, self._showCon)

	local matType, cfgId = MaterialMgr.getMatParams(self._actCfg.prize)

	self._txtBubble.text = string.format("通关后获得\n%s", MaterialMgr.getMaterialsName(matType, cfgId))

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	self._stageCfgs = DragonManClgConfig.instance:getStageCfgs(self._activityId) or {}
end

function DragonManClgMainView:_updateUIByInfo()
	self.isAllPass = false

	local info = DragonManClgModel.instance:getInfoByActId(self._activityId)

	if info then
		local maxPassedStageId = info.maxPassedStageId
		local totalStageNum = #self._stageCfgs

		if totalStageNum <= maxPassedStageId then
			self.isAllPass = true
		end
	end

	goutil.setActive(self._passBubble, self.isAllPass)
	goutil.setActive(self._markPass, self.isAllPass)
end

function DragonManClgMainView:_onClickBtnJump1()
	local jumpToStr = self._actCfg.gotoRank

	GotoMgr.gotoByString(jumpToStr)
end

function DragonManClgMainView:_onClickBtnJump2()
	local jumpToStr = self._actCfg.gotoShop

	GotoMgr.gotoByString(jumpToStr)
end

function DragonManClgMainView:_onClickBtnJump3()
	local jumpToStr = self._actCfg.gotoDirectShop

	GotoMgr.gotoByString(jumpToStr)
end

function DragonManClgMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DragonManClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function DragonManClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DragonManClgMainView:_onClickBtnClg()
	if self.isAllPass then
		FloatWordMgr.instance:show("您已通关全部关卡，无需再次挑战")

		return
	end

	UIStateManager.instance:push(ViewName.DragonManClgStageView, self._activityId)
end

function DragonManClgMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return DragonManClgMainView
