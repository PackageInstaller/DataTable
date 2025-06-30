-- chunkname: @IQIGame\\UI\\Guild\\GuildTask\\GuildActiveRewardCell.lua

local m = {
	isMySelf = false,
	guildRewardItemCells = {}
}
local GuildActiveRewardItemCell = require("IQIGame.UI.Guild.GuildTask.GuildActiveRewardItemCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, top)
	local obj = Clone(m)

	obj:Init(view, top)

	return obj
end

function m:Init(view, top)
	self.View = view
	self.isMySelf = top

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.TextCurrent then
		UGUIUtil.SetText(self.TextCurrent, GuildActiveRewardUIApi:GetString("TextCurrent"))
		self.TextCurrent:SetActive(self.isMySelf)
	end

	if self.TextEmptyCurrent then
		UGUIUtil.SetText(self.TextEmptyCurrent, GuildActiveRewardUIApi:GetString("TextEmptyCurrent"))
	end

	self.RewardMould:SetActive(false)

	self.guildRewardItemCellPool = UIObjectPool.New(5, function()
		local cell = GuildActiveRewardItemCell.New(UnityEngine.Object.Instantiate(self.RewardMould))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data)
	self.cfgData = data

	if self.cfgData then
		self.Info:SetActive(true)

		local path = UIGlobalApi.GetImagePath(self.cfgData.Image)

		AssetUtil.LoadImage(self, path, self.ImgBox:GetComponent("Image"))
		UGUIUtil.SetText(self.TextPoint, GuildActiveRewardUIApi:GetString("TextPoint", self.cfgData.LevelNeed))
		UGUIUtil.SetText(self.TextGuildGold, GuildActiveRewardUIApi:GetString("TextGuildGold", self.cfgData.GuildFond))

		for i, v in pairs(self.guildRewardItemCells) do
			v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
			v.View:SetActive(false)
			self.guildRewardItemCellPool:Release(v)
		end

		self.guildRewardItemCells = {}

		for i = 1, #self.cfgData.MemberReward, 2 do
			local id = self.cfgData.MemberReward[i]
			local num = self.cfgData.MemberReward[i + 1]
			local cell = self.guildRewardItemCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.Rewards.transform, false)
			cell:SetData(id, num)
			table.insert(self.guildRewardItemCells, cell)
		end
	else
		self.Info:SetActive(false)
	end

	if self.EmptyCurrent then
		self.EmptyCurrent:SetActive(self.cfgData == nil)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i, v in pairs(self.guildRewardItemCells) do
		self.guildRewardItemCellPool:Release(v)
	end

	self.guildRewardItemCells = {}

	self.guildRewardItemCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
