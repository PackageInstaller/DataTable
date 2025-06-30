-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_DialogSelectPanel.lua

local MainUI_HudPanel_DialogSelectPanel = {}
local DialogueSelectPanelSelectItemClass = require("IQIGame/UI/Main/MainUI_HudPanel_DialogSelectPanel_Item")
local selectCount = 6

function MainUI_HudPanel_DialogSelectPanel.New(go, mainView)
	local o = Clone(MainUI_HudPanel_DialogSelectPanel)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_DialogSelectPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_DialogSelectPanel:InitComponent()
	self.selectItemViewList = {}

	local childCount = selectCount + 1

	for i = 2, childCount do
		local trans = LuaUtility.GetChild(self.selectContent.transform, i - 1)
		local item = DialogueSelectPanelSelectItemClass.New(LuaUtility.GetChild(trans, 0).gameObject, self)

		table.insert(self.selectItemViewList, item)
	end

	self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.selectContent, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

	local publicParametersData = CfgUtil.GetPublicParametersData()
	local AsideViewFloatOffset = publicParametersData.AsideViewFloatOffset
	local v = Vector3.New(AsideViewFloatOffset.x, AsideViewFloatOffset.y, 0)

	self.FloatEffectComponent:Init(v, publicParametersData.AsideViewFloatFrequency)
end

function MainUI_HudPanel_DialogSelectPanel:InitDelegate()
	function self.buttonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function MainUI_HudPanel_DialogSelectPanel:AddListener()
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.buttonMaskDelegate)
end

function MainUI_HudPanel_DialogSelectPanel:RemoveListener()
	self.buttonMask:GetComponent("Button").onClick:RemoveListener(self.buttonMaskDelegate)
end

function MainUI_HudPanel_DialogSelectPanel:OnButtonMaskClick()
	return
end

function MainUI_HudPanel_DialogSelectPanel:Show()
	LuaUtility.PlayAnimation(self.selectContent, "selectContent_In", nil, function()
		self.isPlayingSelectAnimation = false
	end)

	self.isPlayingSelectAnimation = true

	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel_DialogSelectPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel_DialogSelectPanel:Refresh(mountPoint, headText, actionList, clickCallBack)
	self.actionArray = actionList
	self.clickCallBack = clickCallBack

	LuaUtility.SetText(self.questionText, headText)
	self:SetPos(mountPoint.transform.position)
	self:RefreshDialogueSelection(actionList)
end

function MainUI_HudPanel_DialogSelectPanel:SetPos(pos)
	local screenPos = LuaUtility.WorldToScreenPos(UnityEngine.Camera.main, pos)
	local worldPos = LuaUtility.ScreenToWorldPos(GameEntry.UICamera, screenPos, 100)

	LuaUtility.SetPositionWithGameObject(self.selectContent, worldPos.x, worldPos.y, worldPos.z)
end

function MainUI_HudPanel_DialogSelectPanel:RefreshDialogueSelection(actionList)
	local index = 1

	for _, v in pairs(actionList) do
		if index <= #self.selectItemViewList then
			self.selectItemViewList[index]:Show()
			self.selectItemViewList[index]:Refresh(v)
		end

		index = index + 1
	end

	for i = index, #self.selectItemViewList do
		self.selectItemViewList[i]:Hide()
	end
end

function MainUI_HudPanel_DialogSelectPanel:PlayHideSelectAnimation(textDesc)
	for i = 1, #self.selectItemViewList do
		if self.selectItemViewList[i].data and self.selectItemViewList[i].data.textDesc ~= textDesc then
			self.selectItemViewList[i]:PlayHideAnimation()
		end
	end

	LuaUtility.PlayAnimation(self.selectContent, "selectContent_Out")

	self.isPlayingSelectAnimation = true
end

function MainUI_HudPanel_DialogSelectPanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.selectItemViewList) do
		v:OnDestroy()
	end

	self.selectItemViewList = nil
end

return MainUI_HudPanel_DialogSelectPanel
