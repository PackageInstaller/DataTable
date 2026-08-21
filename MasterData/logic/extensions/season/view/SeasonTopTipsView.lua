-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTopTipsView.lua

module("logic.extensions.season.view.SeasonTopTipsView", package.seeall)

local M = class("SeasonTopTipsView", ViewComponent)

function M:buildUI()
	self._imgLvProgress = self:getImage("fcpy_top_active_hint_-1011288200")
	self._txtLv = self:getText("fcpy_top_active_hint_-43421758")
	self._txtDesc = self:getText("fcpy_top_active_hint_1265480993")
	self._txtScore = self:getText("fcpy_top_active_hint_-748214612")
end

function M:destroyUI()
	return
end

function M:onEnter()
	self:refreshView()

	self._closeTimer = SchedulerCtrl.New(self._onTimeToClose, self)

	self._closeTimer:restart(2, false)
end

function M:onExit()
	self._closeTimer:clear()

	self._closeTimer = nil
end

function M:refreshView()
	local info = self:getFirstParam()
	local addScore = info.score
	local taskId = info.taskId
	local currLv = SeasonModel.instance:getCurrLv()
	local currScore = SeasonModel.instance:getCurrScore()
	local perLvScore = SeasonConfig.instance:getScorePerLv()
	local afterScore = currScore + addScore
	local afterLv = currLv

	while perLvScore < afterScore do
		afterLv = afterLv + 1
		afterScore = afterScore - perLvScore
	end

	local maxLv = SeasonConfig.instance:getMaxLv()

	if afterLv < maxLv then
		self._imgLvProgress.fillAmount = afterScore / perLvScore
	else
		self._imgLvProgress.fillAmount = 1
	end

	self._txtLv.text = afterLv
	self._txtScore.text = addScore

	local taskCfg = SeasonConfig.instance:getConfigByKey(ConfigName.SeasonTask, taskId)
	local strList = string.split(taskCfg.text, "#")

	self._txtDesc.text = strList[1]
end

function M:_onTimeToClose()
	self:close()
	SeasonTopTipsController.instance:showNext(1)
end

return M
