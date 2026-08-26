-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheNodeItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheNodeItem", package.seeall)

local SodacheNodeItem = class("SodacheNodeItem", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(1.7, 2)

function SodacheNodeItem:init(go)
	self.go = go
end

function SodacheNodeItem:addEventListeners()
	local box = gohelper.addBoxCollider2D(self.go, BOX_COLLIDER_SIZE)

	box.offset = Vector2(0, 0.35)

	local clickListener = ZProj.BoxColliderClickListener.Get(self.go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(self._onClickDown, self)
	clickListener:AddMouseUpListener(self._onClickUp, self)
	SodacheController.instance:registerCallback(SodacheEvent.GuideClickNode, self.onGuideClick, self)
end

function SodacheNodeItem:removeEventListeners()
	SodacheController.instance:unregisterCallback(SodacheEvent.GuideClickNode, self.onGuideClick, self)
end

function SodacheNodeItem:initData(nodeInfo, sceneNodeGo)
	self.isActive = true
	self._sceneNodeGo = sceneNodeGo
	self.nodeInfo = nodeInfo

	transformhelper.setLocalPos(self.go.transform, nodeInfo.pos.x, nodeInfo.pos.y, nodeInfo.pos.z)
end

function SodacheNodeItem:updateIsActice(isActive)
	self.isActive = isActive

	gohelper.setActive(self._sceneNodeGo, isActive)
end

function SodacheNodeItem:_onClickDown()
	if not self.isActive then
		return
	end

	SodacheMapUtil.instance:setClickType(SodacheEnum.MapBtnClickType.NodeClick)
end

function SodacheNodeItem:_onClickUp()
	if not self.isActive then
		return
	end

	if not SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.NodeClick) then
		return
	end

	if not SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.MapScene) then
		SodacheMapUtil.instance:clearClickType()

		return
	end

	if SodacheMapUtil.instance:isHaveClick(SodacheEnum.MapBtnClickType.Drag) then
		SodacheMapUtil.instance:clearClickType()

		return
	end

	SodacheMapUtil.instance:clearClickType()

	if SodacheMapUtil.instance:isInFlow() then
		SodacheMapUtil.instance:tryRemoveFlow()

		return
	end

	if isDebugBuild and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		GMRpc.instance:sendGMRequest("soplayerMove " .. self.nodeInfo.id)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickNode, self.go, self.nodeInfo)
end

function SodacheNodeItem:onGuideClick(nodeId)
	if tonumber(nodeId) == self.nodeInfo.id then
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickNode, self.go, self.nodeInfo)
	end
end

return SodacheNodeItem
