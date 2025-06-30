-- chunkname: @IQIGame\\UI\\Maze\\EndlessMazeRewardBoxTip.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:Show(cfgMazeEndlessBoxData, position)
	self.View:SetActive(true)
	UGUIUtil.SetText(self.TitleText, cfgMazeEndlessBoxData.Name)
	UGUIUtil.SetText(self.DescText, cfgMazeEndlessBoxData.Describe)

	self.TipContent.transform.position = position
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
