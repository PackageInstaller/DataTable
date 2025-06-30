-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskDayAwardCell.lua

local TaskDayAwardCell = {
	activityTable = {},
	awardCellList = {}
}

function TaskDayAwardCell.New(go, mainView)
	local o = Clone(TaskDayAwardCell)

	o:Initialize(go, mainView)

	return o
end

function TaskDayAwardCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskDayAwardCell:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function TaskDayAwardCell:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end
end

function TaskDayAwardCell:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function TaskDayAwardCell:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function TaskDayAwardCell:OnButtonClick()
	if self.data.status == 2 then
		TaskSystemModule.SubmitTask({
			self.data.cid
		})
	else
		EventDispatcher.Dispatch(EventID.TaskAwardShow, self.data)
	end
end

function TaskDayAwardCell:ResetStatus()
	LuaUtility.SetGameObjectShow(self.imgHasDown, false)
	LuaUtility.SetGameObjectShow(self.imgHadGot, false)
	LuaUtility.SetGameObjectShow(self.canGet, false)
	self:SetAwardInfoState(true)
end

function TaskDayAwardCell:Refresh(data)
	self.data = data

	self:ResetStatus()

	if self.data.status == Constant.TaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.imgHasDown, false)
		LuaUtility.SetGameObjectShow(self.canGet, true)
		self:SetAwardInfoState(true)
	elseif self.data.status == Constant.TaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.imgHadGot, true)
		LuaUtility.SetGameObjectShow(self.imgHasDown, true)
		self:SetAwardInfoState(false)
	end

	UGUIUtil.SetText(self.textActivityNum, self.data.BaseData.NeedSchedule)
end

function TaskDayAwardCell:SetAwardInfoState(state)
	LuaUtility.SetGameObjectShow(self.ActiveIconLight, state)
	LuaUtility.SetGameObjectShow(self.XText, state)
	LuaUtility.SetGameObjectShow(self.textActivityNum, state)
end

function TaskDayAwardCell:RefreshPreviewAwardData()
	local actionParam = UIUtil.GetConfigArr(self.data.BaseData.ActionParam)
	local actionParamLength = #actionParam
	local awardCellListLength = #self.awardCellList
	local length = awardCellListLength < actionParamLength and actionParamLength or awardCellListLength

	for i = 1, length do
		if i <= actionParamLength then
			if self.awardCellList[i] == nil then
				local itemAwardObj = UnityEngine.Object.Instantiate(self.mainView.AwardObj.gameObject)

				itemAwardObj.name = i

				itemAwardObj.transform:SetParent(self.AwardRoot.transform, false)

				local itemCell = ExtendItemCellOne.New(itemAwardObj)

				self.awardCellList[i] = {
					obj = itemAwardObj,
					userTable = {},
					ItemCell = itemCell
				}
			end

			self.awardCellList[i].obj:SetActive(true)

			local itemActionParam = actionParam[i]
			local itemData = ItemData.CreateByCIDAndNumber(itemActionParam[1], itemActionParam[2])

			self.awardCellList[i].ItemCell:SetAwardData(itemData, itemActionParam[2])
		elseif self.awardCellList[i] ~= nil then
			self.awardCellList[i].obj:SetActive(false)
		end
	end
end

function TaskDayAwardCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

return TaskDayAwardCell
