-- chunkname: @IQIGame\\UI\\Library\\LibraryActionStoryPlaceCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.townLibraryStoryData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function m:Update()
	local isLock = self.townLibraryStoryData:IsLock()

	self.Lock:SetActive(not isLock)

	local cfgStoryBook = CfgTownStoryBookTable[self.townLibraryStoryData.cfgID]
	local path = UIGlobalApi.GetImagePath(cfgStoryBook.ButtonImage)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfgStoryBook.Name)
	UGUIUtil.SetText(self.TextEngName, cfgStoryBook.EngName)
end

function m:Clear()
	self.goView:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return m
