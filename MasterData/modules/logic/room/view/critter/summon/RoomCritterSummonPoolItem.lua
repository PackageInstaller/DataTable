-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonPoolItem.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolItem", package.seeall)

local RoomCritterSummonPoolItem = class("RoomCritterSummonPoolItem", ListScrollCellExtend)

function RoomCritterSummonPoolItem:onUpdateMO(mo)
	if not self._iconItem then
		local critterIconGO = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlCritterIcon, self.viewGO)

		if critterIconGO then
			self._iconItem = MonoHelper.addNoUpdateLuaComOnceToGo(critterIconGO, RoomCritterSummonPoolIcon)
		end
	end

	self._iconItem:onUpdateMO(mo)
	self._iconItem:setCustomClick(self.onClicKCallback, self, mo)
end

function RoomCritterSummonPoolItem:onClicKCallback(mo)
	CritterController.instance:openRoomCritterDetailView(true, mo:getCritterMo(), true)
end

return RoomCritterSummonPoolItem
