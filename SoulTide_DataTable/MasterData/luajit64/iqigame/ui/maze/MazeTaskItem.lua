-- chunkname: @IQIGame\\UI\\Maze\\MazeTaskItem.lua

local m = {
	Targets = {}
}

function m.New(view, targetItemPool)
	local obj = Clone(m)

	obj:Init(view, targetItemPool)

	return obj
end

function m:Init(view, targetItemPool)
	self.View = view
	self.TargetItemPool = targetItemPool

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDetailBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDetailBtn)
end

function m:SetData(cid, progresses, isTaskFinish, isNew)
	self.CfgMazeTaskData = CfgMazeTaskTable[cid]
	self.TitleText:GetComponent("Text").text = self.CfgMazeTaskData.Title

	self:ClearTargets()

	for i = 1, #self.CfgMazeTaskData.TargetId do
		local cfgMazeTargetData = CfgMazeTargetTable[self.CfgMazeTaskData.TargetId[i]]
		local progress = progresses[i]
		local isFinish = progress >= cfgMazeTargetData.TotalProgress

		if cfgMazeTargetData.IsShowBefore or isFinish then
			local mazeTaskTargetItem = self.TargetItemPool:Obtain()

			mazeTaskTargetItem.View:SetActive(true)
			mazeTaskTargetItem.View.transform:SetParent(self.TargetGrid.transform, false)
			mazeTaskTargetItem:SetData(cfgMazeTargetData, progress)
			table.insert(self.Targets, mazeTaskTargetItem)
		end
	end

	self.FinishBg:SetActive(isTaskFinish)
	self.ClearNode:SetActive(isTaskFinish)
	self.NormalBg:SetActive(not isTaskFinish)

	if isNew then
		self:PlayNewEffect()
	end
end

function m:ClearTargets()
	for i = 1, #self.Targets do
		local mazeTaskTargetItem = self.Targets[i]

		mazeTaskTargetItem.View:SetActive(false)
		mazeTaskTargetItem.View.transform:SetParent(self.View.transform, false)
		self.TargetItemPool:Release(mazeTaskTargetItem)
	end

	self.Targets = {}
end

function m:OnClickDetailBtn()
	UIModule.Open(Constant.UIControllerName.MazeTaskUI, Constant.UILayer.UI, {
		taskCid = self.CfgMazeTaskData.Id
	})
end

function m:PlayNewEffect()
	return
end

function m:PlayRemoveEffect()
	return
end

function m:Dispose()
	self:RemoveListeners()
	self:ClearTargets()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.TargetItemPool = nil
end

return m
