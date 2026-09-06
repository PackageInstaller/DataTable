-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangmainView.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangmainView", package.seeall)

local OriginxingjiangmainView = class("OriginxingjiangmainView", ViewComponent)

function OriginxingjiangmainView:ctor()
	OriginxingjiangmainView.super.ctor(self)
end

function OriginxingjiangmainView:buildUI()
	OriginxingjiangmainView.super.buildUI(self)

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

	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._passGo = self:getGo("btnClg/pass")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
	self._showConGo = self:getGo("btnClg/bubble/showCon")
	self._gainGo = self:getGo("btnClg/bubble/pass")
end

function OriginxingjiangmainView:bindEvents()
	OriginxingjiangmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function OriginxingjiangmainView:unbindEvents()
	OriginxingjiangmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnClg)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginxingjiangmainView:onEnter()
	OriginxingjiangmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginXingjiangInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OrixingjiangConfig.instance:getActCfg(self._activityId)

	self:_updateStaticUI()
	OriginXingjiangAgent.instance:sendPM_OriginXingjiangInfoReq(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	MaterialMgr.setCellByCfg(self._actCfg.passAllStagePrize, self._showConGo)
end

function OriginxingjiangmainView:onExit()
	OriginxingjiangmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.resetAll(self._showConGo)
end

function OriginxingjiangmainView:_getRaceId()
	return self._actCfg.raceId
end

function OriginxingjiangmainView:_onClickBtnJump(idx)
	if self._actCfg.jumpList and self._actCfg.jumpList[idx] then
		GotoMgr.gotoByString(self._actCfg.jumpList[idx])
	end
end

function OriginxingjiangmainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.OriginxingjiangstageView, self._activityId)
end

function OriginxingjiangmainView:_onClickBtnTip()
	local challengeCfg = OrixingjiangController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginxingjiangmainView:_updateUI()
	self._info = OrixingjiangModel.instance:getInfo(self._activityId)

	local isPass = OrixingjiangModel.instance:isStagesPass(self._activityId)

	goutil.setActive(self._passGo, isPass)
	goutil.setActive(self._gainGo, self._info.hasGainPrize)
end

function OriginxingjiangmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function OriginxingjiangmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginXingjiangClg)
	end
end

function OriginxingjiangmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OriginxingjiangmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OriginxingjiangmainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return OriginxingjiangmainView
