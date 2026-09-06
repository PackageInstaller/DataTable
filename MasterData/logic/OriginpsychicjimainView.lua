-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjimainView.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjimainView", package.seeall)

local OriginpsychicjimainView = class("OriginpsychicjimainView", ViewComponent)

function OriginpsychicjimainView:buildUI()
	OriginpsychicjimainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/name/imgRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnInfo")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/name/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnGos = {}

	for i = 1, 5 do
		table.insert(self._jumpBtnGos, goutil.findChild(self.mainGO, "jumpBtnCol/btnJump" .. i))
	end

	self._btnClg1 = goutil.findChild(self.mainGO, "btnClg1")
	self._btnClg2 = goutil.findChild(self.mainGO, "btnClg2")
	self._passGo2 = self:getGo("btnClg2/passGo")
	self._passGo1 = self:getGo("btnClg1/passGo")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function OriginpsychicjimainView:bindEvents()
	OriginpsychicjimainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, "jumpStr" .. i))
	end

	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
end

function OriginpsychicjimainView:unbindEvents()
	OriginpsychicjimainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
end

function OriginpsychicjimainView:onEnter()
	OriginpsychicjimainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginPsychicJiInfoRes, self._updateUI, self)

	self._activityType = GameEnum.ActivityType.OriginPsychicJi
	self._activityId = self:_getActivityId()

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = OriginpsychicjiConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	OriginPsychicJiAgent.instance:sendPM_OriginPsychicJiInfoReq(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OriginpsychicjimainView:onExit()
	OriginpsychicjimainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginpsychicjimainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function OriginpsychicjimainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OriginpsychicjimainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function OriginpsychicjimainView:_getSkinId()
	return OriginpsychicjiConfig.instance:getSkinId(self._activityId)
end

function OriginpsychicjimainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginpsychicjimainView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.OriginpsychicjistageView, self._activityId, OriginpsychicjiController.ClgType.Normal)
end

function OriginpsychicjimainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.OriginpsychicjistageView, self._activityId, OriginpsychicjiController.ClgType.Extreme)
end

function OriginpsychicjimainView:_onClickBtnTip()
	local challengeCfg = OriginpsychicjiController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginpsychicjimainView:_updateUI()
	local info = OriginpsychicjiModel.instance:getInfo(self._activityId)
	local isPass1 = OriginpsychicjiModel.instance:isAllNormalStagePass(self._activityId)
	local isPass2 = info.hasPassExtStage

	goutil.setActive(self._passGo2, isPass2)
	goutil.setActive(self._passGo1, isPass1)
end

function OriginpsychicjimainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function OriginpsychicjimainView:_getActivityId()
	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	return activityId
end

function OriginpsychicjimainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return OriginpsychicjimainView
