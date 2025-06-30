-- chunkname: @IQIGame\\UI\\ActivityList\\SummerSignActivity\\SummerSignActivityItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBtn()
		self:OnClickBtn()
	end

	function self.DelegateOnClickLongBtn()
		self:OnClickLongBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClickBtn)
	self.View:GetComponent("LongButton").onLongDown:AddListener(self.DelegateOnClickLongBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateOnClickBtn)
	self.View:GetComponent("LongButton").onLongDown:RemoveListener(self.DelegateOnClickLongBtn)
end

function m:SetData(taskSystemData)
	local itemCfg = CfgItemTable[taskSystemData.BaseData.ActionParam[1]]

	self.taskData = taskSystemData

	UGUIUtil.SetText(self.countText, taskSystemData.BaseData.ActionParam[2])
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.ImageIcon:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.imageCanGet, taskSystemData.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.imageHadGot, taskSystemData.status == Constant.TaskStatus.hadGot)
	self:RefreshRedDot()
end

function m:OnClickBtn()
	if self.taskData.status == Constant.TaskStatus.hadGot then
		return
	end

	if self.taskData.status == Constant.TaskStatus.doing then
		NoticeModule.ShowNotice(54000)

		return
	end

	TaskSystemModule.SubmitTask({
		self.taskData.cid
	})
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.RedDot, self.taskData.status == Constant.TaskStatus.hasDone)
end

function m:OnClickLongBtn()
	ItemModule.OpenTipByCid(self.taskData.BaseData.ActionParam[1], true, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
