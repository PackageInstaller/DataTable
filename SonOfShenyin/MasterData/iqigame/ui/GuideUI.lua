-- chunkname: @IQIGame\\UI\\GuideUI.lua

local GuideUI = Base:Extend("GuideUI ", "IQIGame.Onigao.UI.GuideUI ", {
	disabled = false,
	isShow = false,
	guideViews = {}
})
local GuideArrowPointingView = require("IQIGame.UI.Guide.GuideArrowPointingView")
local GuideClickAreaView = require("IQIGame.UI.Guide.GuideClickAreaView")
local GuideNpcTalkView = require("IQIGame.UI.Guide.GuideNpcTalkView")
local GuidePictureGuideView = require("IQIGame.UI.Guide.GuidePictureGuideView")
local GuidePlayEffectView = require("IQIGame.UI.Guide.GuidePlayEffectView")

function GuideUI:OnInit()
	self:OnInitDelegate()
	self:OnInitComponent()
end

function GuideUI:OnInitComponent()
	self.ClickAreaView = GuideClickAreaView.__New(self.ClickArea, self)

	self.ClickAreaView:Hide()

	self.NpcTalkView = GuideNpcTalkView.__New(self.NpcTalk, self)

	self.NpcTalkView:Hide()

	self.PlayEffectView = GuidePlayEffectView.__New(self.PlayEffect, self)

	self.PlayEffectView:Close()

	self.GuideArrowPointingView = GuideArrowPointingView.__New(self.ArrowPointing, self)
	self.GuidePictureGuideView = GuidePictureGuideView.__New(self.PictureGuide, self)

	self.GuidePictureGuideView:Close()
end

function GuideUI:OnInitDelegate()
	function self.delegateUpgradePosition()
		self:OnUpgradePosition()
	end

	function self.delegateTalkEnd(data)
		self:OnTalkViewEnd(data)
	end

	function self.delegateBtnJump()
		self:OnBtnJump()
	end

	function self.RefreshDelegate(guideSubData, guideID)
		self:GuideStart(guideSubData, guideID)
	end

	function self.StoryGuideCompleteDelegate()
		self:StoryGuideComplete()
	end
end

function GuideUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.GuideUIStartEvent, self.RefreshDelegate)
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
end

function GuideUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.GuideUIStartEvent, self.RefreshDelegate)
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
end

function GuideUI:GetPreloadAssetPaths()
	return nil
end

function GuideUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuideUI:OnOpen(userData)
	self.IsGuiding = false

	LuaUtility.SetGameObjectShow(self.Root, false)

	if userData == nil then
		return
	end

	self.ClickEvent = userData[3]

	self:GuideStart(userData[1], userData[2])
end

function GuideUI:OnClose(userData)
	self.uiName = nil
	self.pathObj = nil
	self.disabled = false

	if self.timerClose ~= nil then
		self.timerClose:Stop()

		self.timerClose = nil
	end

	for i, v in pairs(self.guideViews) do
		v:Close()
	end
end

function GuideUI:OnPause()
	return
end

function GuideUI:OnResume()
	return
end

function GuideUI:OnCover()
	return
end

function GuideUI:OnReveal()
	return
end

function GuideUI:OnRefocus(userData)
	return
end

function GuideUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsGuiding then
		return
	end

	self.ClickAreaView:OnUpdate()
	self.NpcTalkView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.PlayEffectView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function GuideUI:CheckDisable()
	if UIModule.HasUI(Constant.UIControllerName.QueueTipUI) or UIModule.HasUI(Constant.UIControllerName.DialogUI) then
		self.disabled = true

		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.GuideUI, false)
	elseif self.disabled then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.GuideUI, true)

		self.disabled = false
	end
end

function GuideUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	for i, v in pairs(self.guideViews) do
		v:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	end
end

function GuideUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuideUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuideUI:OnDestroy()
	for _, v in pairs(self.guideViews) do
		v:Dispose()

		v = nil
	end

	if self.BattleRoundStartEvent then
		EventDispatcher.RemoveEventListenerByType(EventID.BattleTroopTurnBeginEvent, self.BattleRoundStartEvent)

		self.BattleRoundStartEvent = nil
	end

	if self.BattleRoundStartEvent then
		EventDispatcher.RemoveEventListenerByType(EventID.BattleTroopTurnBeginEvent, self.BattleRoundStartEvent)

		self.BattleRoundStartEvent = nil
	end

	if self.BattleMonsterDeadEvent then
		EventDispatcher.RemoveEventListener(EventID.BattleUnitDead, self.BattleMonsterDeadEvent)

		self.BattleMonsterDeadEvent = nil
	end

	if self.BattleRoleActionOverEvent then
		EventDispatcher.RemoveEventListener(EventID.BattleUnitTurnEndEvent, self.BattleRoleActionOverEvent)

		self.BattleRoleActionOverEvent = nil
	end

	if self.BattleResultWaitEvent then
		EventDispatcher.RemoveEventListener(EventID.ShowBattleResultGuideEvent, self.BattleResultWaitEvent)

		self.BattleResultWaitEvent = nil
	end

	if self.BattleWaitResultWinGuideEvent then
		EventDispatcher.RemoveEventListener(EventID.BattleWaitResultWinGuideEvent, self.BattleWaitResultWinGuideEvent)

		self.BattleWaitResultWinGuideEvent = nil
	end

	if self.customEventTriggerEvent then
		EventDispatcher.RemoveEventListener(EventID.GuideSubCustomTriggerEvent, self.customEventTriggerEvent)

		self.customEventTriggerEvent = nil
	end

	if self.BattleDialogCompleteWaitEvent then
		EventDispatcher.RemoveEventListener(EventID.OnBattleDialogCompleteEvent, self.BattleDialogCompleteWaitEvent)

		self.BattleDialogCompleteWaitEvent = nil
	end

	self.ClickAreaView:Dispose()
	self.NpcTalkView:Dispose()
	self.GuidePictureGuideView:Dispose()

	self.guideViews = nil
end

function GuideUI:CreateGuideModule()
	if self.isShow then
		return
	end

	self.isShow = true

	self.Root:SetActive(true)

	for i, v in pairs(self.guideViews) do
		v:Close()
		v:Dispose()
	end

	for i = 0, self.Root.transform.childCount - 1 do
		local obj = self.Root.transform:GetChild(0).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	self.guideViews = {}

	local npcTalks = {}

	for k, v in pairs(self.guideSubData.GuideUIType) do
		local objModule, moduleView

		if v[1] == "ClickArea" then
			objModule = UnityEngine.GameObject.Instantiate(self.ClickArea)
			moduleView = GuideClickAreaView.__New(objModule, self)
		elseif v[1] == "PlayEffect" then
			objModule = UnityEngine.GameObject.Instantiate(self.PlayEffect)
			moduleView = GuidePlayEffectView.__New(objModule, self)
		elseif v[1] == "NpcTalk" then
			table.insert(npcTalks, v)
		elseif v[1] == "ArrowPointing" then
			objModule = UnityEngine.GameObject.Instantiate(self.ArrowPointing)
			moduleView = GuideArrowPointingView.__New(objModule, self)
		elseif v[1] == "PictureGuide" then
			objModule = UnityEngine.GameObject.Instantiate(self.PictureGuide)
			moduleView = GuidePictureGuideView.__New(objModule, self)
		end

		if moduleView ~= nil then
			moduleView:Open(v, self.guideSubData.GuideSubID)
			table.insert(self.guideViews, moduleView)
			objModule.transform:SetParent(self.Root.transform, false)
		end
	end

	if #npcTalks > 0 then
		local objModule = UnityEngine.GameObject.Instantiate(self.NpcTalk)

		objModule.transform:SetParent(self.Root.transform, false)

		local moduleView = GuideNpcTalkView.__New(objModule, self)

		moduleView:Open(npcTalks, self.guideSubData.GuideSubID)

		moduleView.talkEndBack = self.delegateTalkEnd

		table.insert(self.guideViews, moduleView)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Root.transform)

		local canvases = objModule:GetComponentsInChildren(typeof(UnityEngine.Canvas))

		for i = 0, canvases.Length - 1 do
			canvases[i].enabled = true
		end

		local rayCasters = objModule:GetComponentsInChildren(typeof(UnityEngine.UI.GraphicRaycaster))

		for i = 0, rayCasters.Length - 1 do
			rayCasters[i].enabled = true
		end
	end

	if self.guideSubData.GuideShowTime > 0 then
		self.timerClose = Timer.New(function()
			if self.guideViews then
				for i, v in pairs(self.guideViews) do
					v:TriggerSelf()
				end
			end
		end, self.guideSubData.GuideShowTime)

		self.timerClose:Start()
	end
end

function GuideUI:OnTalkViewEnd(data)
	GuideModule.GuideNext()
end

function GuideUI:OnBtnJump()
	UIModule.Close(Constant.UIControllerName.GuideUI)
	GuideModule.JumpGuide(self.guideID)
end

function GuideUI:GuideStart(guideSubData, guideID)
	self.disabled = false
	self.guideSubData = guideSubData
	self.guideID = guideID
	self.isShow = false

	LuaUtility.SetGameObjectShow(self.BtnJump, false)

	if not self.guideSubData.GuideSubShow then
		logError(string.format("引导子步骤 ID = %s 的 GuideSubShow 配置为空", self.guideSubData.GuideSubID))

		return
	end

	local index = string.find(self.guideSubData.GuideSubShow, "/", 1)

	if index == nil then
		index = string.len(self.guideSubData.GuideSubShow) + 1
	end

	local strUIName = string.sub(self.guideSubData.GuideSubShow, 1, index - 1)

	self.uiName = string.gsub(strUIName, "%(Clone%)", "")
	self.pathObj = string.sub(self.guideSubData.GuideSubShow, index + 1, #self.guideSubData.GuideSubShow)
	self.GuideUITypeIndex = 1

	local needDelay = self:CheckShowDelay()

	self:CheckSpecialGuideParam()

	if not needDelay then
		self:ShowGuideByIndex()
	end
end

function GuideUI:ShowGuideByIndex()
	self.ClickAreaView:Hide()
	self.NpcTalkView:Hide()
	self.GuidePictureGuideView:Close()
	self.PlayEffectView:Close()
	LuaUtility.SetGameObjectShow(self.RawImage, false)

	if self.guideSubData.OpenMaskWhenTrigger then
		LuaUtility.SetGameObjectShow(self.Mask, false)
	else
		LuaUtility.SetGameObjectShow(self.Mask, true)
	end

	if self.GuideUITypeIndex > 1 then
		local isDelay = self:CheckDelayToNext()

		if not isDelay then
			GuideModule.GuideNext()
		end

		return
	end

	for i = 1, #self.guideSubData.GuideUIType do
		local u = self.guideSubData.GuideUIType[i]
		local guideType = u[1]

		if guideType == "ClickArea" then
			self:ShowGuide_ClickArea(u)
		elseif guideType == "PlayEffect" then
			self:ShowGuide_Effect(u, self.guideSubData.GuideSubID)
		elseif guideType == "NpcTalk" then
			self:ShowGuide_NpcTalk(u)
		elseif guideType == "StartStory" then
			self:ShowGuide_StartStory()
		elseif guideType == "Picture" then
			self:ShowGuide_Picture(u, self.guideSubData.GuideSubID)
			LuaUtility.SetGameObjectShow(self.RawImage, true)
		end
	end

	self.IsGuiding = true
end

function GuideUI:ShowGuideNext()
	self.GuideUITypeIndex = self.GuideUITypeIndex + 1

	EventDispatcher.DispatchSingleEvent(EventID.BattleResultGuideEvent)
	self:ShowGuideByIndex()
end

function GuideUI:ShowGuide_ClickArea(u)
	self.ClickAreaView:Refresh(u, self.guideSubData)
	self.ClickAreaView:SetClickEvent(self.ClickEvent)
end

function GuideUI:ShowGuide_NpcTalk(v)
	local npcTalks = {}

	table.insert(npcTalks, v)

	if #npcTalks > 0 then
		self.NpcTalkView:Open(npcTalks, self.guideSubData.GuideSubID)
	end
end

function GuideUI:ShowGuide_Picture(subData, guideSubID)
	self.GuidePictureGuideView:Open(subData, guideSubID)
end

function GuideUI:ShowGuide_Effect(subData, guideSubID)
	self.PlayEffectView:Open(subData, guideSubID)
end

function GuideUI:ShowGuide_StartStory()
	local guidID = self.guideID
	local guidSubID = self.guideSubData.GuideSubID
	local plotID = self.guideSubData.PlotID
	local plotEndID = self.guideSubData.PlotEndID

	EventDispatcher.AddEventListener(EventID.StoryGuideComplete, function()
		if not StoryModule.plotStageDupPOD or StoryModule.plotStageDupPOD.plotCid ~= plotEndID then
			return
		end

		GuideModule.UpdateGuide(guidID, guidSubID, 3)
		log("剧情引导完成")
		EventDispatcher.RemoveEventListenerByType(EventID.StoryGuideComplete)
	end)
	GuideModule.StoryGuide(plotID)
end

function GuideUI:CheckShowDelay()
	local needDelay = false

	if self.guideSubData.BattleRoundStart then
		function self.BattleRoundStartEvent(troopType)
			if troopType == BattleModule.attackBattleTroopType then
				self:ShowGuideByIndex()
				EventDispatcher.RemoveEventListener(EventID.BattleTroopTurnBeginEvent, self.BattleRoundStartEvent)

				self.BattleRoundStartEvent = nil
			end
		end

		EventDispatcher.AddEventListener(EventID.BattleTroopTurnBeginEvent, self.BattleRoundStartEvent)

		needDelay = true
	elseif self.guideSubData.BattleMonsterDead then
		local needEvent = true

		for i, _ in pairs(BattleModule.battleUnitsData) do
			if BattleModule.battleUnitsData[i].monsterConfigID == self.guideSubData.BattleMonsterDead and BattleModule.battleUnitsData[i]:IsDead() then
				needEvent = false
			end
		end

		if needEvent then
			function self.BattleMonsterDeadEvent(battleUnitID)
				log(string.format("【引导】怪物死亡事件,当前引导 = %s,需要判断的角色id = %s,收到的角色id = %s", self.guideSubData.GuideSubID, self.guideSubData.BattleMonsterDead, BattleModule.battleUnitsData[battleUnitID].monsterConfigID))

				if BattleModule.battleUnitsData[battleUnitID].monsterConfigID == self.guideSubData.BattleMonsterDead then
					self:ShowGuideByIndex()
					EventDispatcher.RemoveEventListener(EventID.BattleUnitDead, self.BattleMonsterDeadEvent)

					self.BattleMonsterDeadEvent = nil
				end
			end

			EventDispatcher.AddEventListener(EventID.BattleUnitDead, self.BattleMonsterDeadEvent)

			needDelay = true
		end
	elseif self.guideSubData.BattleRoleActionOver then
		function self.BattleRoleActionOverEvent(battleUnitID)
			log(string.format("【引导】角色出手结束事件,当前引导 = %s,需要判断的角色id = %s,收到的角色id = %s", self.guideSubData.GuideSubID, self.guideSubData.BattleRoleActionOver, BattleModule.battleUnitsData[battleUnitID].monsterConfigID))

			if BattleModule.battleUnitsData[battleUnitID].monsterConfigID == self.guideSubData.BattleRoleActionOver then
				self:ShowGuideByIndex()
				EventDispatcher.RemoveEventListener(EventID.BattleUnitTurnEndEvent, self.BattleRoleActionOverEvent)

				self.BattleRoleActionOverEvent = nil
			end
		end

		EventDispatcher.AddEventListener(EventID.BattleUnitTurnEndEvent, self.BattleRoleActionOverEvent)

		needDelay = true
	elseif self.guideSubData.BattleResultWaitGuide then
		function self.BattleResultWaitEvent()
			log(string.format("【引导】等待战斗结果事件,当前引导 = %s", self.guideSubData.GuideSubID))
			self:ShowGuideByIndex()
			EventDispatcher.RemoveEventListener(EventID.ShowBattleResultGuideEvent, self.BattleResultWaitEvent)
		end

		EventDispatcher.AddEventListener(EventID.ShowBattleResultGuideEvent, self.BattleResultWaitEvent)

		GuideModule.IsBattleResultWaitGuide = self.guideSubData.BattleResultWaitGuide
		needDelay = true
	elseif self.guideSubData.BattleWaitResultWinGuide then
		function self.BattleWaitResultWinGuideEvent()
			log(string.format("【引导】等待战斗胜利事件,当前引导 = %s", self.guideSubData.GuideSubID))
			GuideModule.GuideNext()
			EventDispatcher.RemoveEventListener(EventID.BattleWaitResultWinGuideEvent, self.BattleWaitResultWinGuideEvent)
		end

		EventDispatcher.AddEventListener(EventID.BattleWaitResultWinGuideEvent, self.BattleWaitResultWinGuideEvent)
		LuaUtility.SetGameObjectShow(self.Mask, false)

		needDelay = true
	elseif self.guideSubData.WaitCustomEventTrigger then
		EventDispatcher.RemoveEventListenerByType(EventID.GuideSubCustomTriggerEvent)

		local customId = self.guideSubData.WaitCustomEventTrigger

		function self.customEventTriggerEvent(id)
			if id ~= customId then
				return
			end

			self:ShowGuideByIndex()
			EventDispatcher.RemoveEventListener(EventID.GuideSubCustomTriggerEvent, self.customEventTriggerEvent)
		end

		EventDispatcher.AddEventListener(EventID.GuideSubCustomTriggerEvent, self.customEventTriggerEvent)

		needDelay = true
	elseif self.guideSubData.BattleDialogCompleteWait then
		function self.BattleDialogCompleteWaitEvent(dialogId)
			if dialogId ~= self.guideSubData.BattleDialogCompleteWait then
				return
			end

			log(string.format("【引导】等待对话结束事件,当前引导 = %s", self.guideSubData.GuideSubID))
			GuideModule.GuideNext()
			EventDispatcher.RemoveEventListener(EventID.OnBattleDialogCompleteEvent, self.BattleDialogCompleteWaitEvent)
		end

		EventDispatcher.AddEventListener(EventID.OnBattleDialogCompleteEvent, self.BattleDialogCompleteWaitEvent)
		LuaUtility.SetGameObjectShow(self.Mask, false)

		needDelay = true
	end

	return needDelay
end

function GuideUI:CheckSpecialGuideParam()
	if self.guideSubData.HideBattleButtons then
		EventDispatcher.Dispatch(EventID.SetRightTopPanelShow, false)

		BattleModule.showRightToolsButton = false
	end
end

function GuideUI:CheckDelayToNext()
	local needDelay = false

	if self.guideSubData.DelayCompleteWithStory then
		local plotEndID = self.guideSubData.DelayCompleteWithStory

		EventDispatcher.AddEventListener(EventID.StoryGuideComplete, function()
			if not StoryModule.plotStageDupPOD or StoryModule.plotStageDupPOD.plotCid ~= plotEndID then
				return
			end

			GuideModule.GuideNext()
			log(string.format("剧情引导完成 plotId = %s", plotEndID))
			EventDispatcher.RemoveEventListenerByType(EventID.StoryGuideComplete)
		end)

		needDelay = true
	end

	return needDelay
end

return GuideUI
