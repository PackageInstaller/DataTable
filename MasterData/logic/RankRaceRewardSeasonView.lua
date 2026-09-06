-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceRewardSeasonView.lua

module("logic.extensions.rankrace.view.RankRaceRewardSeasonView", package.seeall)

local RankRaceRewardSeasonView = class("RankRaceRewardSeasonView", TableViewComponent)

RankRaceRewardSeasonView.LocalServer = 1
RankRaceRewardSeasonView.GlobalServer = 2

function RankRaceRewardSeasonView:ctor()
	RankRaceRewardSeasonView.super.ctor(self)
end

function RankRaceRewardSeasonView:buildUI()
	RankRaceRewardSeasonView.super.buildUI(self)

	self._btnClassics = self:getBtn("btnClassics")
	self._btnLimit = self:getBtn("btnLimit")
	self._tabClassics = self:getGo("btnClassics"):GetComponent("UIChangeGroup")
	self._tabLimit = self:getGo("btnLimit"):GetComponent("UIChangeGroup")
	self._txtLimit = self:getTxt("btnLimit/txtLimit")
	self._txtClassics = self:getTxt("btnClassics/txtClassics")
end

function RankRaceRewardSeasonView:bindEvents()
	RankRaceRewardSeasonView.super.bindEvents(self)
	self._btnClassics:AddClickListener(function()
		if self._rewardType ~= RankRaceController.RankingWard then
			self:_onSwitchRankType(RankRaceController.MatchTypeClassics)
		else
			self._serverType = RankRaceRewardSeasonView.LocalServer

			self:_onSwitchRankType(self._rankType)
		end
	end, self)
	self._btnLimit:AddClickListener(function()
		if self._rewardType ~= RankRaceController.RankingWard then
			self:_onSwitchRankType(RankRaceController.MatchTypeLimit)
		else
			self._serverType = RankRaceRewardSeasonView.GlobalServer

			self:_onSwitchRankType(self._rankType)
		end
	end, self)
end

function RankRaceRewardSeasonView:unbindEvents()
	RankRaceRewardSeasonView.super.unbindEvents(self)
	self._btnClassics:RemoveClickListener()
	self._btnLimit:RemoveClickListener()
end

function RankRaceRewardSeasonView:destroyUI()
	RankRaceRewardSeasonView.super.destroyUI(self)
end

function RankRaceRewardSeasonView:onEnter()
	RankRaceRewardSeasonView.super.onEnter(self)

	local param = self:getOpenParam()

	self._rankType = RankRaceController.MatchTypeClassics
	self._serverType = RankRaceRewardSeasonView.GlobalServer

	if param then
		self._rewardType = param[1]
		self._rankType = param[2]
	end

	self:_onSwitchRankType(self._rankType)
	self:_updateSwitchBtnTxt()
end

function RankRaceRewardSeasonView:onEnterFinished()
	RankRaceRewardSeasonView.super.onEnterFinished(self)
end

function RankRaceRewardSeasonView:onExit()
	RankRaceRewardSeasonView.super.onExit(self)

	self._curViewDatas = nil
	self._rewardType = nil
end

function RankRaceRewardSeasonView:onExitFinished()
	RankRaceRewardSeasonView.super.onExitFinished(self)
end

function RankRaceRewardSeasonView:setActive(show)
	self.mainGO:SetActive(show)
end

function RankRaceRewardSeasonView:updateView(rewardType, rankType)
	self._rewardType = rewardType
	self._serverType = RankRaceRewardSeasonView.GlobalServer

	self:_onSwitchRankType(rankType)
	self:_updateSwitchBtnTxt()
end

function RankRaceRewardSeasonView:updateViewWithouParams()
	self:_onSwitchRankType(self._rankType)
end

function RankRaceRewardSeasonView:_onSwitchRankType(rankType)
	self._curViewDatas = {}

	if not rankType then
		self._tableview:ReloadData()

		return
	end

	self._rankType = rankType
	self._curType = rankType

	self:_updateBtnLight()

	if self._rewardType == RankRaceController.RankingWard then
		local matchSeasonId = RankRaceController.instance:getClientSeasonId()

		if matchSeasonId > 0 then
			local cfg = RankRaceConfig.instance:getSeasonCfg(matchSeasonId)

			if self._serverType == RankRaceRewardSeasonView.LocalServer then
				if not cfg.areaRankPrizePlanId then
					local planId = cfg.spaceRankPrizePlanId
					local _cur = RankRaceController.instance:getRankingReward(planId, self._rankType)

					for k, v in pairs(_cur) do
						table.insert(self._curViewDatas, v)
						table.sort(self._curViewDatas, function(a, b)
							return a.rightTop < b.rightTop
						end)
					end

					goutil.setActive(self:getGo("downText"), true)
				end
			end
		end
	else
		local cfgs = RankRaceController.instance:getTaskRewardConfig(RankRaceController.TaskTypeSeason, self._rankType)

		table.insertto(self._curViewDatas, cfgs)
		table.sort(self._curViewDatas, function(a, b)
			return a.sort < b.sort
		end)
		goutil.setActive(self:getGo("downText"), false)
	end

	self._tableview:ReloadData()
end

function RankRaceRewardSeasonView:_updateBtnLight()
	if self._rewardType == RankRaceController.RankingWard then
		if self._serverType == RankRaceRewardSeasonView.LocalServer then
			self._tabClassics:SetState(1)
			self._tabLimit:SetState(0)
		else
			self._tabClassics:SetState(0)
			self._tabLimit:SetState(1)
		end
	elseif self._rankType == RankRaceController.MatchTypeClassics then
		self._tabClassics:SetState(1)
		self._tabLimit:SetState(0)
	else
		self._tabClassics:SetState(0)
		self._tabLimit:SetState(1)
	end
end

function RankRaceRewardSeasonView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function RankRaceRewardSeasonView:_cellSize()
	return 990, 116
end

function RankRaceRewardSeasonView:_updateCell(view, cell, data)
	if self._rewardType == RankRaceController.RankingWard then
		goutil.setActive(goutil.findChild(cell, "bk"), false)
		goutil.setActive(goutil.findChild(cell, "ranking"), true)
		self:_updateRankingRewardCell(view, cell, data)
	else
		goutil.setActive(goutil.findChild(cell, "bk"), true)
		goutil.setActive(goutil.findChild(cell, "ranking"), false)
		self:_updateTaskTypeSeasonCell(view, cell, data)
	end
end

function RankRaceRewardSeasonView:_clearTableview(cell)
	local itemView1 = goutil.findChild(cell.gameObject, "bk/itemView/viewport/content")
	local itemView2 = goutil.findChild(cell.gameObject, "ranking/itemView/viewport/content")

	for _, itemView in ipairs({
		itemView1,
		itemView2
	}) do
		for idx = 1, itemView.transform.childCount do
			local _item = itemView.transform:GetChild(idx - 1).gameObject
			local root = goutil.findChild(_item, "root")

			MaterialMgr.resetAll(root)
		end
	end
end

function RankRaceRewardSeasonView:_updateTaskTypeSeasonCell(view, cell, data)
	local _txtTitle = goutil.findChildComponent(cell.gameObject, "bk/txtTitle", "Text")

	_txtTitle.text = data.bigLevelName

	local txtTitle2 = goutil.findChildComponent(cell.gameObject, "bk/txtTitle2", "Text")

	txtTitle2.text = data.levelTitle

	local itemView = goutil.findChild(cell.gameObject, "bk/itemView/viewport/content")
	local _prizeArray = {}

	if not string.nilorempty(data.levelPrize) then
		_prizeArray = string.split(data.levelPrize, "#")
	end

	for idx = 1, itemView.transform.childCount do
		local _item = itemView.transform:GetChild(idx - 1).gameObject
		local root = goutil.findChild(_item, "root")
		local isHavePrize = not string.nilorempty(_prizeArray[idx])

		if isHavePrize then
			MaterialMgr.setCellByCfg(_prizeArray[idx], root)
		else
			MaterialMgr.resetAll(root)
		end

		_item.gameObject:SetActive(isHavePrize)
	end
end

function RankRaceRewardSeasonView:_updateRankingRewardCell(view, cell, data)
	local _txtTitle = goutil.findChildComponent(cell.gameObject, "ranking/txtTitle", "Text")

	_txtTitle.text = self._curViewDatas[cell.index] and string.format("第%s~%s名", self._curViewDatas[cell.index].rightTop + 1, data.rightTop) or "第1名"

	local itemView = goutil.findChild(cell.gameObject, "ranking/itemView/viewport/content")
	local _prizeArray = {}

	if not string.nilorempty(data.prize) then
		_prizeArray = string.split(data.prize, "#")
	end

	for idx = 1, itemView.transform.childCount do
		local _item = itemView.transform:GetChild(idx - 1).gameObject
		local root = goutil.findChild(_item, "root")
		local isHavePrize = not string.nilorempty(_prizeArray[idx])

		if isHavePrize then
			MaterialMgr.setCellByCfg(_prizeArray[idx], root)
		else
			MaterialMgr.resetAll(root)
		end

		_item.gameObject:SetActive(isHavePrize)
	end
end

function RankRaceRewardSeasonView:_updateSwitchBtnTxt()
	if self._rewardType == RankRaceController.RankingWard then
		self._txtClassics.text = "本服传说榜奖励"
		self._txtLimit.text = "全服传说榜奖励"
	else
		self._txtClassics.text = "经典赛奖励"
		self._txtLimit.text = "极限赛奖励"
	end
end

return RankRaceRewardSeasonView
