-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SkslmainView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SkslmainView", package.seeall)

local SkslmainView = class("SkslmainView", ViewComponent)

function SkslmainView:ctor()
	SkslmainView.super.ctor(self)
end

function SkslmainView:unbindEvents()
	SkslmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()

	for i = 1, 3 do
		self._btns[i]:RemoveClickListener()
	end

	if self._btnExchange then
		self._btnExchange:RemoveClickListener()
	end

	if self._btnShop then
		self._btnShop:RemoveClickListener()
	end

	if self._btnCall then
		self._btnCall:RemoveClickListener()
	end

	if self._btnRank then
		self._btnRank:RemoveClickListener()
	end
end

function SkslmainView:bindEvents()
	SkslmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		local ruleName = ShikongshenglongConfig.instance:getCommonValue("OPEN_RULE")

		UIStateManager.instance:push(ViewName.RulesView, ruleName)
	end, self)
	self._tryBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, self.petRaceId)
	end, self)
	self._shopBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(478)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self.petRaceId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self.petRaceId)
	end, self)
	self._exchangeBtn:AddClickListener(function()
		ActivityshopController.instance:openExchangeView(110, 110001)
	end, self)

	if self._btnExchange then
		self._btnExchange:AddClickListener(self._onClickExchange, self)
	end

	if self._btnShop then
		self._btnShop:AddClickListener(self._onClickShop, self)
	end

	if self._btnCall then
		self._btnCall:AddClickListener(self._onClickCall, self)
	end

	if self._btnRank then
		self._btnRank:AddClickListener(self._onClickRank, self)
	end

	for i = 1, 3 do
		self._btns[i]:AddClickListener(function()
			self:_clickChapter(i)
		end, self)
	end
end

function SkslmainView:buildUI()
	SkslmainView.super.buildUI(self)

	self._sprintGo = self:getGo("con")

	local sprintInfoGo = self:getGo("petInfo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "pointRare")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnSkill")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnIntroduce")
	self._shopBtn = self:getBtn("btnShop")
	self._tryBtn = self:getBtn("btnTry")
	self._exchangeBtn = self:getBtn("btnExchange")
	self._tipsBtn = self:getBtn("btnTip")
	self._closeBtn = self:getBtn("btnClose")
	self._timerTxt = self:getGo("time/txt"):GetComponent("Text")
	self._btnExchange = self:getBtn("jumpButton/btnExchange")
	self._btnShop = self:getBtn("jumpButton/btnShop")
	self._btnCall = self:getBtn("jumpButton/btnCall")
	self._btnRank = self:getBtn("jumpButton/btnRank")
	self._btns = {}
	self._items = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("btn_" .. tostring(i))

		local item = {}

		item.icon = self:getGo(string.format("btn_%d/item/icon", i))
		item.txt = self:getTxt(string.format("btn_%d/item/txt", i))

		table.insert(self._items, item)
	end

	self._exchangeRedpoint = self:getGo("jumpButton/btnExchange/redpoint")
	self._shopRedpoint = self:getGo("jumpButton/btnShop/redpoint")
	self._callRedpoint = self:getGo("jumpButton/btnCall/redpoint")
	self._rankRedpoint = self:getGo("jumpButton/btnRank/redpoint")
	self.curChapter = nil
end

function SkslmainView:onExit()
	SkslmainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)
end

function SkslmainView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SkslChallenge)
end

function SkslmainView:_getPetRaceId()
	return 15006
end

function SkslmainView:onEnter()
	SkslmainView.super.onEnter(self)

	self.curActId = self:_getActivityId()
	self.petRaceId = self:_getPetRaceId()

	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)
	ShikongshenglongController.instance:sendGetInfos(self.curActId)

	self._cfgActivity = ShikongshenglongConfig.instance:getActivityCfg(self.curActId)

	self:_showSpriteRawInfo()
	self:_showUIEff()

	local timeStr = ShikongshenglongConfig.instance:getCommonValue("ACT_TIME")

	self._timerTxt.text = TimeGateController.instance:getActTimeShow(self.curActId)

	self:updateRedPointState(self._exchangeRedpoint, "exchange")
	self:updateRedPointState(self._shopRedpoint, "shop")
	self:updateRedPointState(self._rankRedpoint, "rank")
	self:updateRedPointState(self._callRedpoint, "call")
end

function SkslmainView:_onClickExchange()
	if self._cfgActivity and self._cfgActivity.params and not string.nilorempty(self._cfgActivity.params.exchangeJump) then
		GotoMgr.gotoByString(self._cfgActivity.params.exchangeJump)
	else
		local actType = ActivityDefineController.instance:getActTypeByActId(self.curActId)

		ActivityshopController.instance:openExchangeView(actType, self.curActId)
	end

	self:_useRedPoint(self._exchangeRedpoint, "exchange")
end

function SkslmainView:_onClickShop()
	if self._cfgActivity then
		if self._cfgActivity.params and not string.nilorempty(self._cfgActivity.params.shenyaoJump) then
			GotoMgr.gotoByString(self._cfgActivity.params.shenyaoJump)
		elseif not string.nilorempty(self._cfgActivity.gotoMibao) then
			GotoMgr.gotoByString(self._cfgActivity.gotoMibao)
		end

		self:_useRedPoint(self._shopRedpoint, "shop")
	end
end

function SkslmainView:_onClickRank()
	if self._cfgActivity then
		if self._cfgActivity.params and not string.nilorempty(self._cfgActivity.params.rankJump) then
			GotoMgr.gotoByString(self._cfgActivity.params.rankJump)
		elseif not string.nilorempty(self._cfgActivity.gotoRank) then
			GotoMgr.gotoByString(self._cfgActivity.gotoRank)
		end

		self:_useRedPoint(self._rankRedpoint, "rank")
	end
end

function SkslmainView:_onClickCall()
	if self._cfgActivity then
		if self._cfgActivity.params and not string.nilorempty(self._cfgActivity.params.quanEJump) then
			GotoMgr.gotoByString(self._cfgActivity.params.quanEJump)
		else
			GotoMgr.gotoByString(self._cfgActivity.gotoCall)
		end

		self:_useRedPoint(self._callRedpoint, "call")
	end
end

function SkslmainView:onRefreshUI(chapter)
	if chapter ~= nil then
		self.curChapter = chapter
	end

	for i = 1, 3 do
		local obj = self._btns[i].gameObject

		goutil.findChild(obj, "lock"):SetActive(i > self.curChapter)
		goutil.findChild(obj, "redpoint"):SetActive((i <= self.curChapter or false) and ShikongshenglongModel.instance:isChapterRed(self.curActId, i))
	end
end

function SkslmainView:_clickChapter(chapter)
	if not self.curChapter then
		return
	end

	if chapter > self.curChapter then
		FloatWordMgr.instance:show("通关前置章节")

		return
	end

	UIStateManager.instance:push(self:_getDifficultyView(), chapter)
end

function SkslmainView:_getDifficultyView()
	return ViewName.SksldifficultyView
end

function SkslmainView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self.petRaceId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self.petRaceId, self._sprintGo, scale, nil, true, x, y)
end

function SkslmainView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SkslmainView:_useRedPoint(redPointGo, str)
	local key = string.format("skslmainview_%d_%s", self.curActId, str)
	local isMarked = GameUtil.getUserDayData(key)

	if not isMarked then
		GameUtil.saveUserDayData(key, true)
	end

	goutil.setActive(redPointGo, false)
end

function SkslmainView:updateRedPointState(redPointGo, str)
	local key = string.format("skslmainview_%d_%s", self.curActId, str)
	local isMarked = GameUtil.getUserDayData(key)

	goutil.setActive(redPointGo, not isMarked)
end

return SkslmainView
