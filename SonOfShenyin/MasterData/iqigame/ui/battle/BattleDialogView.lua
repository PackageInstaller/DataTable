-- chunkname: @IQIGame\\UI\\Battle\\BattleDialogView.lua

local BattleDialogElement = {
	contentProgress = 0
}

function BattleDialogElement.New(view)
	local obj = Clone(BattleDialogElement)

	obj:__Init(view)

	return obj
end

function BattleDialogElement:__Init(view)
	self.gameObject = view

	self.gameObject:SetActive(false)
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.contentTextBackgroundSource = self.textChatContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.npcNameTextBackgroundSource = self.textName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
end

function BattleDialogElement:Dispose()
	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end

	self.contentTextBackgroundSource = nil
	self.npcNameTextBackgroundSource = nil

	self.gameObject:SetActive(false)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleDialogElement:Show(dialogCfg)
	local picture = dialogCfg.Picture[1]

	if #dialogCfg.Picture > 1 then
		picture = PlayerModule.GetSex() == 0 and dialogCfg.Picture[1] or dialogCfg.Picture[2]
	end

	if LuaUtility.StrIsNullOrEmpty(picture) then
		logError("战斗对话 {0} 配置错误，未正确配置 字段 Picture")
	end

	local path = BattleApi:GetBattleDialogPicture(picture)
	local pictureImage = self.SpineMountPoint:GetComponent("Image")

	AssetUtil.LoadImage(self, path, pictureImage, function(assetName, asset, duration, userData)
		pictureImage:SetNativeSize()
		LuaUtility.SetImageRectTransformPivot(self.SpineMountPoint.transform, pictureImage)
	end)

	self.contentProgress = 0

	UGUIUtil.SetText(self.textName, dialogCfg.Name)
	self.npcNameTextBackgroundSource:SetProgress(1)
	UGUIUtil.SetText(self.textChatContent, dialogCfg.Dialogue)
	self.contentTextBackgroundSource:SetProgress(self.contentProgress)

	self.dialogShowTime = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		self.contentProgress = self.contentProgress + BattleUIApi:GetBattleDialogTextSpeed()

		if self.contentProgress >= 1 then
			self:OnContentShowComplete()
		else
			self.contentTextBackgroundSource:SetProgress(self.contentProgress)
		end
	end, BattleUIApi:GetBattleDialogTextDuration(), -1, BattleUIApi:GetBattleDialogTextUseTimeScale())

	self.dialogShowTime:Start()
	self.gameObject:SetActive(true)
end

function BattleDialogElement:OnContentShowComplete()
	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end

	self.contentProgress = 1

	self.contentTextBackgroundSource:SetProgress(self.contentProgress)
end

function BattleDialogElement:Hide()
	self.gameObject:SetActive(false)

	if self.dialogShowTime ~= nil then
		self.dialogShowTime:Stop()

		self.dialogShowTime = nil
	end
end

local BattleDialogView = {}

function BattleDialogView.New(view)
	local obj = Clone(BattleDialogView)

	obj:__Init(view)

	return obj
end

function BattleDialogView:__Init(view)
	self.gameObject = view

	self.gameObject:SetActive(false)
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.leftDialog = BattleDialogElement.New(self.leftContent)

	self.leftDialog:Hide()

	self.rightDialog = BattleDialogElement.New(self.rightContent)

	self.rightDialog:Hide()

	function self.__OnDialogBackgroundClickEventProxy()
		self:__OnDialogBackgroundClickEventHandler()
	end

	self:__AddListeners()
end

function BattleDialogView:__AddListeners()
	self.closeBg:GetComponent("Button").onClick:AddListener(self.__OnDialogBackgroundClickEventProxy)
end

function BattleDialogView:__RemoveListeners()
	self.closeBg:GetComponent("Button").onClick:RemoveListener(self.__OnDialogBackgroundClickEventProxy)
end

function BattleDialogView:Dispose()
	self.gameObject:SetActive(false)
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)

	self.curDialog = nil

	self.leftDialog:Dispose()
	self.rightDialog:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleDialogView:ShowDialog(dialogCid, callback)
	self.callBackFunc = callback

	self:__Show(dialogCid)
end

function BattleDialogView:__Show(dialogCid)
	self.gameObject:SetActive(true)

	self.dialogCfg = CfgBattleDialogueTable[dialogCid]

	if self.dialogCfg.PicturePosition then
		self.rightDialog:Hide()

		self.curDialog = self.leftDialog
	else
		self.leftDialog:Hide()

		self.curDialog = self.rightDialog
	end

	self.curDialog:Show(self.dialogCfg)
end

function BattleDialogView:__OnDialogBackgroundClickEventHandler()
	if self.curDialog.contentProgress ~= 1 then
		self.curDialog:OnContentShowComplete()
	else
		self:__ShowNext()
	end
end

function BattleDialogView:__ShowNext()
	if self.dialogCfg.NextID == 0 then
		self:__OnDialogEnd()
	else
		self:__Show(self.dialogCfg.NextID)
	end
end

function BattleDialogView:__OnDialogEnd()
	self.curDialog = nil

	self.gameObject:SetActive(false)

	if self.callBackFunc ~= nil then
		self.callBackFunc()
	end
end

return BattleDialogView
