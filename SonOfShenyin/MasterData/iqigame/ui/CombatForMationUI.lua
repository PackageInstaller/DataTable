-- chunkname: @IQIGame\\UI\\CombatForMationUI.lua

require("IQIGame.Common.TapContent")

local FormationRoleDetailsView = require("IQIGame.UI.CombatFormation.FormationRoleDetailsView")
local CombatForMationUI = Base:Extend("CombatForMationUI", "IQIGame.Onigao.UI.CombatForMationUI", {
	Positive = true,
	GridElementCount = 5,
	isAllowHelpHero = false,
	GridProfessionCount = 4,
	ProfessionTable = {},
	ElementTable = {},
	SortWarklockDataList = {},
	BoxTable = {},
	cellList = {},
	heroList = {},
	CurSortType = WarlockModule.sortType.Easelv
})

function CombatForMationUI:OnInit()
	CombatFormationModel.HeroBoxPool = {}

	LuaCodeInterface.BindOutlet(self.OtherLuaOutlet, self)
	LuaCodeInterface.BindOutlet(self.TapContent, self)
	self:InitDelegates()
	self:Initialize()
	self:ScreenWarlockType()
end

function CombatForMationUI:InitDelegates()
	function self.OnToggleTagChangedDelegate(go_name, isOn)
		self:OnToggleTagChanged(go_name, isOn)
	end

	function self.SaveFormationSucceedDelegate()
		self:SaveFormationSucceedRefresh()
	end

	function self.MyChooseHelpHeroDele()
		self:ChooseHelpHeroDeleFunction()
	end

	function self.OnSelectedGridCellDelegate(isactive)
		self:OnSelectedGridCell(isactive)
	end

	function self.OnToggleChooseHeroTagChangedDelegate(go_name, isOn, go)
		self:OnToggleTagChooseHeroChanged(go_name, isOn, go)
	end

	function self.OnCancelHelpHeroDelegate()
		self:OnCancelHelpHeroDelegateFunction()
	end

	function self.OnResetDragNoEffectDelegate()
		self:ResetDragNoEffect()
	end

	function self.ScreenTypeBtn_OnClick()
		self:ScreenTypeBtnClick()
	end

	function self.StartBtnClick_OnClick()
		self:StartBtnClick()
	end

	function self.CloseBtn_OnClick()
		self:CloseBtnClick()
	end

	function self.CloseScreenTypeBtn_OnClick()
		self:CloseScreenTypeBtnClick()
	end

	function self.OneAddTouchPointFunc(cid, isReset)
		self:OneAddTouchPoint(cid, isReset)
	end

	function self.OnDragImageMaskFunc(isshow)
		self:OnDragImageMask(isshow)
	end
end

function CombatForMationUI:Initialize()
	self.cellList = {}
	self.CurPeopleText = self.CurPeople:GetComponent("Text")
	self.AllPeopleText = self.AllPeople:GetComponent("Text")
	self.ScreenTypeScrollView = self.ScreenTypeScroll:GetComponent("ScrollAreaList")

	function self.ScreenTypeScrollView.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self:InitElementAndProfession()

	self.tapContent = TapContent:New()

	self.tapContent:Init(self.TapContent.gameObject, self.OnToggleTagChangedDelegate)

	for i = 1, self.BoxRoot.transform.childCount do
		self.BoxTable[i] = self.BoxRoot.transform:Find(tostring(i)).gameObject
	end

	self.MyTagTypeContent = TapContent:New()

	self.MyTagTypeContent:Init(self.TagTypeContent.gameObject, self.OnToggleChooseHeroTagChangedDelegate, {
		"Default",
		"Cost",
		"Lv",
		"Quality"
	})

	self.ScreenTypeBtn_Btn = self.ScreenTypeBtn:GetComponent("Button")
	self.StartBtn_Btn = self.StartBtn:GetComponent("Button")
	self.CloseBtn_Btn = self.CloseBtn:GetComponent("Button")
	self.CloseAllScreen_Btn = self.CloseAllScreen:GetComponent("Button")

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
	UGUIUtil.SetText(self.TapToggleDes_1_1, CombatFormationUIApi:GetTextTitle_2())
	UGUIUtil.SetText(self.TapToggleDes_1_2, CombatFormationUIApi:GetTextTitle_2())
	UGUIUtil.SetText(self.TapToggleDes_2_1, CombatFormationUIApi:GetTextTitle_1())
	UGUIUtil.SetText(self.TapToggleDes_2_2, CombatFormationUIApi:GetTextTitle_1())
	UGUIUtil.SetText(self.TapToggleDes_3_1, CombatFormationUIApi:GetTextTitle_3())
	UGUIUtil.SetText(self.TapToggleDes_3_2, CombatFormationUIApi:GetTextTitle_3())
	UGUIUtil.SetText(self.ElementDes, WarlockApi:ElementDes())
	UGUIUtil.SetText(self.ProfessionDes, WarlockApi:ProfessionDes())
	UGUIUtil.SetText(self.InfluenceDes, WarlockApi:InfluenceDes())

	self.FormationRoleDetailsView = FormationRoleDetailsView.New(self.RoleDetailsPanel.gameObject)
end

function CombatForMationUI:InitElementAndProfession()
	for i = 1, self.GridElementCount do
		local Item = UnityEngine.Object.Instantiate(self.ElementItem.gameObject)
		local ItemIcon = Item:GetComponent("Image")
		local path = WarlockApi:GetElementIconPath(i)

		AssetUtil.LoadImage(self, path, ItemIcon)
		Item:SetActive(true)

		Item.name = "Element" .. i

		Item.transform:SetParent(self.ElementRoot.transform, false)

		self.ElementTable[i] = Item
	end

	for i = 1, self.GridProfessionCount do
		local Item = UnityEngine.Object.Instantiate(self.ProfessionItem.gameObject)
		local ItemIcon = Item:GetComponent("Image")
		local path = WarlockApi:GetProfessionIconPath(i)

		AssetUtil.LoadImage(self, path, ItemIcon)
		Item:SetActive(true)

		Item.name = "Profession" .. i

		Item.transform:SetParent(self.ProfressionRoot.transform, false)

		self.ProfessionTable[i] = Item
	end
end

function CombatForMationUI:RefreshData()
	local CurPeople, CostNum = CombatFormationModel.CurFormation:GetCurFomationPeople()

	self.CurPeopleText.text = CurPeople
	self.AllPeopleText.text = CombatFormationModel.CurFormation.BaseData.MaxHeroCount
end

function CombatForMationUI:ScreenWarlockType()
	self.AllScreenWarlock:GetComponent("Canvas").sortingOrder = self.View:GetComponent("Canvas").sortingOrder + 6
	self.MyScreenWarlockList = ScreenWarlockList.New(self.AllScreen, self)
	self.ScreenTypeArr = self.ScreenTypeBtn.transform:Find("Arr").gameObject
end

function CombatForMationUI:OperationProfessionAndElement(isFirst, B_OperationType, index)
	if not isFirst then
		self.ProfessionTable[index].gameObject:SetActive(B_OperationType)
		self.ElementTable[index].gameObject:SetActive(B_OperationType)

		return
	end

	local _t = CombatFormationModel.CurFormation:GetElement()

	for i = 1, #self.ElementTable do
		local B_Item = false

		for j = 1, #_t do
			if i == _t[j] then
				B_Item = true

				break
			end
		end

		self.ElementTable[i].gameObject:SetActive(B_Item)
	end

	local _t = CombatFormationModel.CurFormation:GetProfession()

	for i = 1, #self.ProfessionTable do
		local B_Item = false

		for j = 1, #_t do
			if i == _t[j] then
				B_Item = true

				break
			end
		end

		self.ProfessionTable[i].gameObject:SetActive(B_Item)
	end
end

function CombatForMationUI:ResetPool(isOperateOne, Index)
	if isOperateOne then
		if CombatFormationModel.HeroBoxPool[Index] then
			ObjectPoolManager:UnLoadAsset(Constant.PoolObjName.Formation, CombatFormationModel.HeroBoxPool[Index].cid, CombatFormationModel.HeroBoxPool[Index].obj)

			CombatFormationModel.HeroBoxPool[Index] = nil
		end

		return
	end

	for i, v in pairs(CombatFormationModel.HeroBoxPool) do
		if v then
			ObjectPoolManager:UnLoadAsset(Constant.PoolObjName.Formation, v.cid, v.obj)
		end
	end

	CombatFormationModel.HeroBoxPool = {}
end

function CombatForMationUI:OnToggleTagChanged(go_name, isOn, EaseFormation)
	local CurChooseEase

	if go_name == "Glob1" then
		log("Glob1   " .. tostring(isOn))

		CurChooseEase = CombatFormationModel.EaseFormation.One
	elseif go_name == "Glob2" then
		log("Glob2")

		CurChooseEase = CombatFormationModel.EaseFormation.Two
	elseif go_name == "Glob3" then
		log("Glob3")

		CurChooseEase = CombatFormationModel.EaseFormation.Three
	else
		CurChooseEase = EaseFormation
	end

	self.LastHero = nil

	if CombatFormationModel.CurFormation and CombatFormationModel.CurFormation.haveHelphero then
		AssistInFightingModule.ClearHelpHero(CombatFormationModel.CurFormation.FormationId)
	end

	self:ResetPool()

	CombatFormationModel.CurChooseWarlockData = nil

	CombatFormationModel.ResetChangeDataTable()

	CombatFormationModel.CurFormation = CombatFormationModel.FormationDic[CurChooseEase]

	self:RefreshData()
	self:OperationProfessionAndElement(true)
	self:RefreshFomation()
	CombatFormationModel.GetPreviewWarlockList()
	self:ResetAllScreenState()
	self:GetSortRoleList()
end

function CombatForMationUI:OnSelectedGridCell(data)
	local data = data

	CombatFormationModel.CurChooseWarlockData = data

	if self.LastHero then
		if self.LastHero.cid == data.cid then
			return
		end

		self.heroList[self.LastHero.insID]:IsChooseIng(false)
		self.heroList[data.insID]:IsChooseIng(true)

		self.LastHero = data
	else
		self.heroList[data.insID]:IsChooseIng(true)

		self.LastHero = data
	end

	self:DragBoxRefresh(true)
end

function CombatForMationUI:OnRenderGridCell(gridCellData)
	log("刷新格子---------  " .. gridCellData.index + 1)

	local data = self.SortWarklockDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.heroList[insID]

	data.insID = insID

	if cell == nil then
		cell = FormationRoleCell.New(gridCellData.gameObject, self, self.RolePoolRoot)
		self.heroList[insID] = cell
	end

	cell:Refresh(data)

	gridCellData.gameObject.name = gridCellData.index
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index
end

function CombatForMationUI:OnDragImageMask(isshow)
	self.DragImageMask:SetActive(isshow)
end

function CombatForMationUI:OneAddTouchPoint(cid, isReset)
	PlotSencesModule.Log("isReset::  " .. tostring(isReset))

	for i, v in pairs(self.heroList) do
		if isReset then
			v:TriggerSet(true)
		elseif v.WarlockData.cid ~= cid then
			v:TriggerSet(false)
		end
	end
end

function CombatForMationUI:OnToggleTagChooseHeroChanged(go_name, isOn, go)
	if go_name == "Default" then
		self.CurSortType = nil
		self.Positive = true

		WarlockModule.ResetScreen()
		self.MyScreenWarlockList:ResetAllScreen()
	elseif go_name == "Cost" then
		if self.CurSortType and self.CurSortType == WarlockModule.sortType.Cost then
			self.Positive = not self.Positive
		else
			self.Positive = true
		end

		self.CurSortType = WarlockModule.sortType.Cost
	elseif go_name == "Lv" then
		if self.CurSortType and self.CurSortType == WarlockModule.sortType.Easelv then
			self.Positive = not self.Positive
		else
			self.Positive = true
		end

		self.CurSortType = WarlockModule.sortType.Easelv
	elseif go_name == "Quality" then
		if self.CurSortType and self.CurSortType == WarlockModule.sortType.EaseQuality then
			self.Positive = not self.Positive
		else
			self.Positive = true
		end

		self.CurSortType = WarlockModule.sortType.EaseQuality
	end

	if self.CurSortType ~= nil then
		local y = self.Positive == true and 1 or -1

		go.gameObject.transform:Find("Checkmark/mark").transform.localScale = Vector3.New(1, y, 1)
	end
end

function CombatForMationUI:ResetAllScreenState()
	self.CurSortType = nil

	WarlockModule.ResetScreen()
	self.MyScreenWarlockList:ResetAllScreen()
	self.MyTagTypeContent:ToggleEvent("Default")
end

function CombatForMationUI:GetSortRoleList()
	self.SortWarklockDataList = {}

	local targetList = {}

	for i, v in pairs(CombatFormationModel.PreviewWarlockList) do
		local add = self:ToggleScreenhero(v)

		if add then
			table.insert(targetList, v)
		end
	end

	if WarlockModule.CurScreentable.Element == nil and WarlockModule.CurScreentable.Profession == nil and WarlockModule.CurScreentable.Influence == nil then
		targetList = CombatFormationModel.PreviewWarlockList
	end

	for i, v in ipairs(WarlockModule.GetSortedSoulDataList(self.CurSortType, targetList, self.Positive)) do
		self.SortWarklockDataList[i] = v
	end

	self.ScreenTypeScrollView:Refresh(#self.SortWarklockDataList)
end

function CombatForMationUI:ToggleScreenhero(v)
	local add

	if WarlockModule.CurScreentable.Element == nil then
		add = true
	elseif v.BaseData.Elements == WarlockModule.CurScreentable.Element then
		add = true
	else
		add = false

		return add
	end

	if WarlockModule.CurScreentable.Profession ~= nil then
		if v.BaseData.Profession == WarlockModule.CurScreentable.Profession then
			add = true
		else
			add = false

			return add
		end
	end

	if WarlockModule.CurScreentable.Influence ~= nil then
		if v.BaseData.Forces == WarlockModule.CurScreentable.Influence then
			add = true
		else
			add = false

			return add
		end
	end

	return add
end

function CombatForMationUI:RefreshOther()
	if self.CurSortType == nil then
		self.MyTagTypeContent:ToggleSetOneItemIsOn(1)
	end
end

function CombatForMationUI:RefreshFomation()
	for i = 1, 9 do
		local item = self.BoxTable[i]
		local cell = self.cellList[i]

		if cell == nil then
			cell = FormationCell.New(item, self.SiblingCenter, self.SiblingBottom, self.RolePoolRoot, self)
			self.cellList[i] = cell
		end

		cell:Refresh(CombatFormationModel.CurFormation.Box[i], i)
	end
end

function CombatForMationUI:CloseBtnClick(isEnterClose)
	if isEnterClose == nil and self.levelType == Constant.ChapterPassType.TYPE_MAINLINE then
		if self.isChangeEnter then
			PlotSencesModule.ExitScene(nil, nil, nil, true)
		end

		UIModule.Close(Constant.UIControllerName.CombatForMationUI)
	else
		UIModule.Close(Constant.UIControllerName.CombatForMationUI)
	end
end

function CombatForMationUI:StartBtnClick()
	if self.transcriptId ~= nil then
		-- block empty
	else
		NoticeModule.ShowNotice(20018)
		self:CloseBtnClick(true)
	end
end

function CombatForMationUI:ScreenTypeBtnClick()
	self.AllScreenWarlock.transform.localScale = Vector3.New(1, 1, 1)
	self.ScreenTypeArr.transform.localScale = Vector3.New(1, -1, 1)
end

function CombatForMationUI:CloseScreenTypeBtnClick()
	self.AllScreenWarlock.transform.localScale = Vector3.New(0, 0, 0)
	self.ScreenTypeArr.transform.localScale = Vector3.New(1, 1, 1)

	self:GetSortRoleList()
end

function CombatForMationUI:ResetDragPool(index)
	if index == nil then
		return
	end

	self:ResetPool(true, index)
end

function CombatForMationUI:SaveFormationSucceedRefreshCell(index)
	if index == nil then
		return
	end

	self.cellList[index]:SaveFormationSucceed()
	self.cellList[index]:Refresh(CombatFormationModel.CurFormation.Box[index], index)
end

function CombatForMationUI:DragBoxRefresh(isactive)
	for i = 1, #self.cellList do
		self.cellList[i]:SetCellbtnActive(isactive)
	end
end

function CombatForMationUI:HelpHeroCellRefresh()
	if CombatFormationModel.ChangeDataTable.NextBox.id == nil then
		local index1, index2

		if AssistInFightingModule.HelpHeroBoxPos ~= nil then
			index1 = AssistInFightingModule.HelpHeroBoxPos
			AssistInFightingModule.HelpHeroBoxPos = nil

			self:ResetDragPool(index1)
			self.cellList[index1]:Refresh(CombatFormationModel.CurFormation.Box[index1], index1)

			for i = 1, #self.cellList do
				self.cellList[i]:MarkHelpState(false)
			end
		else
			index1 = CombatFormationModel.ChangeDataTable.LastBox.Index

			self:ResetDragPool(index1)
			self.cellList[index1]:Refresh(CombatFormationModel.CurFormation.Box[index1], index1)

			index2 = CombatFormationModel.ChangeDataTable.NextBox.Index

			self.cellList[index2]:Refresh(CombatFormationModel.CurFormation.Box[index2], index2)
		end

		self:DragBoxRefresh(false)
		self:OperationProfessionAndElement(true)
		self:RefreshData()
		CombatFormationModel.ResetChangeDataTable()
	end
end

function CombatForMationUI:SaveFormationSucceedRefresh()
	if CombatFormationModel.CurChooseWarlockData ~= nil and CombatFormationModel.HeroBoxPool[CombatFormationModel.ChangeDataTable.LastBox.Index] ~= nil then
		NoticeModule.ShowNotice(20019)
	end

	log(" -----上阵成功刷新----------------------------  ")
	self:ResetDragPool(CombatFormationModel.ChangeDataTable.LastBox.Index)
	self:ResetDragPool(CombatFormationModel.ChangeDataTable.NextBox.Index)
	self:SaveFormationSucceedRefreshCell(CombatFormationModel.ChangeDataTable.LastBox.Index)
	self:SaveFormationSucceedRefreshCell(CombatFormationModel.ChangeDataTable.NextBox.Index)

	if CombatFormationModel.CurChooseWarlockData ~= nil then
		-- block empty
	end

	self:DragBoxRefresh(false)

	if CombatFormationModel.ChangeDataTable.LastBox.Index == nil or CombatFormationModel.ChangeDataTable.NextBox.Index == nil then
		self:GetSortRoleList()
	end

	self:OperationProfessionAndElement(true)
	self:RefreshData()

	CombatFormationModel.CurChooseWarlockData = nil
	self.LastHero = nil

	CombatFormationModel.ResetChangeDataTable()

	CombatFormationModel.FormationChange = false

	local isFormationFull = CombatFormationModel.CurFormation:IsFormationFull()

	for i = 1, #self.cellList do
		self.cellList[i]:RefreshCellHelpHeroState(not isFormationFull)
	end
end

function CombatForMationUI:OnCancelHelpHeroDelegateFunction()
	local index1 = CombatFormationModel.ChangeDataTable.LastBox.Index

	if CombatFormationModel.CurChooseWarlockData == nil and index1 then
		self.cellList[index1]:Refresh(CombatFormationModel.CurFormation.Box[index1], index1)
		self:DragBoxRefresh(false)
		self:OperationProfessionAndElement(true)
		self:RefreshData()
		CombatFormationModel.ResetChangeDataTable()
	end

	for i = 1, #self.cellList do
		self.cellList[i]:MarkHelpState(true)
	end
end

function CombatForMationUI:ResetDragNoEffect()
	self:DragBoxRefresh(false)

	CombatFormationModel.CurChooseWarlockData = nil

	if self.LastHero ~= nil then
		self.heroList[self.LastHero.insID]:IsChooseIng(false)
	end

	self.LastHero = nil

	CombatFormationModel.ResetChangeDataTable()

	if CombatFormationModel.CurChooseWarlockData ~= nil then
		warning("将当前操作的术士从筛选池中移除   " .. CombatFormationModel.CurChooseWarlockData.cid)

		CombatFormationModel.PreviewWarlockList[CombatFormationModel.CurChooseWarlockData.cid] = nil
	end
end

function CombatForMationUI:RefreshCellsReplaceableState(targetCellIndex, targetCellState)
	local formationCell

	for i = 1, #self.cellList do
		formationCell = self.cellList[i]

		if i == targetCellIndex then
			formationCell:RefreshCellReplaceableState(targetCellState)
		else
			formationCell:RefreshCellReplaceableState(CombatFormationModel.E_FormationCellStateOnDrag.CanNotReplace)
		end
	end
end

function CombatForMationUI:RefreshRoleDetailsPanel(isShow, targetWarlockData)
	if isShow then
		if GuideModule.currentGuide == nil then
			self.FormationRoleDetailsView:Show(targetWarlockData)
		end
	else
		self.FormationRoleDetailsView:Hide()
	end
end

function CombatForMationUI:ChooseHelpHeroDeleFunction()
	self:HelpHeroCellRefresh()
end

function CombatForMationUI:GetPreloadAssetPaths()
	return nil
end

function CombatForMationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CombatForMationUI:IsManualShowOnOpen(userData)
	return false
end

function CombatForMationUI:GetBGM(userData)
	return nil
end

function CombatForMationUI:OnOpen(arg)
	self:OnDragImageMask(false)
	UGUIUtil.SetmultiTouchEnabled(false)

	if arg ~= nil then
		self.levelType = arg[1]
		self.transcriptId = arg[2]

		if arg[3] ~= nil then
			self.isChangeEnter = arg[3]
		else
			self.isChangeEnter = nil
		end

		local config = CombatFormationModel.DetectionTypeGetConfig(self.levelType, self.transcriptId)

		self.isAllowHelpHero = config.IsHelp

		if config.PlayerTeam ~= 0 then
			if config.PlayerTeam == 1 then
				self.ScreenTypeScroll.gameObject:SetActive(true)
				self.ScreenTypeBtn.gameObject:SetActive(true)
				self.TapGlob1:SetActive(config.PlayerTeam == CombatFormationModel.EaseFormation.One)
				self.TapGlob2:SetActive(config.PlayerTeam == CombatFormationModel.EaseFormation.Two)
				self.TapGlob3:SetActive(config.PlayerTeam == CombatFormationModel.EaseFormation.Three)
				self.tapContent:ToggleEvent("Glob1")
			else
				self.TapContent.gameObject:SetActive(false)
				CombatFormationModel.GetSpecialFormation(config.PlayerTeam)
				self:OnToggleTagChanged("Other", nil, config.PlayerTeam)
			end
		else
			self.TapContent.gameObject:SetActive(true)
			self.ScreenTypeScroll.gameObject:SetActive(true)
			self.ScreenTypeBtn.gameObject:SetActive(true)
			self.tapContent:ToggleEvent("Glob1")
		end
	else
		self.transcriptId = nil
		self.isAllowHelpHero = false

		self.tapContent:ToggleEvent("Glob1")
	end

	self.HelpHeroTips:SetActive(self.isAllowHelpHero)
	self:RefreshRoleDetailsPanel(false, nil)

	if CombatFormationModel.CurFormation.BaseData.Type == 1 then
		self.Islock.gameObject:SetActive(false)
		self.ScreenTypeScroll.gameObject:SetActive(true)
		self.ScreenTypeBtn.gameObject:SetActive(true)
	elseif CombatFormationModel.CurFormation.BaseData.Type == 2 then
		self.Islock.gameObject:SetActive(true)
		self.SiblingBottom.transform:SetAsLastSibling()
		self.ScreenTypeScroll.gameObject:SetActive(false)
		self.ScreenTypeBtn.gameObject:SetActive(false)
	elseif CombatFormationModel.CurFormation.BaseData.Type == 3 then
		self.Islock.gameObject:SetActive(false)
		self.ScreenTypeScroll.gameObject:SetActive(true)
		self.ScreenTypeBtn.gameObject:SetActive(true)
	end

	self:OperationProfessionAndElement(true)
	GuideModule.GoNextSubEventDispatch()

	DigitalRubyShared.FingersScript.Instance.enabled = false
end

function CombatForMationUI:DetectionTypeGetConfig(levelType, transcriptId)
	local config

	if levelType == Constant.ChapterPassType.TYPE_MAINLINE then
		config = CfgPlotDupStageTable[transcriptId]
	elseif levelType == Constant.ChapterPassType.TYPE_RESOURCES then
		config = CfgPlotDupStageTable[transcriptId]
	elseif levelType == Constant.ChapterPassType.TYPE_EQUIP then
		config = CfgPlotDupStageTable[transcriptId]
	end
end

function CombatForMationUI:OnClose(userData)
	if CombatFormationModel.CurFormation and CombatFormationModel.CurFormation.haveHelphero then
		AssistInFightingModule.ClearHelpHero(CombatFormationModel.CurFormation.FormationId)

		CombatFormationModel.CurFormation = nil
	end

	self:ResetPool()

	CombatFormationModel.CurChooseWarlockData = nil

	CombatFormationModel.ResetChangeDataTable()
	DigitalRubyShared.FingersScript.Instance:ResetState()

	DigitalRubyShared.FingersScript.Instance.enabled = true
end

function CombatForMationUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.ChooseHelpHeroDele, self.MyChooseHelpHeroDele)
	EventDispatcher.AddEventListener(EventID.ClearHelpHeroDele, self.OnCancelHelpHeroDelegate)
	EventDispatcher.AddEventListener(EventID.SaveFormationSucceed, self.SaveFormationSucceedDelegate)
	EventDispatcher.AddEventListener(EventID.OnSelectedGridCell, self.OnSelectedGridCellDelegate)
	self.ScreenTypeBtn_Btn.onClick:AddListener(self.ScreenTypeBtn_OnClick)
	self.StartBtn_Btn.onClick:AddListener(self.StartBtnClick_OnClick)
	self.CloseBtn_Btn.onClick:AddListener(self.CloseBtn_OnClick)
	self.CloseAllScreen_Btn.onClick:AddListener(self.CloseScreenTypeBtn_OnClick)
end

function CombatForMationUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ChooseHelpHeroDele, self.MyChooseHelpHeroDele)
	EventDispatcher.RemoveEventListener(EventID.ClearHelpHeroDele, self.OnCancelHelpHeroDelegate)
	EventDispatcher.RemoveEventListener(EventID.SaveFormationSucceed, self.SaveFormationSucceedDelegate)
	EventDispatcher.RemoveEventListener(EventID.OnSelectedGridCell, self.OnSelectedGridCellDelegate)
	self.ScreenTypeBtn_Btn.onClick:RemoveListener(self.ScreenTypeBtn_OnClick)
	self.StartBtn_Btn.onClick:RemoveListener(self.StartBtnClick_OnClick)
	self.CloseBtn_Btn.onClick:RemoveListener(self.CloseBtn_OnClick)
	self.CloseAllScreen_Btn.onClick:RemoveListener(self.CloseScreenTypeBtn_OnClick)
end

function CombatForMationUI:OnPause()
	return
end

function CombatForMationUI:OnResume()
	return
end

function CombatForMationUI:OnCover()
	self:RefreshRoleDetailsPanel(false, nil)
end

function CombatForMationUI:OnReveal()
	return
end

function CombatForMationUI:OnRefocus(userData)
	return
end

function CombatForMationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if CombatFormationModel.isTouch_drag_id ~= nil then
		if IQIGame.Onigao.Game.Device.isMobile then
			if UnityEngine.Input.touchCount > 0 and UGUIUtil.Touch() then
				if CombatFormationModel.CurPointDragData then
					self.heroList[CombatFormationModel.CurPointDragData.insID]:OnEndDrag()
				end

				if CombatFormationModel.CurPointDragDataIndex then
					self.cellList[CombatFormationModel.CurPointDragDataIndex]:OnEndDrag()
				end
			end
		elseif UnityEngine.Input.GetMouseButton(0) == false then
			if CombatFormationModel.CurPointDragData then
				self.heroList[CombatFormationModel.CurPointDragData.insID]:OnEndDrag()
			end

			if CombatFormationModel.CurPointDragDataIndex then
				self.cellList[CombatFormationModel.CurPointDragDataIndex]:OnEndDrag()
			end
		end
	end
end

function CombatForMationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CombatForMationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CombatForMationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CombatForMationUI:OnDestroy()
	if CombatFormationModel.CurFormation and CombatFormationModel.CurFormation.haveHelphero then
		AssistInFightingModule.ClearHelpHero(CombatFormationModel.CurFormation.FormationId)
	end

	self.FormationRoleDetailsView:Dispose()

	self.FormationRoleDetailsView = nil

	self.MyScreenWarlockList:OnDestroy()

	for i, v in pairs(self.heroList) do
		v:OnDestroy()
	end

	self.heroList = {}

	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	self.cellList = {}

	CombatFormationModel.ResetAll()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.TapContent, self)
end

return CombatForMationUI
