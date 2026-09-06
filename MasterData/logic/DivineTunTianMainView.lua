-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianMainView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianMainView", package.seeall)

local DivineTunTianMainView = class("DivineTunTianMainView", ViewComponent)

function DivineTunTianMainView:ctor()
	DivineTunTianMainView.super.ctor(self)
end

function DivineTunTianMainView:unbindEvents()
	DivineTunTianMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnNorClg)
	GameUtil.rmClickHandler(self._btnExtClg)
end

function DivineTunTianMainView:bindEvents()
	DivineTunTianMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnNorClg, self._onClickBtnNorClg, self)
	GameUtil.addClickHandler(self._btnExtClg, self._onClickBtnExtClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, 5))
end

function DivineTunTianMainView:buildUI()
	DivineTunTianMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._btnExtClg = self:getGo("btnExtClg/btn")
	self._btnNorClg = self:getGo("btnNorClg/btn")
	self._firstPassExt = self:getGo("btnExtClg/firstPass")
	self._firstPassNor = self:getGo("btnNorClg/firstPass")
	self._reward = self:getGo("btnExtClg/bubble/reward")
	self._txtDesc = self:getTxt("btnExtClg/bubble/txtDesc")
	self._redPoint = self:getGo("btnNorClg/btn/redPoint")
	self._extGet = self:getGo("btnExtClg/bubble/Passed")
end

function DivineTunTianMainView:onExit()
	DivineTunTianMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._role)
	MaterialMgr.resetAll(self._reward)
	RedPointController.instance:unregRedPoint(self._redPoint)
	MaterialMgr.resetAll(self._pointRare)
end

function DivineTunTianMainView:onEnter()
	DivineTunTianMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineTunTianClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._actCfg = DivineTunTianConfig.instance:getActCfg(self._activityId)
	self._norPrizeCfgs = DivineTunTianConfig.instance:getNorPrizeCfgs(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	DivineTunTianController.instance:calcPlayerPet()
	RedPointController.instance:regRedPoint(self._redPoint, 722)
	DivineTunTianController.instance:sendPM_DivineTunTianClgGetInfoReq(self._activityId)
end

function DivineTunTianMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setCellByCfg(self._actCfg.extremeClgPrize, self._reward)
end

function DivineTunTianMainView:_onUpdate()
	self._info = DivineTunTianModel.instance:getInfo(self._activityId)

	local hasGainNorPrizeNum = #((self._info and self._info.normalPrizeIds or nil) and self._info.normalPrizeIds)
	local totalNorPrizeNum = #self._norPrizeCfgs
	local extremeHasEverPass = false

	if self._info then
		extremeHasEverPass = self._info.extremeHasEverPass
	end

	GameUtil.SetActive(self._firstPassExt, extremeHasEverPass)
	GameUtil.SetActive(self._extGet, extremeHasEverPass)
	GameUtil.SetActive(self._firstPassNor, totalNorPrizeNum <= hasGainNorPrizeNum)

	self._txtDesc.text = extremeHasEverPass and "已获得" or "通关获得"
end

function DivineTunTianMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function DivineTunTianMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function DivineTunTianMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DivineTunTianMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineTunTianMainView:_onClickBtnExtClg()
	UIStateManager.instance:push(ViewName.DivineTunTianExtView, self._activityId)
end

function DivineTunTianMainView:_onClickBtnNorClg()
	local hasGainNorPrizeNum = #((self._info and self._info.normalPrizeIds or nil) and self._info.normalPrizeIds)
	local totalNorPrizeNum = #self._norPrizeCfgs

	if totalNorPrizeNum <= hasGainNorPrizeNum then
		FloatWordMgr.instance:show("已领取所有奖励")

		return
	end

	UIStateManager.instance:push(ViewName.DivineTunTianNorView, self._activityId)
end

return DivineTunTianMainView
