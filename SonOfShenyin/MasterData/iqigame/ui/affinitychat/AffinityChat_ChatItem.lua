-- chunkname: @IQIGame\\UI\\AffinityChat\\AffinityChat_ChatItem.lua

local AffinityChat_ChatItem = {}
local dataName_chatItem = "chatItem"
local stateName_player = "player"
local stateName_npc = "npc"
local stateName_event = "event"

function AffinityChat_ChatItem.New(go, OptimizedViewsHolder, mainView)
	local o = Clone(AffinityChat_ChatItem)

	o:Initialize(go, OptimizedViewsHolder, mainView)

	return o
end

function AffinityChat_ChatItem:Initialize(go, OptimizedViewsHolder, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.optimizedViewsHolder = OptimizedViewsHolder
	self.transform = self.gameObject.transform

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AffinityChat_ChatItem:InitComponent()
	self.rect = self.gameObject:GetComponent("RectTransform")
	self.chatBgRect = self.chatBg:GetComponent("RectTransform")
	self.imageBg = self.chatBg:GetComponent("Image")
	self.headImgNpc = self.imageHeadNpc:GetComponent("Image")
	self.headImgPlayer = self.imageHeadPlayer:GetComponent("Image")
	self.textLayout = self.textChat:GetComponent("UnityEngine.UI.LayoutElement")
	self.chatBgLayout = self.chatBg:GetComponent("UnityEngine.UI.LayoutElement")
	self.imagePhotoLayout = self.imagePhoto:GetComponent("UnityEngine.UI.LayoutElement")
	self.textRect = self.textChat:GetComponent("RectTransform")
	self.imageRect = self.imagePhoto:GetComponent("RectTransform")
	self.optimizedViewsHolder.contentSizeFitter = self.gameObject:GetComponent("ContentSizeFitter")
end

function AffinityChat_ChatItem:InitDelegate()
	function self.delegateOnClickEventRoot()
		self:OnClickEventRoot()
	end
end

function AffinityChat_ChatItem:AddListener()
	self.eventRoot:GetComponent("Button").onClick:AddListener(self.delegateOnClickEventRoot)
end

function AffinityChat_ChatItem:RemoveListener()
	self.eventRoot:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickEventRoot)
end

function AffinityChat_ChatItem:OnClickEventRoot()
	local cfgEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(self.data)

	if not cfgEntry.TriggerAction or #cfgEntry.TriggerAction == 0 then
		logError("【好感度】事件没有触发的行为")

		return
	end

	local taskCid = cfgEntry.TriggerActionParam[1][1]
	local taskData = TaskSystemModule.GetTaskByConfig(taskCid)
	local lvTaskArray = TaskSystemModule.GetSortForTypeDataList(taskData.type, {
		taskCid,
		Constant.RPGTaskType.LvChildTask
	}, TaskSystemModule.sortType.Id, true, true)

	for i = 1, #lvTaskArray do
		if not TaskSystemModule.CheckTaskIsFinished(lvTaskArray[i]) then
			NoticeModule.ShowNotice(11030)

			return
		end
	end

	local childTask = WorldMapModule.GetCurrentChildTaskByParentTaskId(taskCid, taskData.type)

	if childTask then
		local cfgTask = CfgUtil.GetTaskCfgWithID(childTask.cid)

		if cfgTask.TimeType == Constant.RPGTaskTimeType.Night and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
			NoticeModule.ShowNotice(12022)

			return
		elseif cfgTask.TimeType == Constant.RPGTaskTimeType.Day and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Night then
			NoticeModule.ShowNotice(12021)

			return
		end
	end

	local actionData = WorldMapModule.GetActionByTaskId(taskCid)

	if actionData then
		local componentData = WorldMapModule.GetComponentDataWithId(actionData.compCid)

		if not componentData then
			logError(string.format("【RPG】角色传送没有找到行为 id = %s,所属组件id = %s的组件数据", actionData.cid, actionData.compCid))

			return
		end

		local transPos = componentData:GetCfg().TransmitPoint
		local pos

		if transPos[1] and transPos[2] and transPos[3] then
			pos = Vector3.New(transPos[1], transPos[2], transPos[3])
		else
			pos = Vector3.New(componentData.pos.x + 3, componentData.pos.y, componentData.pos.z)
		end

		WorldMapModule.EnterRoom(actionData:GetRoomId(), true, pos and WorldMapModule.PackingEnterRoomData(pos) or nil)
	elseif taskData.type == Constant.MainTaskType.RPGMain then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.MainTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	elseif taskData.type == Constant.MainTaskType.RPGBranch then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.BranchTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	end

	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.MainUI
	})
	EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, false)
end

function AffinityChat_ChatItem:Refresh(Data, OptimizedViewsHolder)
	self.data = Data
	self.optimizedViewsHolder = OptimizedViewsHolder
	self.optimizedViewsHolder.contentSizeFitter = self.gameObject:GetComponent("ContentSizeFitter")
	self.hasPendingVisualSizeChange = true

	local cfgFavorEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(self.data)

	if not LuaUtility.StrIsNullOrEmpty(cfgFavorEntry.IconFemale) or not LuaUtility.StrIsNullOrEmpty(cfgFavorEntry.IconMale) then
		LuaUtility.LoadImage(self, AffinityModule.GetFavorIcon(self.data), self.headImgNpc)
		LuaUtility.LoadImage(self, AffinityModule.GetFavorIcon(self.data), self.headImgPlayer)
	end

	if cfgFavorEntry.Position == 1 then
		LuaUtility.SetStateController(self.gameObject, dataName_chatItem, stateName_npc)
	elseif cfgFavorEntry.Position == 2 then
		LuaUtility.SetStateController(self.gameObject, dataName_chatItem, stateName_player)
	else
		logError(string.format("【好感度】favorEntry表id = %s配置了没有定义的 Position 类型 = %s", cfgFavorEntry.Id, cfgFavorEntry.Position))
	end

	LuaUtility.SetGameObjectShow(self.imagePhoto, false)
	LuaUtility.SetGameObjectShow(self.textChat, false)
	LuaUtility.SetGameObjectShow(self.eventRoot, false)
	LuaUtility.SetGameObjectShow(self.textCheat, false)

	self.imageBg.enabled = true

	self:HideBubble()

	if cfgFavorEntry.Type == Constant.FavorEntryType.Text then
		LuaUtility.SetGameObjectShow(self.textChat, true)
		LuaUtility.SetText(self.textChat, string.format(AffinityModule.GetFavorText(self.data), PlayerModule.GetName()))
	elseif cfgFavorEntry.Type == Constant.FavorEntryType.Image then
		LuaUtility.SetGameObjectShow(self.imagePhoto, true)

		self.imageBg.enabled = false

		LuaUtility.SetGameObjectShow(self.arrowImgNpc, false)
		LuaUtility.SetGameObjectShow(self.arrowImgPlayer, false)

		local assetPath = AffinityModule.GetFavorText(self.data)

		LuaUtility.LoadImage(self, assetPath, self.imagePhoto:GetComponent("Image"), function()
			self.optimizedViewsHolder:MarkForRebuild()
			self.mainView.chattingRecordsScroll:ForceRebuildVHAndUpdateSize(self.optimizedViewsHolder, true, true)
		end)
	elseif cfgFavorEntry.Type == Constant.FavorEntryType.Event then
		LuaUtility.SetGameObjectShow(self.eventRoot, true)
		LuaUtility.SetText(self.textEvent, AffinityModule.GetFavorText(self.data))
		LuaUtility.SetStateController(self.gameObject, dataName_chatItem, stateName_event)
	elseif cfgFavorEntry.Type == Constant.FavorEntryType.Cheat then
		LuaUtility.SetGameObjectShow(self.textCheat, true)
		LuaUtility.SetText(self.textCheat, AffinityModule.GetFavorText(self.data))
	else
		logError("【好感度】没有Entry类型Type = " .. cfgFavorEntry.Type)
	end

	if cfgFavorEntry.IsLastEntry == 1 then
		LuaUtility.SetGameObjectShow(self.historyState, true)
	else
		LuaUtility.SetGameObjectShow(self.historyState, false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rect)

	if cfgFavorEntry.Type == Constant.FavorEntryType.Text then
		if self.textRect.sizeDelta.x > 650 then
			self.textLayout.enabled = true
			self.textLayout.preferredWidth = 650
			self.chatBgLayout.enabled = true
			self.chatBgLayout.preferredWidth = 650
		else
			self.textLayout.enabled = false
			self.chatBgLayout.enabled = false
		end
	elseif cfgFavorEntry.Type == Constant.FavorEntryType.Image then
		if self.imageRect.sizeDelta.x > 650 then
			self.imagePhotoLayout.enabled = true
			self.imagePhotoLayout.preferredWidth = 650
			self.chatBgLayout.enabled = true
			self.chatBgLayout.preferredWidth = 650
		else
			self.imagePhotoLayout.enabled = false
			self.chatBgLayout.enabled = false
		end
	elseif cfgFavorEntry.Type == Constant.FavorEntryType.Event then
		self.chatBgLayout.enabled = false
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rect)
end

function AffinityChat_ChatItem:ShowBubble()
	local cfgFavorEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(self.data)

	if cfgFavorEntry.Position == 1 then
		LuaUtility.SetGameObjectShow(self.npcInputState, true)
	elseif cfgFavorEntry.Position == 2 then
		LuaUtility.SetGameObjectShow(self.playerInputState, true)
	end

	self.imageBg.enabled = true

	LuaUtility.SetGameObjectShow(self.textChat, false)
	LuaUtility.SetGameObjectShow(self.imagePhoto, false)

	self.chatBgLayout.enabled = false
end

function AffinityChat_ChatItem:PlayEnterAni()
	local cfgFavorEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(self.data)
	local publicParam = CfgUtil.GetPublicParametersData()

	if cfgFavorEntry.Position == 1 then
		-- block empty
	elseif cfgFavorEntry.Position == 2 then
		-- block empty
	end

	coroutine.start(function()
		LuaUtility.PlayAnimation(self.gameObject, "chatItem_in")

		self.mainView.isAnimate = true

		coroutine.wait(LuaUtility.GetAnimationLengthWithName(self.gameObject, "chatItem_in"))

		self.mainView.isAnimate = false
	end)
end

function AffinityChat_ChatItem:HideBubble()
	LuaUtility.SetGameObjectShow(self.npcInputState, false)
	LuaUtility.SetGameObjectShow(self.playerInputState, false)
end

function AffinityChat_ChatItem:OnDestroy()
	self.imagePhotoLayout = nil
	self.imageRect = nil
	self.chatBgSizeAdapter = nil
	self.chatBgRect = nil
	self.headImgNpc = nil
	self.optimizedViewsHolder = nil
	self.headImgPlayer = nil
	self.chatBgLayout = nil
	self.rect = nil
	self.imageBg = nil
	self.transform = nil
	self.gameObject = nil

	AssetUtil.UnloadAsset(self)
end

return AffinityChat_ChatItem
