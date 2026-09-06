-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyAddTipView.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyAddTipView", package.seeall)

local HolyStripeCopyAddTipView = class("HolyStripeCopyAddTipView", ViewComponent)

function HolyStripeCopyAddTipView:buildUI()
	HolyStripeCopyAddTipView.super.buildUI(self)

	self._txtAutoTimer = self:getTxt("Nego_middle/autoTimer/txt")
	self._markReady = self:getGo("Nego_middle/markReady")
	self._markReady = self:getGo("Nego_middle/markReady")
	self._markReady = self:getGo("Nego_middle/markReady")
	self._btnAutoReady = self:getGo("Nego_middle/btnAutoReady")
	self._txtMarkReady = goutil.findChildTextComponent(self._btnAutoReady, "mark/txt")
	self._txtAutoReady = self:getTxt("Nego_middle/txtAutoReady")
end

function HolyStripeCopyAddTipView:unbindEvents()
	HolyStripeCopyAddTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAutoReady)
end

function HolyStripeCopyAddTipView:bindEvents()
	HolyStripeCopyAddTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAutoReady, self._onClickAutoReady, self)
end

function HolyStripeCopyAddTipView:onEnter()
	HolyStripeCopyAddTipView.super.onEnter(self)

	self._curInfo = FormTeamModel.instance:getCurTeamInfo()

	if self._curInfo then
		self._teamCfg, self._typeCfg = self._curInfo:getTeamCfgAndTypeCfg()
		self._curGroupId = self._teamCfg.groupId
	else
		self._curGroupId = 1
	end

	self._autoTimer = checkint(HolyStripeCopyConfig.instance:getCommonValue("GROUP_COUNT_DOWN")) + 1

	self:_oncountdown()
	settimer(1, self._oncountdown, self)
	goutil.setActive(self._markReady, false)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeCopyTeamBattleReady, self._onReady, self)
	self:_setAutoReadyPart()
end

function HolyStripeCopyAddTipView:onExit()
	HolyStripeCopyAddTipView.super.onExit(self)
	removetimer(self._oncountdown, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeCopyTeamBattleReady, self._onReady, self)
	removetimer(self._onAutoReadyCountDown, self)

	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._curGroupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Not_Play_Before then
		FormTeamModel.instance:setTeamAutoReadyState(self._curGroupId, GameEnum.FormTeamAutoReadyState.Auto)
	end
end

function HolyStripeCopyAddTipView:_oncountdown()
	self._autoTimer = self._autoTimer - 1
	self._txtAutoTimer.text = GameUtil.FormatTimeWords(self._autoTimer, true)

	if self._autoTimer <= 0 then
		removetimer(self._oncountdown, self)
	end
end

function HolyStripeCopyAddTipView:_onReady()
	goutil.setActive(self._markReady, true)
	self:_setAutoReadyPart()
end

function HolyStripeCopyAddTipView:_setAutoReadyPart()
	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._curGroupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Auto then
		self:_setAutoReadyState(true)
	else
		self:_setAutoReadyState(false)
	end
end

function HolyStripeCopyAddTipView:_setAutoReadyState(isOn)
	removetimer(self._onAutoReadyCountDown, self)

	self._txtAutoReady.text = ""

	if isOn then
		if GameUtil.GetActive(self._markReady) then
			-- block empty
		else
			self._timerAutoReady = checkint(FormTeamConfig.instance:getCommonValue("AUTO_READY_TIME"))
			self._timerAutoReady = self._timerAutoReady + 1

			self:_onAutoReadyCountDown()
			settimer(1, self._onAutoReadyCountDown, self)
		end

		self._txtMarkReady.text = lang("开")
	else
		self._txtMarkReady.text = lang("关")
		self._timerAutoReady = 0
	end
end

function HolyStripeCopyAddTipView:_onClickAutoReady()
	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._curGroupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Not_Play_Before then
		FloatWordMgr.instance:show(langPara("需要挑战过1次组队模式才可以开启自动准备"))
	elseif autoState == GameEnum.FormTeamAutoReadyState.Auto then
		FormTeamModel.instance:setTeamAutoReadyState(self._curGroupId, GameEnum.FormTeamAutoReadyState.Not_Ready)
		FloatWordMgr.instance:show(langPara("自动准备已关闭"))
	elseif autoState == GameEnum.FormTeamAutoReadyState.Not_Ready then
		FormTeamModel.instance:setTeamAutoReadyState(self._curGroupId, GameEnum.FormTeamAutoReadyState.Auto)
		FloatWordMgr.instance:show(langPara("自动准备已开启"))
	end

	self:_setAutoReadyPart()
end

function HolyStripeCopyAddTipView:_onAutoReadyCountDown()
	self._timerAutoReady = self._timerAutoReady - 1

	if self._timerAutoReady > 0 then
		self._txtAutoReady.text = langPara("%s秒后自动准备", self._timerAutoReady)
	else
		self._txtAutoReady.text = ""

		removetimer(self._onAutoReadyCountDown, self)

		local fmtmo = HolyStripeCopyModel.instance:getTeamCustomFmtMo()

		if fmtmo:checkLimitAutoTeamReady() then
			-- block empty
		else
			fmtmo:sendFightMsg()
		end
	end
end

return HolyStripeCopyAddTipView
