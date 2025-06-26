-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomBubbleCell.lua

local HomeLandRoomBubbleCell = {}

function HomeLandRoomBubbleCell.New(view)
	local obj = Clone(HomeLandRoomBubbleCell)

	obj:Init(view)

	return obj
end

function HomeLandRoomBubbleCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	self:AddListener()
end

function HomeLandRoomBubbleCell:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandRoomBubbleCell:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandRoomBubbleCell:OnClickBtnSelf()
	if self.roomEventData ~= nil then
		TownModule.ExecutionEvent(self.roomEventData)
	end
end

function HomeLandRoomBubbleCell:SetData(data, canvas)
	self.roomEventData = data
	self.canvas = canvas

	self:UpdatePos()
end

function HomeLandRoomBubbleCell:UpdatePos()
	local roomTransform = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomEventData.cfgTownEvent.RoomId).transform

	if roomTransform then
		local pos = roomTransform.position
		local uiPos = self:ConvertPosToUI(pos)

		self.View.transform.position = uiPos
	end
end

function HomeLandRoomBubbleCell:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandRoomBubbleCell:OnDragIng(sender, args)
	self:UpdatePos()
end

function HomeLandRoomBubbleCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return HomeLandRoomBubbleCell
