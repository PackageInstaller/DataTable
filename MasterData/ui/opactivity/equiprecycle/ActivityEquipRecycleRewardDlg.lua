-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityEquipRecycleRewardDlg.lua

local ActivityEquipRecycleRewardCell2 = Class("ActivityEquipRecycleRewardCell2", UIControls.Child)

function ActivityEquipRecycleRewardCell2:ctor()
	self:initUI()

	self.awardCells = {}
end

function ActivityEquipRecycleRewardCell2:initUI(...)
	self.gridEquip = UIControls.EquipGridChild(self, "GridEquipItem", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.gridEquip.mEnableTips = false
end

function ActivityEquipRecycleRewardCell2:setData(data)
	self.data = data

	if self.data then
		if self.data.recycleType and self.data.recycleType ~= 0 then
			if self.data.recycleType == 1 then
				self:playStateAnimator("Cell2Level3")
			elseif self.data.recycleType == 2 then
				self:playStateAnimator("Cell2Level2")
			elseif self.data.recycleType == 3 then
				self:playStateAnimator("Cell2Level1")
			end

			local showIds, showNums = CurAvatar:getEquipRecycleReturn(self.data, self.data.recycleType)

			for index = 1, #showIds do
				if not self.awardCells[index] then
					self.awardCells[index] = UIControls.getGridAwardContainer(self, "GridRewardList/Content")
					self.awardCells[index].mDisableWays = true
				end

				self.awardCells[index]:setVisible(true)

				local item = BaseObject.GetObject(showIds[index], showNums[index])

				self.awardCells[index]:setObj(item)
			end

			local num = #showIds

			for index = num + 1, #self.awardCells do
				self.awardCells[index]:setVisible(false)
			end
		end

		self.gridEquip:setObj(self.data)
	end
end

local ActivityEquipRecycleRewardDlg = Class("ActivityEquipRecycleRewardDlg", UIControls.Window)

function ActivityEquipRecycleRewardDlg:ctor(...)
	self:initUI()
end

function ActivityEquipRecycleRewardDlg:initUI(...)
	self.btnGet = UIControls.Button(self, "BgPanel/BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.btnBefore = UIControls.Button(self, "BgPanel/BtnBefore")

	self.btnBefore:addEventClick(self.onBtnBeforeClick)

	self.awardCells = {}

	for i = 1, 4 do
		local newCell = ActivityEquipRecycleRewardCell2(self, "BgPanel/RewardList/Content", "System/Activity/ActivityEquipRecycle/EquipRecycleRewardCell2")

		table.insert(self.awardCells, newCell)
	end

	self.pagePanel = UIControls.Panel(self, "BgPanel/PagePanel")
	self.pageCells = {}

	for i = 1, 15 do
		local newCell = UIControls.Image(self, "BgPanel/PagePanel/Page" .. i)

		table.insert(self.pageCells, newCell)
	end
end

function ActivityEquipRecycleRewardDlg:setListIndex(index)
	self.listIndex = index
end

function ActivityEquipRecycleRewardDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		self.listIndex = self.listIndex or 1

		if self.listIndex == 1 then
			self.listData = self.actData.mainWorkShopData
		else
			self.listData = self.actData.rentWorkShopData
		end

		self.itemsData = self.listData.finishList
		self.pageIndex = self.pageIndex or 1
		self.maxPageIndex = math.ceil(#self.itemsData / 4)

		self:refreshShow()
	end
end

function ActivityEquipRecycleRewardDlg:setPageIndex(index)
	self.pageIndex = index

	self:refreshShow()
end

function ActivityEquipRecycleRewardDlg:refreshShow(...)
	if self.maxPageIndex > 1 then
		self.pagePanel:setVisible(true)

		for i = 1, 15 do
			self.pageCells[i]:setVisible(i <= self.maxPageIndex)
		end
	else
		self.pagePanel:setVisible(false)
	end

	for i = 1, 15 do
		if self.pageIndex == i then
			self.pageCells[i]:setImage("Atlas/ActivityAtlas/ActivityEquipRecycleAtlas/ActivityEquipRecycleEditAtlas", "BgDots2")
		else
			self.pageCells[i]:setImage("Atlas/ActivityAtlas/ActivityEquipRecycleAtlas/ActivityEquipRecycleEditAtlas", "BgDots1")
		end
	end

	self.btnNext:setVisible(self.pageIndex < self.maxPageIndex)
	self.btnBefore:setVisible(self.pageIndex > 1)

	local start = (self.pageIndex - 1) * 4 + 1
	local End = math.min(#self.itemsData, self.pageIndex * 4)

	for i = start, End do
		local index = i % 4

		if index == 0 then
			index = 4
		end

		self.awardCells[index]:setVisible(true)
		self.awardCells[index]:setData(self.itemsData[i])
	end

	End = End % 4

	if End ~= 0 then
		for i = End + 1, 4 do
			self.awardCells[i]:setVisible(false)
		end
	end
end

function ActivityEquipRecycleRewardDlg:onBtnGetClick()
	if self.itemsData and #self.itemsData then
		local actId = self.actData.actObject.opId
		local equips = {}

		for index, equip in ipairs(self.itemsData) do
			local data = {}

			data.equip_gid = equip.gid

			table.insert(equips, data)
		end

		RPC.opActEquipRecycleGetAward(actId, equips, self.listIndex)
	end

	self:setVisible(false)
end

function ActivityEquipRecycleRewardDlg:onBtnBeforeClick()
	if self.pageIndex - 1 >= 1 then
		self:setPageIndex(self.pageIndex - 1)
	end
end

function ActivityEquipRecycleRewardDlg:onBtnNextClick()
	if self.pageIndex + 1 <= self.maxPageIndex then
		self:setPageIndex(self.pageIndex + 1)
	end
end

return ActivityEquipRecycleRewardDlg
