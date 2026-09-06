-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModeRuleView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModeRuleView", package.seeall)

local PerfectRuleModeRuleView = class("PerfectRuleModeRuleView", ViewComponent)

function PerfectRuleModeRuleView:unbindEvents()
	PerfectRuleModeRuleView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function PerfectRuleModeRuleView:bindEvents()
	PerfectRuleModeRuleView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
	self._btnCancle:AddClickListener(self._onClickBtnCancle, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
end

function PerfectRuleModeRuleView:onExit()
	PerfectRuleModeRuleView.super.onExit(self)

	for _, eff in ipairs(self._eff) do
		UIEffectManager.instance:stopEffect(eff)
	end

	MaterialMgr.clearIcon(self._iconRewards)
	MaterialMgr.clearIcon(self._iconRewardsPerfect)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeDailyRresh, self._refreshViewDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshRule, self)
end

function PerfectRuleModeRuleView:buildUI()
	PerfectRuleModeRuleView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnRule = self:getBtn("btnRule")
	self._btnCancle = self:getBtn("btnCancle")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("modeDesc/btnSure")
	self._ruleDesc1 = self:getTxt("rule/rule1/txtDesc")
	self._ruleDesc2 = self:getTxt("rule/rule2/txtDesc")
	self._modeIcon = self:getGo("modeDesc/modeIcon"):GetComponent("UIImageSpriteChange")
	self._txtMode = self:getTxt("modeDesc/txtMode")
	self._zdlTxt = self:getGo("modeDesc/zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
	self._iconRewards = self:getGo("modeDesc/rewards/icon")
	self._txtRewards = self:getTxt("modeDesc/rewards/txt")
	self._iconRewardsPerfect = self:getGo("modeDesc/rewardsPerfect/icon")
	self._txtRewardsPerfect = self:getTxt("modeDesc/rewardsPerfect/txt")
	self._challengeId = 0
end

function PerfectRuleModeRuleView:onEnter()
	PerfectRuleModeRuleView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeDailyRresh, self._refreshViewDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshRule, self)

	self._eff = {}
	self._challengeId = checkint(self:getFirstParam())

	if self._challengeId > 0 then
		self:_refreshViewDaily()
		self:_refreshView()
	else
		printError("当前挑战ID没有传参")
	end
end

function PerfectRuleModeRuleView:_onClickBtnRule()
	local curCommondCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	if curCommondCfg then
		local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curCommondCfg.reRandomCost)
		local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
		local content = langPara("你确定花费<color=#ebad32>%s</color>%s重抽特殊规则吗？重抽不会改变难度，但必定抽到与当前不一样的规则。", curCostNum, curIcon)

		TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
			PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightReChooseRuleReq(self._challengeId)
		end)
	end
end

function PerfectRuleModeRuleView:_onClickBtnCancle()
	local content = langPara("确定放弃当前挑战？\n放弃将扣除1次挑战次数！")

	TipsFacade.instance:openTipWindow(lang("提示"), content, function()
		PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGiveUpReq(self._challengeId)
	end)
end

function PerfectRuleModeRuleView:_onClickBtnSure()
	UIStateManager.instance:push(ViewName.PerfectRuleModeMissionView, self._challengeId)
	self:_onClickClose()
end

function PerfectRuleModeRuleView:_onClickBtnTip()
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	UIStateManager.instance:push(self._commonCfg.ruleshowview, self._challengeId)
end

function PerfectRuleModeRuleView:_refreshViewDaily()
	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if curInfo and checkint(curInfo.curRuleId) > 0 then
		-- block empty
	else
		FloatWordMgr.instance:show(lang("挑战已刷新"))
		self:close()
	end
end

function PerfectRuleModeRuleView:_refreshRule()
	if self._challengeId > 0 then
		local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

		if curInfo and checkint(curInfo.curRuleId) > 0 then
			local path = "fx_ui_anheitiaozhan/prefabs/fx_ui_tiaozhan_anheimengmeng_tanchuang.prefab"

			for i = 1, 2 do
				if self._eff[i] then
					UIEffectManager.instance:stopEffect(self._eff[i])
				end

				local parent = self:getGo("rule/rule" .. i .. "/eff")

				self._eff[i] = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, false)

				self._eff[i]:setParent(parent.transform)
				self._eff[i]:setLocalPos(0, 0, 0)
				self._eff[i]:setScale(1)
				self._eff[i]:setLocalEulerAngle(0, 0, 0)

				self._eff[i].hideEffWhileNotOnTop = false
			end

			self:_refreshView()

			return true
		else
			self:_onClickClose()
		end
	else
		self:_onClickClose()
	end
end

function PerfectRuleModeRuleView:_refreshView()
	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if curInfo then
		local modeId = checkint(curInfo.curModeId)
		local ruleId = checkint(curInfo.curRuleId)

		if modeId > 0 and ruleId > 0 then
			self._modeIcon:SetState(modeId % 10 - 1)
			self._zdlTxt:SetText(PerfectRuleModeModel.instance:getShowZDLByModeId(self._challengeId, modeId))

			local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(self._challengeId, modeId)

			self._txtMode.text = langPara("%s难度", modeCfg.desc)

			MaterialMgr.clearIcon(self._iconRewards)
			MaterialMgr.clearIcon(self._iconRewardsPerfect)

			local matstr = modeCfg.normalPassPrize
			local matType, matId, matNum = MaterialMgr.getMatParams(matstr)

			self._txtRewards.text = matNum <= 1 and "" or "x" .. matNum

			MaterialMgr.updateItemByStr(self._iconRewards, matstr)

			matstr = modeCfg.perfectPassPrize
			matType, matId, matNum = MaterialMgr.getMatParams(modeCfg.perfectPassPrize)
			self._txtRewardsPerfect.text = matNum <= 1 and "" or "x" .. matNum

			MaterialMgr.updateItemByStr(self._iconRewardsPerfect, matstr)

			local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, ruleId)

			self._ruleDesc1.text = ruleCfg.buffDes
			self._ruleDesc2.text = langPara("普通通关：击败敌阵\n完美通关：击败敌阵且%s", ruleCfg.perfectDes)
		end
	end
end

function PerfectRuleModeRuleView:_onClickClose(...)
	self:close()

	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	UIStateManager.instance:popByName(self._commonCfg.difficultyview)
end

return PerfectRuleModeRuleView
