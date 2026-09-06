-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahMainView.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahMainView", package.seeall)

local OriginDragonNoahMainView = class("OriginDragonNoahMainView", ViewComponent)

function OriginDragonNoahMainView:ctor()
	OriginDragonNoahMainView.super.ctor(self)
end

function OriginDragonNoahMainView:unbindEvents()
	OriginDragonNoahMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function OriginDragonNoahMainView:bindEvents()
	OriginDragonNoahMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
end

function OriginDragonNoahMainView:buildUI()
	OriginDragonNoahMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._firstPass = self:getGo("btnNorClg/firstPass")
	self._reward = self:getGo("reward/reward")
	self._geted = self:getGo("reward/geted")
	self._txtRewardName = self:getTxt("reward/txtName")
end

function OriginDragonNoahMainView:onExit()
	OriginDragonNoahMainView.super.onExit(self)
	MaterialMgr.resetAll(self._reward)
end

function OriginDragonNoahMainView:onEnter()
	OriginDragonNoahMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDragonNoahClgInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 539001
	end

	self._actCfg = OriginDragonNoahConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	OriginDragonNoahController.instance:setCurActivityId(self._activityId)
	OriginDragonNoahController.instance:sendPM_OriginDragonNoahClgInfoReq(self._activityId)
end

function OriginDragonNoahMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtPetNameInInfo.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtRewardName.text = MaterialMgr.getMaterialsNameByCfg(self._actCfg.prize)

	MaterialMgr.setCellByCfg(self._actCfg.prize, self._reward)
end

function OriginDragonNoahMainView:_onUpdate()
	self._info = OriginDragonNoahModel.instance:getInfo(self._activityId)

	GameUtil.SetActive(self._geted, self._info.isPass)
	GameUtil.SetActive(self._firstPass, self._info.isPass)
end

function OriginDragonNoahMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(jumpStr)
end

function OriginDragonNoahMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginDragonNoahMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function OriginDragonNoahMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function OriginDragonNoahMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.OriginDragonNoahLevelView, self._activityId)
end

return OriginDragonNoahMainView
