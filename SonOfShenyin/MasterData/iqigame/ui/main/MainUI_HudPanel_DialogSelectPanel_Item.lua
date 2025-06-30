-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_DialogSelectPanel_Item.lua

local MainUI_HudPanel_DialogSelectPanel_Item = {}

function MainUI_HudPanel_DialogSelectPanel_Item.New(go, mainView)
	local o = Clone(MainUI_HudPanel_DialogSelectPanel_Item)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_DialogSelectPanel_Item:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.objectParent = self.gameObject.transform.parent.gameObject

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_DialogSelectPanel_Item:InitComponent()
	return
end

function MainUI_HudPanel_DialogSelectPanel_Item:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClickClick()
	end
end

function MainUI_HudPanel_DialogSelectPanel_Item:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.buttonClickDelegate)
end

function MainUI_HudPanel_DialogSelectPanel_Item:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.buttonClickDelegate)
end

function MainUI_HudPanel_DialogSelectPanel_Item:OnButtonClickClick()
	if self.mainView.isPlayingSelectAnimation then
		return
	end

	LuaUtility.PlayAnimation(self.objectParent, "selectContent_Get", nil, function()
		if self.mainView.clickCallBack then
			self.mainView.clickCallBack(self.data.actionType, self.data.actionParam)
		end

		self.mainView.isPlayingSelectAnimation = false

		UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
		EventDispatcher.Dispatch(EventID.CommonDialogControl_OnActionComplete, Constant.CommonDialogActionType.ShowActionSelect)
	end)
	self.mainView:PlayHideSelectAnimation(self.data.textDesc)
	StoryUIApi:PlayClickOptionSound()
end

function MainUI_HudPanel_DialogSelectPanel_Item:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel_DialogSelectPanel_Item:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel_DialogSelectPanel_Item:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textOption, self.data.textDesc)
	LuaUtility.SetGameObjectShow(self.objectHadSelected, false)

	if self.data.iconType and self.data.iconType ~= 0 then
		LuaUtility.LoadImage(self, MainUIAPI:GetTagIconPath(self.data.iconType), self.arrow:GetComponent("Image"))
	else
		LuaUtility.LoadImage(self, MainUIAPI:GetSelectArrowIconPath(), self.arrow:GetComponent("Image"))
	end
end

function MainUI_HudPanel_DialogSelectPanel_Item:PlayHideAnimation(completeEvent)
	LuaUtility.PlayAnimation(self.objectParent, "selectContent_Out2", nil, completeEvent)
end

function MainUI_HudPanel_DialogSelectPanel_Item:OnDestroy()
	self:RemoveListener()
end

return MainUI_HudPanel_DialogSelectPanel_Item
