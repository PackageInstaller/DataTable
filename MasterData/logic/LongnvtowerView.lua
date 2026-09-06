-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvtowerView.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvtowerView", package.seeall)

local LongnvtowerView = class("LongnvtowerView", ViewComponent)

function LongnvtowerView:ctor()
	LongnvtowerView.super.ctor(self)
end

function LongnvtowerView:buildUI()
	LongnvtowerView.super.buildUI(self)

	self._con = self:getGo("con")
	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.btnWater = self:getGo("btnWater")
	self.btnDark = self:getGo("btnDark")
	self.btnWaterPassed = self:getGo("btnWater/passed")
	self.btnDarkPassed = self:getGo("btnDark/passed")
	self.txtWaterPet = self:getTxt("waterPet/txt")
	self.txtDarkPet = self:getTxt("darkPet/txt")
	self.symbolNo = self:getGo("symbol/no")
	self.bubble = self:getGo("bubble")
	self.remaining = self:getGo("remaining")
	self.txtTime = self:getTxt("remaining/txt")
	self.btnAdd = self:getGo("remaining/btnAdd")
	self.tip = self:getGo("tip")
	self.btnBoss = self:getGo("btnBoss")
	self.txtTip = self:getGo("btnBoss/txtTip")
	self.waterState = self:getTxt("waterState")
	self.darkState = self:getTxt("darkState")
end

function LongnvtowerView:bindEvents()
	LongnvtowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickTip, self)
	GameUtil.addClickHandler(self.btnWater, self.onClickWater, self)
	GameUtil.addClickHandler(self.btnDark, self.onClickDard, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickAdd, self)
	GameUtil.addClickHandler(self.btnBoss, self.onClickBoss, self)
end

function LongnvtowerView:unbindEvents()
	LongnvtowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.addClickHandler(self.btnTip)
	GameUtil.addClickHandler(self.btnWater)
	GameUtil.addClickHandler(self.btnDark)
	GameUtil.addClickHandler(self.btnAdd)
	GameUtil.addClickHandler(self.btnBoss)
end

function LongnvtowerView:destroyUI()
	LongnvtowerView.super.destroyUI(self)
end

function LongnvtowerView:onEnter()
	LongnvtowerView.super.onEnter(self)

	self._challengeId = 16
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	self:loadSprite(self._challengeCfg.raceId)
	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvBuyTimesEnd, self.onBuyTimeEnd, self)
	LongnvController.instance:sendGetFightInfo()
	GameUtil.SetActive(self.tip, false)
	self:onRefreshUI()
end

function LongnvtowerView:onEnterFinished()
	LongnvtowerView.super.onEnterFinished(self)
end

function LongnvtowerView:onExit()
	LongnvtowerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvBuyTimesEnd, self.onBuyTimeEnd, self)
end

function LongnvtowerView:onExitFinished()
	LongnvtowerView.super.onExitFinished(self)
end

function LongnvtowerView:onRefreshUI()
	local isCanChallengeBoss = LongnvModel.instance.isCanChallengeBoss
	local todayChallengeTimes = LongnvModel.instance.todayChallengeTimes
	local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
	local total = checknumber(LongnvConfig.instance:getCommonValue("FREE_CHALLENGE_TIMES"))
	local left = total + todayChallengeBuyTimes - todayChallengeTimes

	self.txtTime.text = langPara("今天剩余挑战次数：<color=#20b376>%s</color>/%s", left, total)

	GameUtil.SetActive(self.btnWaterPassed, isCanChallengeBoss)
	GameUtil.SetActive(self.btnDarkPassed, isCanChallengeBoss)

	if isCanChallengeBoss then
		GameUtil.doCallbackWhenFirst("LongnvtowerView_20210818", function()
			GameUtil.SetActive(self.tip, true)
		end)
	end

	local num1 = LongnvModel.instance:getAlivePetCount(LongnvModel.TYPE_1)
	local num2 = LongnvModel.instance:getAlivePetCount(LongnvModel.TYPE_2)

	GameUtil.SetActive(self.symbolNo, num1 ~= num2)

	self.waterState.text = lang("未达成")
	self.darkState.text = lang("未达成")

	local typeCfg = LongnvConfig.instance:getTypeCfg(LongnvModel.TYPE_1) or {}
	local num = checknumber(typeCfg.minAlivePet)

	if num <= num1 then
		self.waterState.text = lang("已达成")
	end

	local typeCfg = LongnvConfig.instance:getTypeCfg(LongnvModel.TYPE_2) or {}
	local num = checknumber(typeCfg.minAlivePet)

	if num <= num2 then
		self.darkState.text = lang("已达成")
	end

	self.txtWaterPet.text = num1
	self.txtDarkPet.text = num2

	local isCanChallengeBoss = LongnvModel.instance.isCanChallengeBoss

	GameUtil.SetActive(self.txtTip, isCanChallengeBoss)
end

function LongnvtowerView:onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "longnvchallenge1")
end

function LongnvtowerView:loadSprite(skinId)
	local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
end

function LongnvtowerView:onClickAdd()
	LongnvController.instance:checkIfCanChallenge(function()
		TipsFacade.instance:openCommonTips(lang("今日还有免费次数，不需要购买！"))
	end)
end

function LongnvtowerView:onClickWater()
	self:goToDetailView(LongnvModel.TYPE_1)
end

function LongnvtowerView:onClickDard()
	self:goToDetailView(LongnvModel.TYPE_2)
end

function LongnvtowerView:onBuyTimeEnd()
	if self.curType ~= nil then
		if self.curType == LongnvModel.TYPE_3 then
			self:onClickBoss()
		else
			self:goToDetailView(self.curType)
		end

		self.curType = nil
	end
end

function LongnvtowerView:goToDetailView(type)
	local isCanChallengeBoss = LongnvModel.instance.isCanChallengeBoss

	if isCanChallengeBoss then
		TipsFacade.instance:openCommonTips(lang("已通关！你可以挑战龙女了"))
	else
		local todayChallengeTimes = LongnvModel.instance.todayChallengeTimes
		local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
		local total = checknumber(LongnvConfig.instance:getCommonValue("FREE_CHALLENGE_TIMES"))
		local left = total + todayChallengeBuyTimes - todayChallengeTimes

		if left > 0 then
			UIStateManager.instance:push(ViewName.LongnvdetailView, type)
		else
			self.curType = type

			self:onClickAdd()
		end
	end
end

function LongnvtowerView:onClickBoss()
	local isCanChallengeBoss = LongnvModel.instance.isCanChallengeBoss

	if isCanChallengeBoss then
		local todayChallengeTimes = LongnvModel.instance.todayChallengeTimes
		local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
		local total = checknumber(LongnvConfig.instance:getCommonValue("FREE_CHALLENGE_TIMES")) + todayChallengeBuyTimes
		local left = total - todayChallengeTimes

		if left > 0 then
			UIStateManager.instance:push(ViewName.LongnventerView)
		else
			self.curType = LongnvModel.TYPE_3

			self:onClickAdd()
		end
	else
		TipsFacade.instance:openCommonTips(lang(" 通过水之力和暗之力关卡，即可挑战龙女"))
	end
end

return LongnvtowerView
