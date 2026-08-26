-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapElement.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapElement", package.seeall)

local VersionActivity3_10DungeonMapElement = class("VersionActivity3_10DungeonMapElement", VersionActivityFixedDungeonMapElement)
local BOX_COLLIDER_SIZE = Vector2(1.5, 1.5)

function VersionActivity3_10DungeonMapElement:onClick()
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_common_click)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnClickElement, self)
end

function VersionActivity3_10DungeonMapElement.addBoxColliderListener(go, callbackDown, callbackTarget)
	gohelper.setLayer(go, UnityLayer.Scene)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callbackDown, callbackTarget)
	clickListener:AddMouseUpListener(callbackTarget._onClickUp, callbackTarget)
end

function VersionActivity3_10DungeonMapElement:_onClickUp()
	self._sceneElements:setMouseElementUp(self)
end

return VersionActivity3_10DungeonMapElement
