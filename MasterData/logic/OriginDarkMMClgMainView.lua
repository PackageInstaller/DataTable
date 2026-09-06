-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgMainView.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgMainView", package.seeall)

local OriginDarkMMClgMainView = class("OriginDarkMMClgMainView", ViewComponent)

function OriginDarkMMClgMainView:ctor()
	OriginDarkMMClgMainView.super.ctor(self)
end

function OriginDarkMMClgMainView:unbindEvents()
	OriginDarkMMClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPack)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function OriginDarkMMClgMainView:bindEvents()
	OriginDarkMMClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnPack, self._onClickPack, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function OriginDarkMMClgMainView:onExit()
	OriginDarkMMClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._giftItem)
	MaterialMgr.resetAll(self._role)
	RoleObjectPool.instance:removeRole(self._role)
end

function OriginDarkMMClgMainView:buildUI()
	OriginDarkMMClgMainView.super.buildUI(self)

	self._giftItem = self:getGo("bubble/item")
	self._petCon = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnBuy = self:getGo("jumpBtnCol/btnBuy")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnPack = self:getGo("jumpBtnCol/btnPack")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtBubble = self:getTxt("bubble/txt")
	self._txtDetail = self:getTxt("info/txtDetail")
	self._txtProgress = self:getTxt("info/txtProgress")
	self._txtBuffDesc = self:getTxt("info/desc/viewport/txtDesc")
	self._txtTime = self:getTxt("time/txt")
	self._collectProgress = self:getSlider("info/slider")
	self._goPass = self:getGo("btnChallenge/goPass")
end

function OriginDarkMMClgMainView:onEnter()
	OriginDarkMMClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDarkMMClgGetInfoRes, self._refreshView, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 603001
	end

	self._actCfg = OriginDarkMMClgConfig.instance:getActivity(self._activityId)
	self._raceId = self._actCfg.raceId

	OriginDarkMMClgController.instance:sendInfoReq(self._activityId)
	self:_refreshView()
end

function OriginDarkMMClgMainView:_refreshView()
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local raceId = self._actCfg.raceId
	local petData = CharacterConfig.instance:getPetCo(raceId)

	if petData then
		self._txtName.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._petCon, nil, nil, true, nil, nil)

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._rare)
	end

	local collectNum, collectionnRate = OriginDarkMMClgController.instance:petCollectionProgress(self._activityId)

	if self._txtBuffDesc then
		local buffCfg = OriginDarkMMClgConfig.instance:getBuff(self._activityId, collectNum)

		if buffCfg then
			self._txtBuffDesc.text = buffCfg.desc or lang("未激活加成")
		end
	end

	if self._txtDetail then
		self._txtDetail.text = self._actCfg.detailDesc
	end

	if self._txtProgress then
		self._txtProgress.text = langPara("集齐<color=#F78B7BFF>%d只</color>", collectNum)
	end

	self._collectProgress:SetValue(collectionnRate)

	local isAllPassed = OriginDarkMMClgController.instance:isAllStagePassed(self._activityId)

	GameUtil.SetActive(self._goPass, isAllPassed)
end

function OriginDarkMMClgMainView:_onClickTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginDarkMMClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function OriginDarkMMClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId)
end

function OriginDarkMMClgMainView:_onClickChallenge()
	if OriginDarkMMClgController.instance:isAllStagePassed(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("已完成所有关卡"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginDarkMMClgStageView, self._activityId)
end

function OriginDarkMMClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpToRank)
end

function OriginDarkMMClgMainView:_onClickBuy()
	GotoMgr.gotoByString(self._actCfg.jumpToPrize)
end

function OriginDarkMMClgMainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpToShop)
end

function OriginDarkMMClgMainView:_onClickPack()
	GotoMgr.gotoByString(self._actCfg.jumpToPack)
end

return OriginDarkMMClgMainView
