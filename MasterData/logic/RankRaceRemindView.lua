-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRemindView.lua

module("logic.extensions.rankrace.view.RankRaceRemindView", package.seeall)

local RankRaceRemindView = class("RankRaceRemindView", ViewComponent)

function RankRaceRemindView:ctor()
	RankRaceRemindView.super.ctor(self)
end

function RankRaceRemindView:buildUI()
	RankRaceRemindView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._img = self:getGo("btnClose/img")
	self._tabBk = {}
	self._tabLight = {}
	self._txtTab = {}

	for i = 1, 3 do
		self._tabBk[i] = self:getBtn("tabRight/tabBk_" .. i)
		self._tabLight[i] = self:getGo("tabRight/tabBk_" .. i .. "/tabLight")
		self._txtTab[i] = goutil.findChildTextComponent(self.mainGO, "tabRight/tabBk_" .. i .. "/txtTab")
	end

	self._tabRule = {}
	self._tabRule[1] = self:getGo("baseRule")
	self._txtBaseRule = self:getGo("baseRule/txtBaseRule"):GetComponent("Text")
	self._tabRule[2] = self:getGo("degreeGrade")

	local _curViewDatas = RankRaceController.instance:getTaskRewardConfig(RankRaceController.TaskTypeSeason, 0)

	self._imgGradeBk = {}
	self._txtGrade = {}

	for i = 1, 8 do
		self._imgGradeBk[i] = self:getGo("degreeGrade/imgGradeBk_" .. i)
		self._txtGrade[i] = self:getGo("degreeGrade/imgGradeBk_" .. i .. "/txtGrade"):GetComponent("Text")
		self._txtGrade[i].text = _curViewDatas[i].bigLevelName
	end

	self._tabRule[3] = self:getGo("degreeRule")
	self._txtDegreeRule = self:getGo("degreeRule/txtDegreeRule"):GetComponent("Text")
	self._txtRuleTitle = self:getGo("txtRuleTitle"):GetComponent("Text")
end

function RankRaceRemindView:_fillGradeBks()
	local _curViewDatas = RankRaceController.instance:getTaskRewardConfig(RankRaceController.TaskTypeSeason, 0)

	for i = 1, #self._imgGradeBk do
		uGuiUtil.setSpriteToImage(self._imgGradeBk[i], uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _curViewDatas[i].bigLevel))
	end
end

function RankRaceRemindView:_clearBigbg()
	if not self._imgGradeBk then
		return
	end

	for i = 1, 8 do
		local bigImg = Framework.ImageBigBG.Get(self._imgGradeBk[i])

		if bigImg then
			bigImg:ClearImage()
		end
	end
end

function RankRaceRemindView:bindEvents()
	RankRaceRemindView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)

	for i = 1, 3 do
		self._tabBk[i]:AddClickListener(function()
			self:_onClickTabBk(i)
		end, self)
	end
end

function RankRaceRemindView:unbindEvents()
	RankRaceRemindView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 3 do
		self._tabBk[i]:RemoveClickListener()
	end
end

function RankRaceRemindView:destroyUI()
	RankRaceRemindView.super.destroyUI(self)
	self:_clearBigbg()
end

function RankRaceRemindView:onEnter()
	RankRaceRemindView.super.onEnter(self)
	self:_fillGradeBks()

	self._curIndex = 1

	self:_onClickTabBk(self._curIndex, true)
end

function RankRaceRemindView:onEnterFinished()
	RankRaceRemindView.super.onEnterFinished(self)
end

function RankRaceRemindView:onExit()
	RankRaceRemindView.super.onExit(self)
end

function RankRaceRemindView:onExitFinished()
	RankRaceRemindView.super.onExitFinished(self)
	self:_clearBigbg()
end

function RankRaceRemindView:_onClickBtnClose()
	self:close()
end

function RankRaceRemindView:_onClickTabBk(index, force)
	if force then
		for i = 1, 3 do
			self._tabLight[i].gameObject:SetActive(false)
			self._tabRule[i].gameObject:SetActive(false)
			Game.TextUtil.SetColorRGBA(self._txtTab[i], 0.14901960784313725, 0.2823529411764706, 0.40784313725490196, 1)
		end
	else
		self._tabRule[self._curIndex].gameObject:SetActive(false)
		self._tabLight[self._curIndex].gameObject:SetActive(false)
		Game.TextUtil.SetColorRGBA(self._txtTab[self._curIndex], 0.14901960784313725, 0.2823529411764706, 0.40784313725490196, 1)
	end

	self._curIndex = index

	self._tabRule[self._curIndex].gameObject:SetActive(true)
	self._tabLight[self._curIndex].gameObject:SetActive(true)
	Game.TextUtil.SetColorRGBA(self._txtTab[self._curIndex], 1, 1, 1, 1)

	if self._curIndex == 1 then
		self._txtRuleTitle.gameObject:SetActive(true)

		self._txtRuleTitle.text = RulesConfig.instance:getRuleCo("rankracebaserule").title
		self._txtBaseRule.text = RulesConfig.instance:getRuleCo("rankracebaserule").rules
	elseif self._curIndex == 3 then
		self._txtRuleTitle.gameObject:SetActive(true)

		self._txtRuleTitle.text = RulesConfig.instance:getRuleCo("rankracegraderule").title
		self._txtDegreeRule.text = RulesConfig.instance:getRuleCo("rankracegraderule").rules
	else
		self._txtRuleTitle.gameObject:SetActive(false)
	end
end

return RankRaceRemindView
