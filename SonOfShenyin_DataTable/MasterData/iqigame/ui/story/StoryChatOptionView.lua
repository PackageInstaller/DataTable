-- chunkname: @IQIGame\\UI\\Story\\StoryChatOptionView.lua

local StoryChatOptionView = {}

function StoryChatOptionView.New(go, mainView)
	local o = Clone(StoryChatOptionView)

	o:Initialize(go, mainView)

	return o
end

function StoryChatOptionView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryChatOptionView:InitComponent()
	self.button = self.gameObject:GetComponent("Button")
end

function StoryChatOptionView:InitDelegate()
	function self.onButtonClickDelegate()
		self:OnButtonClick()
	end
end

function StoryChatOptionView:AddListener()
	self.button.onClick:AddListener(self.onButtonClickDelegate)
end

function StoryChatOptionView:RemoveListener()
	self.button.onClick:RemoveListener(self.onButtonClickDelegate)
end

function StoryChatOptionView:OnDestroy()
	self:RemoveListener()

	self.button = nil

	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryChatOptionView:OnButtonClick()
	self.mainView:OnOptionClick(self)
	LuaUtility.PlayAnimation(self.gameObject, "selectState_click")
end

function StoryChatOptionView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StoryChatOptionView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StoryChatOptionView:SetSelect(v)
	LuaUtility.SetGameObjectShow(self.selectState, v)

	if v then
		LuaUtility.SetText(self.chatText, string.format(ColorCfg.White, CfgUtil.GetCfgStoryTextDataWithID(self.Data)))
	else
		LuaUtility.SetText(self.chatText, string.format(ColorCfg.Black, CfgUtil.GetCfgStoryTextDataWithID(self.Data)))
	end
end

function StoryChatOptionView:ResetView()
	self:SetSelect(false)
end

function StoryChatOptionView:Refresh(Data)
	self.Data = Data

	self:ResetView()
	LuaUtility.SetText(self.chatText, string.format(ColorCfg.Black, CfgUtil.GetCfgStoryTextDataWithID(self.Data)))
end

return StoryChatOptionView
