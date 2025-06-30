-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\VotingSystemRankRenderCell.lua

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
	UGUIUtil.SetText(self.RankText, index + 1)
	UGUIUtil.SetText(self.TeamText, data.groupName)
	UGUIUtil.SetText(self.NameText, CfgCupMatchVoteGroupTable[data.cid].OptionName)
	UGUIUtil.SetText(self.NoteNumText, data.voteNum)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
