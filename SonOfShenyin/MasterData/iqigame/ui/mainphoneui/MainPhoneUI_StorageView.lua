-- chunkname: @IQIGame\\UI\\MainPhoneUI\\MainPhoneUI_StorageView.lua

local MainPhoneUI_RightView_TopBanner = require("IQIGame/UI/MainPhoneUI/MainPhoneUI_RightView_TopBanner")
local StorageView = {}

function StorageView.New(view)
	local obj = Clone(StorageView)

	obj:__Init(view)

	return obj
end

function StorageView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.bottomBanner = MainPhoneUI_RightView_TopBanner.New(self.BannerRoot)

	self:__OnAddListeners()
end

function StorageView:__OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "CloseBackground")
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn")
	UIEventUtil.AddClickEventListener_Button(self, "TujianBtn")
	UIEventUtil.AddClickEventListener_Button(self, "CompoundBtn")
	UIEventUtil.AddClickEventListener_Button(self, "WarehouseBtn")
	UIEventUtil.AddClickEventListener_Button(self, "FriendBtn")
	UIEventUtil.AddClickEventListener_Button(self, "SetBtn")
	UIEventUtil.AddClickEventListener_Button(self, "CommunityBtn")
	UIEventUtil.AddClickEventListener_Button(self, "NoticeBtn")
	UIEventUtil.AddClickEventListener_Button(self, "SignBtn", self.__OnSignBtnClickHandler)
end

function StorageView:__OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
end

function StorageView:Show()
	self.gameObject:SetActive(true)
	self.bottomBanner:Show()
	self:__CheckQuestionnaireOpen()
end

function StorageView:Hide()
	self.gameObject:SetActive(false)
	self.bottomBanner:Hide()
end

function StorageView:Dispose()
	self.bottomBanner:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function StorageView:__OnCloseBackgroundClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIStorageViewActive, false)
end

function StorageView:__OnCloseBtnClickHandler()
	EventDispatcher.Dispatch(EventID.SetMainPhoneUIStorageViewActive, false)
end

function StorageView:__OnTujianBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.ArchivesUI, Constant.UILayer.UI)
end

function StorageView:__OnCompoundBtnClickHandler()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_Compound) then
		UIModule.Open(Constant.UIControllerName.TransformUI, Constant.UILayer.UI)
	else
		NoticeModule.ShowNotice(19001)
	end
end

function StorageView:__OnWarehouseBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.WarehouseUI, Constant.UILayer.UI)
end

function StorageView:__OnFriendBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.FriendUI, Constant.UILayer.UI)
end

function StorageView:__OnSetBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI)
end

function StorageView:__OnQuestionnaireBtnClickHandler()
	local url = PlayerModule.GetQuestionUrl(self.questionConfig.Url, self.questionConfig.Id, self.questionConfig.Activity)

	Application.OpenURL(url)
	RedDotModule.ClearRedDotByRedDotID(Constant.E_RedDotPath.MobilePhone_Questionnair)
end

function StorageView:__OnCommunityBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.CommunityUI, Constant.UILayer.UI)
end

function StorageView:__OnNoticeBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.NoticeUI, Constant.UILayer.UI, false)
end

function StorageView:__OnSignBtnClickHandler()
	UIModule.Open(Constant.UIControllerName.SignInUI, Constant.UILayer.UI)
end

function StorageView:__CheckQuestionnaireOpen()
	local questionConfig = PlayerModule.GetIsOpenQuestionnaire()

	self.questionConfig = questionConfig

	LuaUtility.SetGameObjectShow(self.QuestionnaireBtn, self.questionConfig ~= nil)
end

return StorageView
