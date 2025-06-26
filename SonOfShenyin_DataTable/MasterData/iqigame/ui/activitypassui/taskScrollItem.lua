-- chunkname: @IQIGame\\UI\\ActivityPassUI\\taskScrollItem.lua

local taskScrollItem = {}

function taskScrollItem.New(go)
	local o = Clone(taskScrollItem)

	o:Initialize(go)

	return o
end

function taskScrollItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function taskScrollItem:InitComponent()
	self.buttonGet = self.buttonGet:GetComponent("Button")
	self.btnGo = self.btnGo:GetComponent("Button")
end

function taskScrollItem:InitDelegate()
	function self.buttonGetDelegate()
		self:OnButtonGetClick()
	end

	function self.btnGoDelegate()
		self:BtnGoOnClick()
	end
end

function taskScrollItem:AddListener()
	self.buttonGet.onClick:AddListener(self.buttonGetDelegate)
	self.btnGo.onClick:AddListener(self.btnGoDelegate)
end

function taskScrollItem:RemoveListener()
	self.buttonGet.onClick:RemoveListener(self.buttonGetDelegate)
	self.btnGo.onClick:RemoveListener(self.btnGoDelegate)
end

function taskScrollItem:CheckTaskState(status)
	local cfg = ActivityPassModule.GetTaskInfoWithID(self.Data.cid)

	LuaUtility.SetGameObjectShow(self.btnGo.gameObject, false)
	LuaUtility.SetGameObjectShow(self.objectGet.gameObject, false)
	LuaUtility.SetGameObjectShow(self.objectHasDone, false)

	if status == Constant.passTaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.btnGo.gameObject, cfg.JumpType ~= 0 and true or false)
	elseif status == Constant.passTaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.objectGet.gameObject, true)
	elseif status == Constant.passTaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.objectHasDone, true)
	end
end

function taskScrollItem:Refresh(Data)
	self.Data = Data

	local cfg = ActivityPassModule.GetTaskInfoWithID(self.Data.cid)

	if self.Data.status then
		self:CheckTaskState(self.Data.status)
	else
		self:CheckTaskState(1)
	end

	UGUIUtil.SetText(self.textName, ActivityPassApi:GetTaskName(cfg.Name))
	UGUIUtil.SetText(self.textDes, cfg.Desc)

	local currentProgress = 0

	if self.Data.schedule then
		if self.Data.schedule > cfg.NeedSchedule then
			currentProgress = cfg.NeedSchedule
		else
			currentProgress = self.Data.schedule
		end
	end

	UGUIUtil.SetText(self.textTaskNowProgress, currentProgress)
	UGUIUtil.SetText(self.textTaskMaxProgress, "/" .. cfg.NeedSchedule)
	UGUIUtil.SetText(self.textExp, cfg.ActionParam[2])
end

function taskScrollItem:OnButtonGetClick()
	ActivityPassModule.SendTask({
		self.Data.cid
	})
end

function taskScrollItem:BtnGoOnClick()
	local cfg = ActivityPassModule.GetTaskInfoWithID(self.Data.cid)

	JumpModule.Jump(cfg.JumpType)
end

function taskScrollItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return taskScrollItem
