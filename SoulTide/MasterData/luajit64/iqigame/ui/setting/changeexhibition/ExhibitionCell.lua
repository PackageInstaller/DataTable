-- chunkname: @IQIGame\\UI\\Setting\\ChangeExhibition\\ExhibitionCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextTag1, ChangeExhibitionUIApi:GetString("TextTag1"))
	UGUIUtil.SetText(self.TextTag2, ChangeExhibitionUIApi:GetString("TextTag2"))
end

function m:SetData(itemData, pos)
	self.itemData = itemData
	self.pos = pos

	local path = UIGlobalApi.GetIconPath(CfgItemTable[self.itemData.cid].Icon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

	local bgState = self:GetBgState()

	self.ImgBg1:SetActive(bgState == 1)
	self.ImgBg2:SetActive(bgState == 2)
	self.ImgBg3:SetActive(bgState == 3)
	self.Tag1:SetActive(bgState == 1)
	self.Tag2:SetActive(bgState == 2)
end

function m:GetBgState()
	local number = 3

	if self.itemData and PlayerModule.PlayerInfo.showCollectItems then
		for i, v in pairs(PlayerModule.PlayerInfo.showCollectItems) do
			if v == self.itemData.cid then
				number = i == self.pos and 2 or 1
			end
		end
	end

	return number
end

function m:SetSelect(top)
	self.Choose:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
