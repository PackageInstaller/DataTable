-- chunkname: @IQIGame\\UI\\Common\\NpcTalk\\CommonNpcTalkView.lua

local CommonNpcSpineView = require("IQIGame.UI.Common.NpcTalk.CommonNpcSpineView")
local CommonNpcActionView = require("IQIGame.UI.Common.NpcTalk.CommonNpcActionView")

CommonNpcTalkView = {
	isStaticVertiaclDraw = false
}

function CommonNpcTalkView.New(view)
	local obj = Clone(CommonNpcTalkView)

	obj:Init(view)

	return obj
end

function CommonNpcTalkView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickButton()
		self:OnClickButton()
	end

	self.commonNpcActionView = CommonNpcActionView.New(self.npcActionTake)
	self.verticalDrawImgCom = self.verticalDrawImg:GetComponent("Image")

	self:AddListeners()
end

function CommonNpcTalkView:AddListeners()
	self.ClickButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickButton)
end

function CommonNpcTalkView:RemoveListeners()
	self.ClickButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButton)
end

function CommonNpcTalkView:Update(elapseSeconds, realElapseSeconds)
	if self.commonNpcActionView then
		self.commonNpcActionView:Update(elapseSeconds, realElapseSeconds)
	end
end

function CommonNpcTalkView:RefreshSpineShow(actionData, completeCallback)
	local function func(state)
		self:SetShowState(state)
		self:SetNpcDefaultInfo(actionData)

		if completeCallback ~= nil then
			completeCallback()
		end
	end

	if actionData.NpcEntityId == 0 or actionData.NpcEntityId == nil then
		if self.lastPath == actionData.NpcResourcesVerticalDraw then
			func(false)

			return
		end

		self.lastPath = actionData.NpcResourcesVerticalDraw
		self.isStaticVertiaclDraw = true

		AssetUtil.LoadImage(self, actionData.NpcResourcesVerticalDraw, self.verticalDrawImgCom)
		func(false)

		self.commonNpcSpineView = nil
	else
		if actionData.NpcEntityId == self.lastEntityId then
			func(true)

			return
		end

		self.lastEntityId = actionData.NpcEntityId
		self.isStaticVertiaclDraw = false
		self.commonNpcSpineView = CommonNpcSpineView.New(actionData.NpcEntityId, self.spineRoot.transform, function()
			func(true)
		end)
	end
end

function CommonNpcTalkView:SetNpcDefaultInfo(actionData)
	local scale = table.len(actionData.Scale) == 0 and {
		1,
		1,
		1
	} or actionData.Scale
	local pos = table.len(actionData.Position) == 0 and {
		0,
		0,
		0
	} or actionData.Position

	if self.isStaticVertiaclDraw then
		self.verticalDrawImg.transform.localScale = Vector3(scale[1], scale[2], scale[3])
		self.verticalDrawImg.transform.localPosition = Vector3(pos[1], pos[2], pos[3])
	else
		self.commonNpcSpineView.spineEntityGo.transform.localScale = Vector3(scale[1], scale[2], scale[3])
		self.commonNpcSpineView.spineEntityGo.transform.localPosition = Vector3(pos[1], pos[2], pos[3])
	end
end

function CommonNpcTalkView:SetShowState(state)
	LuaUtility.SetGameObjectShow(self.spineRoot, state)
	LuaUtility.SetGameObjectShow(self.ImageRoot, not state)
end

function CommonNpcTalkView:Refresh(npcActionGroupId, triggerType, params, callback)
	self.npcActionGroupId = npcActionGroupId

	if self.npcActionGroupId == 0 then
		logError("当前配置的NpcActionGroupId为0")
	end

	local actionData = NpcActionModule.GetAction(npcActionGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, triggerType, params)

	self:RefreshSpineShow(actionData, function()
		self.commonNpcActionView:Refresh(actionData, self.commonNpcSpineView, callback)
	end)
end

function CommonNpcTalkView:ShowCV(actionData)
	self.commonNpcActionView:ShowCV(actionData)
end

function CommonNpcTalkView:OnClickButton()
	self:Refresh(self.npcActionGroupId, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
end

function CommonNpcTalkView:RefreshClickBtn()
	self:SetClickBtnState(false)
end

function CommonNpcTalkView:SetClickBtnState(state)
	self.ClickButton:GetComponent("Button").interactable = state
end

function CommonNpcTalkView:Hide()
	if self.commonNpcActionView then
		self.commonNpcActionView:Hide()
	end
end

function CommonNpcTalkView:Dispose()
	self.verticalDrawImgCom = nil

	if self.commonNpcSpineView then
		self.commonNpcSpineView:Dispose()
	end

	self.commonNpcActionView:Dispose()

	self.lastEntityId = nil
	self.lastPath = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CommonNpcTalkView
