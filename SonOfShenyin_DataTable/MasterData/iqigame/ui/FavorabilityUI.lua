-- chunkname: @IQIGame\\UI\\FavorabilityUI.lua

local FavorabilityUI = {
	sortMark = true,
	FavorLv = 0,
	isMax = false,
	tapShow = false,
	FavorCellList = {},
	cellList = {},
	FavorCellTable = {},
	AwardCellList = {}
}

FavorabilityUI = Base:Extend("FavorabilityUI", "IQIGame.Onigao.UI.FavorabilityUI", FavorabilityUI)

local FavorabilityCell = require("IQIGame.UI.RoleDevelopment.FavorabilityCell")

function FavorabilityUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	LuaCodeInterface.BindOutlet(self.OtherLuaOutlet, self)
	LuaCodeInterface.BindOutlet(self.BaseInfo, self)
	LuaCodeInterface.BindOutlet(self.TapContent, self)
	LuaCodeInterface.BindOutlet(self.TaskRoot, self)
	self:InitDelegates()
	self:Initialize()
	UGUIUtil.SetText(self.tapdes1_1, RoleExtendApi:tap_destag1())
	UGUIUtil.SetText(self.tapdes1_2, RoleExtendApi:tap_destag1())
	UGUIUtil.SetText(self.tapdes2_1, RoleExtendApi:tap_destag2())
	UGUIUtil.SetText(self.tapdes2_2, RoleExtendApi:tap_destag2())
	UGUIUtil.SetText(self.intimacydes, RoleExtendApi:favor())
	UGUIUtil.SetText(self.attribuatedes, RoleExtendApi:attrides())
	UGUIUtil.SetText(self.Sendtext, RoleExtendApi:GetSendText())
	UGUIUtil.SetText(self.Resettext, RoleExtendApi:GetResetText())
	UGUIUtil.SetText(self.GotoText, RoleExtendApi:GetJumpText())
	UGUIUtil.SetText(self.FavorLVDes, RoleExtendApi:GetFavorLVDes())
	UGUIUtil.SetText(self.UnLockAttri, RoleExtendApi:GetUnLockAttri())
end

function FavorabilityUI:InitDelegates()
	function self.OnTogglePartChangedDelegate(go, isOn)
		self:OnTogglePartChanged(go, isOn)
	end

	function self.OnClick_Close(_self, go)
		self:OnCloseBtn(_self, go)
	end

	function self.DeOnClick_My(_self, go)
		self:OnClick_My(_self, go)
	end

	function self.OnClick_sortBtn(_self, go)
		self:OnClicksortBtn(_self, go)
	end

	function self.OnClick_tagbtn(_self, go)
		self:OnClicktagbtn(_self, go)
	end

	function self.OnClick_SendBtn(_self, go)
		self:OnClickSendBtn(_self, go)
	end

	function self.OnClick_ResetBtn(_self, go)
		self:OnClickResetBtn(_self, go)
	end

	function self.OnClick_GotoBtn(_self, go)
		self:OnClickGotoBtn(_self, go)
	end

	function self.OnClick_GetAwardBtn(_self, go)
		self:OnClickGetAwardBtn(_self, go)
	end

	function self.OnClick_HideUpLvBtn(_self, go)
		self:OnClickHideUpLvBtn(_self, go)
	end

	function self.DelegaTasksubmitSucceed(ItemShowPODList)
		self:OnTasksubmitSucceed(ItemShowPODList)
	end

	function self.DelegaTaskNotifyTask(ItemShowPODList)
		self:OnTaskNotifyTask(ItemShowPODList)
	end

	function self.DelegaSendFavorSucceed()
		self:SendFavorSucceedCall()
	end

	function self.DelegaPreviewClickCall()
		self:PreviewFavor()
	end
end

function FavorabilityUI:Initialize()
	self.HeroImgImg = self.HeroImg:GetComponent("Image")
	self.HeroNameText = self.HeroName:GetComponent("Text")
	self.HeroEnglishNameText = self.HeroEnglishName:GetComponent("Text")
	self.intimacylvText = self.intimacylv:GetComponent("Text")
	self.intimacyPreviewLvText = self.intimacyPreviewLv:GetComponent("Text")
	self.intimacyuplviconImg = self.intimacyuplvicon:GetComponent("Image")
	self.progressredImg = self.progressred:GetComponent("Image")
	self.sortBtnImg = self.sortBtn:GetComponent("Image")
	self.AddexpText = self.Addexp:GetComponent("Text")
	self.AddexpText.text = ""
	self.allproText = self.allpro:GetComponent("Text")
	self.curproText = self.curpro:GetComponent("Text")
	self.TagTextText = self.TagText:GetComponent("Text")
	self.tasktitleText = self.tasktitle:GetComponent("Text")
	self.taskcontentText = self.taskcontent:GetComponent("Text")
	self.ScrollAreaScroll = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.ScrollAreaScroll.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.FavorTapContent = TapContent:New()

	self.FavorTapContent:Init(self.TapContent.gameObject, self.OnTogglePartChangedDelegate)

	self.CloseBtnBtn = self.CloseBtn:GetComponent("Button")
	self.sortBtnBtn = self.sortBtn:GetComponent("Button")
	self.tagbtnBtn = self.tagbtn:GetComponent("Button")
	self.SendBtnBtn = self.SendBtn:GetComponent("Button")
	self.ResetBtnBtn = self.ResetBtn:GetComponent("Button")
	self.GotoBtnBtn = self.GotoBtn:GetComponent("Button")
	self.GetAwardBtnBtn = self.GetAwardBtn:GetComponent("Button")
	self.HideAttriUpLvPanelBtn = self.HideAttriUpLvPanel:GetComponent("Button")
end

function FavorabilityUI:OpenRefresh(WarlockData)
	self.FavorLv = self.heroData.favorabilityLevel

	self.intimacyuplvicon:SetActive(false)

	self.WarlockData = self.heroData

	if self.FavorConfig == nil then
		logError("有空配置id  " .. self.WarlockData.cid .. "  请检查 HeroFavor配置表")
	end

	local bgPath = WarlockModule.PreloadAssetPath[self.WarlockData.cid]
	local path = WarlockModule.curWarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)

	AssetUtil.LoadImage(self, path, self.HeroImgImg, function()
		self.View:SetActive(true)
		self.HeroImgImg:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(self.HeroImgImg:GetComponent(typeof(UnityEngine.RectTransform)), self.HeroImgImg)
	end)

	self.HeroNameText.text = self.heroData.BaseData.Name
	self.HeroEnglishNameText.text = self.heroData.BaseData.EnglishName

	self:RefreshLvExp()
	self.FavorTapContent:ToggleEvent("quality")
	self:AttributeInit()
	self:RefreshTask()
	self:RefreshExtendInit()
end

function FavorabilityUI:RefreshExtendInit()
	self.intimacyuplvicon:SetActive(false)
	self.intimacyPreviewLv:SetActive(false)
end

function FavorabilityUI:RefreshLvExp(isinit)
	local ismax
	local lv = 0

	lv = self.WarlockData.favorabilityLevel

	if isinit then
		-- block empty
	end

	self.isMax = self.WarlockData.favorabilityLevel == #RoleExtendModule.MaxTable
	ismax = self.isMax
	self.intimacylvText.text = lv

	if ismax then
		self.progressredImg.fillAmount = 1

		NoticeModule.ShowNotice(20036)
	else
		self.progressredImg.fillAmount = self.WarlockData.favorabilityExp / CfgFavorLvTable[self.WarlockData.favorabilityLevel + 1].FavorExp
	end

	if ismax == false then
		self.allproText.text = CfgFavorLvTable[self.WarlockData.favorabilityLevel + 1].FavorExp
		self.curproText.text = self.WarlockData.favorabilityExp
	else
		self.allproText.text = "-"
		self.curproText.text = "-"
	end
end

function FavorabilityUI:PreviewFavor()
	local PreveiwLv, PreviewCurExp, PreviewNextExp, PreveiwisMax, PreveiwLv2 = RoleExtendModule.PreviewExpAndLv()

	self.intimacyPreviewLvText.text = PreveiwLv2

	if PreveiwisMax then
		self.progressredImg.fillAmount = 1
		self.allproText.text = "-"
		self.curproText.text = "-"
	else
		self.progressredImg.fillAmount = PreviewCurExp / PreviewNextExp
		self.curproText.text = PreviewCurExp
		self.allproText.text = PreviewNextExp
	end

	if PreveiwLv2 > self.heroData.favorabilityLevel then
		self.intimacyuplvicon:SetActive(true)
		self.intimacyPreviewLv:SetActive(true)
	else
		self.intimacyuplvicon:SetActive(false)
		self.intimacyPreviewLv:SetActive(false)
	end
end

function FavorabilityUI:LoadImage(path, icon)
	icon.sprite = self.MainUIController:GetPreloadedAsset(path)
	icon.transform.localScale = Vector3.New(1, 1, 1)

	icon:SetNativeSize()
end

function FavorabilityUI:RefreshTask()
	self.CurTaskData = nil

	local FavorTaskLvIndex = 0
	local TaskIdTable = {}

	for i = 1, #self.FavorConfig.FavorTaskLv do
		if self.FavorConfig.FavorTaskLv[i] <= self.heroData.favorabilityLevel then
			table.insert(TaskIdTable, self.FavorConfig.TaskId[i])
		end
	end

	for i = 1, #TaskIdTable do
		if TaskSystemModule.taskSystemDataDic[TaskIdTable[i]] ~= nil then
			self.CurTaskData = TaskSystemModule.taskSystemDataDic[TaskIdTable[i]]

			break
		end
	end

	self:IsActiveTaskRefresh()
end

function FavorabilityUI:IsActiveTaskRefresh()
	local isActiveTask = false

	if self.CurTaskData then
		if self.CurTaskData.status == 1 then
			isActiveTask = true

			self.GotoBtn:SetActive(true)
			self.GetAwardBtn:SetActive(false)
		elseif self.CurTaskData.status == 2 then
			isActiveTask = true

			self.GotoBtn:SetActive(false)
			self.GetAwardBtn:SetActive(true)
		end
	end

	if isActiveTask then
		self.tasktitleText.text = self.CurTaskData.BaseData.Name
		self.taskcontentText.text = self.CurTaskData.BaseData.Name

		self.TaskRoot:SetActive(true)

		self.BaseInfo.gameObject.transform.localPosition = Vector3.New(0, 41, 0)

		self:TaskAward()
	else
		self.BaseInfo.gameObject.transform.localPosition = Vector3.New(0, 0, 0)

		self.TaskRoot:SetActive(false)
	end
end

function FavorabilityUI:TaskAward()
	local ActionParam = UIUtil.GetConfigArr(self.CurTaskData.BaseData.ActionParam)
	local ActionParamLength = #ActionParam
	local AwardCellListLength = #self.AwardCellList
	local Length = AwardCellListLength < ActionParamLength and ActionParamLength or AwardCellListLength

	for i = 1, Length do
		if i <= ActionParamLength then
			if self.AwardCellList[i] == nil then
				local itemAwardObj = UnityEngine.Object.Instantiate(self.AwardObj.gameObject)

				itemAwardObj.name = i

				itemAwardObj.transform:SetParent(self.AwardGrid.transform, false)

				local ItemCell = ItemCell.New(itemAwardObj, true, true)

				self.AwardCellList[i] = {
					obj = itemAwardObj,
					userTable = {},
					ItemCell = ItemCell
				}
			end

			self.AwardCellList[i].obj:SetActive(true)

			local itemActionParam = ActionParam[i]
			local ItemData = ItemData.CreateByCIDAndNumber(itemActionParam[1], itemActionParam[2])

			self.AwardCellList[i].ItemCell:SetItem(ItemData, itemActionParam[2])
			self.AwardCellList[i].ItemCell:SetNum(itemActionParam[2])
		elseif self.AwardCellList[i] ~= nil then
			self.AwardCellList[i].obj:SetActive(false)
		end
	end
end

function FavorabilityUI:AttributeInit()
	local FavorData_len = #self.FavorConfig.FavorAttrValue
	local FavorCell_len = table.len(self.FavorCellList)
	local Length = FavorCell_len < FavorData_len and FavorData_len or FavorCell_len

	for i = 1, Length do
		if i <= FavorData_len then
			if self.FavorCellList[i] == nil then
				local itemFavorObj = UnityEngine.Object.Instantiate(self.attriObj.gameObject)
				local itemShowFavorObj = UnityEngine.Object.Instantiate(self.AddattriObj.gameObject)

				itemFavorObj.name = i

				itemFavorObj.transform:SetParent(self.attriGrid.transform, false)
				itemShowFavorObj.transform:SetParent(self.AddAttriGrid.transform, false)

				self.FavorCellList[i] = {
					obj = itemFavorObj,
					userTable = {},
					AddLvObj = itemShowFavorObj,
					userTable2 = {}
				}

				local userTable = self.FavorCellList[i].userTable
				local userTable2 = self.FavorCellList[i].userTable2

				LuaCodeInterface.BindOutlet(self.FavorCellList[i].obj, userTable)
				LuaCodeInterface.BindOutlet(self.FavorCellList[i].AddLvObj, userTable2)

				self.FavorCellList[i].AttLvText = userTable.AttLv:GetComponent("Text")
				self.FavorCellList[i].AttnameText = userTable.Attname:GetComponent("Text")
				self.FavorCellList[i].AttnumText = userTable.Attnum:GetComponent("Text")
				self.FavorCellList[i].Add_LvDes = userTable2._LvDes:GetComponent("Text")
				self.FavorCellList[i].Add_LvValue = userTable2._LvValue:GetComponent("Text")
				self.FavorCellList[i].Add_AttrDes = userTable2._AttrDes:GetComponent("Text")
				self.FavorCellList[i].Add_AttriValue = userTable2._AttriValue:GetComponent("Text")
			end

			self.FavorCellList[i].obj:SetActive(true)
			self.FavorCellList[i].AddLvObj:SetActive(false)

			self.FavorCellList[i].AttLvText.text = OtherExtendApi:GetTextTitle_1() .. self.FavorConfig.FavorLv[i]
			self.FavorCellList[i].AttnameText.text = CfgAttributeTable[self.FavorConfig.FavorAttrType[i]].Name
			self.FavorCellList[i].AttnumText.text = "+" .. self.FavorConfig.FavorAttrValue[i]

			if self.FavorConfig.FavorLv[i] <= self.heroData.favorabilityLevel then
				UGUIUtil.SetColor(self.FavorCellList[i].AttLvText, Color.New(1, 1, 1, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnameText, Color.New(0.9921568627450981, 0.8823529411764706, 0.1607843137254902, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnumText, Color.New(0.9921568627450981, 0.8823529411764706, 0.1607843137254902, 1))
			else
				UGUIUtil.SetColor(self.FavorCellList[i].AttLvText, Color.New(0.5450980392156862, 0.5450980392156862, 0.5450980392156862, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnameText, Color.New(0.5450980392156862, 0.5450980392156862, 0.5450980392156862, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnumText, Color.New(0.5450980392156862, 0.5450980392156862, 0.5450980392156862, 1))
			end
		elseif self.FavorCellList[i] ~= nil then
			self.FavorCellList[i].obj:SetActive(false)
		end
	end
end

function FavorabilityUI:RefreshAttribute(FavorCellList)
	for i = 1, #FavorCellList do
		if self.FavorConfig.FavorLv[i] ~= nil then
			if self.FavorConfig.FavorLv[i] <= self.heroData.favorabilityLevel then
				UGUIUtil.SetColor(self.FavorCellList[i].AttLvText, Color.New(1, 1, 1, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnameText, Color.New(0.9921568627450981, 0.8823529411764706, 0.1607843137254902, 1))
				UGUIUtil.SetColor(self.FavorCellList[i].AttnumText, Color.New(0.9921568627450981, 0.8823529411764706, 0.1607843137254902, 1))
			end

			if self.FavorConfig.FavorLv[i] > self.FavorLv and self.FavorConfig.FavorLv[i] <= self.heroData.favorabilityLevel then
				self.AttributeUpLvShow:SetActive(true)
				self.FavorCellList[i].AddLvObj:SetActive(true)

				self.FavorCellList[i].Add_LvDes.text = RoleExtendApi:GetTips_Type1_8()
				self.FavorCellList[i].Add_LvValue.text = self.FavorConfig.FavorLv[i]
				self.FavorCellList[i].Add_AttrDes.text = CfgAttributeTable[self.FavorConfig.FavorAttrType[i]].Name
				self.FavorCellList[i].Add_AttriValue.text = self.FavorConfig.FavorAttrValue[i]
			else
				self.FavorCellList[i].AddLvObj:SetActive(false)
			end
		end
	end
end

function FavorabilityUI:UpLvRefresh()
	self.heroData = WarlockModule.WarlockDataDic[self.heroCid]

	self:RefreshAttribute(self.FavorCellList)
	self:RefreshLvExp(true)
	self:RefreshTask()

	self.FavorLv = self.heroData.favorabilityLevel
end

function FavorabilityUI:OnRenderGridCell(gridCellData)
	local data = self.SortCustomList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList[insID]

	data.insID = insID

	if cell == nil then
		cell = FavorabilityCell.New(gridCellData.gameObject, self)
		self.cellList[insID] = cell
	end

	cell:RefreshItemCell(data, self.UIController)

	gridCellData.gameObject.name = data.cid
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index + 1
end

function FavorabilityUI:ResetItemCell()
	for i = 1, #self.SortCustomList do
		if self.SortCustomList[i].insID ~= nil and self.cellList[self.SortCustomList[i].insID] ~= nil then
			self.cellList[self.SortCustomList[i].insID]:RefreshItemCell(self.SortCustomList[i], self.UIController)
		end
	end
end

function FavorabilityUI:OnTogglePartChanged(go_name)
	self.ToggleName = go_name

	if go_name == "quality" then
		self.TagTextText.text = RoleExtendApi:GetTips_Type1_1()
		self.sortType = RoleExtendModule.sortType.EaseQuality
	elseif go_name == "number" then
		self.TagTextText.text = RoleExtendApi:GetTips_Type1_2()
		self.sortType = RoleExtendModule.sortType.EaseNum
	end

	self.tapShow = false

	self:OnClicktagbtn()
	self:SortDateList()
end

function FavorabilityUI:SortDateList()
	self.SortCustomList = RoleExtendModule.GetSortedSoulDataList(self.sortType, RoleExtendModule.TargetCustomDic)

	self.ScrollAreaScroll:Refresh(#self.SortCustomList)
end

function FavorabilityUI:OnCloseBtn(_self, go)
	RoleExtendModule.ResetAll()
	UIModule.Close(Constant.UIControllerName.FavorabilityUI)
end

function FavorabilityUI:OnClicksortBtn(_self, go)
	self.sortMark = not self.sortMark

	local Favorabilitypath

	if self.sortMark == false then
		Favorabilitypath = WarlockApi:FavorabilityPositive()
	else
		Favorabilitypath = WarlockApi:FavorabilityAntitone()
	end

	AssetUtil.LoadImage(self, Favorabilitypath, self.sortBtnImg)

	RoleExtendModule.isUpSort = not RoleExtendModule.isUpSort

	self:SortDateList()
end

function FavorabilityUI:OnClicktagbtn(_self, go)
	self.tapShow = not self.tapShow

	local localScale_y, localRotation_z

	if self.tapShow == false then
		localScale_y = 1
		localRotation_z = 180
	else
		localRotation_z = 0
		localScale_y = 0
	end

	self.tagarr.gameObject.transform.localScale = Vector3.New(0, 0, localRotation_z)
	self.CurTapContent.gameObject.transform.localScale = Vector3.New(1, localScale_y, 1)
end

function FavorabilityUI:OnClickSendBtn(_self, go)
	if self.isMax then
		NoticeModule.ShowNotice(20005)

		return
	end

	if table.len(RoleExtendModule.CustomItemDic) == 0 then
		NoticeModule.ShowNotice(12003)

		return
	end

	RoleExtendModule.FavorabilityExpItem(self.heroData.cid, RoleExtendModule.CustomItemDic)
end

function FavorabilityUI:OnClickResetBtn(_self, go)
	if RoleExtendModule.PreviewAddExp == 0 then
		return
	end

	for i, v in pairs(self.cellList) do
		v:ResetAll()
	end

	RoleExtendModule.PreviewAddExp = 0

	if RoleExtendModule.OperateData.Data ~= nil then
		RoleExtendModule.OperateData.Data.ItemAddOrSubCount = 0
	end

	for i = 1, #self.SortCustomList do
		self.SortCustomList[i].ItemCustomCount = 0
	end

	self.ScrollAreaScroll:Refresh(#self.SortCustomList)

	self.AddexpText.text = ""

	self:PreviewFavor()
end

function FavorabilityUI:OnClickGotoBtn(_self, go)
	UIModule.Close(Constant.UIControllerName.FavorabilityUI)
end

function FavorabilityUI:OnClickGetAwardBtn(_self, go)
	local cids = {}

	table.insert(cids, self.CurTaskData.cid)
	log(" self.Data.cid   " .. self.CurTaskData.cid)
	TaskSystemModule.SubmitTask(cids)
end

function FavorabilityUI:OnTasksubmitSucceed(ItemShowPODList)
	self:RefreshTask()
end

function FavorabilityUI:OnTaskNotifyTask(tasks)
	if TaskSystemModule:GetSubmitTaskMark() == true then
		return
	end

	local taskTypeisFavor = false

	for i, v in pairs(tasks) do
		if TaskSystemModule.CheckTaskMainTypeAndExtendType(v.Id, Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Favorability) then
			taskTypeisFavor = true

			break
		end
	end

	if taskTypeisFavor == true then
		self:RefreshTask()
	end
end

function FavorabilityUI:SendFavorSucceedCall()
	NoticeModule.ShowNotice(14008)
	self:UpLvRefresh()
	self:ResetItemCell()
	self.intimacyuplvicon:SetActive(false)
	self.intimacyPreviewLv:SetActive(false)

	if RoleExtendModule.ScrollAreaScrollRefresh then
		self:SortDateList()

		RoleExtendModule.ScrollAreaScrollRefresh = false
	end
end

function FavorabilityUI:OnClickHideUpLvBtn(_self, go)
	self.AttributeUpLvShow:SetActive(false)
end

function FavorabilityUI:GetPreloadAssetPaths()
	return nil
end

function FavorabilityUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FavorabilityUI:IsManualShowOnOpen(userData)
	return false
end

function FavorabilityUI:GetBGM(userData)
	return nil
end

function FavorabilityUI:OnOpen(heroCid)
	self.heroCid = heroCid
	self.heroData = WarlockModule.WarlockDataDic[heroCid]

	RoleExtendModule.SetLimitMaxExp()

	self.MainUIController = RoleExtendModule.RoleDevelopment_UIController

	RoleExtendModule.GetFavorabilityIntensifyMaterials()
	self.View:SetActive(false)
	self:OpenRefresh()
end

function FavorabilityUI:OnClose(userData)
	return
end

function FavorabilityUI:OnAddListeners()
	self.CloseBtnBtn.onClick:AddListener(self.OnClick_Close)
	self.sortBtnBtn.onClick:AddListener(self.OnClick_sortBtn)
	self.tagbtnBtn.onClick:AddListener(self.OnClick_tagbtn)
	self.SendBtnBtn.onClick:AddListener(self.OnClick_SendBtn)
	self.ResetBtnBtn.onClick:AddListener(self.OnClick_ResetBtn)
	self.GotoBtnBtn.onClick:AddListener(self.OnClick_GotoBtn)
	self.GetAwardBtnBtn.onClick:AddListener(self.OnClick_GetAwardBtn)
	self.HideAttriUpLvPanelBtn.onClick:AddListener(self.OnClick_HideUpLvBtn)
	EventDispatcher.AddEventListener(EventID.TaskSubmitSucceed, self.DelegaTasksubmitSucceed)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegaTaskNotifyTask)
	EventDispatcher.AddEventListener(EventID.FavorabilityExpItemResult, self.DelegaSendFavorSucceed)
end

function FavorabilityUI:OnRemoveListeners()
	self.CloseBtnBtn.onClick:RemoveListener(self.OnClick_Close)
	self.sortBtnBtn.onClick:RemoveListener(self.OnClick_sortBtn)
	self.tagbtnBtn.onClick:RemoveListener(self.OnClick_tagbtn)
	self.SendBtnBtn.onClick:RemoveListener(self.OnClick_SendBtn)
	self.ResetBtnBtn.onClick:RemoveListener(self.OnClick_ResetBtn)
	self.GotoBtnBtn.onClick:RemoveListener(self.OnClick_GotoBtn)
	self.GetAwardBtnBtn.onClick:RemoveListener(self.OnClick_GetAwardBtn)
	self.HideAttriUpLvPanelBtn.onClick:RemoveListener(self.OnClick_HideUpLvBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskSubmitSucceed, self.DelegaTasksubmitSucceed)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegaTaskNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.FavorabilityExpItemResult, self.DelegaSendFavorSucceed)
end

function FavorabilityUI:AddClick(button, action)
	button.onClick:AddListener(function()
		action(self, button.gameObject)
	end)
end

function FavorabilityUI:RemoveClick(button, action)
	button.onClick:RemoveListener(function()
		action(self, button.gameObject)
	end)
end

function FavorabilityUI:OnPause()
	return
end

function FavorabilityUI:OnResume()
	return
end

function FavorabilityUI:OnCover()
	return
end

function FavorabilityUI:OnReveal()
	return
end

function FavorabilityUI:OnRefocus(userData)
	return
end

function FavorabilityUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FavorabilityUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FavorabilityUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FavorabilityUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FavorabilityUI:OnDestroy()
	RoleExtendModule.ResetAll()

	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	self.cellList = {}

	LuaCodeInterface.ClearOutlet(self.OtherLuaOutlet, self)
	LuaCodeInterface.ClearOutlet(self.TapContent, self)
	LuaCodeInterface.ClearOutlet(self.BaseInfo, self)
	LuaCodeInterface.ClearOutlet(self.TaskRoot, self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)
end

return FavorabilityUI
