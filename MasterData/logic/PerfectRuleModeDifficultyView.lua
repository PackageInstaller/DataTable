-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModeDifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModeDifficultyView", package.seeall)

local PerfectRuleModeDifficultyView = class("PerfectRuleModeDifficultyView", ViewComponent)

function PerfectRuleModeDifficultyView:unbindEvents()
	PerfectRuleModeDifficultyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, 5 do
		self._coms[i].btn:RemoveClickListener()
	end
end

function PerfectRuleModeDifficultyView:bindEvents()
	PerfectRuleModeDifficultyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)

	for i = 1, 5 do
		self._coms[i].btn:AddClickListener(function()
			self:_onClickModeBtn(i)
		end, self)
	end
end

function PerfectRuleModeDifficultyView:onExit()
	PerfectRuleModeDifficultyView.super.onExit(self)

	for k, com in pairs(self._coms) do
		MaterialMgr.clearIcon(com.iconPrize)
		MaterialMgr.clearIcon(com.iconPrizePerfect)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeDailyRresh, self._refreshViewDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshRule, self)
end

function PerfectRuleModeDifficultyView:buildUI()
	PerfectRuleModeDifficultyView.super.buildUI(self)

	self._coms = {}

	for i = 1, 5 do
		local com = {}

		com.cfg = nil
		com.go = self:getGo("com" .. i)
		com.goChallenge = goutil.findChild(com.go, "btnChallenge")
		com.btn = GameUtil.asBtn(com.goChallenge)
		com.zdl = goutil.findChild(com.go, "zdl")
		com.zdlTxt = goutil.findChild(com.go, "zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
		com.txtBtn = goutil.findChildTextComponent(com.goChallenge, "txt")
		com.goOpenTime = goutil.findChild(com.go, "txtOpentime")
		com.txtTime = com.goOpenTime:GetComponent(goutil.Type_UIText)
		com.iconPrize = goutil.findChild(com.go, "prize/icon")
		com.txtPrize = goutil.findChildTextComponent(com.go, "prize/txt")
		com.txtPrizePerfect = goutil.findChildTextComponent(com.go, "prizePerfect/txt")
		com.iconPrizePerfect = goutil.findChild(com.go, "prizePerfect/icon")
		self._coms[i] = com
	end

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._challengeId = 0
end

function PerfectRuleModeDifficultyView:onEnter()
	PerfectRuleModeDifficultyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeDailyRresh, self._refreshViewDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._refreshRule, self)

	self._challengeId = checkint(self:getFirstParam())

	if self._challengeId > 0 then
		self:_freshViewFixedPart()
		self:_refreshViewDaily()
		self:_refreshRule()
	else
		printError("当前挑战ID没有传参")
	end
end

function PerfectRuleModeDifficultyView:_freshViewFixedPart()
	for i = 1, 5 do
		self._coms[i].cfg = PerfectRuleModeConfig.instance:getModeCfgsByIndex(self._challengeId, i)

		local com = self._coms[i]

		if self._coms[i].cfg then
			goutil.setActive(com.go, true)

			if com.cfg.normalPassPrize ~= "" and com.cfg.perfectPassPrize ~= "" then
				com.txtBtn.text = com.cfg.desc

				MaterialMgr.clearIcon(com.iconPrize)
				MaterialMgr.clearIcon(com.iconPrizePerfect)

				local matstr = com.cfg.normalPassPrize
				local matType, matId, matNum = MaterialMgr.getMatParams(matstr)

				com.txtPrize.text = matNum <= 1 and "" or "x" .. matNum

				MaterialMgr.updateItemByStr(com.iconPrize, matstr)

				matstr = com.cfg.perfectPassPrize
				matType, matId, matNum = MaterialMgr.getMatParams(com.cfg.perfectPassPrize)
				com.txtPrizePerfect.text = matNum <= 1 and "" or "x" .. matNum

				MaterialMgr.updateItemByStr(com.iconPrizePerfect, matstr)
			end
		else
			goutil.setActive(com.go, false)
		end
	end
end

function PerfectRuleModeDifficultyView:_refreshRule()
	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if curInfo then
		if checkint(curInfo.curRuleId) > 0 then
			self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

			UIStateManager.instance:push(self._commonCfg.ruleview, self._challengeId)
		end
	else
		self:close()
		printError("数据不存在，不支持Gm op打开")
	end
end

function PerfectRuleModeDifficultyView:_refreshViewDaily()
	if self._challengeId > 0 then
		for i = 1, 5 do
			local isOpen, openTime = PerfectRuleModeModel.instance:getModeIsOpen(self._challengeId, self._coms[i].cfg.modeId)

			if isOpen then
				goutil.setActive(self._coms[i].zdl, true)
				goutil.setActive(self._coms[i].goOpenTime, false)
				self._coms[i].zdlTxt:SetText(PerfectRuleModeModel.instance:getShowZDLByModeId(self._challengeId, self._coms[i].cfg.modeId))
			else
				goutil.setActive(self._coms[i].zdl, false)
				goutil.setActive(self._coms[i].goOpenTime, true)

				self._coms[i].txtTime.text = GameUtil.formatTimeStamp("%m月%d日开启", openTime)
			end
		end
	end
end

function PerfectRuleModeDifficultyView:_onClickModeBtn(index)
	local modeId = self._coms[index].cfg.modeId
	local isOpen, openTime = PerfectRuleModeModel.instance:getModeIsOpen(self._challengeId, modeId)

	if isOpen then
		local content = langPara("确定选择<color=red>%s</color>难度吗？\n本次挑战将不可更改难度哦！", self._coms[index].cfg.desc)

		TipsFacade.instance:openPopupWindow("提示", content, function()
			PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightChooseModeReq(self._challengeId, modeId)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		local str = GameUtil.formatTimeStamp("%m月%d日开启", openTime)

		TipsFacade.instance:openCommonTips(str)
	end
end

function PerfectRuleModeDifficultyView:_onClickBtnTip()
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	UIStateManager.instance:push(self._commonCfg.ruleshowview, self._challengeId)
end

return PerfectRuleModeDifficultyView
