-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/PassRuleView.lua

module("logic.extensions.mission.view.PassRuleView", package.seeall)

local PassRuleView = class("PassRuleView", FlyTweenBase)

function PassRuleView:buildUI()
	PassRuleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._mainBgRect = self:getGo("mainBg"):GetComponent(goutil.Type_RectTransform)
	self._ruleBaseRect = self:getGo("ruleBase"):GetComponent(goutil.Type_RectTransform)
	self._txtRuleDesc = self:getTxt("ruleBase/scrollList/Viewport/Content/txtRuleDesc")
	self._txtPerfectRuleDesc = self:getTxt("rulePerfect/scrollList/Viewport/Content/txtPerfectRuleDesc")
	self._rulePerfect = self:getGo("rulePerfect")
	self._togSelect = self:getToggle("togSelect")
	self._togSelectTrans = self:getGo("togSelect"):GetComponent(goutil.Type_RectTransform)
	self._togTxt = self:getTxt("togSelect/name")
	self._togLabel = self:getTxt("togSelect/name/Label")
	self._txtRuleTitle = self:getTxt("ruleBase/txtRuleTitle")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "mainBg/txtTitle")
end

function PassRuleView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PassRuleView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PassRuleView:onEnter()
	self._togSelect.gameObject:SetActive(false)

	self._txtRuleTitle.text = "基础通关规则"
	self._txtTitle.text = "通关规则"

	local params = self:getOpenParam()

	if params then
		local ruleDescTxt = params[1]
		local rulePerfectDescTxt = params[2]

		self._info = params[3]

		self:_setUIFlyTweenParam(params[4])

		local isShowToggle = false

		if self._info then
			if self._info.isShowToggle then
				isShowToggle = true
			end

			if self._info.ruleTitle then
				self._txtRuleTitle.text = self._info.ruleTitle
			end

			if self._info.challengeType == MissionConst.MissionLegend then
				isShowToggle = true
				self._txtRuleTitle.text = "特殊挑战规则"
			elseif self._info.challengeType == MissionConst.BreakFormation then
				self._txtRuleTitle.text = "特殊破阵规则"
			elseif self._info.challengeType == MissionConst.FamilyTeamplay then
				self._txtRuleTitle.text = "基础规则"
				self._txtTitle.text = "本关规则"
			end
		end

		if string.nilorempty(rulePerfectDescTxt) then
			self:_setBaseRule(ruleDescTxt, isShowToggle)
		else
			self:_setBaseAndPerfectRule(ruleDescTxt, rulePerfectDescTxt)
		end
	else
		self:_setBaseRule("", false)
	end
end

function PassRuleView:onExit()
	PassRuleView.super.onExit(self)
	self:_saveToggleState()
	self._togSelect.gameObject:SetActive(false)
end

function PassRuleView:_setComponent(isShowPerfect, bgHeight, ruleBasePosY)
	Framework.TransformUtil.SetAnchoredPos(self._mainBgRect, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._ruleBaseRect, -2.1, ruleBasePosY)

	local sizeDelta = self._mainBgRect.sizeDelta

	self._mainBgRect.sizeDelta = Vector2.New(sizeDelta.x, bgHeight)

	self._rulePerfect:SetActive(isShowPerfect)
end

function PassRuleView:_setBaseRule(baseDesc, isShowToggle)
	local bgHeight = isShowToggle and 350 or 310
	local ruleBasePosY = isShowToggle and -3.5 or -23.5

	self:_setToggle(isShowToggle, true)
	self:_setComponent(false, bgHeight, ruleBasePosY)

	self._txtRuleDesc.text = baseDesc
end

function PassRuleView:_setBaseAndPerfectRule(baseDesc, perfectDesc)
	self:_setComponent(true, 620, 124.3)

	self._txtRuleDesc.text = baseDesc
	self._txtPerfectRuleDesc.text = perfectDesc
end

function PassRuleView:_setToggle(isShow, isBase)
	self._togSelect.gameObject:SetActive(isShow and isBase)

	if isShow and isBase then
		if self._info then
			self._togSelect.isOn = GameUtil.getUserDayData(MissionConst.MissionLegend .. self._info.challengeId)
			self._togTxt.text = self._info.challengeName

			if not string.nilorempty(self._info.challengeTogDesc) then
				self._togLabel.text = self._info.challengeTogDesc
			end
		end

		Framework.TransformUtil.SetAnchoredPos(self._togSelectTrans, -87, -134)
	end
end

function PassRuleView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

function PassRuleView:_saveToggleState()
	if self._info then
		if self._info.challengeType == MissionConst.MissionLegend then
			GameUtil.saveUserDayData(MissionConst.MissionLegend .. self._info.challengeId, self._togSelect.isOn)
		elseif self._info.isShowToggle then
			GameUtil.saveUserDayData(MissionConst.MissionLegend .. self._info.challengeId, self._togSelect.isOn)
		end
	end
end

return PassRuleView
