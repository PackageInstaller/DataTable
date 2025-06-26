-- chunkname: @IQIGame\\UI\\ExploreHall\\MazeChallengeBonus\\MazeChallengeBonusCell.lua

local m = {
	taskState = 1,
	isSelectBuy = false,
	itemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.CommonSlot:SetActive(false)

	self.itemCellPool = UIObjectPool.New(3, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.CommonSlot))
	end, function(cell)
		local view = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.mazeChallengeBonusData = data
	self.taskUIData = self.mazeChallengeBonusData.tasks[1]

	self:UpdateView()
end

function m:UpdateView()
	self.redPoint:SetActive(false)

	if self.mazeChallengeBonusData and self.taskUIData then
		local UIController = self.View:GetComponentInParent(typeof(UIController))

		for i, v in pairs(self.itemCells) do
			v.ViewGo:SetActive(false)
			v.ViewGo.transform:SetParent(UIController.transform, false)
			self.itemCellPool:Release(v)
		end

		self.itemCells = {}

		local cfgMainQuestData = CfgMainQuestTable[self.taskUIData.cid]

		for i = 1, #cfgMainQuestData.Reward, 2 do
			local itemId = cfgMainQuestData.Reward[i]
			local itemNum = cfgMainQuestData.Reward[i + 1]
			local itemCell = self.itemCellPool:Obtain()

			itemCell.ViewGo:SetActive(true)
			itemCell.ViewGo.transform:SetParent(self.ItemNode.transform, false)
			itemCell:SetItemByCID(itemId, itemNum)
			table.insert(self.itemCells, itemCell)
		end

		local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]

		UGUIUtil.SetText(self.NameText, cfgTargetData.TargetDes)
		UGUIUtil.SetText(self.ProgressText, MazeChallengeBonusUIApi:GetString("TaskItemProgressText", self.taskUIData.CurrentNum, self.taskUIData.TargetNum))

		local cfgChapterData = CfgChapterTable[self.mazeChallengeBonusData:GetConfig().Chapter]

		UGUIUtil.SetText(self.textName, cfgChapterData.Name)

		local path = UIGlobalApi.GetImagePath(self.mazeChallengeBonusData:GetConfig().Icon)

		AssetUtil.LoadImage(self, path, self.imgBG:GetComponent("Image"))

		local state = self.mazeChallengeBonusData:GetState()

		for i = 1, 4 do
			self["state" .. i]:SetActive(state == i)
			UGUIUtil.SetTextInChildren(self["state" .. i], cfgChapterData.Name)
		end

		self.SellType = Constant.ItemID.ID_PAYPOINT_SHOW

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoneyIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.textMoneyNeed, MazeChallengeBonusUIApi:GetString("TextMoneyNeed", self.mazeChallengeBonusData:GetConfig().payPoint))
		self.redPoint:SetActive(state == 3)
	end
end

function m:SetSelectShowTask(top)
	self.selectShowTask:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.itemCells) do
		self.itemCellPool:Release(v)
	end

	self.itemCells = {}

	self.itemCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
