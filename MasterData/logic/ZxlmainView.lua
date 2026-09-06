-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxlmainView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxlmainView", package.seeall)

local ZxlmainView = class("ZxlmainView", ViewComponent)

function ZxlmainView:ctor()
	ZxlmainView.super.ctor(self)
end

function ZxlmainView:unbindEvents()
	ZxlmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self.btnGo:RemoveClickListener()
end

function ZxlmainView:bindEvents()
	ZxlmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		local value = "orderlyDrago_rule"

		UIStateManager.instance:push(ViewName.RulesView, value)
	end, self)
	self._tryBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, self.petRaceId)
	end, self)
	self._shopBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.ZxldaywishView)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self.petRaceId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self.petRaceId)
	end, self)
	self._exchangeBtn:AddClickListener(function()
		GotoMgr.gotoByString("func#984")
	end, self)
	self.btnGo:AddClickListener(function()
		self:_clickChapter()
	end, self)
	self._btnPetVerify:AddClickListener(function()
		FuncOpenController.instance:openFunc(493, 115001, 2)
	end, self)
end

function ZxlmainView:buildUI()
	ZxlmainView.super.buildUI(self)

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
	self.btnGo = self:getBtn("btnGo")
	self._btnPetVerify = self:getBtn("btnPetVerify")
	self._petVerifyRed = self:getGo("btnPetVerify/redPoint")
end

function ZxlmainView:onExit()
	ZxlmainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)
	PetAwakenVerificationController.instance:unRegRedAboutPetAwken(self._petVerifyRed)
end

function ZxlmainView:onEnter()
	ZxlmainView.super.onEnter(self)

	self.activityType = ShikongshenglongController.instance:getActivityType()
	self.curActId = ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.ZxlChallenge)

	if self.curActId <= 0 then
		self:close()

		return
	end

	self.petRaceId = 16003

	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)
	ShikongshenglongController.instance:sendGetInfos(self.curActId)
	self:_showSpriteRawInfo()
	self:_showUIEff()

	local startStamp, endStamp = 0, 0

	if self.curActId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self.activityType, self.curActId)
	end

	if self._timerTxt then
		self._timerTxt.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	PetAwakenVerificationController.instance:regRedAboutPetAwken(self._petVerifyRed, "endlessdragonview")
end

function ZxlmainView:onRefreshUI(chapter)
	local isOver = ShikongshenglongModel.instance:isOverAll(self.curActId)

	goutil.findChild(self.btnGo.gameObject, "redpoint"):SetActive(not isOver)
end

function ZxlmainView:_clickChapter()
	UIStateManager.instance:push(ViewName.ZxldifficultyView)
end

function ZxlmainView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self.petRaceId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self.petRaceId, self._sprintGo, scale, nil, true, x, y)
end

function ZxlmainView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

return ZxlmainView
