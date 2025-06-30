-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerSkill\\PlaceGamePlayerSkillView.lua

local m = {
	playerSkillInfoCellPool = {}
}
local PlaceGamePlayerSkillInfoCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerSkill.PlaceGamePlayerSkillInfoCell")
local PlaceGamePlayerSkillGroupCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerSkill.PlaceGamePlayerSkillGroupCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.playerSkillGroupCell = PlaceGamePlayerSkillGroupCell.New(self.SkillGroup)

	for i = 1, 4 do
		local obj = self.SkillInfoNode.transform:Find("Mould_" .. i).gameObject

		self.playerSkillInfoCellPool[i] = PlaceGamePlayerSkillInfoCell.New(obj, i)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.placeGameSoulData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.placeGameSoulData then
		self.playerSkillGroupCell:SetData(self.placeGameSoulData)

		for i, v in pairs(self.playerSkillInfoCellPool) do
			v:SetData(self.placeGameSoulData)
		end
	end
end

function m:Dispose()
	self.playerSkillGroupCell:Dispose()

	for i, v in pairs(self.playerSkillInfoCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
