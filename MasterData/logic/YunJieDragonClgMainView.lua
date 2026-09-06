-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgMainView.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgMainView", package.seeall)

local YunJieDragonClgMainView = class("YunJieDragonClgMainView", ViewComponent)

function YunJieDragonClgMainView:ctor()
	YunJieDragonClgMainView.super.ctor(self)
end

function YunJieDragonClgMainView:unbindEvents()
	YunJieDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function YunJieDragonClgMainView:bindEvents()
	YunJieDragonClgMainView.super.bindEvents(self)
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

function YunJieDragonClgMainView:buildUI()
	YunJieDragonClgMainView.super.buildUI(self)

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
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._item = self:getGo("reward/item")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
end

function YunJieDragonClgMainView:onExit()
	YunJieDragonClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	MaterialMgr.resetAll(self._item)
end

function YunJieDragonClgMainView:onEnter()
	YunJieDragonClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YunJieDragonClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 572001
	end

	self._actCfg = YunJieDragonClgConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	YunJieDragonClgController.instance:sendPM_YunJieDragonClgGetInfoReq(self._activityId)
end

function YunJieDragonClgMainView:_onSetUI()
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

	MaterialMgr.setCellByCfg(self._actCfg.passPrize, self._item)
end

function YunJieDragonClgMainView:_onUpdate()
	local hasAllPass = YunJieDragonClgController.instance:hasAllPass(self._activityId)

	GameUtil.SetActive(self._firstPass, hasAllPass)
end

function YunJieDragonClgMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(jumpStr)
end

function YunJieDragonClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function YunJieDragonClgMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function YunJieDragonClgMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function YunJieDragonClgMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.YunJieDragonClgLevelView, self._activityId)
end

function YunJieDragonClgMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return YunJieDragonClgMainView
