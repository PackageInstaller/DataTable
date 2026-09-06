-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianFmtView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianFmtView", package.seeall)

local DivineTunTianFmtView = class("DivineTunTianFmtView", ViewComponent)

function DivineTunTianFmtView:ctor()
	DivineTunTianFmtView.super.ctor(self)
end

function DivineTunTianFmtView:unbindEvents()
	DivineTunTianFmtView.super.unbindEvents(self)
end

function DivineTunTianFmtView:bindEvents()
	DivineTunTianFmtView.super.bindEvents(self)
end

function DivineTunTianFmtView:buildUI()
	DivineTunTianFmtView.super.buildUI(self)

	self._txt = self:getTxt("img/txt")
end

function DivineTunTianFmtView:onExit()
	DivineTunTianFmtView.super.onExit(self)
end

function DivineTunTianFmtView:onEnter()
	DivineTunTianFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._day = self._fmtMo:getDay()
	self._index = self._fmtMo:getIndex()

	local curBuffCfgs = DivineTunTianConfig.instance:getNorBuffCfgsByActId(self._activityId)
	local totalPower = DivineTunTianModel.instance:getAllNorScores(self._activityId)
	local curBuffCfgIdx = 1

	for i, cfg in ipairs(curBuffCfgs) do
		local powerArr = string.split(cfg.powerArrDesc, "-")

		if totalPower >= checknumber(powerArr[1]) and totalPower <= checknumber(powerArr[2]) then
			curBuffCfgIdx = i
		end

		if i == #curBuffCfgs and totalPower >= checknumber(powerArr[1]) then
			curBuffCfgIdx = i
		end
	end

	local curBuffCfg = curBuffCfgs[curBuffCfgIdx]

	self._txt.text = string.format("敌阵加成：%s", curBuffCfg.desc)
end

return DivineTunTianFmtView
