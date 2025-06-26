-- chunkname: @IQIGame\\UI\\Maze\\UI\\SubUI\\GemstoneDetailsView.lua

local gemstoneItemDetailView = {}

function gemstoneItemDetailView.New(view)
	local obj = Clone(gemstoneItemDetailView)

	obj:Init(view)

	return obj
end

function gemstoneItemDetailView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.bgImageCom = self.NumImage:GetComponent("Image")
end

function gemstoneItemDetailView:SetData(type, value)
	AssetUtil.LoadImage(self, MazeApi:GetGemElementBG(type), self.bgImageCom, function()
		return
	end)
	LuaUtility.SetGameObjectShow(self.black, type ~= MazeModule.ElementEnum.Yin)
	LuaUtility.SetGameObjectShow(self.white, type == MazeModule.ElementEnum.Yin)
	UGUIUtil.SetText(self.ElementName, string.format(MazeApi:GetTypeTextColor(type), MazeApi:GetTypeNameAndDesc(type)))
	UGUIUtil.SetText(self.NumValue, string.format(MazeApi:GetTypeTextColor(type), value))
end

function gemstoneItemDetailView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function gemstoneItemDetailView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function gemstoneItemDetailView:Dispose()
	AssetUtil.UnloadAsset(self)

	self.bgImageCom = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	gemElementItemList = {}
}

m.GemstoneItemDetailView = gemstoneItemDetailView

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	LuaUtility.SetGameObjectShow(self.ElementPrefab, false)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(gemData)
	local mazeGemstoneCfg = CfgMazeGemstoneTable[gemData.cid]

	UGUIUtil.SetText(self.GemName, mazeGemstoneCfg.Name)

	local str = ""
	local attrs = mazeGemstoneCfg.Attr

	for i = 1, #attrs, 2 do
		local attrCfg = CfgAttributeTable[attrs[i]]
		local showValue = attrs[i + 1]

		if attrCfg.IsPer then
			showValue = showValue * 100 .. "%"
		end

		str = str .. attrCfg.Name .. "+" .. showValue .. " "
	end

	UGUIUtil.SetText(self.GemInfo, str)

	for k, v in pairs(self.gemElementItemList) do
		v:Hide()
	end

	local element = mazeGemstoneCfg.Element
	local index = 0

	for i = 1, #element do
		if element[i] ~= 0 then
			index = index + 1

			if self.gemElementItemList[index] == nil then
				local obj = GameObject.Instantiate(self.ElementPrefab)

				obj.transform:SetParent(self.ElementGrid.transform, false)

				self.gemElementItemList[index] = m.GemstoneItemDetailView.New(obj)
			end

			self.gemElementItemList[index]:Show()
			self.gemElementItemList[index]:SetData(i, element[i])
		end
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.gemElementItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
