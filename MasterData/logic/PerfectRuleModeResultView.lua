-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModeResultView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModeResultView", package.seeall)

local PerfectRuleModeResultView = class("PerfectRuleModeResultView", TLCBattleResultView)

function PerfectRuleModeResultView:unbindEvents()
	PerfectRuleModeResultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnReGame:RemoveClickListener()
end

function PerfectRuleModeResultView:bindEvents()
	PerfectRuleModeResultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnReGame:AddClickListener(self._onClickReGame, self)
end

function PerfectRuleModeResultView:onExit()
	PerfectRuleModeResultView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._onInfoUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeError, self._onError, self)
end

function PerfectRuleModeResultView:buildUI()
	self._txtTitle = self:getTxt("txtTitle")
	self._btnOk = self:getBtn("btnGroup/btnOk")
	self._btnCancel = self:getBtn("btnGroup/btnCancel")
	self._btnReGame = self:getBtn("btnGroup/btnReGame")
	self._txtOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._txtCancel = goutil.findChildTextComponent(self._btnCancel.gameObject, "Text")
	self._txtWin = self:getTxt("win/Text")
	self._winTrue = self:getGo("win/true")
	self._winFalse = self:getGo("win/false")
	self._txtPerfect = self:getTxt("perfectWin/Text")
	self._perfectTrue = self:getGo("perfectWin/true")
	self._perfectFalse = self:getGo("perfectWin/false")
	self._failure = self:getGo("failure")
	self._txtTips = self:getTxt("txtTips")
	self._rewards = self:getGo("rewards")
	self._itemsView = self:getGo("rewards/itemsView/Viewport/Content").transform
	self._itemsLayout = self:getGo("rewards/itemsView/Viewport/Content/items"):GetComponent(typeof(UILayoutMulLines))
end

function PerfectRuleModeResultView:onEnter()
	self._cells = {}

	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._onInfoUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeError, self._onError, self)

	self._challengeId = checkint(self:getFirstParam())
	self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if self._challengeId > 0 and self._curInfo and self._curInfo.curRuleId > 0 then
		self:refreshView()
	else
		self:_closeResultView()
	end
end

function PerfectRuleModeResultView:refreshView()
	self._isWin = self._curInfo.isWin
	self._isPerfectWin = self._curInfo.isPerfectWin

	self._failure:SetActive(not self._isWin)
	self._rewards:SetActive(self._isWin)
	self._winTrue:SetActive(self._isWin)
	self._winFalse:SetActive(not self._isWin)
	self._perfectTrue:SetActive(self._isPerfectWin)
	self._perfectFalse:SetActive(not self._isPerfectWin)

	local ruleId = self._curInfo.curRuleId
	local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, ruleId)
	local modeId = self._curInfo.curModeId
	local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(self._challengeId, modeId)

	self._txtPerfect.text = ruleCfg.missionDesc
	self._txtTips.text = ""

	self._btnCancel.gameObject:SetActive(false)
	self._btnOk.gameObject:SetActive(false)
	self._btnReGame.gameObject:SetActive(false)

	if not self._isWin then
		self._txtTitle.text = lang("战斗失败")

		self._btnCancel.gameObject:SetActive(true)
	else
		self._txtTitle.text = lang("战斗胜利")

		self._btnOk.gameObject:SetActive(true)

		local itemStr = ""
		local items = {}

		if self._isPerfectWin then
			itemStr = modeCfg.perfectPassPrize
		else
			self._txtTips.text = "未达到完美通关可重新挑战不消耗次数"

			self._btnReGame.gameObject:SetActive(true)

			itemStr = modeCfg.normalPassPrize
		end

		for _, v in ipairs(string.split(itemStr, "#")) do
			local array = string.splitToNumber(v, ":")
			local data = {}

			data.type = array[1]
			data.id = array[2]
			data.num = array[3]

			table.insert(items, data)
		end

		self:_updateRewards(items)
	end
end

function PerfectRuleModeResultView:_onClickOk()
	if self._isWin and not self._isPerfectWin then
		PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightConfirmResultReq(self._challengeId)
	else
		self:_closeResultView()
	end
end

function PerfectRuleModeResultView:_onClickCancel()
	self:_closeResultView()
end

function PerfectRuleModeResultView:_onClickReGame()
	self:_closeResultView()
end

function PerfectRuleModeResultView:_closeResultView()
	self:close()
	PerfectRuleModeModel.instance:showCI(self._challengeId)
	BattleController.instance:endBattle()
end

function PerfectRuleModeResultView:_onInfoUpdate()
	if self._challengeId > 0 and self._curInfo then
		if checkint(self._curInfo.curRuleId) <= 0 then
			self:_closeResultView()
		end
	else
		self:_closeResultView()
	end
end

function PerfectRuleModeResultView:_onError(status)
	self:_closeResultView()
end

return PerfectRuleModeResultView
