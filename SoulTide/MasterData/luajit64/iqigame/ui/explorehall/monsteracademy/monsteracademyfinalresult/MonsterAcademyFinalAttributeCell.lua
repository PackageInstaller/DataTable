-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyFinalResult\\MonsterAcademyFinalAttributeCell.lua

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

function m:SetData(attributeID)
	self.attributeID = attributeID

	self:UpdateView()
end

function m:UpdateView()
	local value = MonsterAcademyModule.SaveDataDetailPOD.basePOD.baseProps[self.attributeID]

	if value == nil then
		value = 0
	end

	local cfgAttr = CfgGalgameMonsterAttributeTable[self.attributeID]

	UGUIUtil.SetText(self.TextAttrName, cfgAttr.Name)
	UGUIUtil.SetText(self.Attribute, MonsterAcademyFinalResultUIApi:GetString("Attribute", value))
	UGUIUtil.SetText(self.AttrState, MonsterAcademyFinalResultUIApi:GetString("AttrState", value))

	if cfgAttr.Icon ~= nil and cfgAttr.Icon ~= "" then
		local path = UIGlobalApi.GetImagePath(cfgAttr.Icon)

		AssetUtil.LoadImage(self, path, self.ImgAttr:GetComponent("Image"))
	end

	local star = MonsterAcademyFinalResultUIApi:GetString("AttrStar", value)

	for i = 1, 5 do
		local show = i <= star

		self["Star" .. i].transform:Find("Image_02").gameObject:SetActive(show)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
