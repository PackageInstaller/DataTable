-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostActivityTaskUI_taskItem.lua

local GhostActivityTaskUI_taskItem = {}

function GhostActivityTaskUI_taskItem.New(go, mainView)
	local o = Clone(GhostActivityTaskUI_taskItem)

	o:Initialize(go, mainView)

	return o
end

function GhostActivityTaskUI_taskItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.awardCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostActivityTaskUI_taskItem:InitComponent()
	return
end

function GhostActivityTaskUI_taskItem:InitDelegate()
	function self.delegateOnClickGetBtn()
		self:OnClickGetBtn()
	end

	function self.delegateOnClickButtonGoTo()
		self:OnClickButtonGoTo()
	end
end

function GhostActivityTaskUI_taskItem:AddListener()
	self.GetBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGetBtn)
	self.buttonGoTo:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGoTo)
end

function GhostActivityTaskUI_taskItem:RemoveListener()
	self.GetBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGetBtn)
	self.buttonGoTo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGoTo)
end

function GhostActivityTaskUI_taskItem:OnClickButtonGoTo()
	local cfgTask = CfgUtil.GetTaskCfgWithID(self.data.cid)

	JumpModule.Jump(cfgTask.JumpType)
end

function GhostActivityTaskUI_taskItem:OnClickGetBtn()
	TaskSystemModule.SubmitTask({
		self.data.cid
	})
end

function GhostActivityTaskUI_taskItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostActivityTaskUI_taskItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostActivityTaskUI_taskItem:Refresh(Data)
	self.data = Data

	local cfgTask = CfgUtil.GetTaskCfgWithID(self.data.cid)

	LuaUtility.SetGameObjectShow(self.hadGot, self.data.status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.hasDone, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.noFinish, self.data.status == Constant.TaskStatus.doing)
	LuaUtility.SetGameObjectShow(self.RedDot, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetText(self.taskTittle, cfgTask.Name)

	local valueStr = {}
	local descStr = {}
	local len = #cfgTask.Desc

	for i = 1, len do
		local c = cfgTask.Desc:sub(i, i)

		if c:match("%w") then
			table.insert(valueStr, c)
		else
			table.insert(descStr, c)
		end
	end

	valueStr = table.concat(valueStr)
	descStr = table.concat(descStr)

	LuaUtility.SetText(self.textCurrent, valueStr)
	LuaUtility.SetText(self.taskDescription, descStr)
	self:RefreshPreviewAwardData(cfgTask.ActionParam)
end

function GhostActivityTaskUI_taskItem:RefreshPreviewAwardData(ActionParam)
	local actionParam = UIUtil.GetConfigArr(ActionParam)
	local actionParamLength = #actionParam
	local awardCellListLength = #self.awardCellList
	local length = awardCellListLength < actionParamLength and actionParamLength or awardCellListLength

	for i = 1, length do
		if i <= actionParamLength then
			if self.awardCellList[i] == nil then
				local itemAwardObj = UnityEngine.Object.Instantiate(self.CommonSlotUI, self.content.transform)

				itemAwardObj.name = i

				local itemCell = ItemCell.New(itemAwardObj)

				self.awardCellList[i] = itemCell
			end

			local itemActionParam = actionParam[i]

			self.awardCellList[i]:SetItemByCid(itemActionParam[1], itemActionParam[2])
			self.awardCellList[i]:SetNum(itemActionParam[2])
			self.awardCellList[i]:Show()
		elseif self.awardCellList[i] ~= nil then
			self.awardCellList[i]:Hide()
		end
	end
end

function GhostActivityTaskUI_taskItem:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return GhostActivityTaskUI_taskItem
