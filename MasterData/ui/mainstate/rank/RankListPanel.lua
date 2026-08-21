-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\RankListPanel.lua

local RearHouseRankCell = require("UI/MainState/Rank/RearHouseRankCell")
local strClassName = "RankListPanel"
local RankListPanel = Class(strClassName, UIControls.Panel)

function RankListPanel:ctor()
	self:initUI()
end

function RankListPanel:initUI()
	self.scrollRank = UIControls.ScrollViewLoopV(self, self.mPath)

	self.scrollRank:addEventCellChanged(self.onRankCellChanged)

	self.cells = {}
end

function RankListPanel:setDataList(dataList, isLastPage)
	self.dataList = dataList
	self.isLastPage = isLastPage

	self.scrollRank:setVisible(true)
	self:checkSort()
	self:refreshRankScroll()

	self.scrollRank:getComObj().vertical = false
	self.enableScrollTimer = Timer.New(Slot(self.enableScrollSlot, self), 0.2, 1)

	self.enableScrollTimer:Start()
end

function RankListPanel:refreshRankScroll()
	if self.dataList == nil then
		return
	end

	if self.isLastPage then
		self.scrollRank:setTotalCount(#self.dataList)
	else
		self.scrollRank:setTotalCount(#self.dataList + 1)
	end
end

function RankListPanel:enableScrollSlot()
	self.scrollRank:getComObj().vertical = true
end

function RankListPanel:onRankCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		if self.mWindow.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
			targetCell = RearHouseRankCell(sender, "System/Backyard/BtnBackyardRank", newIdx)
		else
			targetCell = UIControls.BtnPlayerRankCellLoop(sender, "System/Rank/BtnPlayerRank", newIdx)
		end
	end

	if not self.dataList or #self.dataList == 0 then
		return
	end

	if self.dataList[newIdx] ~= nil then
		targetCell:setData(self.dataList[newIdx], newIdx)
	else
		CurAvatar:onRankListRequestNextPage(self.mWindow.typeRank)
	end

	self.cells[newIdx] = targetCell
end

function RankListPanel:checkSort(...)
	if self.dataList == nil then
		return
	end

	if self.mWindow.typeRank ~= Const.RANK_TYPE_OPACTPVP then
		return
	end

	local myTick = -1

	for i = #self.dataList, 1, -1 do
		if self.dataList[i].data.comm.uid == CurAvatar.uid then
			myTick = self.dataList[i].data.tick

			table.remove(self.dataList, i)
		end
	end

	local actData = CurAvatar:getPVPArenaActivityData()

	if actData and actData.enrolled ~= 0 then
		local data = CurAvatar:getMyOpactPvpRankData()

		if CurAvatar.opactPvpScoreRefreshTick then
			data.data.tick = CurAvatar.opactPvpScoreRefreshTick
		elseif myTick > 0 then
			data.data.tick = myTick
		end

		table.insert(self.dataList, data)
	end

	table.sort(self.dataList, function(v1, v2)
		if v1.data.score == v2.data.score then
			return v1.data.tick < v2.data.tick
		end

		return v1.data.score > v2.data.score
	end)

	if #self.dataList > 50 then
		table.remove(self.dataList, #self.dataList)
	end

	for i, data in ipairs(self.dataList) do
		if data.data.comm.uid == CurAvatar.uid then
			CurAvatar.opactPvpRank = i

			local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

			if ui then
				ui:refreshRank()
			end
		end

		data.rank = i
	end
end

function RankListPanel:clear(...)
	self.dataList = nil
end

return RankListPanel
