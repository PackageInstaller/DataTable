-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyDayCell.lua

local m = {
	icons = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	self.IconModule:SetActive(false)

	self.iconPool = UIObjectPool.New(3, function()
		return UnityEngine.Object.Instantiate(self.IconModule)
	end, function(cell)
		UnityEngine.Object.Destroy(cell)
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data, schedulePODTab)
	self.cfgMonsterTime = data

	UGUIUtil.SetText(self.TextDay, self.cfgMonsterTime.Day)
	self.Weekend:SetActive(self.cfgMonsterTime.Week > 3)

	local iconPaths = {}
	local datingIconPath

	for i, v in pairs(schedulePODTab) do
		if v.functionId > 0 then
			datingIconPath = MonsterAcademyCalendarUIApi:GetString("DatingIconPath")

			break
		end
	end

	for i = 1, #self.cfgMonsterTime.ShowImage do
		local str = self.cfgMonsterTime.ShowImage[i]

		table.insert(iconPaths, str)
	end

	if datingIconPath then
		table.insert(iconPaths, datingIconPath)
	end

	for i, v in pairs(self.icons) do
		v.transform:SetParent(self.root.UIController.transform, false)
		v:SetActive(false)
		self.iconPool:Release(v)
	end

	self.icons = {}

	for i = 1, #iconPaths do
		local str = iconPaths[i]
		local path = UIGlobalApi.GetImagePath(str)
		local image = self.iconPool:Obtain()

		AssetUtil.LoadImage(self, path, image:GetComponent("Image"))
		image:SetActive(true)
		image.transform:SetParent(self.IconView.transform, false)
		table.insert(self.icons, image)
	end

	self.IconView:SetActive(#self.icons > 0)
end

function m:SetSelect(top)
	self.SelectImg:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.icons) do
		self.iconPool:Release(v)
	end

	self.icons = {}

	self.iconPool:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
