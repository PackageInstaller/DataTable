-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoChallengeView.lua

module("logic.extensions.fuyao.view.FuYaoChallengeView", package.seeall)

local FuYaoChallengeView = class("FuYaoChallengeView", ViewComponent)

function FuYaoChallengeView:ctor()
	FuYaoChallengeView.super.ctor(self)
end

function FuYaoChallengeView:unbindEvents()
	FuYaoChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge_1)
	GameUtil.rmClickHandler(self._btnChallenge_2)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function FuYaoChallengeView:bindEvents()
	FuYaoChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge_1, self._onClickChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge_2, self._onClickChallenge2, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnLottery, GameUtil.handler(self._onClickBtnJump, self, "jump_give"))
	GameUtil.addClickHandler(self._btnShop, GameUtil.handler(self._onClickBtnJump, self, "jump_shop"))
	GameUtil.addClickHandler(self._btnRank, GameUtil.handler(self._onClickBtnJump, self, "jump_rank"))
end

function FuYaoChallengeView:buildUI()
	FuYaoChallengeView.super.buildUI(self)

	self._petCon = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnChallenge_1 = self:getBtn("btnChallenge_1")
	self._btnChallenge_2 = self:getBtn("btnChallenge_2")
	self._jumpBtnCol = self:getGo("jumpCol")
	self._btnLottery = self:getBtn("jumpCol/btnLottery")
	self._btnShop = self:getBtn("jumpCol/btnShop")
	self._btnRank = self:getBtn("jumpCol/btnRank")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")

	self:_recordGoDefaultActive(self._btnChallenge_1)
	self:_recordGoDefaultActive(self._jumpBtnCol)
end

function FuYaoChallengeView:onExit()
	FuYaoChallengeView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._loader)
	MaterialMgr.resetAll(self._rare)
end

function FuYaoChallengeView:onEnter()
	FuYaoChallengeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = FuYaoController.instance:getActivityId()
	end

	self._activityType = FuYaoController.instance:getActivityType()

	local isInTime = FuYaoController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	FuYaoModel.instance:setActivityId(self._activityId)

	self._challengeCfg = FuYaoConfig.instance:getFuyaoChallengeCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._btnChallenge_1, false)
		GameUtil.SetActive(self._jumpBtnCol, false)
	else
		self:_refreshDefaultActive(self._btnChallenge_1)
		self:_refreshDefaultActive(self._jumpBtnCol)
	end

	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local x, y, scale = 0, 0, 1

	self._raceId = self._challengeCfg.raceId
	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
	FuYaoController.instance:sendPM_FuyaoGetInfoReq(self._activityId)
end

function FuYaoChallengeView:_onClickTip()
	local key = self._challengeCfg.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function FuYaoChallengeView:_onClickChallenge1()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.FuYaoPuzzlesView)
end

function FuYaoChallengeView:_onClickChallenge2()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.FuYaoExtremeView, self._activityId)
end

function FuYaoChallengeView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	if self._challengeCfg then
		local jumpToStr = self._challengeCfg[key]

		GotoMgr.gotoByString(jumpToStr)
	end
end

function FuYaoChallengeView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function FuYaoChallengeView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

function FuYaoChallengeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function FuYaoChallengeView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return FuYaoChallengeView
