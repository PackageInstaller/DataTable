-- chunkname: @IQIGame\\UI\\MazeDetail\\MazeRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI)

	if self.FirstPassFlag ~= nil then
		UGUIUtil.SetTextInChildren(self.FirstPassFlag, MazeDetailUIApi:GetString("FirstPassFlagText"))
	end

	if self.UncertainFlag ~= nil then
		UGUIUtil.SetTextInChildren(self.UncertainFlag, MazeDetailUIApi:GetString("UncertainFlagText"))
	end

	if self.SpecialDropFlag ~= nil then
		UGUIUtil.SetTextInChildren(self.SpecialDropFlag, MazeDetailUIApi:GetString("SpecialDropFlagText"))
	end
end

function m:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
	self.View:SetActive(itemCid ~= 0)
	self.ItemCell:SetItemByCID(itemCid, itemNum)

	if self.FirstPassFlag ~= nil then
		self.FirstPassFlag:SetActive(isFirstPassReward)
	end

	if self.UncertainFlag ~= nil then
		self.UncertainFlag:SetActive(isUncertain)
	end
end

function m:RefreshIsSpecialDrop(itemCid)
	self.View:SetActive(itemCid ~= 0)

	if itemCid == 0 then
		return
	end

	local cfgItemData = CfgItemTable[itemCid]

	self.SpecialDropFlag:SetActive(cfgItemData.Quality == 5)
end

function m:Dispose()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
