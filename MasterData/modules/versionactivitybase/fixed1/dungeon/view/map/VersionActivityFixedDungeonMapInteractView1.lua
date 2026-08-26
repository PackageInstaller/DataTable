-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapInteractView1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapInteractView1", package.seeall)

local VersionActivityFixedDungeonMapInteractView1 = class("VersionActivityFixedDungeonMapInteractView1", BaseViewExtended)

function VersionActivityFixedDungeonMapInteractView1:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")

	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
end

function VersionActivityFixedDungeonMapInteractView1:addEvents()
	self.addEventCb(self, VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self._onClickElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
end

function VersionActivityFixedDungeonMapInteractView1:hide()
	if self._interactView then
		self._interactView:hide()
	end
end

function VersionActivityFixedDungeonMapInteractView1:_onClickElement(mapElement)
	self._interactView = self:_getInteractView()

	self._interactView:removeEvents()
	self._interactView:addEvents()
	self._interactView:showInteractUI(mapElement)
end

function VersionActivityFixedDungeonMapInteractView1:onRecheck(elementCo)
	self._interactView = self:_getInteractView()

	self._interactView:removeEvents()
	self._interactView:addEvents()
	self._interactView:onRecheck(elementCo)
end

function VersionActivityFixedDungeonMapInteractView1:_getInteractView()
	if not self._interact1View then
		local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
		local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
		local mapNormalInteractView = VersionActivityFixedHelper.getVersionActivityDungeonMapNormalInteractView(bigVersion, smallVersion, scriptSuffix)

		self._interact1View = self:openSubView(mapNormalInteractView, self.viewGO)
	end

	return self._interact1View
end

function VersionActivityFixedDungeonMapInteractView1:onHideInteractUI()
	if self._interactView then
		self._interactView:removeEvents()

		self._interactView = nil
	end
end

return VersionActivityFixedDungeonMapInteractView1
