-- chunkname: @IQIGame\\UI\\Common\\CommonHeroScreenView.lua

local m = {
	ForceID = 150,
	ProfessionID = 120,
	ElementID = 100,
	itemObjTables = {},
	ScreenDataList = {},
	TempScreenDataList = {}
}

function m.New(view, uiController, callback)
	local obj = Clone(m)

	obj:Init(view, uiController, callback)

	return obj
end

function m:Init(view, uiController, callback)
	self.View = view
	self.uiController = uiController
	self.CallBack = callback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnTabClick(isOn)
		self:OnTableClick(isOn)
	end

	self.elementTabGroupCom = self.ElementTabGroup:GetComponent("ToggleGroup")
	self.professionTabGroupCom = self.ProfessionTabGroup:GetComponent("ToggleGroup")
	self.forceTabGroupCom = self.ForceTabGroup:GetComponent("ToggleGroup")

	self:InitStaticText()
	self:InitScreen()
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:InitStaticText()
	UGUIUtil.SetText(self.ElementTitleText, CommonHeroScreenViewApi:GetTipsText(CfgHeroScreenTable[self.ElementID].TipsID))
	UGUIUtil.SetText(self.ProfessionText, CommonHeroScreenViewApi:GetTipsText(CfgHeroScreenTable[self.ProfessionID].TipsID))
	UGUIUtil.SetText(self.ForceText, CommonHeroScreenViewApi:GetTipsText(CfgHeroScreenTable[self.ForceID].TipsID))
end

function m:SetData(screenDataList)
	self.ScreenDataList = screenDataList
end

function m:InitScreen()
	self.ElementType = -1
	self.ProfessionType = -1
	self.ForceType = -1

	self:CreateElementScreenItem()
	self:CreateProfessionScreenItem()
	self:CreateForceScreenItem()
end

function m:OnTableClick(isOn)
	if isOn then
		local currentTarget = self.uiController:GetCurrentTarget()

		for k, v in pairs(self.itemObjTables) do
			for i = 1, #v do
				if v[i].gameObject == currentTarget then
					self:ToggleTo(k, i)

					return
				end
			end
		end
	end
end

function m:ToggleTo(fatherID, index)
	local screenCfg = self:GetScreenCfgByScreenID(fatherID)[index]

	if fatherID == self.ElementID then
		self.ElementType = screenCfg.RelationID
	elseif fatherID == self.ProfessionID then
		self.ProfessionType = screenCfg.RelationID
	elseif fatherID == self.ForceID then
		self.ForceType = screenCfg.RelationID
	end

	self:ScreenList()
end

function m:ScreenList()
	self.TempScreenDataList = Clone(self.ScreenDataList)

	if self.ElementType ~= -1 then
		for i = #self.TempScreenDataList, 1, -1 do
			if CfgHeroTable[self.TempScreenDataList[i].cid].Elements ~= self.ElementType then
				table.remove(self.TempScreenDataList, i)
			end
		end
	end

	if self.ProfessionType ~= -1 then
		for i = #self.TempScreenDataList, 1, -1 do
			if CfgHeroTable[self.TempScreenDataList[i].cid].Profession ~= self.ProfessionType then
				table.remove(self.TempScreenDataList, i)
			end
		end
	end

	if self.ForceType ~= -1 then
		for i = #self.TempScreenDataList, 1, -1 do
			if CfgHeroTable[self.TempScreenDataList[i].cid].Forces ~= self.ForceType then
				table.remove(self.TempScreenDataList, i)
			end
		end
	end

	if self.CallBack ~= nil then
		self.CallBack(self.TempScreenDataList)
	end
end

function m:RefreshScreen()
	self:ScreenList()
end

function m:CreateScreenItem(cfgDatas, parent)
	self.itemObjTables[cfgDatas[1].LastID] = {}

	for i = 1, #cfgDatas do
		local itemObj = UnityEngine.Object.Instantiate(self.TabPrefab)

		itemObj.transform:SetParent(parent.transform, false)
		self:SetTabItemData(itemObj, cfgDatas[i])
		table.insert(self.itemObjTables[cfgDatas[i].LastID], itemObj)
	end
end

function m:SetTabItemData(tabItem, cfgData)
	local tabItemToggle = tabItem:GetComponent("Toggle")

	if cfgData.LastID == self.ElementID then
		tabItemToggle.group = self.elementTabGroupCom
	elseif cfgData.LastID == self.ProfessionID then
		tabItemToggle.group = self.professionTabGroupCom
	elseif cfgData.LastID == self.ForceID then
		tabItemToggle.group = self.forceTabGroupCom
	end

	tabItem:GetComponent("ToggleHelperComponent").text = CommonHeroScreenViewApi:GetTipsText(cfgData.TipsID)
	tabItemToggle.isOn = cfgData.Checked

	tabItemToggle.onValueChanged:AddListener(self.DelegateOnTabClick)
end

function m:CreateElementScreenItem()
	local elementCfg = self:GetScreenCfgByScreenID(self.ElementID)

	self:CreateScreenItem(elementCfg, self.ElementTabGroup)
end

function m:CreateProfessionScreenItem()
	local professionCfg = self:GetScreenCfgByScreenID(self.ProfessionID)

	self:CreateScreenItem(professionCfg, self.ProfessionTabGroup)
end

function m:CreateForceScreenItem()
	local forceCfg = self:GetScreenCfgByScreenID(self.ForceID)

	self:CreateScreenItem(forceCfg, self.ForceTabGroup)
end

function m:GetScreenCfgByScreenID(screenID)
	local cfgDatas = {}

	for k, v in pairsCfg(CfgHeroScreenTable) do
		if v.LastID == screenID then
			table.insert(cfgDatas, v)
		end
	end

	table.sort(cfgDatas, function(a, b)
		return a.Index < b.Index
	end)

	return cfgDatas
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.itemObjTables) do
		for i = 1, #v do
			v[i].gameObject:GetComponent("Toggle").onValueChanged:RemoveAllListeners()
			UnityEngine.Object.Destroy(v[i].gameObject)
		end
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
