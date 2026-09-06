-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgMainView.lua

module("logic.extensions.jiuclg.view.JiuClgMainView", package.seeall)

local JiuClgMainView = class("JiuClgMainView", ViewComponent)

function JiuClgMainView:buildUI()
	JiuClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._jumpCol = self:getGo("jumpCol")
	self._btnRank = self:getGo("jumpCol/btnRank")
	self._btnShop = self:getGo("jumpCol/btnShop")
	self._btnSummon = self:getGo("jumpCol/btnSummon")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
end

function JiuClgMainView:bindEvents()
	JiuClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRank, GameUtil.handler(self._onClickBtnJump, self, "jumpTo1"))
	GameUtil.addClickHandler(self._btnShop, GameUtil.handler(self._onClickBtnJump, self, "jumpTo2"))
	GameUtil.addClickHandler(self._btnSummon, GameUtil.handler(self._onClickBtnJump, self, "jumpTo3"))
end

function JiuClgMainView:unbindEvents()
	JiuClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function JiuClgMainView:onEnter()
	JiuClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = JiuClgController.instance:getActivityId()
	end

	self._activityType = JiuClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = JiuClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._cfgActivity = JiuClgConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	GameUtil.SetActive(self._jumpCol, not self._isAoqiGodProcessType)
	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	self.addGEvent(self, GlobalNotify.JiuClgGetInfoRes, self._onGetInfoRes, self)
	JiuClgAgent.instance:sendPM_JiuClgGetInfoReq(self._activityId)
end

function JiuClgMainView:onExit()
	JiuClgMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function JiuClgMainView:_onClickTip()
	local key = self._cfgActivity.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function JiuClgMainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = self._cfgActivity[key]

	GotoMgr.gotoByString(jumpToStr)
end

function JiuClgMainView:_onClickChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.JiuClgLevelView, self._activityId)
end

function JiuClgMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function JiuClgMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function JiuClgMainView:_onGetInfoRes()
	return
end

function JiuClgMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function JiuClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function JiuClgMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function JiuClgMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function JiuClgMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

return JiuClgMainView
