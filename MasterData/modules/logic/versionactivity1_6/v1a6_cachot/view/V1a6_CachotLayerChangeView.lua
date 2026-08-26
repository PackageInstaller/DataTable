-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotLayerChangeView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLayerChangeView", package.seeall)

local V1a6_CachotLayerChangeView = class("V1a6_CachotLayerChangeView", BaseView)

function V1a6_CachotLayerChangeView:onOpen()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	local roomCo = lua_rogue_room.configDict[self._rogueInfo.room]

	if not roomCo then
		return
	end

	self._gotabs = {}
	self._difficulty = self._rogueInfo.difficulty

	for i = 1, 2 do
		local item = self._gotabs[i]
		local layer = roomCo.layer

		if i == 1 then
			layer = layer - 1
		end

		if not item then
			item = self:getUserDataTb_()
			item.simagelevel = gohelper.findChildSingleImage(self.viewGO, i .. "/#simage_level" .. i)
			item.gohard = gohelper.findChild(self.viewGO, i .. "/#go_hard")
			item.txtlevel = gohelper.findChildText(self.viewGO, i .. "/#txt_level")

			table.insert(self._gotabs, item)
			item.simagelevel:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. layer))

			if layer >= 3 then
				gohelper.setActive(item.gohard, true)
			else
				gohelper.setActive(item.gohard, false)
			end

			item.txtlevel.text = V1a6_CachotRoomConfig.instance:getLayerName(layer, self._difficulty)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_floor_load)
	TaskDispatcher.runDelay(self.checkViewIsOpenFinish, self, 2.5)
end

function V1a6_CachotLayerChangeView:_onOpenView(viewName)
	if viewName == ViewName.V1a6_CachotMainView or viewName == ViewName.V1a6_CachotRoomView then
		TaskDispatcher.runDelay(self.closeThis, self, 0.2)
	end
end

function V1a6_CachotLayerChangeView:checkViewIsOpenFinish()
	if ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotMainView) or ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotRoomView) then
		self:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	end
end

function V1a6_CachotLayerChangeView:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self.checkViewIsOpenFinish, self)
end

return V1a6_CachotLayerChangeView
