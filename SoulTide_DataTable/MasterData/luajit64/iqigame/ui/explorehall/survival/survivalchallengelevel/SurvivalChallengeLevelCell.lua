-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalChallengeLevel\\SurvivalChallengeLevelCell.lua

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
	self.levelData = data

	self:UpDateView()
end

function m:UpDateView()
	if self.levelData then
		local path = UIGlobalApi.GetImagePath(self.levelData:GetCfgData().HeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextName, self.levelData:GetCfgData().Name)

		local openCount = 0

		for i = 1, 3 do
			local isOpen = self.levelData:RewardIsComplete(i)

			self["Star" .. i].transform:Find("Image_02").gameObject:SetActive(isOpen)

			if isOpen then
				openCount = openCount + 1
			end
		end

		self.TextPer:SetActive(openCount < 3)
		self.TextPerMax:SetActive(openCount == 3)
		self.ImgRank:SetActive(openCount == 3)
		UGUIUtil.SetText(self.TextPer, string.format("%0.2f", openCount / 3 * 100) .. "%")
		self.FlyType:SetActive(self.levelData:GetCfgData().Type == 1)
		self.PlotType:SetActive(self.levelData:GetCfgData().Type == 2)
	end
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
