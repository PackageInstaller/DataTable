-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/HolyDarkMMMainView.lua

module("logic.extensions.holydarkmm.view.HolyDarkMMMainView", package.seeall)

local HolyDarkMMMainView = class("HolyDarkMMMainView", ViewComponent)

function HolyDarkMMMainView:unbindEvents()
	HolyDarkMMMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnGift)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function HolyDarkMMMainView:bindEvents()
	HolyDarkMMMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function HolyDarkMMMainView:buildUI()
	HolyDarkMMMainView.super.buildUI(self)

	self._goldbarCon = self:getGo("goldBarCon")
	self._giftItem = self:getGo("bubble/item")
	self._petCon = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnGift = self:getGo("btnGift")
	self._btnExchange = self:getGo("btnExchange")
	self._btnRank = self:getGo("btnRank")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtBubble = self:getTxt("bubble/txt")
	self._txtDetail = self:getTxt("info/txtDetail")
	self._txtProgress = self:getTxt("info/txtProgress")
	self._txtBuffDesc = self:getTxt("info/txtDesc")
	self._txtTime = self:getTxt("time/txt")
	self._collectProgress = self:getSlider("info/slider")
end

function HolyDarkMMMainView:onExit()
	HolyDarkMMMainView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._giftItem)
	RoleObjectPool.instance:removeRole(self._loader)
end

function HolyDarkMMMainView:onEnter()
	HolyDarkMMMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 284001
	end

	self._actCfg = HolyDarkMMConfig.instance:getHolyDarkMMActCfg(self._activityId)
	self._raceId = self._actCfg.raceId

	self.addGEvent(self, GlobalNotify.HolyDarkMMChallengeInfoRes, self._initUI, self)
	HolyDarkMMController.instance:sendPM_HolyDarkMMChallengeInfoReq(self._activityId)
	self:_initUI()
	self:_petInfoShow()
end

function HolyDarkMMMainView:_initUI()
	GameUtil.SetActive(self._tip, false)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.HolyDarkMM, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
	self._txtBubble.text = self._actCfg.giftDesc

	MaterialMgr.setCellByCfg(self._actCfg.giftItem, self._giftItem)

	local collectNum, collectionnRate = HolyDarkMMController.instance:petCollectionProgress(self._activityId)

	if self._txtBuffDesc then
		local buffCfg = HolyDarkMMConfig.instance:getHolyDarkMMBuffCfg(self._activityId, collectNum)

		if buffCfg then
			self._txtBuffDesc.text = buffCfg.desc or ""
		end
	end

	if self._txtDetail then
		self._txtDetail.text = self._actCfg.detailDesc
	end

	if self._txtProgress then
		self._txtProgress.text = string.format("集齐<color=#F78B7BFF>%d只</color>", collectNum)
	end

	self._collectProgress:SetValue(collectionnRate)

	local objList = {
		{
			showAdd = false,
			id = self._actCfg.money
		}
	}

	MainUIController.instance:showGlodBar(self._goldbarCon, self._viewPresentor, objList)
end

function HolyDarkMMMainView:_petInfoShow()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, self._raceId)

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)
end

function HolyDarkMMMainView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tip, false)
	end
end

function HolyDarkMMMainView:_onClickTip()
	TipsFacade.instance:openRulesView("holydarkmm_rule")
end

function HolyDarkMMMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function HolyDarkMMMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

function HolyDarkMMMainView:_onClickGift()
	GotoMgr.gotoByString(self._actCfg.jump_gift)
end

function HolyDarkMMMainView:_onClickExchange()
	GotoMgr.gotoByString(self._actCfg.jump_give)
end

function HolyDarkMMMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jump_rank)
end

function HolyDarkMMMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.HolyDarkMMChallengeView, self._activityId)
end

return HolyDarkMMMainView
