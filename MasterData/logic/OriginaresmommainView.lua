-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmommainView.lua

module("logic.extensions.originaresmom.view.OriginaresmommainView", package.seeall)

local OriginaresmommainView = class("OriginaresmommainView", ViewComponent)

function OriginaresmommainView:buildUI()
	OriginaresmommainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump5 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump5")
	self._btnClg1 = goutil.findChild(self.mainGO, "btnClg1")
	self._btnClg2 = goutil.findChild(self.mainGO, "btnClg2")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._passGo1 = self:getGo("btnClg1/pass")
	self._passGo2 = self:getGo("btnClg2/pass")
	self._itemcellGo = self:getGo("btnClg2/bubble/itemcell")
	self._imgHasGainGo = self:getGo("btnClg2/bubble/imgHasGain")
end

function OriginaresmommainView:bindEvents()
	OriginaresmommainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStr5"))
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function OriginaresmommainView:unbindEvents()
	OriginaresmommainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump5)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function OriginaresmommainView:onEnter()
	OriginaresmommainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginAresMomClgInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OriginaresmomConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgInfoReq(self._activityId)
end

function OriginaresmommainView:onExit()
	OriginaresmommainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
end

function OriginaresmommainView:_getRaceId()
	return self._actCfg.raceId
end

function OriginaresmommainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginaresmommainView:_onClickBtnClg1()
	if OriginaresmomModel.instance:isAllNorStagePass(self._activityId) then
		FloatWordMgr.instance:show("已领取所有奖励")

		return
	end

	UIStateManager.instance:push(ViewName.OriginaresmomnorstageView, self._activityId)
end

function OriginaresmommainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.OriginaresmomextstageView, self._activityId)
end

function OriginaresmommainView:_onClickBtnTip()
	local challengeCfg = OriginaresmomController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginaresmommainView:_updateUI()
	self._info = OriginaresmomModel.instance:getInfo(self._activityId)

	local cfgs = OriginaresmomConfig.instance:getNorPrizeCfgs(self._activityId)
	local isNorPass = true

	for i, v in ipairs(cfgs) do
		if not table.indexof(self._info.normalGainedPrizeIds) then
			isNorPass = false

			break
		end
	end

	MaterialMgr.setCellByCfg(self._actCfg.extremePrize, self._itemcellGo)
	goutil.setActive(self._passGo1, isNorPass)
	goutil.setActive(self._imgHasGainGo, self._info.extremePassed)
	goutil.setActive(self._passGo2, self._info.extremePassed)
end

function OriginaresmommainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function OriginaresmommainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginaresMom)
	end
end

function OriginaresmommainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OriginaresmommainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

return OriginaresmommainView
