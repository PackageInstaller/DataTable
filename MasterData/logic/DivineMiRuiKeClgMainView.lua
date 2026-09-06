-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgMainView.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgMainView", package.seeall)

local DivineMiRuiKeClgMainView = class("DivineMiRuiKeClgMainView", ViewComponent)

function DivineMiRuiKeClgMainView:buildUI()
	DivineMiRuiKeClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
end

function DivineMiRuiKeClgMainView:bindEvents()
	DivineMiRuiKeClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickSummon, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function DivineMiRuiKeClgMainView:unbindEvents()
	DivineMiRuiKeClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DivineMiRuiKeClgMainView:onEnter()
	DivineMiRuiKeClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineMiRuiKeClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = DivineMiRuiKeClgModel.instance:getActivityId()

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineMiRuiKe, self._activityId)

	printInfo("test DivineMiRuiKeClgMainView:onEnter", self._activityId, startTime, endTime, ServerTime.now())

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = DivineMiRuiKeClgConfig.instance:getActivityCfg(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_showRoleModel()
	self:_initPetInfo()
	DivineMiRuiKeClgAgent.instance:sendPM_DivineMiRuiKeClgGetInfoReq(self._activityId)
end

function DivineMiRuiKeClgMainView:onExit()
	DivineMiRuiKeClgMainView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function DivineMiRuiKeClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divinemiruikeclgmainview_rule")
end

function DivineMiRuiKeClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function DivineMiRuiKeClgMainView:_onClickShop()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function DivineMiRuiKeClgMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function DivineMiRuiKeClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DivineMiRuiKeClgLevelView, self._activityId)
end

function DivineMiRuiKeClgMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DivineMiRuiKeClgMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DivineMiRuiKeClgMainView:_onGetInfoRes()
	return
end

function DivineMiRuiKeClgMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	local function onLoadFinish(go)
		local bgTrans = go.transform:GetChild(0)

		goutil.setActive(bgTrans.gameObject, false)
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, onLoadFinish, true, x, y)
end

function DivineMiRuiKeClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineMiRuiKeClgMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivineMiRuiKeClgMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function DivineMiRuiKeClgMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

return DivineMiRuiKeClgMainView
