-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonMainView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonMainView", package.seeall)

local DarkKingDragonMainView = class("DarkKingDragonMainView", ViewComponent)

function DarkKingDragonMainView:ctor()
	DarkKingDragonMainView.super.ctor(self)
end

function DarkKingDragonMainView:unbindEvents()
	DarkKingDragonMainView.super.unbindEvents(self)
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

function DarkKingDragonMainView:bindEvents()
	DarkKingDragonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, self._onClickJump3, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, self._onClickJump4, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
end

function DarkKingDragonMainView:buildUI()
	DarkKingDragonMainView.super.buildUI(self)

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

function DarkKingDragonMainView:onExit()
	DarkKingDragonMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DarkKingDragonMainView:onEnter()
	DarkKingDragonMainView.super.onEnter(self)

	self._activityId = 526001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgInfoRes, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	DivineDarkKingDragonClgController.instance:getInfo(self._activityId)
end

function DarkKingDragonMainView:_updateUIByCfg()
	self._actCfg = DivineDarkKingDragonClgConfig.instance:getActCfgById(self._activityId)
	self._phaseCfgs = DivineDarkKingDragonClgConfig.instance:getPhaseCfgsByActId(self._activityId)
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name
end

function DarkKingDragonMainView:_updateUIByInfo()
	goutil.setActive(self._pass, false)

	local lastPhaseId = #self._phaseCfgs
	local lastPhaseInfo = DivineDarkKingDragonClgModel.instance:getPhaseInfo(self._activityId, lastPhaseId)

	if lastPhaseInfo then
		goutil.setActive(self._pass, lastPhaseInfo.info.hadGainedPrize)
	end
end

function DarkKingDragonMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DarkKingDragonMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DarkKingDragonMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function DarkKingDragonMainView:_onClickJump1()
	local jumpToStr = self._actCfg.jumpToRank

	GotoMgr.gotoByString(jumpToStr)
end

function DarkKingDragonMainView:_onClickJump2()
	local jumpToStr = self._actCfg.jumpToShop

	GotoMgr.gotoByString(jumpToStr)
end

function DarkKingDragonMainView:_onClickJump3()
	local jumpToStr = self._actCfg.jumpToCall

	GotoMgr.gotoByString(jumpToStr)
end

function DarkKingDragonMainView:_onClickJump4()
	local jumpToStr = self._actCfg.jumpToFirstPass

	GotoMgr.gotoByString(jumpToStr)
end

function DarkKingDragonMainView:_onClickFight()
	UIStateManager.instance:push(ViewName.DarkKingDragonClgView, self._activityId)
end

return DarkKingDragonMainView
