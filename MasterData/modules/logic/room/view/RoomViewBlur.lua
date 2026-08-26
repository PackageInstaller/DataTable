-- chunkname: @modules/logic/room/view/RoomViewBlur.lua

module("modules.logic.room.view.RoomViewBlur", package.seeall)

local RoomViewBlur = class("RoomViewBlur", BaseView)

function RoomViewBlur:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewBlur:addEvents()
	return
end

function RoomViewBlur:removeEvents()
	return
end

function RoomViewBlur:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._blurGO = nil
	self._material = nil
end

function RoomViewBlur:_refreshUI()
	if not self._blurGO then
		self._blurGO = self.viewContainer:getResInst("ppassets/uixiaowumask.prefab", self.viewGO, "blur")

		local image = self._blurGO:GetComponent(typeof(UnityEngine.UI.Image))

		self._material = image.material

		self:_updateBlur(0)
	end
end

function RoomViewBlur:_updateBlur(blur)
	if not self._material then
		return
	end

	blur = blur or 0

	self._material:SetFloat("_ChangeTax", blur)
end

function RoomViewBlur:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateBlur, self._updateBlur, self)
end

function RoomViewBlur:onClose()
	return
end

function RoomViewBlur:onDestroyView()
	self._material = nil
end

return RoomViewBlur
