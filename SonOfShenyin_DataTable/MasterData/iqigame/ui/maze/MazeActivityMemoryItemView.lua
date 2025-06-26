-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityMemoryItemView.lua

local MazeActivityMemoryItemView = {}

function MazeActivityMemoryItemView.New(go, mainView)
	local o = Clone(MazeActivityMemoryItemView)

	o:Initialize(go, mainView)

	return o
end

function MazeActivityMemoryItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityMemoryItemView:InitComponent()
	return
end

function MazeActivityMemoryItemView:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function MazeActivityMemoryItemView:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function MazeActivityMemoryItemView:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function MazeActivityMemoryItemView:OnClickButtonClick()
	local userData = {
		storySrc = self.storySrc
	}

	UIModule.Open(Constant.UIControllerName.CommonVideoUI, Constant.UILayer.UI, userData)
end

function MazeActivityMemoryItemView:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function MazeActivityMemoryItemView:Refresh(eventId)
	local labyrinthEventCfg = CfgLabyrinthEventTable[eventId]
	local stroyCfg = CfgLabyrinthEventStoryTable[labyrinthEventCfg.SubTypeID]

	UGUIUtil.SetText(self.memoryName, stroyCfg.Name)

	self.storySrc = stroyCfg.StoryData
end

return MazeActivityMemoryItemView
