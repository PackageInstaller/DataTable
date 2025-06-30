-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneCell.lua

local m = {}

function m.New(view, interactive)
	local obj = Clone(m)

	obj:Init(view, interactive)

	return obj
end

function m:Init(view, interactive)
	self.View = view

	if interactive == nil then
		interactive = true
	end

	self.Interactive = interactive

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.View:GetComponent("Button").enabled = self.Interactive

	if self.Interactive then
		self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	end
end

function m:SetData(mazeRunePOD)
	self.MazeRunePOD = mazeRunePOD

	self.View:SetActive(mazeRunePOD ~= nil)

	if mazeRunePOD == nil then
		return
	end

	self:SetDataByCID(self.MazeRunePOD.CID)
end

function m:SetDataByCID(runeCid)
	local cfgRuneData = CfgRuneTable[runeCid]

	self:SetDataByCfgData(cfgRuneData)
end

function m:SetDataByCfgData(cfgRuneData)
	self.CfgRuneData = cfgRuneData

	AssetUtil.LoadImage(self, EndlessMazeRuneMainUIApi:GetString("RuneCellQualityImage", cfgRuneData.Quality), self.QualityImg:GetComponent("Image"), nil, nil, nil, true)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgRuneData.Icon), self.Icon:GetComponent("Image"), nil, nil, nil, true)

	local typeIconPath = EndlessMazeRuneMainUIApi:GetString("RuneCellFeatureImage", cfgRuneData.Feature)

	self.TypeImg:SetActive(cfgRuneData.Feature ~= 0 and typeIconPath ~= nil)

	if cfgRuneData.Feature ~= 0 and typeIconPath ~= nil then
		AssetUtil.LoadImage(self, typeIconPath, self.TypeImg:GetComponent("Image"), nil, nil, nil, true)
	end

	local isUnlock = PlayerModule.IsRuneUnlock(self.CfgRuneData.Id)

	self.UnlockImg:SetActive(not isUnlock)
	self.Icon:GetComponent("GrayComponent"):SetGray(not isUnlock)
end

function m:OnClick()
	local isUnlock = PlayerModule.IsRuneUnlock(self.CfgRuneData.Id)

	if isUnlock then
		UIModule.Open(Constant.UIControllerName.RuneTipsUI, Constant.UILayer.Tooltip, {
			runeCid = self.CfgRuneData.Id,
			mazeRunePOD = self.MazeRunePOD
		})
	else
		NoticeModule.ShowNoticeNoCallback(70000002, MiscApi:GetString("EndlessMazeDifficultyText", self.CfgRuneData.UnlockInstance))
	end
end

function m:Show()
	self:SetActive(true)
end

function m:Hide()
	self:SetActive(false)
end

function m:SetActive(value)
	for i = 0, self.View.transform.childCount - 1 do
		self.View.transform:GetChild(i).gameObject:SetActive(value)
	end

	local isUnlock = PlayerModule.IsRuneUnlock(self.CfgRuneData.Id)

	self.UnlockImg:SetActive(value and not isUnlock)
	self.Icon:GetComponent("GrayComponent"):SetGray(value and not isUnlock)
end

function m:Reset()
	self:SetActive(true)
end

function m:GetRoot()
	return self.Root
end

function m:Dispose()
	if self.Interactive then
		self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
