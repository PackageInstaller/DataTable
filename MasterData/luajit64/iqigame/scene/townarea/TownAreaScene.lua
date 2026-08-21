-- chunkname: @IQIGame\\Scene\\TownArea\\TownAreaScene.lua

local TownAreaScene = {
	taskEntryPool = {},
	eventEntryPool = {},
	npcPool = {},
	walkAreas = {}
}
local TaskEntry = require("IQIGame.Scene.TownArea.TaskEntry")
local EventEntry = require("IQIGame.Scene.TownArea.EventEntry")
local AreaEventEntry = require("IQIGame.Scene.TownArea.AreaEventEntry")
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local Npc = require("IQIGame.Scene.TownArea.Npc")

function TownAreaScene.New(view)
	local obj = Clone(TownAreaScene)

	obj:Init(view)

	return obj
end

function TownAreaScene:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	GameEntry.Input:InitPanGesture()

	self.cameraCtrl = CameraCtrl.New()
	self.cameraCtrl.speedAutoMoveToTarget = TownAreaUIApi:GetString("sceneStairSpeed")

	function self.cameraCtrl.onMoveTargetOverDelegate()
		self:OnMoveTargetOver()
	end

	self.goTaskEntry:SetActive(false)
	self.goEventEntry:SetActive(false)
	self.goAreaEventEntry:SetActive(false)

	for i = 1, self.goWalkAreaRoot.transform.childCount do
		local trans = self.goWalkAreaRoot.transform:Find("WalkArea_" .. i)
		local leftPos = trans:Find("LimitLeft").localPosition
		local rightPos = trans:Find("LimitRight").localPosition

		self.walkAreas[i] = {
			leftPos,
			rightPos,
			trans
		}
	end

	function self.onClickBtnShopDelegate()
		self:OnClickBtnShop()
	end

	function self.onClickBtnSearchDelegate()
		self:OnClickBtnSearch()
	end

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	function self.updateTownAreaEventDelegate()
		self:OnUpdateTownAreaEvent()
	end

	function self.onRefreshNpcDelegate(cfgNpcData)
		self:OnRefreshNpc(cfgNpcData)
	end

	function self.onClickBtnUpStairDelegate()
		self:OnClickBtnUpStair()
	end

	function self.onClickBtnDownStairDelegate()
		self:OnClickBtnDownStair()
	end

	function self.onClickBtnDownUnknownDelegate()
		self:OnClickBtnDownUnknown()
	end

	function self.onSpineDoorUpEndDelegate()
		self:OnSpineDoorUpEnd()
	end

	function self.onSpineDoorDownEndDelegate()
		self:OnSpineDoorDownEnd()
	end

	function self.onClickBtnMiningDelegate()
		self:OnClickBtnMining()
	end

	self:OnAddListener()
end

function TownAreaScene:Refresh(userData)
	self.areaData = userData

	self:RefreshMisc()
	self:RefreshCamera()
	self:RefreshAllEventEntry()
	self:RefreshAllNpc()
	TownAreaModule.PlaySound()
end

function TownAreaScene:OnDestroy()
	TownAreaModule.StopSound()
	self:OnRemoveListener()
	GameEntry.Input:RemovePanGesture()
	self.cameraCtrl:OnDestroy()

	for i, v in pairs(self.eventEntryPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.taskEntryPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.npcPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TownAreaScene:OnAddListener()
	if self.goBtnShop ~= nil then
		EventTriggerListener.Get(self.goBtnShop).onClick = self.onClickBtnShopDelegate
	end

	if self.goBtnSearch ~= nil then
		EventTriggerListener.Get(self.goBtnSearch).onClick = self.onClickBtnSearchDelegate
	end

	if self.goBtnUpStair ~= nil then
		EventTriggerListener.Get(self.goBtnUpStair).onClick = self.onClickBtnUpStairDelegate
	end

	if self.goBtnDownStair ~= nil then
		EventTriggerListener.Get(self.goBtnDownStair).onClick = self.onClickBtnDownStairDelegate
	end

	if self.goBtnDownUnknownStair ~= nil then
		EventTriggerListener.Get(self.goBtnDownUnknownStair).onClick = self.onClickBtnDownUnknownDelegate
	end

	if self.goBtnMining ~= nil then
		EventTriggerListener.Get(self.goBtnMining).onClick = self.onClickBtnMiningDelegate
	end

	EventDispatcher.AddEventListener(EventID.UpdateTownAreaEvent, self.updateTownAreaEventDelegate)
	EventDispatcher.AddEventListener(EventID.TownAreaRefreshNpc, self.onRefreshNpcDelegate)
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
end

function TownAreaScene:OnRemoveListener()
	if self.goBtnShop ~= nil then
		EventTriggerListener.Get(self.goBtnShop).onClick = nil
	end

	if self.goBtnSearch ~= nil then
		EventTriggerListener.Get(self.goBtnSearch).onClick = nil
	end

	if self.goBtnUpStair ~= nil then
		EventTriggerListener.Get(self.goBtnUpStair).onClick = nil
	end

	if self.goBtnDownStair ~= nil then
		EventTriggerListener.Get(self.goBtnDownStair).onClick = nil
	end

	if self.goBtnDownUnknownStair ~= nil then
		EventTriggerListener.Get(self.goBtnDownUnknownStair).onClick = nil
	end

	if self.goBtnMining ~= nil then
		EventTriggerListener.Get(self.goBtnMining).onClick = nil
	end

	if self.goSpineDoorUp ~= nil then
		local anim = self.goSpineDoorUp:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		anim.state.Complete = anim.state.Complete - self.onSpineDoorUpEndDelegate
	end

	if self.goSpineDoorDown ~= nil then
		local anim = self.goSpineDoorDown:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		anim.state.Complete = anim.state.Complete - self.onSpineDoorDownEndDelegate
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateTownAreaEvent, self.updateTownAreaEventDelegate)
	EventDispatcher.RemoveEventListener(EventID.TownAreaRefreshNpc, self.onRefreshNpcDelegate)
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
end

function TownAreaScene:OnClickBtnShop()
	self:ClickFixedFunction(Constant.TownFixedFunctionType.Shop)
end

function TownAreaScene:OnClickBtnSearch()
	self:ClickFixedFunction(Constant.TownFixedFunctionType.Search)
end

function TownAreaScene:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end

	for i, v in pairs(self.eventEntryPool) do
		v:OnUpdate()
	end

	for i, v in pairs(self.npcPool) do
		v:OnUpdate()
	end
end

function TownAreaScene:OnUpdateTownAreaEvent()
	self:RefreshAllEventEntry()
end

function TownAreaScene:OnRefreshNpc(cfgNpcData)
	local existNpc

	for i, v in pairs(self.npcPool) do
		if v.cfgTownAreaNpcData.Id == cfgNpcData.Id and v.isWorking then
			existNpc = v

			break
		end
	end

	local curAreaId = TownAreaModule.npc2AreaDic[cfgNpcData.Id]

	if existNpc then
		if curAreaId ~= self.areaData.cfgID then
			existNpc:SetActive(false)
		end
	elseif curAreaId == self.areaData.cfgID then
		self:AddNpc(cfgNpcData.Id)
	end
end

function TownAreaScene:RefreshMisc()
	for i, v in pairs(self.taskEntryPool) do
		v:SetActive(false)
	end

	for i, v in pairs(self.eventEntryPool) do
		v:SetActive(false)
	end

	for i, v in pairs(self.npcPool) do
		v:SetActive(false)
	end
end

function TownAreaScene:RefreshCamera()
	self.cameraCtrl:Refresh(0, self.goLimitLeft.transform.position, self.goLimitRight.transform.position, UnityEngine.Camera.main, 3.75)
end

function TownAreaScene:RefreshAllEventEntry()
	for i, v in pairs(self.areaData.townFunDic) do
		if v.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY or v.functionType == TownModule.TOWN_FUNCTION_SHOPPING then
			local existEntry = false

			for m, n in pairs(self.eventEntryPool) do
				if n.isWorking and v.cfgID == n.townFunctionData.cfgID then
					existEntry = true

					break
				end
			end

			if not existEntry then
				self:AddEventEntry(v)
			end
		end
	end

	for i, v in pairs(self.eventEntryPool) do
		local existData = false

		for m, n in pairs(self.areaData.townFunDic) do
			if (n.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY or n.functionType == TownModule.TOWN_FUNCTION_SHOPPING) and v.isWorking and v.townFunctionData.cfgID == n.cfgID then
				existData = true

				break
			end
		end

		if not existData then
			v:SetActive(false)
		end
	end
end

function TownAreaScene:RefreshAllTaskEntry()
	for i, v in pairs(self.areaData.townFunDic) do
		if v.functionType == TownModule.TOWN_FUNCTION_PLOT then
			local existEntry = false

			for m, n in pairs(self.taskEntryPool) do
				if n.isWorking and v.cfgID == n.townFunctionData.cfgID then
					existEntry = true

					break
				end
			end

			if not existEntry then
				self:AddTaskEntry(v)
			end
		end
	end

	for i, v in pairs(self.taskEntryPool) do
		local existData = false

		for m, n in pairs(self.areaData.townFunDic) do
			if n.functionType == TownModule.TOWN_FUNCTION_PLOT and v.isWorking and v.townFunctionData.cfgID == n.cfgID then
				existData = true

				break
			end
		end

		if not existData then
			v:SetActive(false)
		end
	end
end

function TownAreaScene:RefreshAllNpc()
	local ids = {}

	for i, v in pairs(TownAreaModule.npc2AreaDic) do
		if v == self.areaData.cfgID then
			ids[#ids + 1] = i
		end
	end

	for i, v in ipairs(ids) do
		self:AddNpc(v)
	end
end

function TownAreaScene:AddTaskEntry(funcData)
	local entry = self:GetIdleTaskEntry()
	local pos = Vector3.New(0, 0, 0)

	if #funcData.cfgTownEvent.TownAreaPros ~= 0 then
		pos.x = funcData.cfgTownEvent[1]
		pos.y = funcData.cfgTownEvent[2]
		pos.z = funcData.cfgTownEvent[3]
	end

	entry:Refresh(funcData, pos)
end

function TownAreaScene:AddEventEntry(funcData)
	local randomPos, randomArea = self:GetRandomData()
	local entry

	if funcData.cfgTownEvent ~= nil and #funcData.cfgTownEvent.TownAreaPros ~= 0 then
		entry = self:GetIdleEventEntry(self.goAreaEventRoot.transform, funcData)

		entry:Refresh(funcData, funcData.cfgTownEvent.TownAreaPros)
	else
		entry = self:GetIdleEventEntry(randomArea[3], funcData)

		entry:Refresh(funcData, randomPos, randomArea)
	end
end

function TownAreaScene:AddNpc(id)
	local randomPos, randomArea = self:GetRandomData()
	local npc = self:GetIdleNpc(randomArea[3])

	npc:Refresh(id, randomPos, randomArea)
end

function TownAreaScene:GetRandomData()
	local randomArea = self.walkAreas[math.random(1, #self.walkAreas)]
	local randomPos = Vector3.New(math.Random(randomArea[1].x, randomArea[2].x), randomArea[1].y, randomArea[1].z)

	return randomPos, randomArea
end

function TownAreaScene:GetIdleTaskEntry()
	local entry

	for i, v in pairs(self.taskEntryPool) do
		if not v.isWorking then
			entry = v

			break
		end
	end

	if entry == nil then
		local go = UnityEngine.Object.Instantiate(self.goTaskEntry)

		go.transform:SetParent(self.goTaskRoot.transform, false)

		entry = TaskEntry.New(go)
		self.taskEntryPool[#self.taskEntryPool + 1] = entry
	end

	return entry
end

function TownAreaScene:GetIdleEventEntry(parent, funcData)
	local entry

	for i, v in pairs(self.eventEntryPool) do
		if not v.isWorking then
			entry = v

			break
		end
	end

	if entry == nil then
		local go

		if funcData.cfgTownEvent ~= nil and #funcData.cfgTownEvent.TownAreaPros ~= 0 then
			go = UnityEngine.Object.Instantiate(self.goAreaEventEntry)
			entry = AreaEventEntry.New(go)
		else
			go = UnityEngine.Object.Instantiate(self.goEventEntry)
			entry = EventEntry.New(go)
		end

		go.transform:SetParent(parent, false)

		self.eventEntryPool[#self.eventEntryPool + 1] = entry
	end

	return entry
end

function TownAreaScene:GetIdleNpc(parent)
	local npc

	for i, v in pairs(self.npcPool) do
		if not v.isWorking then
			npc = v

			break
		end
	end

	if npc == nil then
		local go = UnityEngine.Object.Instantiate(self.goNpc)

		npc = Npc.New(go)
		self.npcPool[#self.npcPool + 1] = npc
	end

	return npc
end

function TownAreaScene:ClickFixedFunction(type)
	for i, v in pairs(self.areaData.townFunDic) do
		if v.cfgID == type then
			TownModule.ExecutionEvent(v)

			break
		end
	end
end

function TownAreaScene:OnClickBtnUpStair()
	self.cameraCtrl:SetDragEnable(false)
	self.cameraCtrl:SetMoseEnable(false)

	self.isToDown = true

	self:PlaySpineDoorUp()
end

function TownAreaScene:OnClickBtnDownStair()
	self.cameraCtrl:SetDragEnable(false)
	self.cameraCtrl:SetMoseEnable(false)
	self.goBtnUpStair:SetActive(false)
	self.goBtnUpStair:SetActive(true)

	self.isToDown = false

	self:PlaySpineDoorDown()
end

function TownAreaScene:OnClickBtnDownUnknown()
	self.goBtnDownUnknownStair:SetActive(false)
	self.goBtnDownUnknownStair:SetActive(true)
	NoticeModule.ShowNoticeNoCallback(21052003)
end

function TownAreaScene:OnSpineDoorUpEnd()
	local anim = self.goSpineDoorUp:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	anim.state.Complete = anim.state.Complete - self.onSpineDoorUpEndDelegate

	if self.isToDown then
		local targetPos = Vector2.New(self.cameraCtrl.transCamera.position.x, self.goLimitBottom.transform.position.y)

		self.cameraCtrl:StartAutoMoveToTarget(targetPos, true)
	else
		self.cameraCtrl:SetMoseEnable(true)
		self.cameraCtrl:SetDragEnable(true)
	end
end

function TownAreaScene:OnSpineDoorDownEnd()
	local anim = self.goSpineDoorDown:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	anim.state.Complete = anim.state.Complete - self.onSpineDoorDownEndDelegate

	if self.isToDown then
		self.cameraCtrl:SetMoseEnable(true)
		self.cameraCtrl:SetDragEnable(true)
	else
		local targetPos = Vector2.New(self.cameraCtrl.transCamera.position.x, self.goLimitTop.transform.position.y)

		self.cameraCtrl:StartAutoMoveToTarget(targetPos, true)
	end
end

function TownAreaScene:OnMoveTargetOver()
	if self.isToDown then
		self:PlaySpineDoorDown()
	else
		self:PlaySpineDoorUp()
	end

	self.cameraCtrl:SetDragEnable(false)
end

function TownAreaScene:PlaySpineDoorUp()
	local anim = self.goSpineDoorUp:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	anim.state:SetEmptyAnimation(0, 0)
	anim.state:SetAnimation(0, "Startup", false)

	anim.state.Complete = anim.state.Complete + self.onSpineDoorUpEndDelegate
end

function TownAreaScene:PlaySpineDoorDown()
	local anim = self.goSpineDoorDown:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	anim.state:SetEmptyAnimation(0, 0)
	anim.state:SetAnimation(0, "Startup", false)

	anim.state.Complete = anim.state.Complete + self.onSpineDoorDownEndDelegate
end

function TownAreaScene:OnClickBtnMining()
	if MiningModule.IsOpen() then
		TownAreaModule.CleanAreaScene()
		MiningModule.EnterMap()
	end
end

return TownAreaScene
