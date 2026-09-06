-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgMainView.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgMainView", package.seeall)

local OriginInfiniteFutureClgMainView = class("OriginInfiniteFutureClgMainView", ViewComponent)

function OriginInfiniteFutureClgMainView:ctor()
	OriginInfiniteFutureClgMainView.super.ctor(self)
end

function OriginInfiniteFutureClgMainView:unbindEvents()
	OriginInfiniteFutureClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)

	for _, btn in ipairs(self._jumpBtns or {}) do
		GameUtil.rmClickHandler(btn)
	end
end

function OriginInfiniteFutureClgMainView:bindEvents()
	OriginInfiniteFutureClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)

	for idx, btn in ipairs(self._jumpBtns or {}) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnJump, self, idx), self)
	end
end

function OriginInfiniteFutureClgMainView:buildUI()
	OriginInfiniteFutureClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._jumpBtns = {}
	self._jumpRedPoints = {}
	self._jumpBubbles = {}

	for i = 1, 5 do
		self._jumpBtns[i] = self:getGo("jumpBtnCol/btnJump" .. i)
		self._jumpRedPoints[i] = self:getGo("jumpBtnCol/btnJump" .. i .. "/redPoint")
		self._jumpBubbles[i] = goutil.findChild(self._jumpBtns[i], "bubble")
	end

	self._btnExtClg = self:getGo("btnExtClg")
	self._btnNorClg = self:getGo("btnNorClg")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._firstPass = self:getGo("btnNorClg/firstPass")
	self._btnRedPoint = self:getGo("btnNorClg/redPoint")
	self._txtTime = self:getTxt("btnNorClg/time/txtTime")
	self._reward = self:getGo("bubble/reward")
	self._geted = self:getGo("bubble/Passed")
	self._buffCol = self:getGo("buffCol")
end

function OriginInfiniteFutureClgMainView:onExit()
	OriginInfiniteFutureClgMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._role)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._reward)
end

function OriginInfiniteFutureClgMainView:onEnter()
	OriginInfiniteFutureClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgResetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginInfiniteFutureClgNotifyFightRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 619001
	end

	self._actCfg = OriginInfiniteFutureClgConfig.instance:getActivityCfg(self._activityId) or {}

	self:_onSetUI()
	OriginInfiniteFutureClgController.instance:sendPM_OriginInfiniteFutureClgGetInfoReq(self._activityId)
end

function OriginInfiniteFutureClgMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = checknumber(self._actCfg.skinId)
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtPetName.text = petData.name or ""
	end

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	MaterialMgr.setCellByCfg(self._actCfg.firstPassPrize, self._reward)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.firstPassPrize)

	GameUtil.SetActive(self._btnExtClg, false)
	GameUtil.SetActive(self._buffCol, false)
	GameUtil.SetActive(self._btnRedPoint, false)
end

function OriginInfiniteFutureClgMainView:_onUpdate()
	self._info = OriginInfiniteFutureClgModel.instance:getInfo(self._activityId) or {}

	local gainPrize = self._info.gainFirstPassPrize == true

	GameUtil.SetActive(self._firstPass, gainPrize)
	GameUtil.SetActive(self._geted, gainPrize)
end

function OriginInfiniteFutureClgMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKeyMain)
end

function OriginInfiniteFutureClgMainView:_onClickBtnSkill()
	local skinId = checknumber(self._actCfg.skinId)

	PetbookController.instance:previewBattle(skinId)
end

function OriginInfiniteFutureClgMainView:_onClickBtnIntroduce()
	local skinId = checknumber(self._actCfg.skinId)

	PetbookController.instance:openPetinfoView(skinId)
end

function OriginInfiniteFutureClgMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function OriginInfiniteFutureClgMainView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.OriginInfiniteFutureClgLevelView, self._activityId)
end

return OriginInfiniteFutureClgMainView
