-- chunkname: @IQIGame\\UI\\Chat\\ChatMsgCell.lua

local ChatMsgCell = {
	isMyself = false,
	_isUsed = false,
	chatMsgTable = {},
	cellView = {},
	headIcon = {}
}

function ChatMsgCell.PackageOrReuseView(ui, itemCellPrefab)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ChatMsgCell == nil then
		ui.__SUB_UI_MAP_ChatMsgCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ChatMsgCell
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = ChatMsgCell.New(itemCellPrefab)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	return itemCell
end

function ChatMsgCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ChatMsgCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ChatMsgCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ChatMsgCell = nil
end

function ChatMsgCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.leftCellView.goContentAudioBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnAudioClick)
	self.rightCellView.goContentAudioBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnAudioClick)
	self.leftHeadIcon.HeadIcon:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClick)
	self.rightHeadIcon.HeadIcon:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClick)
	LuaCodeInterface.ClearOutlet(self.cellView.leftNode, self.leftCellView)
	LuaCodeInterface.ClearOutlet(self.cellView.rightNode, self.rightCellView)
	LuaCodeInterface.ClearOutlet(self.cellView.sysNode, self.sysCellView)
	LuaCodeInterface.ClearOutlet(self.leftHeadNode.gameObject, self.leftHeadIcon)
	LuaCodeInterface.ClearOutlet(self.rightHeadNode.gameObject, self.rightHeadIcon)
	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)
end

function ChatMsgCell.New(itemCellView)
	local itemCell = Clone(ChatMsgCell)
	local chatMsgCell = itemCellView

	itemCell.cellObj = chatMsgCell
	itemCell.cellView = {}
	itemCell.leftCellView = {}
	itemCell.rightCellView = {}
	itemCell.sysCellView = {}
	itemCell.leftHeadIcon = {}
	itemCell.rightHeadIcon = {}
	itemCell._isUsed = true

	LuaCodeInterface.BindOutlet(chatMsgCell, itemCell.cellView)
	LuaCodeInterface.BindOutlet(itemCell.cellView.leftNode, itemCell.leftCellView)
	LuaCodeInterface.BindOutlet(itemCell.cellView.rightNode, itemCell.rightCellView)
	LuaCodeInterface.BindOutlet(itemCell.cellView.sysNode, itemCell.sysCellView)

	itemCell.leftHeadNode = itemCell.leftCellView.goSlotParent.transform:GetChild(0)
	itemCell.rightHeadNode = itemCell.rightCellView.goSlotParent.transform:GetChild(0)

	LuaCodeInterface.BindOutlet(itemCell.leftHeadNode.gameObject, itemCell.leftHeadIcon)
	LuaCodeInterface.BindOutlet(itemCell.rightHeadNode.gameObject, itemCell.rightHeadIcon)

	function itemCell.DelegateOnBtnClick()
		itemCell:OnBtnClick()
	end

	function itemCell.DelegateOnBtnAudioClick()
		itemCell:OnBtnAudioClick()
	end

	itemCell.leftCellView.goContentAudioBtn:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnBtnAudioClick)
	itemCell.rightCellView.goContentAudioBtn:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnBtnAudioClick)
	itemCell.leftHeadIcon.HeadIcon:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnBtnClick)
	itemCell.rightHeadIcon.HeadIcon:GetComponent("Button").onClick:AddListener(itemCell.DelegateOnBtnClick)

	return itemCell
end

function ChatMsgCell:SetItem(SChatPOD)
	self.chatMsgTable = SChatPOD

	local msgView
	local isLeft = false

	if SChatPOD.sender ~= nil then
		if SChatPOD.sender.pid ~= PlayerModule.PlayerInfo.baseInfo.pid then
			msgView = self.leftCellView

			self.cellView.leftNode:SetActive(true)
			self.cellView.rightNode:SetActive(false)

			isLeft = true
		else
			msgView = self.rightCellView

			self.cellView.rightNode:SetActive(true)
			self.cellView.leftNode:SetActive(false)

			isLeft = false
		end
	end

	if SChatPOD.sender == nil then
		self.cellView.sysNode:SetActive(true)
		self.cellView.leftNode:SetActive(false)
		self.cellView.rightNode:SetActive(false)

		self.sysCellView.timeTxt:GetComponent("Text").text = getDateTimeText(SChatPOD.time)
		self.sysCellView.msgTxt:GetComponent("Text").text = SChatPOD.content
	else
		self.cellView.sysNode:SetActive(false)

		local headIconData = CfgPlayerHeadIconTable[SChatPOD.sender.headIcon]

		if headIconData ~= nil then
			self:LoadAsset(UIGlobalApi.IconPath .. headIconData.Url, msgView.goSlotParent.transform:GetChild(0))
		end

		self:ShowTitle(SChatPOD, msgView.TitlePos.transform)

		msgView.goName:GetComponent("Text").text = ChatUIApi:GetString("goChannelCellTitle", SChatPOD.channel, SChatPOD.sender.pName)

		local chatContent = WarnStrFunc:warningStrGsub(SChatPOD.content)
		local isAudio = false
		local startIndex, endIndex = string.find(chatContent, "(audio)")

		if startIndex == 3 and endIndex == 7 then
			isAudio = true
		end

		local isEmoticon = false
		local CfgEmoticonData

		if #chatContent >= 3 and #chatContent <= 6 then
			for str in string.gmatch(chatContent, "#(%d+)#") do
				if tonumber(str) ~= nil then
					CfgEmoticonData = CfgChatEmoticonTable[tonumber(str)]
				end

				if CfgEmoticonData ~= nil then
					isEmoticon = true

					break
				end
			end
		end

		msgView.goContentAudioParent:SetActive(false)

		if isAudio then
			msgView.goContentTxtParent:SetActive(false)
			msgView.goContentImgParent:SetActive(false)
			msgView.goContentAudioParent:SetActive(true)

			local strList = string.split(SChatPOD.content, "|")
			local argsList = string.split(strList[2], "~")

			if argsList[3] ~= nil then
				local audioText = WarnStrFunc:warningStrGsub(argsList[3])

				msgView.AudioText:GetComponent("Text").text = audioText
			else
				msgView.AudioText:GetComponent("Text").text = ""
			end
		elseif isEmoticon == true then
			msgView.goContentTxtParent:SetActive(false)
			msgView.goContentImgParent:SetActive(true)

			local sequenceComponent = msgView.emotion:GetComponent("FrameSequenceComponent")

			sequenceComponent.relativePath = CfgEmoticonData.Emoticons
			sequenceComponent.startNumber = CfgEmoticonData.startIndex
			sequenceComponent.imageCount = CfgEmoticonData.totalNum

			local resPath = ChatUIApi:GetString("emotion", CfgEmoticonData)

			self:LoadAsset(resPath, msgView.emotion, "emotion")
		else
			msgView.goContentImgParent:SetActive(false)
			msgView.goContentTxtParent:SetActive(true)
			UGUIUtil.SetTextInChildren(msgView.TextContent, chatContent)
			self:ShowChatBubble(isLeft, SChatPOD, msgView.bgNode.transform, chatContent)
		end
	end
end

function ChatMsgCell:ShowChatBubble(isLeft, SChatPOD, transform, chatContent)
	local cid = SChatPOD.sender.chatBackground

	if cid == nil or cid == 0 then
		cid = ChatBubbleModule.GetDefaultChatBubble()
	end

	local cfg = CfgChatBubbleTable[cid]
	local path

	if isLeft then
		path = UIGlobalApi.GetArtPath(cfg.LeftPrefabName)
	else
		path = UIGlobalApi.GetArtPath(cfg.RightPrefabName)
	end

	AssetUtil.LoadAsset(self, path, self.OnLoadPrefabSucceed, nil, {
		type = "LoadBubble",
		parent = transform,
		content = chatContent
	})
end

function ChatMsgCell:ShowTitle(SChatPOD, transform)
	if SChatPOD.sender ~= nil then
		if SChatPOD.sender.title ~= nil and SChatPOD.sender.title > 0 then
			transform.gameObject:SetActive(true)

			local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[SChatPOD.sender.title].Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadPrefabSucceed, nil, {
				type = "LoadTitle",
				parent = transform
			})
		else
			transform.gameObject:SetActive(false)
		end
	end
end

function ChatMsgCell:OnLoadPrefabSucceed(assetName, asset, duration, userData)
	local type = userData.type
	local transform = userData.parent

	if type == "LoadTitle" then
		for i = 0, transform.childCount - 1 do
			local obj = transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goTitle = UnityEngine.Object.Instantiate(asset)
		local size = Vector2.New(35, 35)

		goTitle.transform:Find("Image").sizeDelta = size
		goTitle.transform.sizeDelta = size

		goTitle.transform:SetParent(transform, false)
	elseif type == "LoadBubble" then
		for i = 0, transform.childCount - 1 do
			local obj = transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local chatBubble = UnityEngine.Object.Instantiate(asset)
		local content = userData.content

		UGUIUtil.SetTextInChildren(chatBubble, content)
		chatBubble.transform:SetParent(transform, false)
	end
end

function ChatMsgCell:OnBtnClick()
	if self.chatMsgTable.sender.pid ~= PlayerModule.PlayerInfo.baseInfo.pid then
		EventDispatcher.Dispatch(EventID.ClickHead, {
			PlayerSimplePOD = self.chatMsgTable.sender,
			anchoredPosition3D = self.cellObj.transform.anchoredPosition3D,
			MsgData = self.chatMsgTable
		})
	end
end

function ChatMsgCell:OnBtnAudioClick()
	local strList = string.split(self.chatMsgTable.content, "|")
	local argsList = string.split(strList[2], "&")
end

function ChatMsgCell:Clear()
	self.cellView = {}
	self.headIcon = {}
	self._isUsed = false

	if self.sysCellView ~= nil then
		self.sysCellView.timeTxt:GetComponent("Text").text = ""
		self.sysCellView.msgTxt:GetComponent("Text").text = ""
	end
end

function ChatMsgCell:LoadAsset(path, icon, type)
	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, self.OnLoadFailed, {
		icon,
		type
	})
end

function ChatMsgCell:OnLoadSucceed(assetName, asset, duration, userData)
	local goIcon = userData[1]
	local type = userData[2]
	local imgIcon = goIcon:GetComponent("Image")

	if LuaCodeInterface.GameObjIsDestroy(imgIcon) then
		local headView = {}

		LuaCodeInterface.BindOutlet(goIcon.gameObject, headView)

		local headIcon = headView.HeadIcon:GetComponent("Image")

		headIcon.sprite = LuaCodeInterface.ToSprite(asset)

		if self.chatMsgTable.sender ~= nil then
			local lv = 0

			if self.chatMsgTable.sender.pid == PlayerModule.PlayerInfo.baseInfo.pid then
				lv = PlayerModule.PlayerInfo.baseInfo.pLv
			else
				lv = self.chatMsgTable.sender.pLv
			end

			headView.LevelText:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerLv", lv)

			if self.chatMsgTable.sender.avatarFrame ~= nil and self.chatMsgTable.sender.avatarFrame > 0 then
				local cfgPlayerAvatarFrameData = CfgPlayerAvatarFrameTable[self.chatMsgTable.sender.avatarFrame]
				local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrameData.Prefab)

				AssetUtil.LoadAsset(self, path, self.OnLoadFrameSucceed, nil, headView.HeadFrame)
			end
		end

		LuaCodeInterface.ClearOutlet(goIcon.gameObject, headView)
	else
		imgIcon.sprite = LuaCodeInterface.ToSprite(asset)

		if type == "emotion" then
			goIcon:GetComponent("FrameSequenceComponent"):Play()
		end
	end
end

function ChatMsgCell:OnLoadFrameSucceed(assetName, asset, duration, userData)
	local root = userData

	if root ~= nil then
		for i = 0, root.transform.childCount - 1 do
			local obj = root.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goFrame = UnityEngine.Object.Instantiate(asset)

		goFrame.transform:SetParent(root.transform, false)
		UIUtil.InitSortedComponents(root:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
		EventDispatcher.Dispatch(EventID.PlayerHeadFrameLoaded)
	end
end

function ChatMsgCell:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return ChatMsgCell
