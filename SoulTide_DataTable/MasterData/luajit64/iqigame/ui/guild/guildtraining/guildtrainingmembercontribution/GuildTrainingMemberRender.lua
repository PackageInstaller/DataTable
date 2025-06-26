-- chunkname: @IQIGame\\UI\\Guild\\GuildTraining\\GuildTrainingMemberContribution\\GuildTrainingMemberRender.lua

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

function m:SetData(index, data)
	self.rankIndex = index
	self.trainingPlayerRankPOD = data

	self:UpdateView()
end

function m:UpdateView()
	if self.trainingPlayerRankPOD then
		if self.ImgBG then
			self.ImgBG:SetActive(self.rankIndex % 2 == 1)
		end

		UGUIUtil.SetText(self.TextIndex, self.rankIndex)
		UGUIUtil.SetText(self.TextName, self.trainingPlayerRankPOD.name)
		UGUIUtil.SetText(self.TextScore, self.trainingPlayerRankPOD.score)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
