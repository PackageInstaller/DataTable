-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandDragView.lua

local HomeLandDragView = {}
local oldTransform

function HomeLandDragView:New(ui, root)
	local o = Clone(HomeLandDragView)

	o:InitView(ui, root)

	return o
end

function HomeLandDragView:InitView(ui, root)
	self.goView = ui
	self.rootUI = root
	oldTransform = self.goView.transform.parent

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnCancel = self.BtnCancel:GetComponent("Button")
	self.btnConfirm = self.BtnConfirm:GetComponent("Button")

	function self.delegateOnBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.delegateOnBtnConfirm()
		self:OnClickBtnConfirm()
	end

	function self.delegateStartDragEventArgs(sender, args)
		self:StartDrag(sender, args)
	end

	function self.delegateOnDragEventArgs(sender, args)
		self:OnDrag(sender, args)
	end

	function self.delegateOnEndDragEventArgs(sender, args)
		self:OnEndDrag(sender, args)
	end

	self:AddEventListener()
end

function HomeLandDragView:AddEventListener()
	self.btnCancel.onClick:AddListener(self.delegateOnBtnCancel)
	self.btnConfirm.onClick:AddListener(self.delegateOnBtnConfirm)
	GameEntry.LuaEvent:Subscribe(HomelandStartDragEventArgs.EventId, self.delegateStartDragEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandOnDragEventArgs.EventId, self.delegateOnDragEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandEndDragEventArgs.EventId, self.delegateOnEndDragEventArgs)
end

function HomeLandDragView:RemoveEventListener()
	if LuaCodeInterface.GameObjIsDestroy(self.goView) then
		return
	end

	self.btnCancel.onClick:RemoveListener(self.delegateOnBtnCancel)
	self.btnConfirm.onClick:RemoveListener(self.delegateOnBtnConfirm)
	GameEntry.LuaEvent:Unsubscribe(HomelandStartDragEventArgs.EventId, self.delegateStartDragEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandOnDragEventArgs.EventId, self.delegateOnDragEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandEndDragEventArgs.EventId, self.delegateOnEndDragEventArgs)
end

function HomeLandDragView:StartDrag(sender, args)
	self.goView:SetActive(true)
	self.rootUI:SetActive(false)
	self.goView.transform:SetParent(args.ObjUITransform)

	self.goView.transform.localPosition = Vector3(0, 0, 0)
	self.goView.transform.localScale = Vector3(0.01, 0.01, 0.01)
end

function HomeLandDragView:OnDrag(sender, args)
	HomeLandLuaModule.isCanSave = args.IsCanSave
end

function HomeLandDragView:OnEndDrag(sender, args)
	self.roomID = args.RoomID
	self.dragObjID = args.DragObjID
	self.dragCID = args.Cid
	self.endPos = args.DragObjEndPos
end

function HomeLandDragView:OnClickBtnCancel()
	if CfgHomeLandDecorateTable[self.dragCID].FunctionBuilding > 0 then
		NoticeModule.ShowNoticeNoCallback(21042037)

		return
	end

	self.goView.transform:SetParent(oldTransform)

	self.goView.transform.localScale = Vector3.one

	HomeLandLuaModule.RemoveDecorate(self.roomID, self.dragObjID)

	HomeLandLuaModule.isCanSave = 0

	GameEntry.LuaEvent:Fire(nil, HomelandCloseDragViewEventArgs())
	self:CloseView()
end

function HomeLandDragView:OnClickBtnConfirm()
	if HomeLandLuaModule.isCanSave > 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HomeLandRoomUIApi:GetString("IsCanSave", HomeLandLuaModule.isCanSave))

		return
	end

	self.goView.transform:SetParent(oldTransform)

	self.goView.transform.localScale = Vector3.one

	GameEntry.LuaEvent:Fire(nil, HomelandCloseDragViewEventArgs())
	self:CloseView()
end

function HomeLandDragView:CloseView()
	if HomeLandLuaModule.isCanSave > 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HomeLandRoomUIApi:GetString("IsCanSave", HomeLandLuaModule.isCanSave))

		return
	end

	self.goView:SetActive(false)
	self.rootUI:SetActive(true)
end

function HomeLandDragView:Update()
	return
end

function HomeLandDragView:Dispose()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
	self.rootUI = nil
end

return HomeLandDragView
