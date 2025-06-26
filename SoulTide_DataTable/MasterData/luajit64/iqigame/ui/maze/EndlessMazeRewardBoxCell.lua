-- chunkname: @IQIGame\\UI\\Maze\\EndlessMazeRewardBoxCell.lua

local m = {
	Num = 0
}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:SetData(host, cfgMazeEndlessBoxData, num, isChanged)
	self.CfgMazeEndlessBoxData = cfgMazeEndlessBoxData
	self.Num = num

	if isChanged then
		GameEntry.Effect:PlayUIMountPointEffect(EndlessMazeMainUIApi:GetString("ScoreBarBoxEffect", self.CfgMazeEndlessBoxData.Type), 50000, 0, self.Icon, Constant.Unity.SortingOrderMaxValue - 1)
	end

	local rewardBoxImgUrls = EndlessMazeMainUIApi:GetString("ScoreInfoBoxImagePaths")

	self.Icon:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(host.UIController:GetPreloadedAsset(rewardBoxImgUrls[self.CfgMazeEndlessBoxData.Type]))

	UGUIUtil.SetText(self.NumText, EndlessMazeMainUIApi:GetString("ScoreInfoTipBoxNumText", num))
end

function m:OnClick()
	self.OnClickCallback(self.CfgMazeEndlessBoxData, self.View.transform.position)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
	self.CfgMazeEndlessBoxData = nil
end

return m
