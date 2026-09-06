-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/view/DivinedisorderdragonmainView.lua

module("logic.extensions.divinedisorderdragon.view.DivinedisorderdragonmainView", package.seeall)

local DivinedisorderdragonmainView = class("DivinedisorderdragonmainView", ViewComponent)

function DivinedisorderdragonmainView:ctor()
	DivinedisorderdragonmainView.super.ctor(self)
end

function DivinedisorderdragonmainView:unbindEvents()
	DivinedisorderdragonmainView.super.unbindEvents(self)
end

function DivinedisorderdragonmainView:bindEvents()
	DivinedisorderdragonmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSKill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function DivinedisorderdragonmainView:buildUI()
	DivinedisorderdragonmainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._time = self:getGo("time")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._txtTime = self:getTxt("time/txtTime")
	self._petRace = self:getGo("petInfo/pointRare")
	self._petCon = self:getGo("petCon")
end

function DivinedisorderdragonmainView:onExit()
	DivinedisorderdragonmainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRace)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function DivinedisorderdragonmainView:onEnter()
	DivinedisorderdragonmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = DivinedisorderdragonController.instance:getActivityId()
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = DivinedisorderdragonConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRace)
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRace)

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtPetName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petCon)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_initAoqiGodUI()
	DivineDisorderDragonAgent.instance:sendPM_DivineDisorderDragonGetInfoReq(self._activityId)
end

function DivinedisorderdragonmainView:_initAoqiGodUI()
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
end

function DivinedisorderdragonmainView:_onClickChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineDisorderDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local cfgs = DivinedisorderdragonConfig.instance:getStageCfgs(self._activityId)

	if DivinedisorderdragonModel.instance:getPassStage(self._activityId) >= #cfgs then
		FloatWordMgr.instance:show(lang("已通过全部关卡"))
	else
		UIStateManager.instance:push(ViewName.DivinedisorderdragonlevelView, self._activityId)
	end
end

function DivinedisorderdragonmainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function DivinedisorderdragonmainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function DivinedisorderdragonmainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function DivinedisorderdragonmainView:_onClickSKill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

function DivinedisorderdragonmainView:_onClickInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function DivinedisorderdragonmainView:_onClickRule()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(199)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

return DivinedisorderdragonmainView
