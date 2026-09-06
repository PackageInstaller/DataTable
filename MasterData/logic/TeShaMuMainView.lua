-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/TeShaMuMainView.lua

module("logic.extensions.teshamu.view.TeShaMuMainView", package.seeall)

local TeShaMuMainView = class("TeShaMuMainView", ViewComponent)

function TeShaMuMainView:ctor()
	TeShaMuMainView.super.ctor(self)
end

function TeShaMuMainView:unbindEvents()
	TeShaMuMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function TeShaMuMainView:bindEvents()
	TeShaMuMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickPetSkill, self)
end

function TeShaMuMainView:buildUI()
	TeShaMuMainView.super.buildUI(self)

	self._goldBarCon = self:getGo("goldBarCon")
	self._petcon = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnLottery = self:getBtn("btnLottery")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtTime = self:getTxt("time/txt")
	self._txtName = self:getTxt("petInfo/txtName")
end

function TeShaMuMainView:onExit()
	TeShaMuMainView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	RoleObjectPool.instance:removeRole(self._loder)
end

function TeShaMuMainView:onEnter()
	TeShaMuMainView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.TeshamuChallenge)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TeshamuChallenge, self._activityId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._challengeCfg = TeShaMuChallengeConfig.instance:getChallengeCfg(self._activityId)
	self._raceId = self._challengeCfg.raceId

	self:_petInfo()

	local objList = {
		{
			showAdd = false,
			id = self._challengeCfg.coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function TeShaMuMainView:_petInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	local x, y, scale = 0, 0, 1

	self._loder = RoleObjectPool.instance:addRoleToParent(self._loder, self._raceId, self._petcon, scale, nil, true, x, y)
end

function TeShaMuMainView:_onClickTip()
	TipsFacade.instance:openRulesView("teshumuchallenge_rule")
end

function TeShaMuMainView:_onClickRank()
	GotoMgr.gotoByString(self._challengeCfg.jump_rank)
end

function TeShaMuMainView:_onClickShop()
	GotoMgr.gotoByString(self._challengeCfg.jump_shop)
end

function TeShaMuMainView:_onClickLottery()
	GotoMgr.gotoByString(self._challengeCfg.jump_give)
end

function TeShaMuMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.TeShaMuChallengeView, self._activityId)
end

function TeShaMuMainView:_onClickPetInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function TeShaMuMainView:_onClickPetSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

return TeShaMuMainView
