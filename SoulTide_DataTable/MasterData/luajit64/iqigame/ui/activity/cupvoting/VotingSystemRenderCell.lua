-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\VotingSystemRenderCell.lua

local m = {
	top = false
}

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

function m:SetData(index, memberData)
	self.index = index
	self.memberData = memberData

	local cfgData = CfgCupMatchVoteGroupTable[self.memberData.cid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.ImageShow), self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextRank, index)
	UGUIUtil.SetText(self.TextValue, VotingSystemVoteUIApi:GetString("TextValue", self.memberData.voteNum))
end

function m:Select(top)
	self.top = top

	self.CheckNode:SetActive(self.top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.memberData = nil
	self.View = nil
end

return m
