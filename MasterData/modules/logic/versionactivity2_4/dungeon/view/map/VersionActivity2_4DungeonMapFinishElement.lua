-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/VersionActivity2_4DungeonMapFinishElement.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.VersionActivity2_4DungeonMapFinishElement", package.seeall)

local VersionActivity2_4DungeonMapFinishElement = class("VersionActivity2_4DungeonMapFinishElement", DungeonMapFinishElement)

function VersionActivity2_4DungeonMapFinishElement:init(go)
	self._go = go
	self._transform = go.transform

	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

	self.resPath = self._config.res
	self.effectPath = self._config.effect

	if self._existGo then
		if not string.nilorempty(self.resPath) then
			self._itemGo = gohelper.findChild(self._go, self:getPathName(self.resPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(self._itemGo, self._onDown, self)
		end

		if not string.nilorempty(self.effectPath) then
			self._effectGo = gohelper.findChild(self._go, self:getPathName(self.effectPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(self._effectGo, self._onDown, self)
		end
	else
		if self._resLoader then
			return
		end

		self._resLoader = MultiAbLoader.New()

		if not string.nilorempty(self.resPath) then
			self._resLoader:addPath(self.resPath)
		end

		if not string.nilorempty(self.effectPath) then
			self._resLoader:addPath(self.effectPath)
		end

		self._resLoader:startLoad(self._onResLoaded, self)
	end
end

function VersionActivity2_4DungeonMapFinishElement:_onResLoaded()
	if not string.nilorempty(self.resPath) then
		local assetItem = self._resLoader:getAssetItem(self.resPath)
		local mainPrefab = assetItem:GetResource(self.resPath)

		self._itemGo = gohelper.clone(mainPrefab, self._go)

		local resScale = self._config.resScale

		if resScale and resScale ~= 0 then
			transformhelper.setLocalScale(self._itemGo.transform, resScale, resScale, 1)
		end

		gohelper.setLayer(self._itemGo, UnityLayer.Scene, true)
		DungeonMapFinishElement.addBoxColliderListener(self._itemGo, self._onDown, self)
		transformhelper.setLocalPos(self._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(self.effectPath) then
		local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

		self._offsetX = offsetPos[1] or 0
		self._offsetY = offsetPos[2] or 0

		local assetItem = self._resLoader:getAssetItem(self.effectPath)
		local mainPrefab = assetItem:GetResource(self.effectPath)

		self._effectGo = gohelper.clone(mainPrefab, self._go)

		DungeonMapFinishElement.addBoxColliderListener(self._effectGo, self._onDown, self)
		transformhelper.setLocalPos(self._effectGo.transform, self._offsetX, self._offsetY, -3)

		local aniGo = gohelper.findChild(self._effectGo, "ani/yuanjian_new_07/gou")

		if aniGo then
			gohelper.setActive(aniGo, true)

			local animator = aniGo:GetComponent(typeof(UnityEngine.Animator))

			animator:Play("idle")
		end
	end
end

function VersionActivity2_4DungeonMapFinishElement:onDown()
	self:_onDown()
end

function VersionActivity2_4DungeonMapFinishElement:_onDown()
	self._sceneElements:setMouseElementDown(self)
end

function VersionActivity2_4DungeonMapFinishElement:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._config.type == DungeonEnum.ElementType.None and self._config.fragment > 0 then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			notShowToast = true,
			fragmentId = self._config.fragment,
			elementId = self._config.id
		})
	end
end

return VersionActivity2_4DungeonMapFinishElement
