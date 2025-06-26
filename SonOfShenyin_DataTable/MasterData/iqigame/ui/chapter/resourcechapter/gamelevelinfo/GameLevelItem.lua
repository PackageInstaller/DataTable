-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\GameLevelItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemBtnComponent = self.LevelDetails:GetComponent("Button")
	self.starComp = self.Stars:GetComponent("SimpleStarComponent")
	self.FrameImgComponent = self.Frame:GetComponent("Image")
	self.BgImgComponent = self.BG:GetComponent("Image")

	function self.DelegateItemBtn()
		self:OnItemClick()
	end

	self.LineRect = self.Line:GetComponent("RectTransform")

	self:AddListeners()
end

function m:AddListeners()
	self.ItemBtnComponent.onClick:AddListener(self.DelegateItemBtn)
end

function m:RemoveListeners()
	self.ItemBtnComponent.onClick:RemoveListener(self.DelegateItemBtn)
end

function m:SetLineRotate(isUp)
	if isUp then
		self.LineRect.localRotation = Quaternion.Euler(Vector3.New(0, 0, 60))
	else
		self.LineRect.localRotation = Quaternion.Euler(Vector3.New(0, 0, -240))
	end
end

function m:SetData(index, data, isLast)
	local y = 0

	if index % 2 == 0 then
		y = -100

		self:SetLineRotate(false)
	else
		y = 100

		self:SetLineRotate(true)
	end

	self.Line:SetActive(not isLast)

	self.ItemData = data
	self.ItemData.isUnLock = ConditionModule.Check(self.ItemData:GetCfg().UnlockConditionId)
	self.LevelDetails:GetComponent("RectTransform").anchoredPosition = Vector2.New(0, y)
	self.isUnLock = self.ItemData.isUnLock

	if not self.isUnLock then
		UGUIUtil.SetText(self.UnlockConditionText, ConditionModule.GetDesc(self.ItemData:GetCfg().UnlockConditionId))
	end

	LuaUtility.SetGameObjectShow(self.UnlockConditionText, not self.isUnLock)
	LuaUtility.SetGameObjectShow(self.Lock, not self.isUnLock)
	self.Stars:SetActive(false)
	UGUIUtil.SetText(self.LevelInfoText, self.ItemData:GetCfg().Name)
	self:LoadImage(ChapterUIApi:GetResourcePassFrame(Constant.ChapterPassEnemyType.TYPE_NORMAL), self.FrameImgComponent)
	self:LoadImage(UIGlobalApi.GetImagePath(self.ItemData:GetCfg().Icon), self.BgImgComponent)
end

function m:OnItemClick()
	if not self.isUnLock then
		NoticeModule.ShowNotice(51009)

		return
	end

	EventDispatcher.Dispatch(EventID.LevelInfoEvent, self.ItemData)
end

function m:LoadImage(path, imageGo)
	AssetUtil.LoadImage(self, path, imageGo, self.OnLoadImageScuess, nil, imageGo)
end

function m:OnLoadImageScuess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
