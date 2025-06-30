-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogMazeView.lua

local LibraryDialogMazeView = {
	storyCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryDialogMazeCell = require("IQIGame.UI.Library.LibraryDialogMazeCell")

function LibraryDialogMazeView.New(view, root)
	local obj = Clone(LibraryDialogMazeView)

	obj:Init(view, root)

	return obj
end

function LibraryDialogMazeView:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	self.ScrollMould:SetActive(false)

	self.storyCellPool = UIObjectPool.New(10, function()
		local cellObj = UnityEngine.Object.Instantiate(self.ScrollMould)

		return LibraryDialogMazeCell.New(cellObj)
	end, function(currentCell)
		currentCell:Dispose()
		UnityEngine.Object.Destroy(currentCell.View)
	end)

	self:AddListener()
end

function LibraryDialogMazeView:AddListener()
	return
end

function LibraryDialogMazeView:RemoveListener()
	return
end

function LibraryDialogMazeView:UpdateView()
	for i, v in pairs(self.storyCells) do
		v.View.transform:SetParent(self.root.UIController.gameObject.transform, false)
		v.View:SetActive(false)
		self.storyCellPool:Release(v)
	end

	self.storyCells = {}

	for i = 1, #self.storyDataTab do
		local cfgStoryRes = self.storyDataTab[i]
		local cell = self.storyCellPool:Obtain()

		cell:SetDate(cfgStoryRes, i)
		cell.View.transform:SetParent(self.ScrollView.transform, false)
		cell.View:SetActive(true)

		function cell.clickCallBack(cel)
			self:OnClickCell(cel)
		end

		table.insert(self.storyCells, cell)
	end
end

function LibraryDialogMazeView:OnClickCell(cel)
	if not cel.isLock then
		NoticeModule.ShowNoticeByType(1, LibraryStoryUIApi:GetString("LockError"))

		return
	end

	if self.selectCell and self.selectCell.index ~= cel.index and self.selectCell.isOpen then
		self.selectCell:CloseChildView()
	end

	self.selectCell = cel

	if self.selectCell.isOpen then
		self:SetScrollContentPos()
	end
end

function LibraryDialogMazeView:SetScrollContentPos()
	local anPox = -343 * (self.selectCell.index - 1)
	local minPox = -343 * (#self.storyDataTab - 1) + 200

	anPox = anPox < minPox and minPox or anPox

	local tween = TweenPosition.Begin(self.ScrollView.transform.gameObject, 0.5, Vector2(anPox, 0))

	tween:SetOnFinished(function()
		UnityEngine.GameObject.DestroyImmediate(tween)
	end)
end

function LibraryDialogMazeView:Open(type)
	self.type = type
	self.storyDataTab = TownLibraryModule.GetStoryDataByType(self.type)

	self.View:SetActive(true)
	self:UpdateView()
end

function LibraryDialogMazeView:Close()
	if self.selectCell then
		self.selectCell:CloseChildView()

		self.ScrollView.transform.anchoredPosition = Vector2.zero
	end

	self.View:SetActive(false)
end

function LibraryDialogMazeView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.storyCells) do
		self.storyCellPool:Release(v)
	end

	self.storyCells = {}

	self.storyCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogMazeView
