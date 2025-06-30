-- chunkname: @IQIGame\\UI\\Activity\\CupVoting\\AdvancedStageGroupHeadCell.lua

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
	self:ShowTag(false)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	return
end

function m:SetData(id)
	local cfgData = CfgCupMatchVoteGroupTable[id]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.HeadIcon), self.ImgIcon:GetComponent("Image"))
end

function m:ShowTag(top)
	self.Tag:SetActive(top)
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
