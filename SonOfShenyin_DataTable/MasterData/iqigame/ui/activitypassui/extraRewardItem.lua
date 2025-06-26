-- chunkname: @IQIGame\\UI\\ActivityPassUI\\extraRewardItem.lua

local extraRewardItem = {}

function extraRewardItem.New(go)
	local o = Clone(extraRewardItem)

	o:Initialize(go)

	return o
end

function extraRewardItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function extraRewardItem:InitComponent()
	self.cellNormal = ExtendItemCellOne.New(self.normalItem.gameObject)
	self.cellHighTop = ExtendItemCellOne.New(self.highItemTop.gameObject)
	self.cellHighBottom = ExtendItemCellOne.New(self.highItemBottom.gameObject)
	self.buttonGet = self.buttonGet:GetComponent("Button")
end

function extraRewardItem:InitDelegate()
	function self.buttonGetDelegate()
		self:OnButtonGetClick()
	end
end

function extraRewardItem:AddListener()
	self.buttonGet.onClick:AddListener(self.buttonGetDelegate)
end

function extraRewardItem:RemoveListener()
	self.buttonGet.onClick:RemoveListener(self.buttonGetDelegate)
end

function extraRewardItem:OnButtonGetClick()
	local buyHigh = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()

	if buyHigh then
		if TaskSystemModule.CheckTaskIsFinished(self.Data) then
			ActivityPassModule.SendTask({
				ActivityPassModule.GetHighLevelIDWithNormalID(self.Data.cid)
			})
		else
			ActivityPassModule.SendTask({
				self.Data.cid,
				ActivityPassModule.GetHighLevelIDWithNormalID(self.Data.cid)
			})
		end
	else
		ActivityPassModule.SendTask({
			self.Data.cid
		})
	end
end

function extraRewardItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function extraRewardItem:Refresh(data, isExtra, force)
	self.Data = data

	if isExtra then
		local extraCfgTask = CfgUtil.GetTaskCfgWithID(self.Data.cid)

		LuaUtility.SetGameObjectShow(self.baseReward, false)

		local itemData = LuaUtility.ActionParamToItemDataTable(extraCfgTask.ActionParam)

		self.cellNormal:SetItemAchieveState(self.Data.status == Constant.passTaskStatus.hadGot)
	else
		local CfgNormalTask = CfgUtil.GetTaskCfgWithID(self.Data.cid)
		local CfgHighTask = CfgUtil.GetTaskCfgWithID(ActivityPassModule.GetHighLevelIDWithNormalID(self.Data.cid))

		LuaUtility.SetGameObjectShow(self.baseReward, true)

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

		UGUIUtil.SetText(self.textLevel, CfgNormalTask.NeedSchedule)

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
		elseif self.Data.status then
			if self.Data.status == Constant.passTaskStatus.doing then
				isGray = true
			elseif self.Data.status == Constant.passTaskStatus.hasDone then
				self.cellNormal:SetItemLockState(false)
				self.cellNormal:SetItemCanGetState(true)
			end
		end

		self.cellNormal:SetGrayState(isGray)
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
end

function extraRewardItem:Dispose()
	self.cellNormal:Dispose()
	self.cellHighTop:Dispose()
	self.cellHighBottom:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return extraRewardItem
