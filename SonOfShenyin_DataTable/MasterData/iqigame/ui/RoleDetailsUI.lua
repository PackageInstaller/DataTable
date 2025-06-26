-- chunkname: @IQIGame\\UI\\RoleDetailsUI.lua

local NewSkillItem = require("IQIGame.UI.RoleDevelopment.Skill.NewSkillItem")
local RoleDetailsUI = Base:Extend("RoleDetailsUI", "IQIGame.Onigao.UI.RoleDetailsUI", {
	index = 1,
	StarTable = {},
	Attributes = {
		Constant.Attribute.TYPE_ATTACK,
		Constant.Attribute.TYPE_HP,
		Constant.Attribute.TYPE_DEFENSE,
		Constant.Attribute.TYPE_CRIT,
		Constant.Attribute.TYPE_CRIT_HURT
	},
	AttriTable = {},
	SkillList = {},
	WarlockDataTable = {}
})

function RoleDetailsUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	self.nameText = self._nameText:GetComponent("Text")
	self.ElementIcon = self.Element:GetComponent("Image")
	self.ProfessionIcon = self.Profession:GetComponent("Image")

	for i = 1, self.StarGrid.transform.childCount do
		self.StarTable[i] = self.StarGrid.transform:Find("Star" .. i).gameObject
	end

	self.RoleImageIcon = self.RoleImage:GetComponent("Image")

	self:AttributeRefresh()

	self.CloseBtn_Btn = self.CloseBtn:GetComponent("Button")
	self.LeftBtn = self.LeftBtn:GetComponent("Button")
	self.RightBtn = self.RightBtn:GetComponent("Button")

	local len = self.SkillsGrid.transform.childCount

	for i = 1, len do
		self.SkillList[i] = NewSkillItem.New(self.SkillsGrid.transform:GetChild(i - 1).gameObject)
	end

	self:InitDetagation()
end

function RoleDetailsUI:InitDetagation()
	function self.CloseBtn_OnClick()
		self:CloseBtnClick()
	end

	function self.RightBtn_OnClick()
		self:RightBtnOnClick()
	end

	function self.LeftBtn_OnClick()
		self:LeftBtnOnClick()
	end
end

function RoleDetailsUI:GetPreloadAssetPaths()
	return nil
end

function RoleDetailsUI:GetOpenPreloadAssetPaths(userData)
	if userData[1] ~= nil then
		table.insert(self.WarlockDataTable, userData[1])

		self.CurChooseWarlockData = self.WarlockDataTable[1]
		self.RoleImagePath = self.CurChooseWarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)

		local _t = {}

		table.insert(_t, self.RoleImagePath)

		return _t
	else
		self.RoleImagePath = nil

		return nil
	end
end

function RoleDetailsUI:IsManualShowOnOpen(userData)
	return false
end

function RoleDetailsUI:GetBGM(userData)
	return nil
end

function RoleDetailsUI:OnOpen(userData)
	if userData[1] == nil then
		for i, v in pairs(userData[2]) do
			local ItemWarlockData = WarlockModule.CreatRoleDetailsData(v)

			table.insert(self.WarlockDataTable, ItemWarlockData)
		end

		self.CurChooseWarlockData = self.WarlockDataTable[1]
	end

	self:RefreshUI()
end

function RoleDetailsUI:RefreshUI()
	self.nameText.text = self.CurChooseWarlockData.BaseData.Name

	if self.RoleImagePath then
		self:LoadImage(self.RoleImagePath, self.RoleImageIcon)
		LuaUtility.SetImageRectTransformPivot(self.RoleImageIcon:GetComponent(typeof(UnityEngine.RectTransform)), self.RoleImageIcon)
	else
		local path

		if self.CurChooseWarlockData.curSkinPODs ~= nil then
			path = self.CurChooseWarlockData:GetCurrentSkinImgPath(Constant.SkinImageType.HeroResourcesVerticalDraw)
		else
			path = self.CurChooseWarlockData:GetDefaultSkinImgPath(Constant.SkinImageType.HeroResourcesVerticalDraw)
		end

		AssetUtil.LoadImage(self, path, self.RoleImageIcon, function()
			self.RoleImageIcon.transform.localScale = Vector3.New(1, 1, 1)

			self.RoleImageIcon:SetNativeSize()
			LuaUtility.SetImageRectTransformPivot(self.RoleImageIcon:GetComponent(typeof(UnityEngine.RectTransform)), self.RoleImageIcon)
		end, nil, nil, true)
	end

	self:RefreshStar()
	self:RefreshAttribute()
	self:SetRoleSkillInfo()

	local path1 = WarlockApi:GetElementIconPath(self.CurChooseWarlockData.BaseData.Elements)

	AssetUtil.LoadImage(self, path1, self.ElementIcon, nil, nil, nil, true)

	local path2 = WarlockApi:GetProfessionIconPath(self.CurChooseWarlockData.BaseData.Profession)

	AssetUtil.LoadImage(self, path2, self.ProfessionIcon, nil, nil, nil, true)
	self.RightBtn.gameObject:SetActive(self.index ~= #self.WarlockDataTable)
	self.LeftBtn.gameObject:SetActive(self.index ~= 1)
end

function RoleDetailsUI:RefreshStar()
	for i = 1, #self.StarTable do
		if i <= self.CurChooseWarlockData.BaseData.Quality then
			self.StarTable[i]:SetActive(true)
		else
			self.StarTable[i]:SetActive(false)
		end
	end
end

function RoleDetailsUI:RefreshAttribute()
	for i = 1, table.len(self.Attributes) do
		self.AttriTable[i].BaseAtt1Addnum.text = self.CurChooseWarlockData.AttributeDir[self.Attributes[i]].attValue
	end
end

function RoleDetailsUI:SetRoleSkillInfo()
	self.SkillDatas = RoleDevelopmentModule.GetCurHeroSkill(nil, self.CurChooseWarlockData)

	for i = 1, #self.SkillList do
		self.SkillList[i]:SetData(self.SkillDatas[i], i, self.CurChooseWarlockData)
	end
end

function RoleDetailsUI:AttributeRefresh()
	local AttriLength = table.len(self.Attributes)

	for i = 1, AttriLength do
		local itemAttributeObj = UnityEngine.Object.Instantiate(self.AttributeItem.gameObject)

		itemAttributeObj:SetActive(true)

		itemAttributeObj.name = i

		itemAttributeObj.transform:SetParent(self.AttriRoot.transform, false)

		self.AttriTable[i] = {
			obj = itemAttributeObj,
			userTable = {}
		}

		local userTable = self.AttriTable[i].userTable

		LuaCodeInterface.BindOutlet(self.AttriTable[i].obj, userTable)

		self.AttriTable[i].AttMark = userTable.Image:GetComponent("Image")

		local imageurl = UIGlobalApi.IconPath .. CfgAttributeTable[self.Attributes[i]].ImageUrl

		AssetUtil.LoadImage(self, imageurl, self.AttriTable[i].AttMark, nil, nil, nil, true)

		self.AttriTable[i].BaseAtt1Name = userTable.Name:GetComponent("Text")
		self.AttriTable[i].BaseAtt1Name.text = CfgAttributeTable[self.Attributes[i]].Name
		self.AttriTable[i].BaseAtt1Addnum = userTable.Num:GetComponent("Text")
	end
end

function RoleDetailsUI:LoadImage(path, icon)
	icon.sprite = self.UIController:GetPreloadedAsset(path)
	icon.transform.localScale = Vector3.New(1, 1, 1)

	icon:SetNativeSize()
end

function RoleDetailsUI:OnClose(userData)
	self.WarlockDataTable = {}
end

function RoleDetailsUI:CloseBtnClick()
	UIModule.Close(Constant.UIControllerName.RoleDetailsUI)
end

function RoleDetailsUI:LeftBtnOnClick()
	self.index = self.index - 1
	self.CurChooseWarlockData = self.WarlockDataTable[self.index]

	self:RefreshUI()
end

function RoleDetailsUI:RightBtnOnClick()
	self.index = self.index + 1
	self.CurChooseWarlockData = self.WarlockDataTable[self.index]

	self:RefreshUI()
end

function RoleDetailsUI:OnAddListeners()
	self.CloseBtn_Btn.onClick:AddListener(self.CloseBtn_OnClick)
	self.LeftBtn.onClick:AddListener(self.LeftBtn_OnClick)
	self.RightBtn.onClick:AddListener(self.RightBtn_OnClick)
end

function RoleDetailsUI:OnRemoveListeners()
	self.CloseBtn_Btn.onClick:RemoveListener(self.CloseBtn_OnClick)
	self.LeftBtn.onClick:RemoveListener(self.LeftBtn_OnClick)
	self.RightBtn.onClick:RemoveListener(self.RightBtn_OnClick)
end

function RoleDetailsUI:OnPause()
	return
end

function RoleDetailsUI:OnResume()
	return
end

function RoleDetailsUI:OnCover()
	return
end

function RoleDetailsUI:OnReveal()
	return
end

function RoleDetailsUI:OnRefocus(userData)
	return
end

function RoleDetailsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleDetailsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleDetailsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleDetailsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleDetailsUI:OnDestroy()
	for i = 1, #self.AttriTable do
		LuaCodeInterface.ClearOutlet(self.AttriTable[i].obj, self.AttriTable[i].userTable)
	end

	self.WarlockDataTable = nil

	AssetUtil.UnloadAsset(self)
end

return RoleDetailsUI
