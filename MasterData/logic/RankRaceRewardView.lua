-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRewardView.lua

module("logic.extensions.rankrace.view.RankRaceRewardView", package.seeall)

local RankRaceRewardView = class("RankRaceRewardView", TabFrameWorkMainView)

function RankRaceRewardView:buildUI()
	RankRaceRewardView.super.buildUI(self)

	self._tabBk = {}
	self._tabLight = {}
	self._redPoint = {}
	self._txtTab = {}

	for i = 1, 4 do
		-- block empty
	end

	self._tableviewGo = self:getGo("tabView_1/sv_info")
	self._tablecellGo = self:getGo("tabView_1/sv_item")
	self._tabView_1 = self:getGo("tabView_1")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function RankRaceRewardView:bindEvents()
	RankRaceRewardView.super.bindEvents(self)
end

function RankRaceRewardView:unbindEvents()
	RankRaceRewardView.super.unbindEvents(self)

	for i = 1, 4 do
		-- block empty
	end
end

function RankRaceRewardView:onEnter()
	RankRaceRewardView.super.onEnter(self)

	self._curIndex = self._curIndex or 1

	local _matchType = RankRaceController.instance:getCurViewType()

	RankingMatchAgent.instance:sendRM_GetAllTaskReq(_matchType)
end

function RankRaceRewardView:onExit()
	RankRaceRewardView.super.onExit(self)
	RankRaceController.instance:operView(ViewName.RankRaceRewardSeasonView, function(_view)
		_view:close()
	end)

	self._curViewDatas = nil

	self._tableview:dispose()
end

function RankRaceRewardView:onExitFinished()
	RankRaceRewardView.super.onExitFinished(self)
end

function RankRaceRewardView:_openTabView1(force)
	if force then
		self._tabView_1.gameObject:SetActive(true)
		RankRaceController.instance:operView(ViewName.RankRaceRewardSeasonView, function(_view)
			_view:setActive(false)
		end)
	elseif self._curIndex == 3 or self._curIndex then
		self._tabView_1.gameObject:SetActive(true)
		RankRaceController.instance:operView(ViewName.RankRaceRewardSeasonView, function(_view)
			_view:setActive(false)
		end)
	end
end

function RankRaceRewardView:_onClickTabBk(index, force)
	if not force and self._curIndex == index then
		return
	end

	if index == 1 then
		self:_openTabView1(force)

		self._curViewDatas = {}

		local _configData = RankRaceController.instance:getTaskRewardConfig(index)

		for i = 1, #_configData do
			if _configData[i].matchType == RankRaceController.instance:getCurViewType() then
				table.insert(self._curViewDatas, _configData[i])
			end
		end

		self._tableview:reloadData(self._curViewDatas)
	elseif index == 2 then
		self:_openTabView1(force)

		self._curViewDatas = {}

		local _configData = RankRaceController.instance:getTaskRewardConfig(index)

		for i = 1, #_configData do
			if _configData[i].matchType == RankRaceController.instance:getCurViewType() then
				table.insert(self._curViewDatas, _configData[i])
			end
		end

		self._tableview:reloadData(self._curViewDatas)
	elseif index == 3 then
		self._tabView_1.gameObject:SetActive(false)

		if ViewMgr.instance:isOpen(ViewName.RankRaceRewardSeasonView) then
			RankRaceController.instance:operView(ViewName.RankRaceRewardSeasonView, function(_view)
				_view:setActive(true)
				_view:updateView(nil, RankRaceController.MatchTypeClassics)
			end)
		else
			ViewMgr.instance:open(ViewName.RankRaceRewardSeasonView)
		end
	elseif index == 4 then
		self._tabView_1.gameObject:SetActive(false)

		if self._curSecTabIndex == 1 then
			if not RankRaceController.MatchTypeClassics then
				local rankType = RankRaceController.MatchTypeLimit

				if ViewMgr.instance:isOpen(ViewName.RankRaceRewardSeasonView) then
					RankRaceController.instance:operView(ViewName.RankRaceRewardSeasonView, function(_view)
						_view:setActive(true)
						_view:updateView(RankRaceController.RankingWard, rankType)
					end)
				else
					ViewMgr.instance:open(ViewName.RankRaceRewardSeasonView, RankRaceController.RankingWard, rankType)
				end
			end
		end
	end

	self._curIndex = index
end

function RankRaceRewardView:_cellSize()
	return 990, 116
end

function RankRaceRewardView:_updateCell(view, cell, data)
	local btnRward = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bk/btnGetReward")
	local _txtGetReward = goutil.findChildComponent(cell.gameObject, "bk/btnGetReward/txtGetReward", "Text")
	local _txtWinCount = goutil.findChildComponent(cell.gameObject, "bk/txtWinCount", "Text")

	if not data.progressValue then
		return
	end

	if data.progressValue < data.progress then
		btnRward.gameObject:SetActive(false)
		_txtWinCount.gameObject:SetActive(true)

		local _txtWinCountValue = goutil.findChildComponent(cell.gameObject, "bk/txtWinCount/txtWinCountValue", "Text")

		_txtWinCountValue.text = data.progressValue .. "/" .. data.progress
	else
		btnRward.gameObject:SetActive(true)
		_txtWinCount.gameObject:SetActive(false)

		if data.prizeGained then
			_txtGetReward.text = RankRaceConfig.instance:getWord(14)

			uGuiUtil.setImageGrayStateRecursive(btnRward.gameObject, true)
		else
			uGuiUtil.setImageGrayStateRecursive(btnRward.gameObject, false)

			_txtGetReward.text = RankRaceConfig.instance:getWord(15)
		end

		btnRward:AddClickListener(function()
			local taskIdList = {}

			for _, taskData in ipairs(self._curViewDatas or {}) do
				if taskData.progressValue >= taskData.progress and not taskData.prizeGained then
					table.insert(taskIdList, taskData.id)
				end
			end

			RankingMatchAgent.instance:sendRM_GainTaskPrizeReq(taskIdList)
		end, self)
	end

	local _txtTitle = goutil.findChildComponent(cell.gameObject, "bk/txtTitle", "Text")

	_txtTitle.text = data.title

	local _txtDesc = goutil.findChildComponent(cell.gameObject, "bk/txtTitle/txtDesc", "Text")

	_txtDesc.text = data.desc

	local _prizeArray = string.split(data.prize, "#")

	print("dengsong data.prize", data.prize)

	if _prizeArray then
		for i = 1, #_prizeArray do
			local _item = goutil.findChild(cell.gameObject, "bk/item_" .. i)

			_item.gameObject:SetActive(true)
			MaterialMgr.resetAll(_item)

			if _prizeArray[i] and _prizeArray[i] ~= "" then
				local proxy = MaterialMgr.setCellByCfg(_prizeArray[i], _item)

				Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
			end
		end
	end
end

function RankRaceRewardView:_clearCell(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "bk/btnGetReward"):RemoveClickListener()
end

function RankRaceRewardView:updateView()
	self:_onClickTabBk(self._curIndex, true)
	self:_updateRedPoint()
end

function RankRaceRewardView:_updateRedPoint()
	for i = 1, 2 do
		local cfgData = RankRaceController.instance:getTaskRewardConfig(i)
		local data = {}

		for i = 1, #cfgData do
			if cfgData[i].matchType == RankRaceController.instance:getCurViewType() then
				table.insert(data, cfgData[i])
			end
		end

		local showActive = false

		for _, itemData in pairs(data) do
			if itemData and itemData.progressValue >= itemData.progress and not itemData.prizeGained then
				showActive = true

				break
			end
		end
	end
end

function RankRaceRewardView:_getFrameId()
	return 7
end

function RankRaceRewardView:_onUpdatePlaneUI()
	local force = self._curIndex == self._curHeadTabIndex

	self:_onClickTabBk(self._curHeadTabIndex, force)
end

return RankRaceRewardView
