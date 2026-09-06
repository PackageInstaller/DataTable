-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitamainView.lua

module("logic.extensions.originweileita.view.OriginweileitamainView", package.seeall)

local OriginweileitamainView = class("OriginweileitamainView", ViewComponent)

function OriginweileitamainView:ctor()
	OriginweileitamainView.super.ctor(self)
end

function OriginweileitamainView:buildUI()
	OriginweileitamainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnGos = {}

	local jumpBtnCol = self:getGo("jumpBtnCol")

	for i = 1, jumpBtnCol.transform.childCount do
		local go = jumpBtnCol.transform:GetChild(i - 1).gameObject

		table.insert(self._jumpBtnGos, go)
	end

	self._btnClg1 = goutil.findChild(self.mainGO, "btnClg1")
	self._btnClg2 = goutil.findChild(self.mainGO, "btnClg2")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._passGo1 = self:getGo("btnClg1/pass")
	self._passGo2 = self:getGo("btnClg2/pass")
	self._itemcellGo = self:getGo("btnClg2/bubble/itemcell")
	self._imgHasGainGo = self:getGo("btnClg2/bubble/imgHasGain")
end

function OriginweileitamainView:bindEvents()
	OriginweileitamainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function OriginweileitamainView:unbindEvents()
	OriginweileitamainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function OriginweileitamainView:onEnter()
	OriginweileitamainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginWeiLeiTaGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OriginWeiLeiTaConfig.instance:getActCfg(self._activityId)

	self:_updateStaticUI()
	OriginWeiLeiTaAgent.instance:sendPM_OriginWeiLeiTaGetInfoReq(self._activityId)
end

function OriginweileitamainView:onExit()
	OriginweileitamainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
end

function OriginweileitamainView:_getRaceId()
	return self._actCfg.raceId
end

function OriginweileitamainView:_onClickBtnJump(idx)
	if self._actCfg.jumpList and self._actCfg.jumpList[idx] then
		GotoMgr.gotoByString(self._actCfg.jumpList[idx])
	end
end

function OriginweileitamainView:_onClickBtnClg1()
	if OriginWeiLeiTaModel.instance:isAllNorStagePass(self._activityId) then
		FloatWordMgr.instance:show("已领取所有奖励")

		return
	end

	UIStateManager.instance:push(ViewName.OriginweileitanorstageView, self._activityId)
end

function OriginweileitamainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.OriginweileitaextstageView, self._activityId)
end

function OriginweileitamainView:_onClickBtnTip()
	local challengeCfg = OriginWeiLeiTaController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginweileitamainView:_updateUI()
	self._info = OriginWeiLeiTaModel.instance:getInfo(self._activityId)

	local cfgs = OriginWeiLeiTaConfig.instance:getNorPrizeCfgs(self._activityId) or {}
	local isNorPass = true
	local normalGainedPrizeIds = OriginWeiLeiTaModel.instance:getNorPrizeIds(self._activityId)

	for i, v in ipairs(cfgs) do
		if not table.indexof(normalGainedPrizeIds, v.prizeId) then
			isNorPass = false

			break
		end
	end

	MaterialMgr.setCellByCfg(self._actCfg.extremePassPrize, self._itemcellGo)
	goutil.setActive(self._passGo1, isNorPass)
	goutil.setActive(self._imgHasGainGo, self._info.passExtreme)
	goutil.setActive(self._passGo2, self._info.passExtreme)
end

function OriginweileitamainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function OriginweileitamainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginWeiLeiTa)
	end
end

function OriginweileitamainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OriginweileitamainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

return OriginweileitamainView
