-- chunkname: @IQIGame\\UI\\Map\\Area\\WorldArea_AreaItem.lua

local WorldArea_AreaItem = {}
local dataName_state = "state"
local stateName_isUnlock = "isUnlock"
local stateName_NotUnlock = "NotUnlock"

function WorldArea_AreaItem.New(go, mainView)
	local o = Clone(WorldArea_AreaItem)

	o:Initialize(go, mainView)

	return o
end

function WorldArea_AreaItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function WorldArea_AreaItem:InitComponent()
	self.anchorPos = self.gameObject:GetComponent("RectTransform").anchoredPosition
end

function WorldArea_AreaItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function WorldArea_AreaItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function WorldArea_AreaItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function WorldArea_AreaItem:OnClickButtonClick()
	if not self.isUnlock then
		return
	end

	self.mainView:ShowDetailPop(self.anchorPos.x, self.anchorPos.y, self.areaId)

	if self.mainView.currentSelectedArea then
		self.mainView.currentSelectedArea:UnSelected()
	end

	self:Selected()

	self.mainView.currentSelectedArea = self
end

function WorldArea_AreaItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function WorldArea_AreaItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function WorldArea_AreaItem:Selected()
	LuaUtility.SetGameObjectShow(self.selected, true)
end

function WorldArea_AreaItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selected, false)
end

function WorldArea_AreaItem:RefreshByAreaId(areaId)
	self.areaId = areaId
end

function WorldArea_AreaItem:Refresh()
	if not self.areaId then
		return
	end

	local cfgWorldArea = CfgUtil.GetCfgWorldMapAreaDataWithID(self.areaId)
	local areaData = WorldMapModule.GetAreaDataWithID(self.areaId)

	LuaUtility.SetText(self.chapterName, WorldMapModule.GetAreaName(cfgWorldArea))

	local isUnlock = areaData:GetUnlock()

	self.isUnlock = isUnlock

	if not isUnlock then
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_NotUnlock)

		return
	end

	LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_isUnlock)
	self:UnSelected()
	LuaUtility.SetGameObjectShow(self.imageMain, false)
	LuaUtility.SetGameObjectShow(self.imageBranch, false)
	LuaUtility.SetGameObjectShow(self.imageBranchRpg, false)
	LuaUtility.SetGameObjectShow(self.imageSaunterEvent, false)
	LuaUtility.SetGameObjectShow(self.imageSmallEvent, false)
	LuaUtility.SetGameObjectShow(self.imageAffinity, false)
	LuaUtility.SetGameObjectShow(self.imageDaily, false)
	LuaUtility.SetGameObjectShow(self.imageHunt, false)

	local roomList = areaData:GetUnlockRoomArray()

	for _, roomData in pairs(roomList) do
		local tagArray = roomData:GetRoomTagArray()
		local len = #tagArray

		for i = 1, len do
			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.MainTag then
				LuaUtility.SetGameObjectShow(self.imageMain, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.BranchTag then
				LuaUtility.SetGameObjectShow(self.imageBranch, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.BranchTag_RPG then
				LuaUtility.SetGameObjectShow(self.imageBranchRpg, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.SaunterEvent then
				LuaUtility.SetGameObjectShow(self.imageSaunterEvent, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.Affinity then
				LuaUtility.SetGameObjectShow(self.imageAffinity, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.Daily then
				LuaUtility.SetGameObjectShow(self.imageDaily, true)
			end

			if tagArray[i]:GetCfg().IconType == Constant.RPGTagType.Hunt then
				LuaUtility.SetGameObjectShow(self.imageHunt, true)
			end

			if roomData:GetStoryTag() == Constant.RPGTagType.MainTag then
				LuaUtility.SetGameObjectShow(self.imageMain, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.BranchTag then
				LuaUtility.SetGameObjectShow(self.imageBranch, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.BranchTag_RPG then
				LuaUtility.SetGameObjectShow(self.imageBranchRpg, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.SaunterEvent then
				LuaUtility.SetGameObjectShow(self.imageSaunterEvent, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.Affinity then
				LuaUtility.SetGameObjectShow(self.imageAffinity, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.Daily then
				LuaUtility.SetGameObjectShow(self.imageDaily, true)
			elseif roomData:GetStoryTag() == Constant.RPGTagType.Hunt then
				LuaUtility.SetGameObjectShow(self.imageHunt, true)
			end
		end
	end
end

function WorldArea_AreaItem:LogInfo()
	if not self.areaId then
		return
	end

	local areaData = WorldMapModule.GetAreaDataWithID(self.areaId)

	if not areaData then
		return
	end

	log(string.format("【区域】区域id = %s,服务器状态 = %s,开启次数 = %s,区域解锁 = %s", areaData.cid, areaData.status, areaData.openCount, areaData:GetUnlock()))
end

function WorldArea_AreaItem:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.anchorPos = nil
	self.gameObject = nil
end

return WorldArea_AreaItem
