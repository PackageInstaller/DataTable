-- chunkname: @IQIGame\\UI\\UserInfo\\RoleInfoView.lua

local m = {
	isSelf = false,
	HeroDataList = {},
	HelpFightHeroList = {}
}
local SkinHeroCell = {}

function SkinHeroCell.New(view)
	local obj = Clone(SkinHeroCell)

	obj:__Init(view)

	return obj
end

function SkinHeroCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "BtnRoot", self.__OnItemClickHandler)
end

function SkinHeroCell:__OnItemClickHandler()
	EventDispatcher.Dispatch(EventID.ShowUserInfoSkinView, true, self.skinCid)
end

function SkinHeroCell:Show(skinCid)
	self.gameObject:SetActive(true)

	self.skinCid = skinCid

	local skinCfg = CfgHeroSkinTable[skinCid]

	self.heroCid = skinCfg.HeroId

	local heroData = WarlockModule.GetHeroData(self.heroCid)
	local heroCfg = CfgHeroTable[self.heroCid]

	UGUIUtil.SetText(self.RoleName, heroCfg.Name)
	UGUIUtil.SetText(self.RoleLevel, UIGlobalApi.GetLevelText(heroData.lv))

	local skinHeadPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, skinHeadPath, self.RoleImg:GetComponent("Image"))

	local elementPath = WarlockApi:GetElementIconPath(heroCfg.Elements)

	AssetUtil.LoadImage(self, elementPath, self.ElementImg:GetComponent("Image"))

	local professionPath = WarlockApi:GetProfessionIconPath(heroCfg.Profession)

	AssetUtil.LoadImage(self, professionPath, self.ProfessionImg:GetComponent("Image"))
end

function SkinHeroCell:Hide()
	self.gameObject:SetActive(false)
end

function SkinHeroCell:Dispose()
	UIEventUtil.ClearEventListener(self)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SmallRoleItem = require("IQIGame.UI.UserInfo.SmallRoleItem")
local AchievementShowView = require("IQIGame.UI.UserInfo.AchievementShowView")
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")

function m.New(view, actionTb)
	local obj = Clone(m)

	obj:Init(view, actionTb)

	return obj
end

function m:Init(view, actionTb)
	self.View = view
	self.Action_OpenReNamePanel = actionTb[1]

	LuaCodeInterface.BindOutlet(self.View, self)

	self.roleDisplayView = CommonRoleDisplayView.New(self.SpineDisplayView, Constant.DynamicSkinShowPosition.UserInfo)
	self.SignInput = self.SignInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.SignValueLabel = self.SignValueLabel:GetComponent("Text")
	self.NowSetBtn = self.NowSetBtn:GetComponent("Button")
	self.LevelMaskImg = self.levelMask:GetComponent("Image")

	UGUIUtil.SetText(self.RoleCountTittle, UserInfoApi:GetAllTittle(1))
	UGUIUtil.SetText(self.BirthdayTittle, UserInfoApi:GetAllTittle(3))
	UGUIUtil.SetText(self.NowSetTittle, UserInfoApi:GetAllTittle(4))
	UGUIUtil.SetText(self.SignPlaceholder, UserInfoApi:GetSignPlaceholder())
	UGUIUtil.SetTextInChildren(self.CopyUIDBtn.gameObject, UserInfoApi:GetCopyIDBtn())

	function self.DelegateCopyBtn()
		self:OnBtnCopy()
	end

	function self.DelegateChangeData(type)
		self:ChangeUserDataCallBack(type)
	end

	function self.DelegateIntroInput()
		self:ChangeIntro()
	end

	function self.DelegateOpenHeroPanel()
		self:OpenHeroBtnClick()
	end

	function self.DelegateAssistInFightHero(pos, dataInfo)
		self:AssistInFightHero(pos, dataInfo.hero)
	end

	function self.Delegation_OnReNamePanelBtn()
		if self.Action_OpenReNamePanel ~= nil then
			self:Action_OpenReNamePanel()
		end
	end

	for i = 1, 4 do
		local obj = self.HelpFightHeroList[i]

		if obj == nil then
			obj = UnityEngine.Object.Instantiate(self.SmallRoleItem)

			obj.transform:SetParent(self.SmallHeroList.transform, false)
			obj.gameObject:SetActive(false)

			obj = SmallRoleItem.New(obj)

			table.insert(self.HelpFightHeroList, i, obj)
		end
	end

	local roleDisplayCellGo = UnityEngine.Object.Instantiate(self.SmallRoleItem)

	roleDisplayCellGo.transform:SetParent(self.SmallHeroList.transform, false)
	roleDisplayCellGo.gameObject:SetActive(true)

	self.roleDisplayCell = SkinHeroCell.New(roleDisplayCellGo)
	self.AchievementShowView = AchievementShowView.New(self.achievementPanel)

	self:AddListeners()
end

function m:AddListeners()
	self.CopyUIDBtn:GetComponent("Button").onClick:AddListener(self.DelegateCopyBtn)
	self.SignInput.onEndEdit:AddListener(self.DelegateIntroInput)
	self.RoleCountBtn:GetComponent("Button").onClick:AddListener(self.DelegateOpenHeroPanel)
	self.ReNameBtn:GetComponent("Button").onClick:AddListener(self.Delegation_OnReNamePanelBtn)
	EventDispatcher.AddEventListener(EventID.PlayerDataChangeEvent, self.DelegateChangeData)
	EventDispatcher.AddEventListener(EventID.AssisInFightingChange, self.DelegateAssistInFightHero)
end

function m:RemoveListeners()
	self.CopyUIDBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCopyBtn)
	self.SignInput.onEndEdit:RemoveListener(self.DelegateIntroInput)
	self.RoleCountBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOpenHeroPanel)
	self.ReNameBtn:GetComponent("Button").onClick:RemoveListener(self.Delegation_OnReNamePanelBtn)
	EventDispatcher.RemoveEventListener(EventID.PlayerDataChangeEvent, self.DelegateChangeData)
	EventDispatcher.RemoveEventListener(EventID.AssisInFightingChange, self.DelegateAssistInFightHero)
end

function m:SetData(args)
	self:OnSetViewData(args)
end

function m:OnSetViewData(args)
	self.UserPlayer = args[1]
	self.isSelf = args[2]
	self.SignInput.text = self.UserPlayer.intro

	UGUIUtil.SetText(self.UserID, self.UserPlayer.guid)
	UGUIUtil.SetText(self.UserLevel, self.UserPlayer.pLv)
	UGUIUtil.SetText(self.upwardLevelText, self.UserPlayer.pLv)
	UGUIUtil.SetText(self.UsreName, self.UserPlayer.pName)
	UGUIUtil.SetText(self.CumulativeLoginText, self.UserPlayer.totalLoginDay)
	UGUIUtil.SetText(self.BirthdayValueLabel, getDateText(self.UserPlayer.createTime))

	local stageCfg = MapModule.GetMainLineNewUnlock()

	UGUIUtil.SetText(self.GameProgressText, CfgGeneralDupChapterTable[stageCfg.ChapterId].Name .. "-" .. stageCfg.Name)
	self.RoleCountBtn:SetActive(self.isSelf)

	self.SignInput.enabled = self.isSelf

	self.ReNameBtn:SetActive(self.isSelf)
	LuaUtility.SetGameObjectShow(self.GameProgressParent, self.isSelf)
	self:SetExpFillAmount()
	self:RefreshCenterHeroShow()

	if self.isSelf then
		self.HeroDataList = AssistInFightingModule.WarlockList
	else
		self.HeroDataList = {}

		for k, v in pairs(self.UserPlayer.helpHeros) do
			self.HeroDataList[k] = self.UserPlayer.helpHeros[k].hero
		end
	end

	if self.isSelf == false then
		return
	end

	UGUIUtil.SetText(self.RoleValueLabel, UserInfoModule.GetPlayerHeroCount())
end

function m:SetExpFillAmount()
	LuaUtility.SetGameObjectShow(self.levelMask, self.isSelf)

	if self.isSelf then
		local exp = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv].Exp
		local allExp = 0

		for k, v in pairsCfg(CfgPlayerLevelTable) do
			if v.Id < PlayerModule.PlayerInfo.baseInfo.pLv then
				allExp = allExp + v.Exp
			end
		end

		local curExp = PlayerModule.PlayerInfo.baseInfo.exp - allExp

		self.LevelMaskImg.fillAmount = curExp / exp
	end
end

function m:InitHelpHeroList()
	for i = 1, 4 do
		self:AssistInFightHero(i, self.HeroDataList[i])
	end
end

function m:ChangeUserDataCallBack(type)
	UGUIUtil.SetText(self.UsreName, UserInfoModule.GetPlayerInfo().pName)

	self.SignInput.text = UserInfoModule.GetPlayerInfo().intro
end

function m:RefreshCenterHeroShow()
	if self.UserPlayer == nil then
		self.roleDisplayView:Hide()

		return
	end

	local skinCid = 0

	if self.isSelf then
		skinCid = PlayerModule.GetPlayerKanBanSkinCid()
	elseif self.UserPlayer.showHeroCid > 0 then
		skinCid = self.UserPlayer.heroSkin.skinCid
	else
		skinCid = CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
	end

	self.roleDisplayView:Show(skinCid)
	self.roleDisplayCell:Show(skinCid)
end

function m:ChangeIntro()
	local introText

	if self.SignInput.text ~= nil and self.SignInput.text ~= "" and self.SignInput.text ~= UserInfoModule.GetPlayerInfo().intro then
		introText = self.SignInput.text

		SDKLoginModule.SensitiveWordFilter(introText, function(resultStr, isHasSensitive)
			if isHasSensitive then
				NoticeModule.ShowNotice(21045002)

				return
			end

			local data = {}

			data[UserInfoModule.CHANGE_PLAYER_DESCRIBE] = tostring(resultStr)

			UserInfoModule.ChangeUserData(data)
		end)
	end
end

function m:OpenHeroBtnClick()
	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI)
end

function m:AssistInFightHero(pos, dataInfo)
	local obj = self.HelpFightHeroList[pos]
	local data = dataInfo

	obj:SetData(data, self.isSelf)
end

function m:OnBtnCopy()
	UnityEngine.GUIUtility.systemCopyBuffer = self.UserPlayer.guid

	NoticeModule.ShowNotice(20031)
end

function m:OnOpen()
	LuaUtility.SetGameObjectShow(self.View, true)
	self.AchievementShowView:Hide()
end

function m:OnClose()
	LuaUtility.SetGameObjectShow(self.View, false)
	self.roleDisplayView:Hide()
	self.AchievementShowView:Hide()
end

function m:Dispose()
	self.roleDisplayView:Dispose()

	self.HeroDataList = {}

	self:RemoveListeners()

	for i = 1, #self.HelpFightHeroList do
		self.HelpFightHeroList[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)

	self.View = nil
	self.Action_OpenReNamePanel = nil
end

return m
