-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasMainView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasMainView", package.seeall)

local DivineFarnasMainView = class("DivineFarnasMainView", ViewComponent)

function DivineFarnasMainView:ctor()
	DivineFarnasMainView.super.ctor(self)
end

function DivineFarnasMainView:unbindEvents()
	DivineFarnasMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnExtClg)
	GameUtil.rmClickHandler(self._btnNorClg)
end

function DivineFarnasMainView:bindEvents()
	DivineFarnasMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, 5))
	GameUtil.addClickHandler(self._btnExtClg, self._onClickBtnExt, self)
	GameUtil.addClickHandler(self._btnNorClg, self._onClickBtnNor, self)
end

function DivineFarnasMainView:buildUI()
	DivineFarnasMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
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
	self._firstPassExt = self:getGo("btnExtClg/firstPass")
	self._btnExtClg = self:getGo("btnExtClg/btn")
	self._btnNorClg = self:getGo("btnNorClg/btn")
	self._reward = self:getGo("btnExtClg/bubble/reward")
	self._txtReward = self:getTxt("btnExtClg/bubble/txtReward")
	self._passedExt = self:getGo("btnExtClg/bubble/Passed")
	self._redPointNor = self:getGo("btnNorClg/redPoint")
end

function DivineFarnasMainView:onExit()
	DivineFarnasMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._reward)
	RedPointController.instance:unregRedPoint(self._redPointNor)
end

function DivineFarnasMainView:onEnter()
	DivineFarnasMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineFarnasClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 522001
	end

	self._actCfg = DivineFarnasConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	DivineFarnasController.instance:sendPM_DivineFarnasClgGetInfoReq(self._activityId)
end

function DivineFarnasMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId
	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.extremePrize)
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtPetNameInInfo.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtReward.text = matName

	RedPointController.instance:regRedPoint(self._redPointNor, self._actCfg.redPointId)
	MaterialMgr.setCellByCfg(self._actCfg.extremePrize, self._reward)
end

function DivineFarnasMainView:_onUpdate()
	self._info = DivineFarnasModel.instance:getInfo(self._activityId)

	if self._info then
		if not self._info.extremePass then
			local extremePass = false

			GameUtil.SetActive(self._firstPassExt, extremePass)
			GameUtil.SetActive(self._passedExt, extremePass)
		end
	end
end

function DivineFarnasMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineFarnasMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function DivineFarnasMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DivineFarnasMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = string.format("jumpTo%d", jumpIdx)
	local btnStr = self._actCfg[jumpStr]

	GotoMgr.gotoByString(btnStr)
end

function DivineFarnasMainView:_onClickBtnNor()
	UIStateManager.instance:push(ViewName.DivineFarnasNorView, self._activityId)
end

function DivineFarnasMainView:_onClickBtnExt()
	UIStateManager.instance:push(ViewName.DivineFarnasExtView, self._activityId)
end

return DivineFarnasMainView
