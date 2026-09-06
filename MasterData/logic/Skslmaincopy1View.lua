-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/copy/view/Skslmaincopy1View.lua

module("logic.extensions.copy.view.Skslmaincopy1View", package.seeall)

local Skslmaincopy1View = class("Skslmaincopy1View", ViewComponent)

function Skslmaincopy1View:unbindEvents()
	Skslmaincopy1View.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()

	for i = 1, 3 do
		self._btns[i]:RemoveClickListener()
	end

	self._btnExchange:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnShenyao:RemoveClickListener()
	self._btnQuane:RemoveClickListener()
end

function Skslmaincopy1View:bindEvents()
	Skslmaincopy1View.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		local ruleName = ShikongshenglongConfig.instance:getCommonValue("OPEN_RULE_LIMIT")

		UIStateManager.instance:push(ViewName.RulesView, ruleName)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self.petRaceId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self.petRaceId)
	end, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnShenyao:AddClickListener(self._onClickbtnShenyao, self)
	self._btnQuane:AddClickListener(self._onClickbtnQuane, self)

	for i = 1, 3 do
		self._btns[i]:AddClickListener(function()
			self:_clickChapter(i)
		end, self)
	end
end

function Skslmaincopy1View:buildUI()
	Skslmaincopy1View.super.buildUI(self)

	self._sprintGo = self:getGo("con")

	local sprintInfoGo = self:getGo("petInfo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "pointRare")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnSkill")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnIntroduce")
	self._tipsBtn = self:getBtn("btnTip")
	self._closeBtn = self:getBtn("btnClose")
	self._timerTxt = self:getGo("time/txt"):GetComponent("Text")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnRank = self:getBtn("btnRank")
	self._btnShenyao = self:getBtn("btnShenyao")
	self._btnQuane = self:getBtn("btnQuane")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btns = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("btn_" .. tostring(i))
	end

	self.curChapter = nil
end

function Skslmaincopy1View:onExit()
	Skslmaincopy1View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)
end

function Skslmaincopy1View:_getActivityId()
	return ShikongshenglongController.SYWDLYActivityId
end

function Skslmaincopy1View:_getPetRaceId()
	return self._cfgActivity.params.raceId
end

function Skslmaincopy1View:onEnter()
	Skslmaincopy1View.super.onEnter(self)

	self.curActId = self:_getActivityId()
	self._cfgActivity = ShikongshenglongConfig.instance:getActivityCfg(self.curActId)
	self.petRaceId = self:_getPetRaceId()

	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)
	ShikongshenglongController.instance:sendGetInfos(self.curActId)
	self:_showSpriteRawInfo()
	self:_showUIEff()
	self:_setPetName()

	self._timerTxt.text = TimeGateController.instance:getActTimeShow(self.curActId)
end

function Skslmaincopy1View:_onClickExchange()
	GotoMgr.gotoByString(self._cfgActivity.params.exchangeJump)
end

function Skslmaincopy1View:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.params.rankJump)
end

function Skslmaincopy1View:_onClickbtnShenyao()
	GotoMgr.gotoByString(self._cfgActivity.params.shenyaoJump)
end

function Skslmaincopy1View:_onClickbtnQuane()
	GotoMgr.gotoByString(self._cfgActivity.params.quanEJump)
end

function Skslmaincopy1View:onRefreshUI(chapter)
	if chapter ~= nil then
		self.curChapter = chapter
	end

	for i = 1, 3 do
		local obj = self._btns[i].gameObject

		goutil.findChild(obj, "lock"):SetActive(i > self.curChapter)
		goutil.findChild(obj, "redpoint"):SetActive((i <= self.curChapter or false) and ShikongshenglongModel.instance:isChapterRed(self.curActId, i))
	end
end

function Skslmaincopy1View:_clickChapter(chapter)
	if not self.curChapter then
		return
	end

	if chapter > self.curChapter then
		FloatWordMgr.instance:show("通关前置章节")

		return
	end

	UIStateManager.instance:push(self:_getDifficultyView(), chapter)
end

function Skslmaincopy1View:_getDifficultyView()
	return ViewName.Sksldifficultycopy1View
end

function Skslmaincopy1View:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self.petRaceId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self.petRaceId, self._sprintGo, scale, nil, true, x, y)
end

function Skslmaincopy1View:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function Skslmaincopy1View:_setPetName()
	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self.petRaceId)
end

return Skslmaincopy1View
