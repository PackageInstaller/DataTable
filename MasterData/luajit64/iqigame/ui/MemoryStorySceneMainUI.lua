-- chunkname: @IQIGame\\UI\\MemoryStorySceneMainUI.lua

local DialogElem = require("IQIGame.UI.MemoryStory.MemoryStoryDialog")
local TaskElem = require("IQIGame.UI.MemoryStory.MemoryStoryTask")
local MemoryStorySceneMainUI = {
	optionUIExamineId = 0,
	optionUIBindElementId = 0,
	changeSceneEffectId = 0,
	leaveSceneEffectId = 0,
	talkElementId = 0,
	optionUITalkId = 0
}

MemoryStorySceneMainUI = Base:Extend("MemoryStorySceneMainUI", "IQIGame.Onigao.UI.MemoryStorySceneMainUI", MemoryStorySceneMainUI)

function MemoryStorySceneMainUI:OnInit()
	self:__OnInitialize()
end

function MemoryStorySceneMainUI:GetPreloadAssetPaths()
	return nil
end

function MemoryStorySceneMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MemoryStorySceneMainUI:IsManualShowOnOpen(userData)
	return false
end

function MemoryStorySceneMainUI:GetBGM(userData)
	return nil
end

function MemoryStorySceneMainUI:OnOpen(userData)
	self:__ResetUI()
	self:__OnRefresh()
end

function MemoryStorySceneMainUI:OnClose(userData)
	if self.leaveSceneEffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.leaveSceneEffectId)
	end

	self.leaveSceneEffectId = 0

	self:__HideElementOptionUI(nil)
	self.TalkOpBtnRoot.gameObject:SetActive(false)
	self.dialogElem:OnHide()
	self:__HideJoystick()
	self.taskElem:OnClose()
end

function MemoryStorySceneMainUI:OnAddListeners()
	self:__AddButtonEventListener()
	self:__AddLogicEventListener()
end

function MemoryStorySceneMainUI:OnRemoveListeners()
	self:__RemoveLogicEventListener()
	self:__RemoveButtonEventListener()
end

function MemoryStorySceneMainUI:OnPause()
	return
end

function MemoryStorySceneMainUI:OnResume()
	return
end

function MemoryStorySceneMainUI:OnCover()
	return
end

function MemoryStorySceneMainUI:OnReveal()
	return
end

function MemoryStorySceneMainUI:OnRefocus(userData)
	return
end

function MemoryStorySceneMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MemoryStorySceneMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MemoryStorySceneMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemoryStorySceneMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MemoryStorySceneMainUI:OnDestroy()
	self:__DestroyJoystick()
	self.dialogElem:OnDestroy()
	self.taskElem:OnDestroy()
end

function MemoryStorySceneMainUI:__OnInitialize()
	self:__InitJoystick()
	self:__PrepareEventProxy()

	self.dialogElem = DialogElem.New(self.TalkContentRoot)
	self.taskElem = TaskElem.New(self.TaskRoot)
end

function MemoryStorySceneMainUI:__PrepareEventProxy()
	self:__PrepareButtonEventProxy()
	self:__PrepareLogicEventProxy()
end

function MemoryStorySceneMainUI:__ResetUI()
	self:__HideElementOptionUI(nil)
	self.TalkOpBtnRoot.gameObject:SetActive(false)
	self.dialogElem:OnHide()
	self:__ShowJoystick()
	self.taskElem:Reset()
end

function MemoryStorySceneMainUI:__OnRefresh()
	if MemoryStoryModule == nil or MemoryStoryModule.StorySceneCfg == nil then
		return
	end

	self.goTitle:GetComponent("Text").text = MemoryStorySceneMainUIApi:GetString("sceneName", MemoryStoryModule.StorySceneCfg.Name)
end

function MemoryStorySceneMainUI:__ShowElementOptionUI(elementId, talkId, examineId)
	self.optionUIBindElementId = elementId
	self.optionUITalkId = talkId
	self.optionUIExamineId = examineId

	self.TalkFunBtn.gameObject:SetActive(talkId > 0)
	self.ExamineFunBtn.gameObject:SetActive(examineId > 0)
end

function MemoryStorySceneMainUI:__HideElementOptionUI(elementId)
	if elementId ~= self.optionUIBindElementId and elementId ~= nil then
		return
	end

	self.optionUIBindElementId = 0
	self.optionUITalkId = 0
	self.optionUIExamineId = 0

	self:__HideOptionFunBtn()
end

function MemoryStorySceneMainUI:__HideOptionFunBtn()
	self.TalkFunBtn.gameObject:SetActive(false)
	self.ExamineFunBtn.gameObject:SetActive(false)
end

function MemoryStorySceneMainUI:__ReShowOptionFunBtn()
	self:__ShowElementOptionUI(self.optionUIBindElementId, self.optionUITalkId, self.optionUIExamineId)
end

function MemoryStorySceneMainUI:__ShowDialog(elementId, talkId)
	self:__HideJoystick()
	self.TalkFunBtn.gameObject:SetActive(false)
	self.ExamineFunBtn.gameObject:SetActive(false)

	if talkId ~= 0 then
		self.TalkOpBtnRoot.gameObject:SetActive(false)
		self.dialogElem:OnShowDialog(elementId, talkId)
	else
		self.TalkOpBtnRoot.gameObject:SetActive(true)
	end
end

function MemoryStorySceneMainUI:__HideDialog()
	self.dialogElem:OnHide()
	self.TalkOpBtnRoot.gameObject:SetActive(false)
	self:__ShowJoystick()
	self:__ReShowOptionFunBtn()
end

function MemoryStorySceneMainUI:__InitJoystick()
	self.joystickComp = self.goJoystick:GetComponent("FingersJoystickScript")

	function self.joystickComp.JoystickExecuted(script, value)
		self:__OnJoystickExecutedEventHandler(script, value)
	end
end

function MemoryStorySceneMainUI:__DestroyJoystick()
	self.joystickComp = self.goJoystick:GetComponent("FingersJoystickScript")
	self.joystickComp.JoystickExecuted = nil
	self.joystickComp = nil
end

function MemoryStorySceneMainUI:__ShowJoystick()
	self.joystickComp:ResetJoyStickToCenter()
	self.goJoystick.gameObject:SetActive(true)
end

function MemoryStorySceneMainUI:__HideJoystick()
	self.goJoystick.gameObject:SetActive(false)
	EventDispatcher.Dispatch(EventID.JoystickMove, Vector2.zero)
end

function MemoryStorySceneMainUI:__OnJoystickExecutedEventHandler(script, value)
	EventDispatcher.Dispatch(EventID.JoystickMove, value)
end

function MemoryStorySceneMainUI:__PrepareButtonEventProxy()
	function self.btnCloseClickEventProxy()
		self:__OnBtnCloseClickEventHandler()
	end

	function self.talkFunBtnClickEventProxy()
		self:__OnTalkFunBtnClickEventHandler()
	end

	function self.examineFunBtnClickEventProxy()
		self:__OnExamineFunBtnClickEventHandler()
	end

	function self.talkContinueBtnClickEventProxy()
		self:__OnTalkContinueBtnClickEventHandler()
	end

	function self.talkShipBtnClickEventProxy()
		self:__OnTalkShipBtnClickEventHandler()
	end
end

function MemoryStorySceneMainUI:__AddButtonEventListener()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.btnCloseClickEventProxy)
	self.TalkOpSkipBtn:GetComponent("Button").onClick:AddListener(self.talkShipBtnClickEventProxy)
	self.TalkOpContinueBtn:GetComponent("Button").onClick:AddListener(self.talkContinueBtnClickEventProxy)
	self.TalkFunBtn:GetComponent("Button").onClick:AddListener(self.talkFunBtnClickEventProxy)
	self.ExamineFunBtn:GetComponent("Button").onClick:AddListener(self.examineFunBtnClickEventProxy)
end

function MemoryStorySceneMainUI:__RemoveButtonEventListener()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.btnCloseClickEventProxy)
	self.TalkOpSkipBtn:GetComponent("Button").onClick:RemoveListener(self.talkShipBtnClickEventProxy)
	self.TalkOpContinueBtn:GetComponent("Button").onClick:RemoveListener(self.talkContinueBtnClickEventProxy)
	self.TalkFunBtn:GetComponent("Button").onClick:RemoveListener(self.talkFunBtnClickEventProxy)
	self.ExamineFunBtn:GetComponent("Button").onClick:RemoveListener(self.examineFunBtnClickEventProxy)
end

function MemoryStorySceneMainUI:__OnBtnCloseClickEventHandler()
	MemoryStoryModule.OnStoryEnd(21043008)
end

function MemoryStorySceneMainUI:__OnTalkFunBtnClickEventHandler()
	if self.optionUITalkId <= 0 or self.optionUIBindElementId <= 0 then
		return
	end

	self:__ShowDialog(self.optionUIBindElementId, self.optionUITalkId)
end

function MemoryStorySceneMainUI:__OnExamineFunBtnClickEventHandler()
	if self.optionUIExamineId <= 0 or self.optionUIBindElementId <= 0 then
		return
	end

	MemoryStoryModule.ExecuteServicesByElementId(self.optionUIBindElementId, self.optionUIExamineId)
end

function MemoryStorySceneMainUI:__OnTalkContinueBtnClickEventHandler()
	MemoryStoryModule.CallNextDialog(1)
end

function MemoryStorySceneMainUI:__OnTalkShipBtnClickEventHandler()
	MemoryStoryModule.CallEndDialog()
end

function MemoryStorySceneMainUI:__PrepareLogicEventProxy()
	function self.setElementOptionUIActiveEventProxy(active, elementId, args)
		self:__OnSetElementOptionUIActiveEventHandler(active, elementId, args)
	end

	function self.showMemoryStoryTalkEventProxy(elementId, talkID)
		self:__OnShowMemoryStoryTalkEventHandler(elementId, talkID)
	end

	function self.hideMemoryStoryTalkEventProxy()
		self:__OnHideMemoryStoryTalkEventHandler()
	end

	function self.memoryStoryScenePrepareChangeEventProxy(sceneId)
		self:__OnMemoryStoryScenePrepareChangeEventHandler(sceneId)
	end

	function self.memoryStorySceneChangeSuccessEventProxy()
		self:__OnMemoryStorySceneChangeSuccessEventHandler()
	end

	function self.memoryStoryScenePrepareLeaveEventProxy()
		self:__OnMemoryStoryScenePrepareLeaveEventHandler()
	end
end

function MemoryStorySceneMainUI:__AddLogicEventListener()
	EventDispatcher.AddEventListener(EventID.SetMemoryStoryOptionUIActiveEvent, self.setElementOptionUIActiveEventProxy)
	EventDispatcher.AddEventListener(EventID.ShowMemoryStoryTalkUIEvent, self.showMemoryStoryTalkEventProxy)
	EventDispatcher.AddEventListener(EventID.HideMemoryStoryTalkEvent, self.hideMemoryStoryTalkEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryScenePrepareChangeEvent, self.memoryStoryScenePrepareChangeEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStorySceneChangeSuccessEvent, self.memoryStorySceneChangeSuccessEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryScenePrepareLeaveEvent, self.memoryStoryScenePrepareLeaveEventProxy)
end

function MemoryStorySceneMainUI:__RemoveLogicEventListener()
	EventDispatcher.RemoveEventListener(EventID.SetMemoryStoryOptionUIActiveEvent, self.setElementOptionUIActiveEventProxy)
	EventDispatcher.RemoveEventListener(EventID.ShowMemoryStoryTalkUIEvent, self.showMemoryStoryTalkEventProxy)
	EventDispatcher.RemoveEventListener(EventID.HideMemoryStoryTalkEvent, self.hideMemoryStoryTalkEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryScenePrepareChangeEvent, self.memoryStoryScenePrepareChangeEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStorySceneChangeSuccessEvent, self.memoryStorySceneChangeSuccessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryScenePrepareLeaveEvent, self.memoryStoryScenePrepareLeaveEventProxy)
end

function MemoryStorySceneMainUI:__OnSetElementOptionUIActiveEventHandler(active, elementId, args)
	if active == true then
		self:__ShowElementOptionUI(elementId, args.TalkID, args.ExamineID)
	else
		self:__HideElementOptionUI(elementId)
	end
end

function MemoryStorySceneMainUI:__OnShowMemoryStoryTalkEventHandler(elementId, talkId)
	self:__ShowDialog(elementId, talkId)
end

function MemoryStorySceneMainUI:__OnHideMemoryStoryTalkEventHandler()
	self:__HideDialog()
end

function MemoryStorySceneMainUI:__OnMemoryStoryScenePrepareChangeEventHandler(sceneId)
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MemoryStorySceneChangeScene, true)
	self:__HideJoystick()

	local canvas = self.EffectCanvas:GetComponent(typeof(UnityEngine.Canvas))

	self.changeSceneEffectId = GameEntry.Effect:PlayUIMountPointEffect(9008002, 50000, 0, self.EffectRoot, canvas.sortingOrder + 1)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MemoryStory, function()
		GameEntry.Effect:SetEffectSpeed(self.changeSceneEffectId, 0.01)
		EventDispatcher.Dispatch(EventID.MemoryStoryScenePrepareChangeReadyEvent, sceneId)
	end, 1, false)

	timer:Start()
end

function MemoryStorySceneMainUI:__OnMemoryStorySceneChangeSuccessEventHandler()
	self:__OnRefresh()
	self:__ShowJoystick()

	if self.changeSceneEffectId ~= 0 then
		GameEntry.Effect:SetEffectSpeed(self.changeSceneEffectId, 1)

		self.changeSceneEffectId = 0
	end

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MemoryStorySceneChangeScene, false)
end

function MemoryStorySceneMainUI:__OnMemoryStoryScenePrepareLeaveEventHandler()
	local canvas = self.EffectCanvas:GetComponent(typeof(UnityEngine.Canvas))

	self.leaveSceneEffectId = GameEntry.Effect:PlayUIMountPointEffect(9008002, 50000, 0, self.EffectRoot, canvas.sortingOrder + 1)

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MemoryStory, function()
		GameEntry.Effect:SetEffectSpeed(self.leaveSceneEffectId, 0.01)
		EventDispatcher.Dispatch(EventID.MemoryStoryScenePrepareLeaveReadyEvent)
	end, 1, false)

	timer:Start()
end

return MemoryStorySceneMainUI
