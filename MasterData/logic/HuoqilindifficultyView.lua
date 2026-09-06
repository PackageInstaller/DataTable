-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilindifficultyView.lua

module("logic.extensions.huoqilin.view.HuoqilindifficultyView", package.seeall)

local HuoqilindifficultyView = class("HuoqilindifficultyView", PerfectRuleModeDifficultyView)

function HuoqilindifficultyView:ctor()
	HuoqilindifficultyView.super.ctor(self)
end

function HuoqilindifficultyView:unbindEvents()
	HuoqilindifficultyView.super.unbindEvents(self)
end

function HuoqilindifficultyView:bindEvents()
	HuoqilindifficultyView.super.bindEvents(self)
end

function HuoqilindifficultyView:onExit()
	HuoqilindifficultyView.super.onExit(self)
end

function HuoqilindifficultyView:buildUI()
	HuoqilindifficultyView.super.buildUI(self)

	self._times = self:getTxt("times")
end

function HuoqilindifficultyView:onEnter()
	HuoqilindifficultyView.super.onEnter(self)
	self:_firstOpenActivity()
	self:_onRefreshUI()
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)
end

function HuoqilindifficultyView:_refreshRule()
	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if curInfo and checkint(curInfo.curRuleId) > 0 then
		self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

		UIStateManager.instance:push(self._commonCfg.ruleview, self._challengeId)
	end

	self:_onRefreshUI()
end

function HuoqilindifficultyView:_onRefreshUI()
	local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}
	local commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	local allTimes = commonCfg.dailyTimes + checknumber(progress.hasBuyTimes)
	local leftTimes = commonCfg.dailyTimes + checknumber(progress.hasBuyTimes) - checknumber(progress.hasUseTimes)

	self._times.text = string.format("今日次数：%s/%s", leftTimes, allTimes)
end

function HuoqilindifficultyView:_onClickModeBtn(index)
	local modeId = self._coms[index].cfg.modeId
	local isOpen, openTime = PerfectRuleModeModel.instance:getModeIsOpen(self._challengeId, modeId)

	if isOpen then
		local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}
		local commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
		local leftTimes = commonCfg.dailyTimes + checknumber(progress.hasBuyTimes) - checknumber(progress.hasUseTimes)

		if leftTimes > 0 then
			local content = langPara("确定选择<color=red>%s</color>难度吗？\n本次挑战将不可更改难度哦！", self._coms[index].cfg.desc)

			TipsFacade.instance:openPopupWindow("提示", content, function()
				PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightChooseModeReq(self._challengeId, modeId)
			end)
		else
			TipsFacade.instance:openCommonTips(lang("今日挑战次数已耗尽"))
		end
	else
		local str = GameUtil.formatTimeStamp("%m月%d日开启", openTime)

		TipsFacade.instance:openCommonTips(str)
	end
end

function HuoqilindifficultyView:_firstOpenActivity()
	return
end

return HuoqilindifficultyView
