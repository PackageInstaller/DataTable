-- chunkname: @IQIGame\\UI\\Library\\LibraryEquipInfoView.lua

local LibraryEquipInfoView = {
	isSelectMaxLv = false,
	isSelectMaxStar = false,
	comeBtnTab = {},
	EquipTipCells = {},
	tipNames = {},
	skinCidList = {},
	SkinCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryEquipComBtnCell = require("IQIGame.UI.Library.LibraryEquipComBtnCell")
local LibraryEquipInfoTipCell = require("IQIGame.UI.Library.LibraryEquipInfoTipCell")
local LibraryEquipSkillCell = require("IQIGame.UI.Library.LibraryEquipSkillCell")

function LibraryEquipInfoView.New(view, root)
	local obj = Clone(LibraryEquipInfoView)

	obj:Init(view, root)

	return obj
end

function LibraryEquipInfoView:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 7 do
		UGUIUtil.SetText(self["TextTitle" .. i], LibraryEquipApi:GetString("EquipInfoTitles", i))
	end

	UGUIUtil.SetText(self.TextMaxLv, LibraryEquipApi:GetString("TextMaxLv"))
	UGUIUtil.SetText(self.TextMaxStar, LibraryEquipApi:GetString("TextMaxStar"))

	self.toggleMaxLv = self.ToggleMaxLv:GetComponent("Toggle")
	self.toggleMaxStar = self.ToggleMaxStar:GetComponent("Toggle")

	function self.delegateOnToggleMaxLv(isOn)
		self:OnToggleMaxLv(isOn)
	end

	function self.delegateOnToggleMaxStar(isOn)
		self:OnToggleMaxStar(isOn)
	end

	self.EquipTipPool = UIObjectPool.New(8, function()
		local cell = LibraryEquipInfoTipCell.New(UnityEngine.Object.Instantiate(self.GridMouldContent4))

		return cell
	end, function(cell)
		cell:Dispose()

		local v = cell.View

		UnityEngine.Object.Destroy(v)
	end)
	self.scrollList = self.EquipSkinScroll:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function LibraryEquipInfoView:AddListener()
	self.toggleMaxLv.onValueChanged:AddListener(self.delegateOnToggleMaxLv)
	self.toggleMaxStar.onValueChanged:AddListener(self.delegateOnToggleMaxStar)
end

function LibraryEquipInfoView:RemoveListener()
	self.toggleMaxLv.onValueChanged:RemoveListener(self.delegateOnToggleMaxLv)
	self.toggleMaxStar.onValueChanged:RemoveListener(self.delegateOnToggleMaxStar)
end

function LibraryEquipInfoView:UpdateView(data)
	self.equipData = data

	if self.equipData then
		self:ShowMsg()
	end
end

function LibraryEquipInfoView:ShowSelectSkin()
	for i, v in pairs(self.SkinCells) do
		if v.skinCid == self.selectSkin then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	if self.selectSkin > 0 then
		local currentSkinCfgData = CfgSoulPaintingSkinTable[self.selectSkin]

		self.root:ChangeSkinMsg(currentSkinCfgData)
		UGUIUtil.SetText(self.InfoView1.transform:Find("Move/Text_01").gameObject, currentSkinCfgData.Desc)

		local unlock = EquipModule.GetSkinState(self.selectSkin) ~= nil

		self:ShowStory(currentSkinCfgData.HiddenStory, true, unlock)
	else
		self.root:ChangeSkinMsg()
		UGUIUtil.SetText(self.InfoView1.transform:Find("Move/Text_01").gameObject, self.equipData.cfgInfo.Describe)
		self:ShowStory(self.equipData.cfgInfo.HiddenStory, false, false)
	end
end

function LibraryEquipInfoView:OnSelectedGridCell(cell)
	local clickSkin = self.skinCidList[cell.index + 1]

	if self.selectSkin == clickSkin then
		self.selectSkin = 0
	else
		self.selectSkin = clickSkin
	end

	self:ShowSelectSkin()
end

function LibraryEquipInfoView:OnRenderGridCell(cell)
	local skinCell = self.SkinCells[cell.gameObject:GetInstanceID()]

	if skinCell == nil then
		skinCell = LibraryEquipSkillCell.New(cell.gameObject)
		self.SkinCells[cell.gameObject:GetInstanceID()] = skinCell
	end

	local skin = self.skinCidList[cell.index + 1]

	skinCell:SetData(skin)
	skinCell:SetSelect(false)
end

function LibraryEquipInfoView:ShowMsg()
	self.skinCidList = EquipModule.GetEquipSkins(self.equipData.cfgID)

	local isShow = #self.skinCidList > 0

	self.Title7:SetActive(isShow)
	self.InfoView7:SetActive(isShow)

	if isShow then
		self.selectSkin = 0

		self.scrollList:Refresh(#self.skinCidList)
		self:ShowSelectSkin()
	end

	isShow = self.equipData.cfgInfo.Describe ~= nil and self.equipData.cfgInfo.Describe ~= "" or isShow

	self.Title1:SetActive(isShow)
	self.InfoView1:SetActive(isShow)

	if isShow and #self.skinCidList == 0 then
		UGUIUtil.SetText(self.InfoView1.transform:Find("Move/Text_01").gameObject, self.equipData.cfgInfo.Describe)
	end

	self:ShowBilityMsg()

	isShow = #self.equipData.cfgInfo.Source > 0

	self.Title5:SetActive(isShow)
	self.InfoView5:SetActive(isShow)
	self.GridMould5:SetActive(false)

	for i, v in pairs(self.comeBtnTab) do
		v:Dispose()
	end

	self.comeBtnTab = {}

	for k, v in pairs(self.equipData.cfgInfo.Source) do
		local obj = UnityEngine.Object.Instantiate(self.GridMould5)

		obj.transform:SetParent(self.Grid5.transform, false)
		obj:SetActive(true)

		local comeCell = LibraryEquipComBtnCell.New(obj)

		comeCell:SetData(v)
		table.insert(self.comeBtnTab, comeCell)
	end

	if #self.skinCidList == 0 then
		self:ShowStory(self.equipData.cfgInfo.HiddenStory, false, false)
	end
end

function LibraryEquipInfoView:ShowStory(hiddenStory, isSkin, skinUnlock)
	local isShow = #hiddenStory > 0

	self.Title6:SetActive(isShow)
	self.InfoView6:SetActive(isShow)
	self.GridMouldTitle6:SetActive(false)
	self.GridMouldContent6:SetActive(false)

	for i = 2, self.Grid6.transform.childCount - 1 do
		local obj = self.Grid6.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for i = 1, #hiddenStory do
		local obj = UnityEngine.Object.Instantiate(self.GridMouldTitle6)

		obj.transform:SetParent(self.Grid6.transform, false)
		obj:SetActive(true)
		UGUIUtil.SetText(obj.transform:Find("Text").gameObject, LibraryEquipApi:GetString("HiddenStoryTitle", i))

		local objContent = UnityEngine.Object.Instantiate(self.GridMouldContent6)

		objContent.transform:SetParent(self.Grid6.transform, false)
		objContent:SetActive(true)

		local str = hiddenStory[i]

		if isSkin then
			if skinUnlock then
				if i > self.equipData.maxStart then
					str = LibraryEquipApi:GetString("HiddenStoryValue", i)
				end
			else
				str = LibraryEquipApi:GetString("HiddenStorySkinValue")
			end
		elseif i > self.equipData.maxStart then
			str = LibraryEquipApi:GetString("HiddenStoryValue", i)
		end

		UGUIUtil.SetText(objContent.transform:Find("Text").gameObject, str)
	end
end

function LibraryEquipInfoView:ShowBilityMsg()
	local minCfg, maxCfg = self:GetCfgData()
	local maxLv = CfgDiscreteDataTable[6520037].Data[self.equipData.cfgInfo.Quality]
	local mainBiLity = {}

	if self.isSelectMaxStar and self.isSelectMaxLv then
		for i = 1, #maxCfg.MainBility do
			local id = maxCfg.MainBility[i]
			local value = maxCfg.MainBilityNum[i] + maxCfg.LevelBilityUPNum[i] * maxLv

			mainBiLity[id] = value
		end
	elseif self.isSelectMaxStar and not self.isSelectMaxLv then
		for i = 1, #maxCfg.MainBility do
			local id = maxCfg.MainBility[i]
			local value = maxCfg.MainBilityNum[i] + maxCfg.LevelBilityUPNum[i]

			mainBiLity[id] = value
		end
	elseif not self.isSelectMaxStar and self.isSelectMaxLv then
		for i = 1, #minCfg.MainBility do
			local id = minCfg.MainBility[i]
			local value = minCfg.MainBilityNum[i] + minCfg.LevelBilityUPNum[i] * maxLv

			mainBiLity[id] = value
		end
	else
		for i = 1, #minCfg.MainBility do
			local id = minCfg.MainBility[i]
			local value = minCfg.MainBilityNum[i] + minCfg.LevelBilityUPNum[i]

			mainBiLity[id] = value
		end
	end

	self.GridMould2:SetActive(false)

	for i = 1, self.Grid2.transform.childCount - 1 do
		local obj = self.Grid2.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for k, v in pairs(mainBiLity) do
		local obj = UnityEngine.Object.Instantiate(self.GridMould2)

		obj.transform:SetParent(self.Grid2.transform, false)
		obj:SetActive(true)

		local attributeName = AttributeModule.GetAttName(k)
		local attributeValue = AttributeModule.GetAttShowValue(k, v)

		UGUIUtil.SetText(obj.transform:Find("Text_01").gameObject, attributeName)
		UGUIUtil.SetText(obj.transform:Find("Text_02").gameObject, attributeValue)
	end

	local isShow = self.equipData.cfgInfo.Describe ~= nil and self.equipData.cfgInfo.Describe ~= ""
	local index = 1

	if self.isSelectMaxStar then
		index = maxCfg.QualityLevel
	end

	local pabilityTab = {}

	for i = 1, 2 do
		local tab = self.equipData.cfgInfo.PabilityID[i]

		if tab then
			local id = tab[index]

			if id then
				table.insert(pabilityTab, id)
			end
		end
	end

	isShow = #pabilityTab > 0

	self.Title3:SetActive(isShow)
	self.InfoView3:SetActive(isShow)
	self.GridMould3:SetActive(false)

	for i = 1, self.Grid3.transform.childCount - 1 do
		local obj = self.Grid3.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	for k, v in pairs(pabilityTab) do
		local obj = UnityEngine.Object.Instantiate(self.GridMould3)

		obj.transform:SetParent(self.Grid3.transform, false)
		obj:SetActive(true)

		local cfgBility = CfgPabilityTable[v]

		UGUIUtil.SetText(obj.transform:Find("Text_01").gameObject, LibraryEquipApi:GetString("TextAbility", cfgBility.Describe))
	end

	pabilityTab = {}

	for i = 3, 4 do
		local tab = self.equipData.cfgInfo.PabilityID[i]

		if tab then
			local id = tab[index]

			if id then
				table.insert(pabilityTab, id)
			end
		end
	end

	isShow = #pabilityTab > 0

	self.Title4:SetActive(isShow)
	self.InfoView4:SetActive(isShow)
	self.GridMouldTitle4:SetActive(false)
	self.GridMouldContent4:SetActive(false)

	for i, v in pairs(self.tipNames) do
		UnityEngine.Object.Destroy(v)
	end

	self.tipNames = {}

	for i, v in pairs(self.EquipTipCells) do
		v.View.transform:SetParent(self.root.UIController.transform, false)
		v.View:SetActive(false)
		self.EquipTipPool:Release(v)
	end

	self.EquipTipCells = {}

	for k, v in pairs(pabilityTab) do
		local cfgBility = CfgPabilityTable[v]
		local obj = UnityEngine.Object.Instantiate(self.GridMouldTitle4)

		obj.transform:SetParent(self.Grid4.transform, false)
		obj:SetActive(true)
		UGUIUtil.SetText(obj.transform:Find("Text").gameObject, cfgBility.Name)
		table.insert(self.tipNames, obj)

		local cell = self.EquipTipPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.Grid4.transform, false)
		cell:SetData(cfgBility.Describe)
		table.insert(self.EquipTipCells, cell)
	end
end

function LibraryEquipInfoView:GetCfgData()
	local minStarCfg, maxStarCfg
	local tab = {}

	for i, v in pairsCfg(CfgSoulPaintingQualityTable) do
		if v.PaintingId == self.equipData.cfgID then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.QualityLevel < b.QualityLevel
	end)

	minStarCfg = tab[1]
	maxStarCfg = tab[#tab]

	return minStarCfg, maxStarCfg
end

function LibraryEquipInfoView:OnToggleMaxLv(isOn)
	self.isSelectMaxLv = isOn

	self:ShowBilityMsg()
end

function LibraryEquipInfoView:OnToggleMaxStar(isOn)
	self.isSelectMaxStar = isOn

	self:ShowBilityMsg()
end

function LibraryEquipInfoView:Open()
	self.isSelectMaxLv = false
	self.isSelectMaxStar = false
	self.toggleMaxStar.isOn = self.isSelectMaxStar
	self.toggleMaxLv.isOn = self.isSelectMaxLv

	self.View:SetActive(true)
end

function LibraryEquipInfoView:Close()
	self.View:SetActive(false)
end

function LibraryEquipInfoView:Dispose()
	for i, v in pairs(self.comeBtnTab) do
		v:Dispose()
	end

	for i, v in pairs(self.EquipTipCells) do
		self.EquipTipPool:Release(v)
	end

	self.EquipTipCells = {}

	self.EquipTipPool:Dispose()

	for i, v in pairs(self.SkinCells) do
		v:Dispose()
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryEquipInfoView
