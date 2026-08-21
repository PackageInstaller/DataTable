-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomGuideView.lua

local HomeLandRoomGuideView = {
	buttons = {}
}
local HomeLandGuideBtnCell = require("IQIGame.UI.HomeLand.HomeLandGuideBtnCell")

function HomeLandRoomGuideView.__New(ui, parent)
	local o = Clone(HomeLandRoomGuideView)

	o:InitView(ui, parent)

	return o
end

function HomeLandRoomGuideView:InitView(ui, rootParent)
	self.rootUI = ui
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.canvas = self.rootParent.UIController.gameObject:GetComponent("Canvas")

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	function self.delegateOnHomelandLookObjEventArgs(sender, args)
		self:OnLookObjEventArgs(sender, args)
	end

	function self.delegateClickObj(data)
		self:OnClickObj(data)
	end

	function self.delegateUpdateRoomGuideEvent()
		self:OnUpdateRoomGuideEvent()
	end
end

function HomeLandRoomGuideView:AddEventListener()
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandLookObjEventArgs.EventId, self.delegateOnHomelandLookObjEventArgs)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRoomGuideEvent, self.delegateUpdateRoomGuideEvent)
end

function HomeLandRoomGuideView:RemoveEventListener()
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandLookObjEventArgs.EventId, self.delegateOnHomelandLookObjEventArgs)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRoomGuideEvent, self.delegateUpdateRoomGuideEvent)
end

function HomeLandRoomGuideView:OnDragIng(sender, args)
	for i, v in pairs(self.buttons) do
		local btnCell = self.buttons[i]
		local transform = self.roomTransforms[i]

		if not LuaCodeInterface.GameObjIsDestroy(transform) then
			local pos = transform.position
			local uiPos = self:ConvertPosToUI(pos)

			btnCell.goView.transform.position = uiPos
		end
	end
end

function HomeLandRoomGuideView:OnLookObjEventArgs(sender, args)
	if HomeLandLuaModule.cameraPosition == args.Position and HomeLandLuaModule.cameraSize == args.TargetSize then
		local timerShow = Timer.New(function()
			self.rootUI:SetActive(true)
			self:OnDragIng()
		end, 0.5)

		timerShow:Start()
	else
		self.rootUI:SetActive(false)
	end
end

function HomeLandRoomGuideView:UpDataView()
	if UnityEngine.GameObject.Find("Root") == nil then
		return
	end

	for i, v in pairs(self.buttons) do
		v:Dispose()
	end

	self.buttons = {}
	self.roomTransforms = {}

	for i, v in ipairs(Constant.HomelandRoomFunDecorates) do
		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. HomeLandLuaModule.currentEnterRoomID .. "/Objects/decorate_" .. v .. "/UIObj")

		if object then
			local cfgDecorate = CfgHomeLandDecorateTable[v]

			if cfgDecorate.FunctionBuilding > 0 then
				local obj = UnityEngine.Object.Instantiate(self.BtnGuide)

				obj:SetActive(true)

				obj.name = "Decorate" .. v

				obj.transform:SetParent(self.GuidePos.transform, false)

				local objTransform = object.transform
				local pos = objTransform.position
				local uiPos = self:ConvertPosToUI(pos)

				obj.transform.position = uiPos

				local btnCell = HomeLandGuideBtnCell.__New(obj)

				btnCell.callBackSelf = self.delegateClickObj

				btnCell:SetData(v)

				self.buttons[v] = btnCell
				self.roomTransforms[v] = objTransform
			end
		end
	end
end

function HomeLandRoomGuideView:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandRoomGuideView:OnClickObj(data)
	GameEntry.LuaEvent:Fire(nil, HomelandClickFunctionDecorationEventArgs():Fill(data, true))
end

function HomeLandRoomGuideView:OnUpdateRoomGuideEvent()
	self:UpDataView()
end

function HomeLandRoomGuideView:Dispose()
	for i, v in ipairs(self.buttons) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandRoomGuideView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
end

function HomeLandRoomGuideView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandRoomGuideView
