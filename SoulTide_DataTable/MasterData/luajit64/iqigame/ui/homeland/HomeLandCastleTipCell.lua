-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandCastleTipCell.lua

local HomeLandCastleTipCell = {
	tipIcons = {}
}
local HomeLandCastleTipIcon = require("IQIGame.UI.HomeLand.HomeLandCastleTipIcon")

function HomeLandCastleTipCell.__New(itemCellView, rootParent)
	local itemCell = Clone(HomeLandCastleTipCell)

	itemCell:Init(itemCellView, rootParent)

	return itemCell
end

function HomeLandCastleTipCell:Init(view, rootParent)
	self.goView = view
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.goView, self)
	self.TipGold:SetActive(false)

	self.canvas = self.rootParent.UIController:GetComponent("Canvas")

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	self:AddListener()
end

function HomeLandCastleTipCell:AddListener()
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandCastleTipCell:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandCastleTipCell:SetData(data, builds)
	self.roomID = data
	self.builds = builds
	self.roomTransform = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomID).transform

	self:CreateTip()
	self:UpdatePos()
end

function HomeLandCastleTipCell:CreateTip()
	for i, v in pairs(self.tipIcons) do
		v:Dispose()
	end

	self.tipIcons = {}

	if self.builds then
		for i, v in pairs(self.builds) do
			local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(v)

			if homeLandBuildingData then
				local isGetReward = homeLandBuildingData:IsGetReward()

				if isGetReward then
					local obj = UnityEngine.Object.Instantiate(self.TipGold)

					obj:SetActive(true)
					obj.transform:SetParent(self.goView.transform, false)

					local tipIcon = HomeLandCastleTipIcon.__New(obj)

					tipIcon:SetData(v)
					table.insert(self.tipIcons, tipIcon)
				end
			end
		end
	end
end

function HomeLandCastleTipCell:UpdatePos()
	if HomeLandLuaModule.currentEnterRoomID > 0 then
		return
	end

	if self.roomTransform == nil or LuaCodeInterface.GameObjIsDestroy(self.roomTransform) then
		return
	end

	local pos = self.roomTransform.position
	local uiPos = self:ConvertPosToUI(pos)

	self.goView.transform.position = uiPos
end

function HomeLandCastleTipCell:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandCastleTipCell:OnDragIng(sender, args)
	self:UpdatePos()
end

function HomeLandCastleTipCell:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.tipIcons) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return HomeLandCastleTipCell
