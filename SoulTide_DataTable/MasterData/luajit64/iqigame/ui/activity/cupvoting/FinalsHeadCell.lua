-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\FinalsHeadCell.lua

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

function m:SetData(data, index)
	local cfgData = CfgCupMatchVoteGroupTable[data.cid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.HeadIcon), self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextRank, ActivityUIApi:GetString("CupVotingTextRank", index))
	UGUIUtil.SetText(self.TextVotesNum, ActivityUIApi:GetString("CupVotingTextVotesNum", data.voteNum))
	self.Tag:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
