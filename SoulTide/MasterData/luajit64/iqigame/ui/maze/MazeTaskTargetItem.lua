-- chunkname: @IQIGame\\UI\\Maze\\MazeTaskTargetItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickGuideBtn()
		self:OnClickGuideBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.GuideBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGuideBtn)
end

function m:RemoveListeners()
	self.GuideBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGuideBtn)
end

function m:SetData(cfgMazeTargetData, progress)
	local isFinish = progress >= cfgMazeTargetData.TotalProgress
	local desc

	if isFinish then
		desc = cfgMazeTargetData.FinishedTargetName
		self.TouchEffect = cfgMazeTargetData.FinishedTargetTouchEffect
	else
		desc = cfgMazeTargetData.TargetName
		self.TouchEffect = cfgMazeTargetData.TargetTouchEffect
	end

	UGUIUtil.SetText(self.DescText, MazeMainUIApi:GetString("TaskTargetDesc", desc, progress, cfgMazeTargetData.TotalProgress, cfgMazeTargetData.IsShowRate, cfgMazeTargetData.IsShowTotalProgress, isFinish))
	self.FinishFg:SetActive(isFinish)
	self.FailFg:SetActive(progress == -1)
	self.GuideBtn:SetActive(#self.TouchEffect > 0 and progress ~= -1)
end

function m:OnClickGuideBtn()
	if #self.TouchEffect == 0 then
		return
	end

	if MazeModule.MazeScene.Hero:IsMoving() or MazeModule.MazeScene.InputMgr:IsLock() then
		NoticeModule.ShowNotice(84500010)

		return
	end

	if #self.TouchEffect == 1 then
		NoticeModule.ShowNotice(self.TouchEffect[1])

		return
	end

	local heroAreaIx = MazeModule.MazeScene.Hero.NodeData.AreaIx
	local isOutOfArea = false

	for i = 2, #self.TouchEffect do
		local switchCid = self.TouchEffect[i]
		local cfgMazeScreenSwitchData = CfgMazeScreenSwitchTable[switchCid]

		if cfgMazeScreenSwitchData.NodeId ~= 0 then
			local mazeNode = MazeModule.MazeScene:GetNodeByCID(cfgMazeScreenSwitchData.NodeId)

			if mazeNode == nil or mazeNode.NodeData.AreaIx ~= heroAreaIx then
				warning(string.format("cfgMazeScreenSwitchData.NodeId [%s] 错误或不在当前区域内，MazeScreenSwitch.Id：%s。", cfgMazeScreenSwitchData.NodeId, switchCid))

				isOutOfArea = true

				break
			end
		end
	end

	if not isOutOfArea then
		local screenSwitchCidList = {}

		for i = 2, #self.TouchEffect do
			table.insert(screenSwitchCidList, self.TouchEffect[i])
		end

		MazeModule.MazeScene:PlayScreenMoveAnimation(screenSwitchCidList)
	elseif self.TouchEffect[1] ~= 0 then
		NoticeModule.ShowNotice(self.TouchEffect[1])
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
