-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyMessage\\MessageCell.lua

local m = {
	showStr = ""
}

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

function m:SetData(cfgMessageData, selectOption)
	self.cfgData = cfgMessageData
	self.selectOption = selectOption

	self:UpdateView()
end

function m:UpdateView()
	if #self.cfgData.NextID > 1 then
		if self.selectOption and self.selectOption > 0 then
			local index = table.indexOf(self.cfgData.NextID, self.selectOption)

			self.showStr = self.cfgData.Contents[index]
		else
			self.showStr = ""
		end
	else
		self.showStr = self.cfgData.Contents[1]
	end

	if PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
		self.showStr = string.gsub(self.showStr, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
	end

	UGUIUtil.SetText(self.Context, self.showStr)

	local path = UIGlobalApi.GetImagePath(self.cfgData.HeadImage)

	AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
