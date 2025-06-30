-- chunkname: @IQIGame\\UI\\ActivityPassUI\\passScrollItem.lua

local passScrollItem = {}

function passScrollItem.New(go, mainView)
	local o = Clone(passScrollItem)

	o:Initialize(go, mainView)

	return o
end

function passScrollItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.LevelTitleValue = self.LevelTitle:GetComponent("Text").text

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function passScrollItem:InitComponent()
	self.cellNormal = ExtendItemCellOne.New(self.normalItem.gameObject)
	self.cellHighTop = ExtendItemCellOne.New(self.highItemTop.gameObject)
	self.cellHighBottom = ExtendItemCellOne.New(self.highItemBottom.gameObject)
end

function passScrollItem:InitDelegate()
	return
end

function passScrollItem:AddListener()
	return
end

function passScrollItem:RemoveListener()
	return
end

function passScrollItem:Refresh(data)
	self.Data = data

	local textColorCfg = ColorCfg.ActivityPassUI.activityLevelText
	local CfgNormalTask = CfgUtil.GetTaskCfgWithID(self.Data.cid)
	local CfgHighTask = CfgUtil.GetTaskCfgWithID(ActivityPassModule.GetHighLevelIDWithNormalID(self.Data.cid))
	local itemNormalData = LuaUtility.ActionParamToItemDataTable(CfgNormalTask.ActionParam)

	if itemNormalData[1] then
		self.cellNormal:SetAwardData(itemNormalData[1], itemNormalData[1]:GetNum())
		LuaUtility.SetGameObjectShow(self.normalItem, true)
	else
		LuaUtility.SetGameObjectShow(self.normalItem, false)
	end

	local itemHighData = LuaUtility.ActionParamToItemDataTable(CfgHighTask.ActionParam)

	if itemHighData[1] then
		self.cellHighTop:SetAwardData(itemHighData[1], itemHighData[1]:GetNum())
		LuaUtility.SetGameObjectShow(self.highItemTop, true)
	else
		LuaUtility.SetGameObjectShow(self.highItemTop, false)
	end

	if itemHighData[2] then
		self.cellHighBottom:SetAwardData(itemHighData[2], itemHighData[2]:GetNum())
		LuaUtility.SetGameObjectShow(self.highItemBottom, true)
	else
		LuaUtility.SetGameObjectShow(self.highItemBottom, false)
	end

	local buyHigh = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()
	local isLock = false

	if buyHigh then
		isLock = true
	end

	LuaUtility.SetGameObjectShow(self.lockImg, not isLock)
	self.cellNormal:SetItemAchieveState(false)
	self.cellHighTop:SetItemAchieveState(false)
	self.cellNormal:SetItemCanGetState(false)
	self.cellHighTop:SetItemCanGetState(false)

	if self.cellHighBottom then
		self.cellHighBottom:SetItemAchieveState(false)
		self.cellHighBottom:SetItemCanGetState(false)
	end

	LuaUtility.SetGameObjectShow(self.imageGet, false)

	local isGray = false

	if TaskSystemModule.CheckTaskIsFinished(self.Data) then
		self.cellNormal:SetItemAchieveState(true)

		textColorCfg = ColorCfg.ActivityPassUI.activityTypeNoSelect
	elseif self.Data.status then
		textColorCfg = ColorCfg.ActivityPassUI.activityLevelText

		if self.Data.status == Constant.passTaskStatus.doing then
			self.cellNormal:SetItemLockState(false)
			LuaUtility.SetGameObjectShow(self.imageGet, false)

			isGray = true
		elseif self.Data.status == Constant.passTaskStatus.hasDone then
			textColorCfg = ColorCfg.ActivityPassUI.activityTypeNoSelect

			self.cellNormal:SetItemLockState(false)
			self.cellNormal:SetItemCanGetState(true)
		end
	end

	self.cellNormal:SetGrayState(isGray)
	UGUIUtil.SetText(self.textLevel, string.format(textColorCfg, CfgNormalTask.NeedSchedule))
	UGUIUtil.SetText(self.LevelTitle, string.format(textColorCfg, self.LevelTitleValue))
	self.cellHighTop:SetItemLockState(not buyHigh)

	if self.cellHighBottom then
		self.cellHighBottom:SetItemLockState(not buyHigh)
	end

	isGray = false

	local taskPodHigh = ActivityPassModule.GetHighLevelTaskWithNormalID(self.Data.cid)

	LuaUtility.SetGameObjectShow(self.highCanGetImg, false)

	if taskPodHigh then
		if TaskSystemModule.CheckTaskIsFinished(taskPodHigh) then
			self.cellHighTop:SetItemAchieveState(true)

			if self.cellHighBottom then
				self.cellHighBottom:SetItemAchieveState(true)
			end
		elseif taskPodHigh.status then
			if taskPodHigh.status == Constant.passTaskStatus.doing then
				LuaUtility.SetGameObjectShow(self.highCanGetImg, false)

				isGray = true
			elseif taskPodHigh.status == Constant.passTaskStatus.hasDone then
				LuaUtility.SetGameObjectShow(self.highCanGetImg, true)
				self.cellHighTop:SetItemCanGetState(true)

				if self.cellHighBottom then
					self.cellHighBottom:SetItemCanGetState(true)
				end
			end
		end
	end

	self.cellHighTop:SetGrayState(isGray)

	if self.cellHighBottom then
		self.cellHighBottom:SetGrayState(isGray)
	end
end

function passScrollItem:Dispose()
	self.cellNormal:Dispose()
	self.cellHighTop:Dispose()
	self.cellHighBottom:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return passScrollItem
