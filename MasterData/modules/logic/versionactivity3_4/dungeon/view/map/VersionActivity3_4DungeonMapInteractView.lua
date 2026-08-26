-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonMapInteractView.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonMapInteractView", package.seeall)

local VersionActivity3_4DungeonMapInteractView = class("VersionActivity3_4DungeonMapInteractView", BaseViewExtended)

function VersionActivity3_4DungeonMapInteractView:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")

	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
end

function VersionActivity3_4DungeonMapInteractView:addEvents()
	self.addEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self._onClickElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
end

function VersionActivity3_4DungeonMapInteractView:hide()
	if self._interactView then
		self._interactView:hide()
	end
end

function VersionActivity3_4DungeonMapInteractView:_onClickElement(mapElement)
	local config = mapElement._config

	if config.type == DungeonEnum.ElementType.V3a4BBS then
		local postId = tonumber(config.param)

		V3a4BBSController.instance:openV3a4BBSView(postId, nil, config.id)
	else
		self._interactView = self:_getInteractView()

		self._interactView:removeEvents()
		self._interactView:addEvents()
		self._interactView:showInteractUI(mapElement)
	end
end

function VersionActivity3_4DungeonMapInteractView:_getInteractView()
	self._interact1View = self._interact1View or self:openSubView(VersionActivity3_4DungeonMapNormalInteractView, self.viewGO)

	return self._interact1View
end

function VersionActivity3_4DungeonMapInteractView:onHideInteractUI()
	if self._interactView then
		self._interactView:removeEvents()

		self._interactView = nil
	end
end

return VersionActivity3_4DungeonMapInteractView
