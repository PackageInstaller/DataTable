-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogCGCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetDate(cfgTownStoryCGResData, open)
	self.Lock:SetActive(not open)

	local path = UIGlobalApi.GetHarmoniousImagePath(cfgTownStoryCGResData.CGPicture)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, LibraryStoryUIApi:GetString("HandBookName", cfgTownStoryCGResData.CGName, open))
	UGUIUtil.SetText(self.TextCondition, cfgTownStoryCGResData.UnlockCon)
	UGUIUtil.SetText(self.TextNum, tostring(cfgTownStoryCGResData.Order))

	local typePath = LibraryStoryUIApi:GetString("ImgTag", cfgTownStoryCGResData.Type, open)

	AssetUtil.LoadImage(self, typePath, self.ImgTag:GetComponent("Image"))
	AssetUtil.LoadImage(self, typePath, self.ImgTagLock:GetComponent("Image"))
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(not open)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
