-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhenglimainView.lua

module("logic.extensions.chuangzhengli.view.ChuangzhenglimainView", package.seeall)

local ChuangzhenglimainView = class("ChuangzhenglimainView", ViewComponent)

function ChuangzhenglimainView:buildUI()
	ChuangzhenglimainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
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
	self._jumpBtnCol_btnJump4_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._buffRoot = self:getGo("buffRoot")
end

function ChuangzhenglimainView:bindEvents()
	ChuangzhenglimainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function ChuangzhenglimainView:unbindEvents()
	ChuangzhenglimainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function ChuangzhenglimainView:onEnter()
	ChuangzhenglimainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ChuangZhengliClgGetInfoRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 398001
	end

	self._activityType = ChuangzhengliController.instance:getActivityType()

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = ChuangzhengliConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	ChuangZhengliClgAgent.instance:sendPM_ChuangZhengliClgGetInfoReq(self._activityId)
end

function ChuangzhenglimainView:onExit()
	ChuangzhenglimainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function ChuangzhenglimainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function ChuangzhenglimainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function ChuangzhenglimainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function ChuangzhenglimainView:_getSkinId()
	return ChuangzhengliConfig.instance:getSkinId(self._activityId)
end

function ChuangzhenglimainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function ChuangzhenglimainView:_onClickBtnClg()
	local info = ChuangzhengliModel.instance:getInfo(self._activityId)
	local cfgs = ChuangzhengliConfig.instance:getStageCfgs(self._activityId)

	if info.passStageId >= #cfgs then
		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	UIStateManager.instance:push(ViewName.ChuangzhengliclgView, self._activityId)
end

function ChuangzhenglimainView:_onClickBtnTip()
	local challengeCfg = ChuangzhengliController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function ChuangzhenglimainView:_updateUI()
	self._info = ChuangzhengliModel.instance:getInfo(self._activityId)
end

function ChuangzhenglimainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function ChuangzhenglimainView:_getSkinId()
	return ChuangzhengliConfig.instance:getSkinId(self._activityId)
end

return ChuangzhenglimainView
