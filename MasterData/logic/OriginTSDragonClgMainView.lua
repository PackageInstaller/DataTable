-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgMainView.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgMainView", package.seeall)

local OriginTSDragonClgMainView = class("OriginTSDragonClgMainView", ViewComponent)

function OriginTSDragonClgMainView:ctor()
	OriginTSDragonClgMainView.super.ctor(self)
end

function OriginTSDragonClgMainView:unbindEvents()
	OriginTSDragonClgMainView.super.unbindEvents(self)
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

function OriginTSDragonClgMainView:bindEvents()
	OriginTSDragonClgMainView.super.bindEvents(self)
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

function OriginTSDragonClgMainView:buildUI()
	OriginTSDragonClgMainView.super.buildUI(self)

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
	self._firstPass = self:getGo("btnNorClg/firstPass")
	self._btnChallenge = self:getGo("btnNorClg")
	self._tagHasGain = self:getGo("bubble/tagHasGain")
	self._item = self:getGo("bubble/item")
end

function OriginTSDragonClgMainView:onExit()
	OriginTSDragonClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._item)
	MaterialMgr.resetAll(self._role)
end

function OriginTSDragonClgMainView:onEnter()
	OriginTSDragonClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginTSDragonClgInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 591001
	end

	self._actCfg = OriginTSDragonClgConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	MaterialMgr.setCellByCfg(self._actCfg.prize, self._item)
	OriginTSDragonClgController.instance:sendPM_OriginTSDragonClgInfoReq(self._activityId)
end

function OriginTSDragonClgMainView:_onSetUI()
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
end

function OriginTSDragonClgMainView:_onUpdate()
	local hasAllPass = OriginTSDragonClgController.instance:isAllPass(self._activityId)

	GameUtil.SetActive(self._tagHasGain, hasAllPass)
end

function OriginTSDragonClgMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(jumpStr)
end

function OriginTSDragonClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginTSDragonClgMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function OriginTSDragonClgMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function OriginTSDragonClgMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.OriginTSDragonClgLevelView, self._activityId)
end

return OriginTSDragonClgMainView
