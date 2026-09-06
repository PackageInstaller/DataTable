-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankRewardView.lua

module("logic.extensions.rank.view.RankRewardView", package.seeall)

local RankRewardView = class("RankRewardView", ViewComponent)

function RankRewardView:ctor()
	RankRewardView.super.ctor(self)
end

function RankRewardView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function RankRewardView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function RankRewardView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._rewardListView = goutil.findChildComponent(self.mainGO, "rewardListView", "UITableview")
	self._rewardCell = self:getGo("rewardCell")

	goutil.setActive(self._rewardCell, false)
	self._rewardListView:RegisterCallback(self._rewardNumInView, self._rewardCellSize, self._rewardCellAtIndex, self)
	self._rewardListView:RegisterUpdateCellCallback(self._updateRewardCell)
	self._rewardListView:SetOffsetWithoutRefresh(0)

	self._tabs = {}

	local gridTabs = self:getGo("gridTab").transform

	for i = 1, 3 do
		local go = gridTabs:GetChild(i - 1).gameObject
		local btn = Framework.ButtonAdapter.Get(go)

		if btn then
			btn:AddClickListener(function()
				self:_onClickTab(i)
			end)
		end

		table.insert(self._tabs, go)
	end
end

function RankRewardView:_rewardNumInView()
	return #self._curViewDatas
end

function RankRewardView:_rewardCellSize()
	return 742, 122
end

function RankRewardView:_rewardCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rewardCell)
	cell.index = index

	self:_updateRewardCell(view, cell)

	return cell
end

function RankRewardView:_updateRewardCell(view, cell)
	local idx = cell.index
	local mo = self._curViewDatas[idx + 1]
	local txtRange = goutil.findChildComponent(cell.gameObject, "txtRange", "Text")

	txtRange.text = string.format("第%d—%d名", mo.begin, mo.tail)

	local parent = goutil.findChild(cell.gameObject, "gridReward").transform
	local childCount = parent.childCount

	if childCount == 0 then
		return cell
	end

	local cloneCell = parent:GetChild(0).gameObject
	local t = string.split(mo.prize, "#")

	for k, v in ipairs(t) do
		local go = k <= childCount and parent:GetChild(k - 1).gameObject or goutil.cloneAndSetParent(cloneCell, parent)

		goutil.setActive(go, true)
		MaterialMgr.setCellByCfg(v, go)
	end

	local i = #t

	while i < childCount do
		local go = parent:GetChild(i).gameObject

		goutil.setActive(go, false)

		i = i + 1
	end

	return cell
end

function RankRewardView:destroyUI()
	return
end

function RankRewardView:onEnter()
	self:_updateUI(1)
end

function RankRewardView:_updateUI(tab)
	self._curViewDatas = BreakFormationConfig.instance:getRankPrizeCfg(tab)

	self._rewardListView:ReloadData()

	for i = 1, 3 do
		local goNotSelected = self._tabs[i].transform:GetChild(0).gameObject
		local goSelected = self._tabs[i].transform:GetChild(1).gameObject

		goutil.setActive(goNotSelected, i ~= tab)
		goutil.setActive(goSelected, i == tab)
	end
end

function RankRewardView:onEnterFinished()
	return
end

function RankRewardView:onExit()
	return
end

function RankRewardView:onExitFinished()
	return
end

function RankRewardView:_onClickClose()
	self:close()
end

function RankRewardView:_onClickTab(tab)
	self:_updateUI(tab)
end

return RankRewardView
