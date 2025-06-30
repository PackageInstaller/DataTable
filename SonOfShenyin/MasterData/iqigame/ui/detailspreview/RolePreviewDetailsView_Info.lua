-- chunkname: @IQIGame\\UI\\DetailsPreview\\RolePreviewDetailsView_Info.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local rolePreviewDetailsView_baseSkillDetailView = require("IQIGame.UI.DetailsPreview.RolePreviewDetailsView_BaseSkillDetailView")
local previewBaseSkillItem = {}

function previewBaseSkillItem.New(view, mainView, index)
	local obj = Clone(previewBaseSkillItem)

	obj:Init(view, mainView, index)

	return obj
end

function previewBaseSkillItem:Init(view, mainView, index)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.mainView = mainView
	self.index = index

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function previewBaseSkillItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function previewBaseSkillItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClickClick()
	end
end

function previewBaseSkillItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function previewBaseSkillItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function previewBaseSkillItem:OnButtonClickClick()
	self.mainView:ShowSkillDetailPanel(self.index, false)
end

function previewBaseSkillItem:SelectState(state)
	LuaUtility.SetGameObjectShow(self.selectImg, state)
end

function previewBaseSkillItem:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function previewBaseSkillItem:Refresh(Data)
	self.Data = Data

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.Data.skillCid)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), self.SkillIcon:GetComponent("Image"))
	LuaUtility.SetText(self.skillType, RoleDevelopmentApi:GetSkillType(skillCfg.SkillType))
	LuaUtility.SetText(self.SkillLvText, "Lv." .. self.Data.lv + self.Data.extLv)

	local skillElement = CfgSkillDetailTable[self.Data.skillCid].Element

	LuaUtility.SetGameObjectShow(self.SkillElementIcon, skillElement ~= 0)

	if skillElement ~= 0 then
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillElementImgPath(skillElement), self.SkillElementIcon:GetComponent("Image"))
	end
end

local m = {
	AttrsTable = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.onShowMaxValueChanged(isOn)
		if isOn then
			self:OnClickMaxToggle(true)
		else
			self:OnClickMaxToggle(false)
		end
	end

	self.heroStarCom = self.heroStar:GetComponent("SimpleStarComponent")

	self:InitBaseSkill()
	self:InitAttrList()
	self:InitTabList()
	self:AddListeners()
end

function m:AddListeners()
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:AddListener(self.onShowMaxValueChanged)
end

function m:RemoveListeners()
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:RemoveListener(self.onShowMaxValueChanged)
end

function m:InitTabList()
	self.TableList = UITabList.Create()

	self.TableList:AddTableItem(self.attrTabItem, function()
		return self.attrParent
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
	self.TableList:AddTableItem(self.skillTabItem, function()
		return self.skillParent
	end, function(_isOn, _view)
		self:__OnToggleValueChange(_isOn, _view)
	end, nil)
end

function m:InitAttrList()
	local attrs = {}

	for k, v in pairsCfg(CfgAttributeTable) do
		if v.Show == true and v.Type == 1 then
			table.insert(attrs, v)
		end
	end

	table.sort(attrs, function(a, b)
		return a.Sort < b.Sort
	end)

	for i = 1, #attrs do
		local attrItem

		attrItem = UnityEngine.Object.Instantiate(self.AttributeItem)
		self.AttrsTable[attrs[i].Id] = attrItem
		attrItem.transform:Find("PropertyText"):GetComponent("Text").text = attrs[i].Name

		local img = attrItem.transform:Find("Image"):GetComponent("Image")

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrs[i].ImageUrl), img)
		attrItem.transform:SetParent(self.AttributeGrid.transform, false)
	end
end

function m:InitBaseSkill()
	self.BaseSkillViews = {}

	for i = 1, 3 do
		local item = previewBaseSkillItem.New(self["SkillItem" .. i], self, i)

		table.insert(self.BaseSkillViews, item)
	end

	self.SkillDetailPanel = rolePreviewDetailsView_baseSkillDetailView.New(self.SkillDetailsRoot, self)
end

function m:OnClickMaxToggle(isMax)
	if isMax then
		self:SetRoleInfo(self.__previewHeroData.Max)
	else
		self:SetRoleInfo(self.__previewHeroData.Min)
	end
end

function m:SetData(heroData)
	self.__previewHeroData = heroData

	self:SetRoleInfo(self.__previewHeroData.Min)
	self.SkillDetailPanel:Hide()

	self.toggleShowMax:GetComponent("Toggle").isOn = false
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.heroStarCom = nil

	self.TableList:Dispose()

	for k, v in pairs(self.AttrsTable) do
		UnityEngine.GameObject.Destroy(v)
	end

	for k, v in pairs(self.BaseSkillViews) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:SetRoleInfo(roleData)
	self.heroWarlockData = roleData
	self.heroCfgData = self.heroWarlockData:GetCfg()

	local elementPath = WarlockApi:GetElementIconPath(self.heroCfgData.Elements)

	AssetUtil.LoadImage(self, elementPath, self.elementImage:GetComponent("Image"), self.OnLoadImageSucess, nil, self.elementImage)

	local professionPath = WarlockApi:GetProfessionIconPath(self.heroCfgData.Profession)

	AssetUtil.LoadImage(self, professionPath, self.professionImage:GetComponent("Image"), self.OnLoadImageSucess, nil, self.professionImage)

	local forcePath = WarlockApi:GetForceImgPath(self.heroCfgData.Forces)

	AssetUtil.LoadImage(self, forcePath, self.ForceImg:GetComponent("Image"), self.OnLoadImageSucess, nil, self.ForceImg)
	UGUIUtil.SetText(self.nameText, self.heroCfgData.Name)

	local startValue = self.heroWarlockData:GetCfg().Quality

	self.heroStarCom:UpdateView(startValue, startValue)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreachFontImg(self.heroWarlockData.breakLv), self.BreachFontImg:GetComponent("Image"), self.OnLoadImageSucess, nil, self.BreachFontImg)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreachStateImg(self.heroWarlockData.breakLv), self.BreachImgBtn:GetComponent("Image"), self.OnLoadImageSucess, nil, self.BreachImgBtn)

	local MaxLv = CfgHeroTable[self.heroWarlockData.cid].MaxLv

	UGUIUtil.SetText(self.MaxLevel, "/" .. MaxLv)
	UGUIUtil.SetText(self.CurLevelText, self.heroWarlockData.lv)
	self:UpdateHeroBaseSkill()
	self:SetRoleAttr()
	self.TableList:ChangeSelectIndex(1)
end

function m:UpdateHeroBaseSkill()
	local heroSkillPOD = self.heroWarlockData.SkillGroups

	for i = 1, 3 do
		self.BaseSkillViews[i]:Refresh(heroSkillPOD[i])
		self.BaseSkillViews[i]:SelectState(false)
	end
end

function m:SetRoleAttr()
	local Attrs = RoleDevelopmentModule.GetRoleAttrsByWarlockData(self.heroWarlockData, 1)

	for k, v in pairs(Attrs) do
		self.AttrsTable[k].transform:Find("Text"):GetComponent("Text").text = v.value
	end
end

function m:ShowSkillDetailPanel(index)
	self:CloseSkillItemSelect(index)

	local heroSkillPOD = self.heroWarlockData.SkillGroups

	self.SkillDetailPanel:SetData(heroSkillPOD[index], self.heroWarlockData)
	self.SkillDetailPanel:Show()
end

function m:CloseSkillDetailPanel()
	self:CloseSkillItemSelect(0)
end

function m:CloseSkillItemSelect(index)
	for i = 1, 3 do
		if i == index then
			self.BaseSkillViews[i]:SelectState(true)
		else
			self.BaseSkillViews[i]:SelectState(false)
		end
	end
end

function m:OnLoadImageSucess(assetName, asset, duration, userData)
	userData.gameObject:SetActive(true)

	local img = userData:GetComponent("Image")

	img:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent("RectTransform"), img)
end

function m:__OnToggleValueChange(_isOn, _view)
	LuaUtility.SetGameObjectShow(_view, _isOn)
end

return m
