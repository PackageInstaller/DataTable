-- chunkname: @IQIGame\\UI\\HomeLandRoomComfortUI.lua

local HomeLandRoomComfortUI = Base:Extend("HomeLandRoomComfortUI", "IQIGame.Onigao.UI.HomeLandRoomComfortUI", {})

function HomeLandRoomComfortUI:OnInit()
	UGUIUtil.SetText(self.TextTitle2, HomeLandRoomComfortUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextTitle3, HomeLandRoomComfortUIApi:GetString("TextTitle3"))
	UGUIUtil.SetText(self.TextTitle4, HomeLandRoomComfortUIApi:GetString("TextTitle4"))
	UGUIUtil.SetText(self.TextTitle5, HomeLandRoomComfortUIApi:GetString("TextTitle5"))
	UGUIUtil.SetText(self.TextTitle6, HomeLandRoomComfortUIApi:GetString("TextTitle6"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnTipComponent = self.BtnTip:GetComponent("Button")
	self.scrollAreaComponent1 = self.ScrollArea1:GetComponent("ScrollAreaList")

	function self.scrollAreaComponent1.onRenderCell(cell)
		self:OnRenderCell1(cell)
	end

	self.scrollAreaComponent2 = self.ScrollArea2:GetComponent("ScrollAreaList")

	function self.scrollAreaComponent2.onRenderCell(cell)
		self:OnRenderCell2(cell)
	end

	function self.delegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.delegateUpdateBaseInfo()
		self:UpDataView()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end
end

function HomeLandRoomComfortUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandRoomComfortUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandRoomComfortUI:OnOpen(userData)
	self.roomPOD = HomeLandLuaModule.GetRoomDataByID(userData)

	self:UpDataView()
end

function HomeLandRoomComfortUI:OnClose(userData)
	return
end

function HomeLandRoomComfortUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateOnBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateOnBtnClose)
	self.btnTipComponent.onClick:AddListener(self.delegateBtnTip)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
end

function HomeLandRoomComfortUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateOnBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnClose)
	self.btnTipComponent.onClick:RemoveListener(self.delegateBtnTip)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
end

function HomeLandRoomComfortUI:OnPause()
	return
end

function HomeLandRoomComfortUI:OnResume()
	return
end

function HomeLandRoomComfortUI:OnCover()
	return
end

function HomeLandRoomComfortUI:OnReveal()
	return
end

function HomeLandRoomComfortUI:OnRefocus(userData)
	return
end

function HomeLandRoomComfortUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandRoomComfortUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandRoomComfortUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandRoomComfortUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandRoomComfortUI:OnDestroy()
	return
end

function HomeLandRoomComfortUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandRoomComfortUI)
end

function HomeLandRoomComfortUI:UpDataView()
	local cfgRoom = CfgHomeLandRoomTable[self.roomPOD.cid]
	local roomName = cfgRoom.Name

	if self.roomPOD.name ~= nil and self.roomPOD.name ~= "" then
		roomName = self.roomPOD.name
	end

	UGUIUtil.SetText(self.TextName, roomName)

	local lv = HomeLandLuaModule.GetHomeLandDormitoryComfortLv(self.roomPOD.comfort)
	local str = ""

	for i, v in pairsCfg(CfgCheckInSoulMoodReduceEffectTable) do
		if v.level == lv then
			str = v.ChangeMoodSpeedWord

			break
		end
	end

	UGUIUtil.SetText(self.TextTitle1, str)
	UGUIUtil.SetText(self.TextValue, tostring(self.roomPOD.comfort))

	self.themeTable, self.decorateTab = self:GetDataList()

	self.scrollAreaComponent1:Refresh(#self.decorateTab)

	self.themeIDs = {}

	for i, v in pairs(self.themeTable) do
		table.insert(self.themeIDs, i)
	end

	self.scrollAreaComponent2:Refresh(#self.themeIDs)

	local baseComfort, themeComfort = self:GetComfort()
	local maxBaseComfort = CfgDiscreteDataTable[6520047].Data[1]
	local maxThemeComfort = CfgDiscreteDataTable[6520047].Data[2]

	UGUIUtil.SetText(self.TextBaseComfort, HomeLandRoomComfortUIApi:GetString("TextBaseComfort", baseComfort, maxBaseComfort))
	UGUIUtil.SetText(self.TextThemeComfort, HomeLandRoomComfortUIApi:GetString("TextThemeComfort", themeComfort, maxThemeComfort))

	self.PerBaseComfort:GetComponent("Image").fillAmount = baseComfort / maxBaseComfort
	self.PerThemeComfort:GetComponent("Image").fillAmount = themeComfort / maxThemeComfort
end

function HomeLandRoomComfortUI:GetComfort()
	local baseComfort = 0
	local themeComfort = 0

	for i, v in pairs(self.decorateTab) do
		local cfgDecorate = CfgHomeLandDecorateTable[v]

		baseComfort = baseComfort + cfgDecorate.Score
	end

	for i, v in pairs(self.themeIDs) do
		local cfgTheme = CfgHomeLandDecorateThemeTable[v]
		local have = #self.themeTable[v]
		local score = 0

		for i = 1, #cfgTheme.Score, 2 do
			local topN = cfgTheme.Score[i]

			if topN <= have then
				score = cfgTheme.Score[i + 1]
			end
		end

		themeComfort = themeComfort + score
	end

	return baseComfort, themeComfort
end

function HomeLandRoomComfortUI:OnRenderCell1(cell)
	local cid = self.decorateTab[cell.index + 1]

	if cid == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local cfgDecorate = CfgHomeLandDecorateTable[cid]

	if cfgDecorate.ThemeID > 0 then
		local cfgTheme = CfgHomeLandDecorateThemeTable[cfgDecorate.ThemeID]
		local themeName = cfgTheme.Name

		UGUIUtil.SetText(cell.gameObject.transform:Find("Text_01").gameObject, HomeLandRoomComfortUIApi:GetString("TextDecorateName", cfgDecorate.Name, themeName, true))
	else
		UGUIUtil.SetText(cell.gameObject.transform:Find("Text_01").gameObject, HomeLandRoomComfortUIApi:GetString("TextDecorateName", cfgDecorate.Name, "", false))
	end

	UGUIUtil.SetText(cell.gameObject.transform:Find("Text_02").gameObject, cfgDecorate.Score)
end

function HomeLandRoomComfortUI:OnRenderCell2(cell)
	local themeID = self.themeIDs[cell.index + 1]

	if themeID == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local cfgTheme = CfgHomeLandDecorateThemeTable[themeID]
	local total = cfgTheme.Score[#cfgTheme.Score - 1]
	local have = #self.themeTable[themeID]
	local score = 0

	for i = 1, #cfgTheme.Score, 2 do
		local topN = cfgTheme.Score[i]

		if topN <= have then
			score = cfgTheme.Score[i + 1]
		end
	end

	UGUIUtil.SetText(cell.gameObject.transform:Find("Text_01").gameObject, HomeLandRoomComfortUIApi:GetString("TextThemeName", cfgTheme.Name, have, total))
	UGUIUtil.SetText(cell.gameObject.transform:Find("Text_02").gameObject, tostring(score))
end

function HomeLandRoomComfortUI:GetDataList()
	local tab = {}
	local ids = HomeLandLuaModule.GetDecorateIds(self.roomPOD.cid)

	table.sort(ids, HomeLandRoomComfortUI.Sort)

	for i, v in pairs(ids) do
		local cfgDecorate = CfgHomeLandDecorateTable[v]

		if cfgDecorate.ThemeID > 0 then
			if tab[cfgDecorate.ThemeID] == nil then
				tab[cfgDecorate.ThemeID] = {}
			end

			table.insert(tab[cfgDecorate.ThemeID], cfgDecorate)
		end
	end

	return tab, ids
end

function HomeLandRoomComfortUI.Sort(tab1, tab2)
	local themeID1 = CfgHomeLandDecorateTable[tab1].ThemeID
	local themeID2 = CfgHomeLandDecorateTable[tab2].ThemeID

	return themeID1 < themeID2
end

function HomeLandRoomComfortUI:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		HomeLandRoomComfortUIApi:GetString("TextTip", HomeLandLuaModule.GetHomeLandDormitoryComfortLv(self.roomPOD.comfort))
	})
end

return HomeLandRoomComfortUI
