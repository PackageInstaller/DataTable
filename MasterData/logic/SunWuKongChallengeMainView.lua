-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeMainView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeMainView", package.seeall)

local SunWuKongChallengeMainView = class("SunWuKongChallengeMainView", ViewComponent)

function SunWuKongChallengeMainView:ctor()
	SunWuKongChallengeMainView.super.ctor(self)
end

function SunWuKongChallengeMainView:buildUI()
	SunWuKongChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnPrize = self:getBtn("btnPrize")
	self._btnCall = self:getBtn("btnCall")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
	self._txtPetName = self:getTxt("petInfo/name/txtName")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._redPointChallenge = self:getGo("btnChallenge/redpoint")
end

function SunWuKongChallengeMainView:bindEvents()
	SunWuKongChallengeMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function SunWuKongChallengeMainView:unbindEvents()
	SunWuKongChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function SunWuKongChallengeMainView:onEnter()
	SunWuKongChallengeMainView.super.onEnter(self)

	local actId = checknumber(self:getFirstParam())

	self._activityId = actId == 0 and SunWuKongChallengeModel.instance:getCurrActId() or actId
	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRareCon)

	self._txtPetName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._actCfg.raceId)

	if checknumber(self._actCfg.redPointId) ~= 0 then
		RedPointController.instance:regRedPoint(self._redPointChallenge, self._actCfg.redPointId, RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA, RedPointModel.ID_SUNWUKONGCHALLENGE_DAILY_OPEN)
	else
		GameUtil.SetActive(self._redPointChallenge, false)
	end

	self:_setTopGoldBar()
end

function SunWuKongChallengeMainView:onExit()
	SunWuKongChallengeMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)
	RedPointController.instance:unregRedPoint(self._redPointChallenge)
end

function SunWuKongChallengeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._actCfg.ruleKey)
end

function SunWuKongChallengeMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.SunWuKongChallengeGameView, self._activityId)
end

function SunWuKongChallengeMainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function SunWuKongChallengeMainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function SunWuKongChallengeMainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function SunWuKongChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[4])
end

function SunWuKongChallengeMainView:_onClickPetInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function SunWuKongChallengeMainView:_onClickSkill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

function SunWuKongChallengeMainView:_setTopGoldBar()
	local barShow = string.split(self._actCfg.goldBar1, "#")
	local btn_list = {}

	for i, v in ipairs(barShow) do
		local matType, matId, num = MaterialMgr.getMatParams(v)

		table.insert(btn_list, {
			showAdd = true,
			id = string.format("%d:%d", matType, matId)
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return SunWuKongChallengeMainView
