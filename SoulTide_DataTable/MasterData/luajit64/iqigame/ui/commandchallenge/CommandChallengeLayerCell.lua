-- chunkname: @IQIGame\\UI\\CommandChallenge\\CommandChallengeLayerCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.commandChallengeData = data

	self:UpdateView()
end

function m:UpdateView()
	self.IncompleteNode:SetActive(not self.commandChallengeData.pass)
	self.CompleteNode:SetActive(self.commandChallengeData.pass)
	self.TagRewardComplete:SetActive(self.commandChallengeData.pass)
	UGUIUtil.SetText(self.TextOrder, self.commandChallengeData:GetConfig().Lecture)
	UGUIUtil.SetText(self.TextName, self.commandChallengeData:GetConfig().Name)
	UGUIUtil.SetText(self.TextNum, self.commandChallengeData:GetConfig().Reward[2])
end

function m:SetSelect(selectSate)
	self.TagSelect:SetActive(selectSate)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
