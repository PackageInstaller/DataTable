-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankView", package.seeall)

local MartialcontestfinalrankView = class("MartialcontestfinalrankView", ViewComponent)

function MartialcontestfinalrankView:ctor()
	MartialcontestfinalrankView.super.ctor(self)
end

function MartialcontestfinalrankView:unbindEvents()
	MartialcontestfinalrankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialcontestfinalrankView:bindEvents()
	MartialcontestfinalrankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function MartialcontestfinalrankView:buildUI()
	MartialcontestfinalrankView.super.buildUI(self)

	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClickCell, self))

	self._btnClose = self:getBtn("btnClose")
	self._container = self:getGo("container")
	self._txtTime = self:getTxt("time/txtTime")
end

function MartialcontestfinalrankView:onExit()
	MartialcontestfinalrankView.super.onExit(self)
end

function MartialcontestfinalrankView:onEnter()
	MartialcontestfinalrankView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local enterTab = checknumber(params[2])

	self._curTabId = 0
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self._commonTab:clearAllData()

	local cfgs = MartialContestConfig.instance:getFinalsRankViewCfgs()

	for i, data in ipairs(cfgs) do
		if checknumber(data.rootTabId) == 0 then
			local obj = self._commonTab:addTabData(data.name, data)
		end
	end

	for i, data in ipairs(cfgs) do
		if checknumber(data.rootTabId) ~= 0 then
			local obj = self._commonTab:addTabData(data.name, data, data.rootTabId)

			if enterTab == 0 then
				enterTab = data.tabId
			end
		end
	end

	self:_onClickTab(enterTab)
end

function MartialcontestfinalrankView:_onClickTab(tabId)
	self._curTabId = tabId

	local curTabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(self._curTabId)

	self._commonTab:jumpTabByData(curTabCfg)

	local param = checknumber(curTabCfg.param)
end

function MartialcontestfinalrankView:_parseTimeStr(timeStr)
	local date = GameUtil.string2date(timeStr)

	return string.format("%s.%s.%s %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
end

function MartialcontestfinalrankView:_onUpdateExtCell(view, cell, tabData, tag)
	return
end

function MartialcontestfinalrankView:_onUpdateRight(tabData)
	self._curTabId = 0

	if tabData then
		local data = tabData.data

		self._curTabId = data.tabId
	end

	self:refreshView()
end

function MartialcontestfinalrankView:refreshView()
	self:showTabAt(self._container)

	local curTabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(self._curTabId)

	if curTabCfg then
		self:showTabAt(self._container, curTabCfg.viewname, self._activityId, self._curTabId)

		local roundIds = curTabCfg.roundIds
		local minRoundId = roundIds[1]
		local maxRoundId = roundIds[1]

		for i, v in ipairs(roundIds) do
			if minRoundId > checknumber(v) then
				minRoundId = checknumber(v)
			end

			if maxRoundId < checknumber(v) then
				maxRoundId = checknumber(v)
			end
		end

		local minStepCfg, maxStepCfg
		local stepCfgs = MartialContestConfig.instance:getStepCfgs(self._activityId)

		for i, v in ipairs(stepCfgs) do
			if not minStepCfg and v.roundId == minRoundId then
				minStepCfg = v
			end

			if not maxStepCfg and maxRoundId < v.roundId then
				maxStepCfg = v
			end

			if minStepCfg and maxStepCfg then
				break
			end
		end

		self._txtTime.text = minStepCfg and maxStepCfg and string.format("%s - %s", self:_parseTimeStr(minStepCfg.startTime), self:_parseTimeStr(maxStepCfg.startTime)) or "未知"
	end
end

function MartialcontestfinalrankView:_onClickbtnClose()
	self:close()
end

function MartialcontestfinalrankView:_onPreClickCell(tabData)
	local data = tabData.data
	local curTabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(data.tabId)
	local minRoundId = curTabCfg.roundIds[1]

	for i, v in ipairs(curTabCfg.roundIds) do
		if v < minRoundId then
			minRoundId = v
		end
	end

	local minStepCfg
	local stepCfgs = MartialContestConfig.instance:getStepCfgs(self._activityId)

	for i, v in ipairs(stepCfgs) do
		if not minStepCfg and v.roundId == minRoundId then
			minStepCfg = v

			break
		end
	end

	if minStepCfg then
		local time = GameUtil.string2time(minStepCfg.startTime)

		if time > ServerTime.now() then
			FloatWordMgr.instance:show("阶段还未开始")

			return true
		end
	end

	return false
end

return MartialcontestfinalrankView
