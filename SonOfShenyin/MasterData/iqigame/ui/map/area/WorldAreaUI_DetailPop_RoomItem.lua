-- chunkname: @IQIGame\\UI\\Map\\Area\\WorldAreaUI_DetailPop_RoomItem.lua

local m = {}

function m.New(go, mainView)
	local o = Clone(m)

	o:Initialize(go, mainView)

	return o
end

function m:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function m:InitComponent()
	return
end

function m:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end

	function self.delegateOnClickButtonDoubleClick()
		self:OnClickButtonDoubleClick()
	end
end

function m:AddListener()
	self.buttonClick:GetComponent("DoubleButton").onClick:AddListener(self.delegateOnClickButtonClick)
	self.buttonClick:GetComponent("DoubleButton").onDoubleClick:AddListener(self.delegateOnClickButtonDoubleClick)
end

function m:RemoveListener()
	self.buttonClick:GetComponent("DoubleButton").onClick:RemoveListener(self.delegateOnClickButtonClick)
	self.buttonClick:GetComponent("DoubleButton").onDoubleClick:RemoveListener(self.delegateOnClickButtonDoubleClick)
end

function m:OnClickButtonDoubleClick()
	WorldMapModule.EnterRoom(self.data.cid, true)
	UIModule.Close(Constant.UIControllerName.WorldAreaUI)
end

function m:OnClickButtonClick()
	self.mainView:SelectRoom(self)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function m:Selected()
	LuaUtility.SetGameObjectShow(self.imageSelect, true)
end

function m:UnSelected()
	LuaUtility.SetGameObjectShow(self.imageSelect, false)
end

function m:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textName, self.data:GetCfg().Name)
	self:UnSelected()
	LuaUtility.SetGameObjectShow(self.imageMain, false)
	LuaUtility.SetGameObjectShow(self.imageBranch, false)
	LuaUtility.SetGameObjectShow(self.imageBranchRpg, false)
	LuaUtility.SetGameObjectShow(self.imageSaunterEvent, false)
	LuaUtility.SetGameObjectShow(self.smallEvent, false)
	LuaUtility.SetGameObjectShow(self.imageAffinity, false)
	LuaUtility.SetGameObjectShow(self.imageDaily, false)
	LuaUtility.SetGameObjectShow(self.imageHunt, false)

	local actionTagArray = self.data:GetRoomTagArray()
	local len = #actionTagArray

	for i = 1, len do
		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.MainTag then
			LuaUtility.SetGameObjectShow(self.imageMain, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.BranchTag then
			LuaUtility.SetGameObjectShow(self.imageBranch, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.BranchTag_RPG then
			LuaUtility.SetGameObjectShow(self.imageBranchRpg, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.SaunterEvent then
			LuaUtility.SetGameObjectShow(self.imageSaunterEvent, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.Affinity then
			LuaUtility.SetGameObjectShow(self.imageAffinity, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.Daily then
			LuaUtility.SetGameObjectShow(self.imageDaily, true)
		end

		if actionTagArray[i]:GetCfg().IconType == Constant.RPGTagType.Hunt then
			LuaUtility.SetGameObjectShow(self.imageHunt, true)
		end
	end

	if self.data:GetStoryTag() == Constant.RPGTagType.MainTag then
		LuaUtility.SetGameObjectShow(self.imageMain, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.BranchTag then
		LuaUtility.SetGameObjectShow(self.imageBranch, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.BranchTag_RPG then
		LuaUtility.SetGameObjectShow(self.imageBranchRpg, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.SaunterEvent then
		LuaUtility.SetGameObjectShow(self.imageSaunterEvent, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.Affinity then
		LuaUtility.SetGameObjectShow(self.imageAffinity, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.Daily then
		LuaUtility.SetGameObjectShow(self.imageDaily, true)
	elseif self.data:GetStoryTag() == Constant.RPGTagType.Hunt then
		LuaUtility.SetGameObjectShow(self.imageHunt, true)
	end
end

function m:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
