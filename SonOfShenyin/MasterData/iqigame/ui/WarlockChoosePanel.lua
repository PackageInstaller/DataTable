-- chunkname: @IQIGame\\UI\\WarlockChoosePanel.lua

local warlockListCell = require("IQIGame.UI.WarlockList.WarlockListCell")
local WarlockChoosePanel = Base:Extend("WarlockChoosePanel", "IQIGame.Onigao.UI.WarlockChoosePanel", {
	CurSortType = 1,
	isTypeScreen = false,
	isAllScreen = false,
	OpenType = "",
	isSizeShow = false,
	cellList = {},
	CurScreentable = {},
	SortWarklockDataList = {}
})

require("IQIGame.Common.TapContent")

function WarlockChoosePanel:OnInit()
	LuaCodeInterface.BindOutlet(self.AllScreen, self)
	LuaCodeInterface.BindOutlet(self.TypeScreen, self)
	LuaCodeInterface.BindOutlet(self.ElementTapRoot, self)
	LuaCodeInterface.BindOutlet(self.ProfessionTapRoot, self)
	LuaCodeInterface.BindOutlet(self.InfluenceTapRoot, self)
	LuaCodeInterface.BindOutlet(self.OtherLuaOutlet, self)
	self:InitDelegates()
	self:Initialize()
	UGUIUtil.SetText(self.ElementDes_1_1, WarlockApi:GetTextTitle_1())
	UGUIUtil.SetText(self.ElementDes_1_2, WarlockApi:GetTextTitle_1())
	UGUIUtil.SetText(self.ElementDes_2_1, WarlockApi:GetTextTitle_2())
	UGUIUtil.SetText(self.ElementDes_2_2, WarlockApi:GetTextTitle_2())
	UGUIUtil.SetText(self.ElementDes_3_1, WarlockApi:GetTextTitle_3())
	UGUIUtil.SetText(self.ElementDes_3_2, WarlockApi:GetTextTitle_3())
	UGUIUtil.SetText(self.ElementDes_4_1, WarlockApi:GetTextTitle_4())
	UGUIUtil.SetText(self.ElementDes_4_2, WarlockApi:GetTextTitle_4())
	UGUIUtil.SetText(self.PrefessionDes_1_1, WarlockApi:PrefessionDes_1())
	UGUIUtil.SetText(self.PrefessionDes_1_2, WarlockApi:PrefessionDes_1())
	UGUIUtil.SetText(self.PrefessionDes_2_1, WarlockApi:PrefessionDes_2())
	UGUIUtil.SetText(self.PrefessionDes_2_2, WarlockApi:PrefessionDes_2())
	UGUIUtil.SetText(self.PrefessionDes_3_1, WarlockApi:PrefessionDes_3())
	UGUIUtil.SetText(self.PrefessionDes_3_2, WarlockApi:PrefessionDes_3())
	UGUIUtil.SetText(self.PrefessionDes_4_1, WarlockApi:PrefessionDes_4())
	UGUIUtil.SetText(self.PrefessionDes_4_2, WarlockApi:PrefessionDes_4())
	UGUIUtil.SetText(self.InfluenceDes_1_1, WarlockApi:InfluenceDes_1())
	UGUIUtil.SetText(self.InfluenceDes_1_2, WarlockApi:InfluenceDes_1())
	UGUIUtil.SetText(self.InfluenceDes_2_1, WarlockApi:InfluenceDes_2())
	UGUIUtil.SetText(self.InfluenceDes_2_2, WarlockApi:InfluenceDes_2())
	UGUIUtil.SetText(self.InfluenceDes_3_1, WarlockApi:InfluenceDes_3())
	UGUIUtil.SetText(self.InfluenceDes_3_2, WarlockApi:InfluenceDes_3())
	UGUIUtil.SetText(self.ElementDes, WarlockApi:ElementDes())
	UGUIUtil.SetText(self.ProfessionDes, WarlockApi:ProfessionDes())
	UGUIUtil.SetText(self.InfluenceDes, WarlockApi:InfluenceDes())
	UGUIUtil.SetText(self.OtherDes1, WarlockApi:OtherDes1())
	UGUIUtil.SetText(self.OtherDes2, WarlockApi:OtherDes2())
end

function WarlockChoosePanel:Initialize()
	self.AllScreen_Btn = self.AllScreen:GetComponent("Button")
	self.CloseAllScreen_Btn = self.CloseAllScreen:GetComponent("Button")
	self.TypeScreenBtn_Btn = self.TypeScreenBtn:GetComponent("Button")
	self.NotSort_Btn = self.NotSort:GetComponent("Button")
	self.NotPattern_Btn = self.NotPattern:GetComponent("Button")
	self.NotPattern2_Btn = self.NotPattern2:GetComponent("Button")
	self.WenHaoBtn_Btn = self.WenHaoBtn:GetComponent("Button")
	self.ClearChooseBtn_Btn = self.ClearChooseBtn:GetComponent("Button")
	self.SetHelpFightBtn_Btn = self.SetHelpFightBtn:GetComponent("Button")
	self.scrollPageListBig = self.ScrollAreaBig:GetComponent("ScrollAreaList")

	function self.scrollPageListBig.onSelectedCell(gridCell)
		self:OnSelectedGridCell(gridCell)
	end

	function self.scrollPageListBig.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.scrollPageListSmart = self.ScrollAreaSmart:GetComponent("ScrollAreaList")

	function self.scrollPageListSmart.onSelectedCell(gridCell)
		self:OnSelectedGridCell_Smart(gridCell)
	end

	function self.scrollPageListSmart.onRenderCell(gridCell)
		self:OnRenderGridCell_Smart(gridCell)
	end

	self.tapContent_Element = TapContent:New()

	self.tapContent_Element:Init(self.ElementTapRoot.gameObject, self.OnToggleElementChangedDelegate)

	self.tapContent_Profession = TapContent:New()

	self.tapContent_Profession:Init(self.ProfessionTapRoot.gameObject, self.OnToggleProfessionChangedDelegate)

	self.tapContent_Influence = TapContent:New()

	self.tapContent_Influence:Init(self.InfluenceTapRoot.gameObject, self.OnToggleInfluenceChangedDelegate)

	self.tapContent_ChooseType = TapContent:New()

	self.tapContent_ChooseType:Init(self.TapCaiDan.gameObject, self.OnToggleChooseTypeChangedDelegate)

	self.CurChooseTypeText = self.CurChooseType:GetComponent("Text")
	self.CurChooseElementText = self.CurChooseElementText:GetComponent("Text")
	self.CurChooseProfessionText = self.CurChooseProfessionText:GetComponent("Text")
	self.CurChooseinfluenceText = self.CurChooseinfluenceText:GetComponent("Text")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function WarlockChoosePanel:InitDelegates()
	function self.RoleUpdateDataDelegation(heros)
		self:RoleUpdateData(heros)
	end

	function self.OnToggleElementChangedDelegate(go, isOn)
		self:OnToggleElementChanged(go, isOn)
	end

	function self.OnToggleProfessionChangedDelegate(go, isOn)
		self:OnToggleProfessionChanged(go, isOn)
	end

	function self.OnToggleInfluenceChangedDelegate(go, isOn)
		self:OnToggleInfluenceChanged(go, isOn)
	end

	function self.OnToggleChooseTypeChangedDelegate(go, isOn)
		self:OnToggleChooseTypeChanged(go, isOn)
	end

	function self.AllScreenBtn_OnClick()
		self:AllScreenBtnClick()
	end

	function self.TypeScreenBtnOn_Click()
		self:TypeScreenBtnClick()
	end

	function self.NotSortBtnOn_Click()
		self:NotSortBtnClick()
	end

	function self.NotPatternBtnOn_Click()
		self:NotPatternBtnClick()
	end

	function self.WenHaoBtnBtnOn_Click()
		self:WenHaoBtnBtnClick()
	end

	function self.ClearChooseBtnOn_Click()
		self:ClearChooseBtnClick()
	end

	function self.SetHelpFightBtnOn_Click()
		self:SetHelpFightBtnClick()
	end

	function self.DelegateHeroDataChangeEvent()
		self:TypeScreenLvBtnClick()
	end
end

function WarlockChoosePanel:GetPreloadAssetPaths()
	return nil
end

function WarlockChoosePanel:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WarlockChoosePanel:RefreshSortWarklockDataList(type, dataDic)
	self.SortWarklockDataList = {}

	ForPairs(dataDic, function(_, _data)
		table.insert(self.SortWarklockDataList, _data)
	end)

	self.SortWarklockDataList = WarlockModule.SortRoleListByType(self.SortWarklockDataList, type, WarlockModule.isUpSort)
end

function WarlockChoosePanel:IsManualShowOnOpen(userData)
	return false
end

function WarlockChoosePanel:GetBGM(userData)
	return nil
end

function WarlockChoosePanel:OnOpen(userData)
	self.__ShowUnlockHero = false

	if userData ~= nil then
		self.__ShowUnlockHero = TryToBoolean(userData.showUnlockHero, false)
	end

	if userData and not self.__ShowUnlockHero then
		if userData[1] == nil then
			self.TargetWarlockDataDic = WarlockModule.WarlockDataDic
		else
			self.TargetWarlockDataDic = userData[1]
		end

		if userData[3] ~= nil then
			self.TargetWarlockDataDic = WarlockModule.FilterHeroCid(self.TargetWarlockDataDic, userData[3])
		end

		if userData[2] ~= nil then
			self.OpenType = userData[2]

			if self.OpenType == Constant.UIControllerName.AssistInFightingUI then
				local length = table.len(self.TargetWarlockDataDic)

				self.SetHelpFightBtn:SetActive(length > 0)
				self.SetHelpFightNotice:SetActive(length == 0)
			else
				self.SetHelpFightNotice:SetActive(false)
				self.SetHelpFightBtn:SetActive(false)
			end
		end
	else
		self.OpenType = nil

		self.SetHelpFightNotice:SetActive(false)

		self.TargetWarlockDataDic = WarlockModule.WarlockDataDic

		self.SetHelpFightBtn:SetActive(false)
	end

	self:ToggleRefresh()
end

function WarlockChoosePanel:OnSelectedGridCell(gridCellData)
	self:OnSelectedGridCellData(gridCellData)
end

function WarlockChoosePanel:OnRenderGridCell(gridCellData)
	self:OnRenderGridCellData(gridCellData, true)
end

function WarlockChoosePanel:OnSelectedGridCell_Smart(gridCellData)
	self:OnSelectedGridCellData(gridCellData)
end

function WarlockChoosePanel:OnRenderGridCell_Smart(gridCellData)
	self:OnRenderGridCellData(gridCellData, false)
end

function WarlockChoosePanel:OnSelectedGridCellData(gridCellData)
	local data = self.SortWarklockDataList[gridCellData.index + 1]

	WarlockModule.curWarlockData = data

	if self.OpenType ~= nil then
		if self.OpenType == Constant.UIControllerName.AssistInFightingUI then
			AssistInFightingModule.CurOperationWarlockData.targetChangeWarlockData = data
		elseif self.OpenType == Constant.UIControllerName.FormatRoleUI then
			FormatRoleModule.CurWarlockData = data

			FormatRoleModule.ChangeShowHcid(data.cid, 0, 0)

			FormatRoleModule.CurChangeType = FormatRoleModule.Type.Hero

			UIModule.Close(Constant.UIControllerName.WarlockChoosePanel)

			return
		elseif self.OpenType == Constant.UIControllerName.MazeUI then
			EventDispatcher.Dispatch(EventID.MazeFormationHeroSelected, data.cid)
			UIModule.Close(Constant.UIControllerName.WarlockChoosePanel)
		end

		if self.LastHero then
			if self.LastHero.cid == data.cid then
				return
			end

			self.cellList[self.LastHero.insID]:IsChooseIng(false)
			self.cellList[data.insID]:IsChooseIng(true)

			self.LastHero = data
		else
			self.cellList[data.insID]:IsChooseIng(true)

			self.LastHero = data
		end

		return
	end

	UIModule.Open(Constant.UIControllerName.RoleDevelopmentPanel, Constant.UILayer.UI, {
		roleCid = WarlockModule.curWarlockData.cid,
		roleList = self.SortWarklockDataList,
		sortType = self.CurSortType,
		downSort = not WarlockModule.isUpSort
	})
end

function WarlockChoosePanel:OnRenderGridCellData(gridCellData, isBigCell)
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList[insID]

	if cell == nil then
		cell = warlockListCell.New(gridCellData.gameObject, self, isBigCell)
		self.cellList[insID] = cell
	end

	local dataIndex = gridCellData.index + 1

	if dataIndex <= self.unlockHeroCnt then
		local data = self.SortWarklockDataList[dataIndex]

		data.insID = insID

		cell:Refresh(data)
	else
		cell:RefreshLocked(self.lockHeroList[dataIndex - self.unlockHeroCnt])
	end

	gridCellData.gameObject.name = "Item" .. dataIndex
end

function WarlockChoosePanel:InitBtns()
	self.AllScreen_Btn.onClick:AddListener(self.AllScreenBtn_OnClick)
	self.CloseAllScreen_Btn.onClick:AddListener(self.AllScreenBtn_OnClick)
	self.TypeScreenBtn_Btn.onClick:AddListener(self.TypeScreenBtnOn_Click)
	self.NotSort_Btn.onClick:AddListener(self.NotSortBtnOn_Click)
	self.NotPattern_Btn.onClick:AddListener(self.NotPatternBtnOn_Click)
	self.NotPattern2_Btn.onClick:AddListener(self.NotPatternBtnOn_Click)
	self.WenHaoBtn_Btn.onClick:AddListener(self.WenHaoBtnBtnOn_Click)
	self.ClearChooseBtn_Btn.onClick:AddListener(self.ClearChooseBtnOn_Click)
	self.SetHelpFightBtn_Btn.onClick:AddListener(self.SetHelpFightBtnOn_Click)
end

function WarlockChoosePanel:OnToggleElementChanged(go_name)
	local CurChooseEase

	if go_name == "fire" then
		CurChooseEase = WarlockModule.EaseElement.EaseFire
	elseif go_name == "water" then
		CurChooseEase = WarlockModule.EaseElement.EaseWater
	elseif go_name == "wind" then
		CurChooseEase = WarlockModule.EaseElement.EaseWind
	elseif go_name == "mine" then
		CurChooseEase = WarlockModule.EaseElement.EaseMine
	end

	self.CurScreentable.Element = CurChooseEase
end

function WarlockChoosePanel:OnToggleProfessionChanged(go_name)
	local CurChooseEase

	if go_name == "conjuring" then
		CurChooseEase = WarlockModule.EaseProfession.EaseConjuring
	elseif go_name == "implement" then
		CurChooseEase = WarlockModule.EaseProfession.EaseImplement
	elseif go_name == "speech" then
		CurChooseEase = WarlockModule.EaseProfession.EaseSpeech
	elseif go_name == "Rune" then
		CurChooseEase = WarlockModule.EaseProfession.EaseRune
	elseif go_name == "curtain" then
		CurChooseEase = WarlockModule.EaseProfession.EaseCurtain
	elseif go_name == "provide" then
		CurChooseEase = WarlockModule.EaseProfession.EaseProvide
	end

	self.CurScreentable.Profession = CurChooseEase
end

function WarlockChoosePanel:OnToggleChooseTypeChanged(go_name)
	if go_name == "LV" then
		self:TypeScreenLvBtnClick()
	elseif go_name == "Quality" then
		self:TypeScreenQualityBtnClick()
	elseif go_name == "Favorable" then
		self:TypeScreenFavorableBtnClick()
	elseif go_name == "ElementMaster" then
		self:TypeScreenElementMasterBtnClick()
	elseif go_name == "LifeUpLimit" then
		self:TypeScreenLifeUpLimitBtnClick()
	elseif go_name == "LifeFloorLimit" then
		self:TypeScreenDownLimitBtnClick()
	end
end

function WarlockChoosePanel:OnToggleInfluenceChanged(go_name)
	local CurChooseEase

	if go_name == "Hidedoor" then
		CurChooseEase = WarlockModule.EaseInfluence.EaseHidedoor
	elseif go_name == "LifeStudy" then
		CurChooseEase = WarlockModule.EaseInfluence.EaseLifeStudy
	elseif go_name == "yinyang" then
		CurChooseEase = WarlockModule.EaseInfluence.EaseYinyang
	end

	self.CurScreentable.Influence = CurChooseEase
end

function WarlockChoosePanel:ToggleRefresh()
	self.CurWarlockDataDic = {}

	for i, v in pairs(self.TargetWarlockDataDic) do
		local add = self:ToggleScreenhero(v)

		if add then
			table.insert(self.CurWarlockDataDic, v)
		end
	end

	if self.CurScreentable.Element == nil and self.CurScreentable.Profession == nil and self.CurScreentable.Influence == nil then
		self.CurWarlockDataDic = self.TargetWarlockDataDic
	end

	self:RefreshSortWarklockDataList(self.CurSortType, self.CurWarlockDataDic)
	self:NotPatternRefresh()
end

function WarlockChoosePanel:ToggleScreenhero(v)
	local add

	if self.CurScreentable.Element == nil then
		add = true
	elseif v.BaseData.Elements == self.CurScreentable.Element then
		add = true
	else
		add = false

		return add
	end

	if self.CurScreentable.Profession ~= nil then
		if v.BaseData.Profession == self.CurScreentable.Profession then
			add = true
		else
			add = false

			return add
		end
	end

	if self.CurScreentable.Influence ~= nil then
		if v.BaseData.Forces == self.CurScreentable.Influence then
			add = true
		else
			add = false

			return add
		end
	end

	return add
end

function WarlockChoosePanel:IsContain(_table, id)
	for i, v in pairs(_table) do
		if v.id == id then
			return true
		end
	end

	return false
end

function WarlockChoosePanel:AllScreenBtnClick(go)
	self.isAllScreen = not self.isAllScreen

	self.AllScreenOpen:SetActive(self.isAllScreen)
	self.AllScreenClose:SetActive(not self.isAllScreen)

	if self.isAllScreen == false then
		self:ToggleRefresh()

		if self.CurScreentable.Element ~= nil then
			self.CurChooseElement:SetActive(true)

			self.CurChooseElementText.text = WarlockApi:GetEaseElementType(self.CurScreentable.Element)
		end

		if self.CurScreentable.Profession ~= nil then
			self.CurChooseProfession:SetActive(true)

			self.CurChooseProfessionText.text = WarlockApi:GetEaseProfessionType(self.CurScreentable.Profession)
		end

		if self.CurScreentable.Influence ~= nil then
			self.CurChooseinfluence:SetActive(true)

			self.CurChooseinfluenceText.text = WarlockApi:GetEaseInfluenceType(self.CurScreentable.Influence)
		end
	elseif self.isTypeScreen then
		self.TypeScreenScroll.transform.localScale = Vector3.New(1, 0, 1)
		self.isTypeScreen = false
	end
end

function WarlockChoosePanel:TypeScreenBtnClick()
	self.isTypeScreen = not self.isTypeScreen

	local Y = self.isTypeScreen == true and 1 or 0

	self.TypeScreenScroll.transform.localScale = Vector3.New(1, Y, 1)

	self.CurChooseUpArr:SetActive(not self.isTypeScreen)
	self.CurChooseUpDown:SetActive(self.isTypeScreen)

	if self.isTypeScreen and self.isAllScreen then
		self:AllScreenBtnClick()
	end
end

function WarlockChoosePanel:NotSortBtnClick()
	WarlockModule.isUpSort = not WarlockModule.isUpSort

	if self.isAllScreen then
		self:AllScreenBtnClick()
	end

	if self.isTypeScreen then
		self.TypeScreenScroll.transform.localScale = Vector3.New(1, 0, 1)
		self.isTypeScreen = false
	end

	self:RefreshSortWarklockDataList(self.CurSortType, self.CurWarlockDataDic)
	self:NotPatternRefresh()
end

function WarlockChoosePanel:NotPatternBtnClick()
	self.isSizeShow = not self.isSizeShow

	self.NotPattern:SetActive(not self.isSizeShow)
	self.NotPattern2:SetActive(self.isSizeShow)

	if self.isAllScreen then
		self:AllScreenBtnClick()
	end

	if self.isTypeScreen then
		self.TypeScreenScroll.transform.localScale = Vector3.New(1, 0, 1)
		self.isTypeScreen = false
	end

	self.ScrollAreaBig:SetActive(not self.isSizeShow)
	self.ScrollAreaSmart:SetActive(self.isSizeShow)
	self:NotPatternRefresh()
end

function WarlockChoosePanel:NotPatternRefresh()
	self.lockHeroList = {}

	if self.__ShowUnlockHero then
		self.lockHeroList = self:__GetLockedHeroList()
	end

	self.unlockHeroCnt = #self.SortWarklockDataList

	local totalCnt = #self.lockHeroList + #self.SortWarklockDataList

	if not self.isSizeShow then
		self.scrollPageListBig:Refresh(totalCnt)
	else
		self.scrollPageListSmart:Refresh(totalCnt)
	end

	self:PlayScrollMoveInEffect(not self.isSizeShow)
end

function WarlockChoosePanel:__GetLockedHeroList()
	local heroDic = {}
	local heroList = {}

	ForArray(self.SortWarklockDataList, function(_, _warlockData)
		heroDic[_warlockData.cid] = true
	end)
	WarlockModule.ForArrayOpenHeroList(function(_heroCid)
		if heroDic[_heroCid] then
			return
		end

		table.insert(heroList, _heroCid)
	end)
	table.sort(heroList, self.__SortUnlockHero)

	return heroList
end

function WarlockChoosePanel.__SortUnlockHero(hero1, hero2)
	local _cfgCid_a, _needNum_a, _ownerNum_a = WarlockModule.GetLockedHeroCombinationData(hero1)
	local _cfgCid_b, _needNum_b, _ownerNum_b = WarlockModule.GetLockedHeroCombinationData(hero2)
	local c_a = _needNum_a <= _ownerNum_a
	local c_b = _needNum_b <= _ownerNum_b

	if c_a == c_b then
		return _cfgCid_b < _cfgCid_a
	end

	if c_a then
		return true
	end

	return false
end

function WarlockChoosePanel:WenHaoBtnBtnClick()
	NoticeModule.ShowNotice(20001)
end

function WarlockChoosePanel:TypeScreenLvBtnClick()
	self.CurSortType = Constant.WarlockSortType.Level

	self:TypeSortFunc()
end

function WarlockChoosePanel:TypeScreenQualityBtnClick()
	self.CurSortType = Constant.WarlockSortType.Quality

	self:TypeSortFunc()
end

function WarlockChoosePanel:TypeScreenFavorableBtnClick()
	self.CurSortType = Constant.WarlockSortType.Quality

	self:TypeSortFunc()
end

function WarlockChoosePanel:TypeScreenElementMasterBtnClick()
	self.CurSortType = Constant.WarlockSortType.Element

	self:TypeSortFunc()
end

function WarlockChoosePanel:TypeScreenLifeUpLimitBtnClick()
	self.CurSortType = Constant.WarlockSortType.Quality

	self:TypeSortFunc()
end

function WarlockChoosePanel:TypeScreenDownLimitBtnClick()
	log("生命值下限排序按钮点击事件")
end

function WarlockChoosePanel:ClearChooseBtnClick()
	self.CurChooseElement:SetActive(false)

	self.CurChooseElementText.text = ""
	self.CurScreentable.Element = nil
	self.CurScreentable.Profession = nil

	self.CurChooseProfession:SetActive(false)

	self.CurChooseProfessionText.text = ""
	self.CurScreentable.Influence = nil

	self.CurChooseinfluence:SetActive(false)

	self.CurChooseinfluenceText.text = ""

	self.tapContent_Element:ToggleSetItemIsOn()
	self.tapContent_Profession:ToggleSetItemIsOn()
	self.tapContent_Influence:ToggleSetItemIsOn()
	self:ToggleRefresh()
end

function WarlockChoosePanel:TypeSortFunc()
	self.isTypeScreen = false
	self.TypeScreenScroll.transform.localScale = Vector3.New(1, 0, 1)
	self.CurChooseTypeText.text = WarlockApi:GetSortType(self.CurSortType)

	self.CurChooseUpArr:SetActive(true)
	self.CurChooseUpDown:SetActive(false)
	self:RefreshSortWarklockDataList(self.CurSortType, self.CurWarlockDataDic)
	self:NotPatternRefresh()
end

function WarlockChoosePanel:SetHelpFightBtnClick()
	if #self.SortWarklockDataList == 0 then
		return
	end

	if AssistInFightingModule.CurOperationWarlockData.targetChangeWarlockData == nil then
		NoticeModule.ShowNotice(20016)

		return
	end

	self.cellList[self.LastHero.insID]:IsChooseIng(false)
	AssistInFightingModule.SetHelpHero(AssistInFightingModule.CurOperationWarlockData.pos, AssistInFightingModule.CurOperationWarlockData.targetChangeWarlockData.cid)
	UIModule.Close(Constant.UIControllerName.WarlockChoosePanel)
end

function WarlockChoosePanel:Reset()
	if self.LastHero then
		self.cellList[self.LastHero.insID]:IsChooseIng(false)

		self.LastHero.ischooseing = false
		self.LastHero = nil
	end

	AssistInFightingModule.CurOperationWarlockData.targetChangeWarlockData = nil
end

function WarlockChoosePanel:RoleUpdateData(heros)
	for i, v in pairs(heros) do
		for k, u in pairs(self.cellList) do
			if u.WarlockData ~= nil and u.WarlockData.cid == i then
				u:Refresh(self:GetSortWarklockData(u.WarlockData.cid))
			end
		end
	end

	self:TypeScreenLvBtnClick()
end

function WarlockChoosePanel:GetSortWarklockData(cid)
	for i, v in pairs(self.SortWarklockDataList) do
		if v.cid == cid then
			return v
		end
	end
end

function WarlockChoosePanel:PlayScrollMoveInEffect(isBigScroll)
	local sortedTb = Clone(self.cellList)

	if sortedTb then
		table.sort(sortedTb, function(a, b)
			local cell_A = a.gameObject.transform:GetComponent("RenderCell")
			local cell_B = b.gameObject.transform:GetComponent("RenderCell")

			return cell_A.index > cell_B.index
		end)

		local dot, rendererCell

		for i, data in pairs(sortedTb) do
			if data.isBigCell == isBigScroll and data.gameObject.activeInHierarchy then
				rendererCell = data.gameObject.transform:GetComponent("RenderCell")

				if rendererCell then
					local deltaMoveX, duration, cellIndex

					if isBigScroll then
						cellIndex = rendererCell.index
					else
						cellIndex = rendererCell.index % 2 == 0 and rendererCell.index / 2 or (rendererCell.index - 1) / 2
					end

					if cellIndex == 0 then
						deltaMoveX = 500
						duration = 0.25
					elseif cellIndex == 1 then
						deltaMoveX = 600
						duration = 0.3
					elseif cellIndex == 2 then
						deltaMoveX = 700
						duration = 0.4
					elseif cellIndex == 3 then
						deltaMoveX = 775
						duration = 0.45
					elseif cellIndex == 4 then
						deltaMoveX = 825
						duration = 0.55
					elseif cellIndex == 5 then
						deltaMoveX = 850
						duration = 0.6
					elseif cellIndex == 6 then
						deltaMoveX = 860
						duration = 0.625
					end

					if deltaMoveX then
						local oldPos = rendererCell.transform.localPosition
						local newPos = rendererCell.transform.localPosition

						newPos.x = newPos.x + deltaMoveX
						rendererCell.transform.localPosition = newPos

						rendererCell.transform:DOLocalMove(oldPos, duration)
					end
				end
			end
		end
	end
end

function WarlockChoosePanel:OnClose(userData)
	self:Reset()
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseWarlockChoosePanel")
end

function WarlockChoosePanel:OnAddListeners()
	self:InitBtns()
	EventDispatcher.AddEventListener(EventID.RoleUpdateData, self.RoleUpdateDataDelegation)
	EventUtil.AddEventListener(self, EventID.CompositeItemResultEvent, self.__OnCompositeItemResultEvent)
	UIEventUtil.AddClickEventListener_Button(self, "HeroIntroduceUIBtn", self.__OnHeroIntroduceUIBtnClick)
end

function WarlockChoosePanel:OnRemoveListeners()
	EventUtil.ClearEventListener(self)
	UIEventUtil.ClearEventListener(self)
	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, self.RoleUpdateDataDelegation)
	self.AllScreen_Btn.onClick:RemoveListener(self.AllScreenBtn_OnClick)
	self.CloseAllScreen_Btn.onClick:RemoveListener(self.AllScreenBtn_OnClick)
	self.TypeScreenBtn_Btn.onClick:RemoveListener(self.TypeScreenBtnOn_Click)
	self.NotSort_Btn.onClick:RemoveListener(self.NotSortBtnOn_Click)
	self.NotPattern_Btn.onClick:RemoveListener(self.NotPatternBtnOn_Click)
	self.NotPattern2_Btn.onClick:RemoveListener(self.NotPatternBtnOn_Click)
	self.WenHaoBtn_Btn.onClick:RemoveListener(self.WenHaoBtnBtnOn_Click)
	self.ClearChooseBtn_Btn.onClick:RemoveListener(self.ClearChooseBtnOn_Click)
	self.SetHelpFightBtn_Btn.onClick:RemoveListener(self.SetHelpFightBtnOn_Click)
end

function WarlockChoosePanel:OnPause()
	return
end

function WarlockChoosePanel:OnResume()
	return
end

function WarlockChoosePanel:OnCover()
	return
end

function WarlockChoosePanel:OnReveal()
	return
end

function WarlockChoosePanel:OnRefocus(userData)
	return
end

function WarlockChoosePanel:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WarlockChoosePanel:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WarlockChoosePanel:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WarlockChoosePanel:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WarlockChoosePanel:OnDestroy()
	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.ElementTapRoot, self)
	LuaCodeInterface.ClearOutlet(self.ProfessionTapRoot, self)
	LuaCodeInterface.ClearOutlet(self.InfluenceTapRoot, self)
	LuaCodeInterface.ClearOutlet(self.OtherLuaOutlet, self)
	LuaCodeInterface.ClearOutlet(self.AllScreen, self)
	LuaCodeInterface.ClearOutlet(self.TypeScreen, self)
	self.commonReturnBtn:Dispose()
end

function WarlockChoosePanel:__OnCompositeItemResultEvent()
	self:NotPatternRefresh()
end

function WarlockChoosePanel:__OnHeroIntroduceUIBtnClick()
	UIModule.Open(Constant.UIControllerName.HeroIntroduceUI, Constant.UILayer.UI)
end

return WarlockChoosePanel
