-- chunkname: @IQIGame\\UI\\Setting\\SettingPublicView.lua

local SettingPublicView = {
	numImg = {}
}
local SettingChangeIconView = require("IQIGame.UI.Setting.SettingChangeIconView")
local SettingChangeNameView = require("IQIGame.UI.Setting.SettingChangeNameView")

function SettingPublicView.__New(ui)
	local o = Clone(SettingPublicView)

	o:InitView(ui)

	return o
end

function SettingPublicView:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.TextTitle:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextTitle")
	self.PlaceHolder:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextPlaceHolder")

	UGUIUtil.SetText(self.TextBtnCopy, SettingPlayerInfoViewApi:GetString("TextBtnCopy"))

	self.btnEditNameComponent = self.BtnEditName:GetComponent("Button")
	self.btnHeadIconComponent = self.BtnHeadIcon:GetComponent("Button")
	self.btnSaveComponent = self.BtnSave:GetComponent("Button")
	self.btnCopy = self.BtnCopy:GetComponent("Button")
	self.inputComponent = self.InputDes:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	function self.delegateClickBtnEditName()
		self:OnClickBtnEditName()
	end

	function self.delegateClickBtnHeadIcon()
		self:OnClickBtnHeadIcon()
	end

	function self.delegateClickBtnSave()
		self:OnClickBtnSave()
	end

	function self.delegateSettingChangeEvent()
		self:UpDateView()
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChange()
	end

	function self.delegateClickBtnCopy()
		self:OnBtnCopy()
	end

	function self.delegateBtnEditPlayerTitle()
		self:OnBtnEditPlayerTitle()
	end

	function self.delegateBtnPreviewCard()
		self:OnBtnPreviewCard()
	end

	self.settingChangeIconView = SettingChangeIconView.__New(self.ChangeIcon)
	self.settingChangeNameView = SettingChangeNameView.__New(self.ChangeName)
end

function SettingPublicView:AddEventListener()
	self.btnEditNameComponent.onClick:AddListener(self.delegateClickBtnEditName)
	self.btnHeadIconComponent.onClick:AddListener(self.delegateClickBtnHeadIcon)
	self.btnSaveComponent.onClick:AddListener(self.delegateClickBtnSave)
	self.btnCopy.onClick:AddListener(self.delegateClickBtnCopy)
	self.BtnEditPlayerTitle:GetComponent("Button").onClick:AddListener(self.delegateBtnEditPlayerTitle)
	self.BtnPreviewCard:GetComponent("Button").onClick:AddListener(self.delegateBtnPreviewCard)
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function SettingPublicView:RemoveEventListener()
	self.btnEditNameComponent.onClick:RemoveListener(self.delegateClickBtnEditName)
	self.btnHeadIconComponent.onClick:RemoveListener(self.delegateClickBtnHeadIcon)
	self.btnSaveComponent.onClick:RemoveListener(self.delegateClickBtnSave)
	self.btnCopy.onClick:RemoveListener(self.delegateClickBtnCopy)
	self.BtnEditPlayerTitle:GetComponent("Button").onClick:RemoveListener(self.delegateBtnEditPlayerTitle)
	self.BtnPreviewCard:GetComponent("Button").onClick:RemoveListener(self.delegateBtnPreviewCard)
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function SettingPublicView:UpDateView()
	UGUIUtil.SetText(self.TextEmpty, SettingUIApi:GetString("TextEmpty"))
	UGUIUtil.SetText(self.TextBtnPreviewCard, SettingUIApi:GetString("TextBtnPreviewCard"))

	self.TextID:GetComponent("Text").text = SettingPlayerInfoViewApi:GetString("TextID", PlayerModule.PlayerInfo.baseInfo.guid)
	self.TextName:GetComponent("Text").text = PlayerModule.PlayerInfo.baseInfo.pName

	if PlayerModule.PlayerInfo.baseInfo.intro ~= nil then
		self.inputComponent.text = PlayerModule.PlayerInfo.baseInfo.intro
		self.PlaceHolder:GetComponent("Text").text = PlayerModule.PlayerInfo.baseInfo.intro
	else
		self.inputComponent.text = ""
	end

	local playerHeadData = SettingModule.GetPlayHeadData(PlayerModule.PlayerInfo.baseInfo.headIcon)
	local iconPath = UIGlobalApi.IconPath .. playerHeadData.cfgInfo.Url

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))

	local playerHeadFrameData = SettingModule.GetPlayHeadFrameData(PlayerModule.PlayerInfo.baseInfo.avatarFrame)

	if playerHeadFrameData then
		local path = UIGlobalApi.GetPrefabRoot(playerHeadFrameData.cfgInfo.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
	end

	self:OnPlayerInfoChange()
	self.BtnSave:SetActive(false)
	self.PlaceHolder:SetActive(true)
	self.BtnEditName:SetActive(true)
	self:ShowTitle()
	self.GuildInfoNode:SetActive(PlayerModule.PlayerInfo.guildId ~= 0)

	local guildName = PlayerModule.PlayerInfo.guildName == nil and "" or PlayerModule.PlayerInfo.guildName

	UGUIUtil.SetText(self.GuildName, guildName)
end

function SettingPublicView:ShowTitle()
	local settingTitle = PlayerModule.PlayerInfo.baseInfo.title
	local isSetTitle = settingTitle ~= nil and settingTitle > 0

	self.TextEmpty:SetActive(not isSetTitle)
	self.TextTitleName:SetActive(isSetTitle)

	for i = 0, self.PlayerTitleBox.transform.childCount - 1 do
		local obj = self.PlayerTitleBox.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	if isSetTitle then
		local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[settingTitle].Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadTitleSucceed, nil)
		UGUIUtil.SetText(self.TextTitleName, CfgPlayerCoatOfArmsTable[settingTitle].Name)
	end
end

function SettingPublicView:OnLoadTitleSucceed(assetName, asset, duration, userData)
	local goTitle = UnityEngine.Object.Instantiate(asset)

	goTitle.transform:SetParent(self.PlayerTitleBox.transform, false)
end

function SettingPublicView:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.HeadFrame.transform.childCount - 1 do
		local obj = self.HeadFrame.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goFrame = UnityEngine.Object.Instantiate(asset)

	goFrame.transform:SetParent(self.HeadFrame.transform, false)
	UIUtil.InitSortedComponents(self.rootUI:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
end

function SettingPublicView:GetAchievementPer()
	local com = 0
	local total = 0
	local dataTab = self:InitDatum()

	for i, v in pairs(dataTab) do
		local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NORMAL_TASK, {
			v
		})
		local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.NORMAL_TASK, {
			v
		})

		com = com + #finished
		total = total + #processing
	end

	return com, total
end

function SettingPublicView:InitDatum()
	local temp = {}

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.NORMAL_TASK then
			temp[v.TypeParam[1]] = v.TypeParam[1]
		end
	end

	local tab = {}

	for i, v in pairs(temp) do
		table.insert(tab, v)
	end

	return tab
end

function SettingPublicView:OnPlayerInfoChange()
	local playerLevelCfg = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv]
	local value = CfgDiscreteDataTable[6520060].Data[1]

	UGUIUtil.SetText(self.TextMaxLv, SettingUIApi:GetString("TextMaxLv", value))

	if playerLevelCfg.Experience == 0 or value == PlayerModule.PlayerInfo.baseInfo.pLv then
		self.ImgProcess:GetComponent("Image").fillAmount = 1
		self.TextProcess1:GetComponent("Text").text = SettingUIApi:GetString("TextExp", PlayerModule.PlayerInfo.baseInfo.exp, PlayerModule.PlayerInfo.baseInfo.exp, PlayerModule.PlayerInfo.baseInfo.pLv, value)
	else
		self.ImgProcess:GetComponent("Image").fillAmount = PlayerModule.PlayerInfo.baseInfo.exp / playerLevelCfg.Experience
		self.TextProcess1:GetComponent("Text").text = SettingUIApi:GetString("TextExp", PlayerModule.PlayerInfo.baseInfo.exp, playerLevelCfg.Experience, PlayerModule.PlayerInfo.baseInfo.pLv, value)
	end

	self:ShowPlayerLv()
end

function SettingPublicView:ShowPlayerLv()
	local lv = PlayerModule.PlayerInfo.baseInfo.pLv
	local lvString = tostring(lv)
	local reverseLvString = string.reverse(lvString)
	local index = 1

	for i = #self.numImg, 1, -1 do
		local numImgObj = self.numImg[i]
		local str = string.sub(reverseLvString, index, index)

		if str ~= "" then
			numImgObj:SetActive(true)
			AssetUtil.LoadImage(self, SettingUIApi:GetString("imgLvPath", tonumber(str)), numImgObj:GetComponent("Image"))
		else
			numImgObj:SetActive(false)
		end

		index = index + 1
	end
end

function SettingPublicView:OnUpdate()
	if self.inputComponent.isFocused ~= self.isEditConfirm then
		self.isEditConfirm = self.inputComponent.isFocused
		self.strValue = self.inputComponent.text

		if self.isEditConfirm == true then
			self.PlaceHolder:SetActive(false)
			self.BtnSave:SetActive(true)
		end
	end
end

function SettingPublicView:OnClickBtnSave()
	self.PlaceHolder:SetActive(false)
	self.BtnSave:SetActive(false)

	if self.strValue == nil or self.strValue == "" then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg"))
		self.PlaceHolder:SetActive(true)

		return
	end

	if WarnStrFunc:isWarningInPutStr(self.strValue) then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg6"))

		self.inputComponent.text = WarnStrFunc:warningStrGsub(self.strValue)

		self.PlaceHolder:SetActive(true)

		return
	end

	SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_DESCRIBE, self.strValue)
end

function SettingPublicView:OnClickBtnEditName()
	self.settingChangeNameView:Open()
end

function SettingPublicView:OnClickBtnHeadIcon()
	self.settingChangeIconView:Open()
end

function SettingPublicView:OnBtnCopy()
	UnityEngine.GUIUtility.systemCopyBuffer = PlayerModule.PlayerInfo.baseInfo.guid
end

function SettingPublicView:OnBtnEditPlayerTitle()
	UIModule.Open(Constant.UIControllerName.ChangeTitleUI, Constant.UILayer.UI)
end

function SettingPublicView:OnBtnPreviewCard()
	SettingModule.GetPlayerInfo(PlayerModule.PlayerInfo.baseInfo.serverId, PlayerModule.PlayerInfo.baseInfo.pid, function(playerInfo)
		UIModule.Open(Constant.UIControllerName.FriendInfoListUI, Constant.UILayer.UI, playerInfo)
	end)
end

function SettingPublicView:Dispose()
	self:Close()
	self:RemoveEventListener()
	self.settingChangeIconView:Dispose()
	self.settingChangeNameView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingPublicView:Open()
	self.rootUI:SetActive(true)

	self.numImg = {}

	for i = 0, self.SortLv.transform.childCount - 1 do
		self.numImg[i + 1] = self.SortLv.transform:GetChild(i).gameObject
	end

	self:AddEventListener()
	self:UpDateView()
end

function SettingPublicView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()

	self.strValue = nil
end

return SettingPublicView
