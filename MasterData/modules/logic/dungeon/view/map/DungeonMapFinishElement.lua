-- chunkname: @modules/logic/dungeon/view/map/DungeonMapFinishElement.lua

module("modules.logic.dungeon.view.map.DungeonMapFinishElement", package.seeall)

local DungeonMapFinishElement = class("DungeonMapFinishElement", LuaCompBase)

function DungeonMapFinishElement:ctor(param)
	self._config = param[1]
	self._mapScene = param[2]
	self._sceneElements = param[3]
	self._existGo = param[4]
end

function DungeonMapFinishElement:getElementId()
	return self._config.id
end

function DungeonMapFinishElement:hide()
	gohelper.setActive(self._go, false)
end

function DungeonMapFinishElement:show()
	gohelper.setActive(self._go, true)
end

function DungeonMapFinishElement:init(go)
	self._go = go
	self._transform = go.transform

	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

	self.resPath = self._config.res
	self.effectPath = self._config.effect

	if self._existGo then
		self._itemGo = gohelper.findChild(self._go, self:getPathName(self.resPath) .. "(Clone)")

		DungeonMapFinishElement.addBoxColliderListener(self._itemGo, self._onDown, self)

		if not string.nilorempty(self.effectPath) then
			self._effectGo = gohelper.findChild(self._go, self:getPathName(self.effectPath) .. "(Clone)")

			DungeonMapFinishElement.addBoxColliderListener(self._effectGo, self._onDown, self)
		end
	else
		if self._resLoader then
			return
		end

		self._resLoader = MultiAbLoader.New()

		self._resLoader:addPath(self.resPath)

		if not string.nilorempty(self.effectPath) then
			self._resLoader:addPath(self.effectPath)
		end

		self._resLoader:startLoad(self._onResLoaded, self)
	end
end

function DungeonMapFinishElement:_onResLoaded()
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

	if not string.nilorempty(self.effectPath) then
		local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

		self._offsetX = offsetPos[1] or 0
		self._offsetY = offsetPos[2] or 0
		assetItem = self._resLoader:getAssetItem(self.effectPath)
		mainPrefab = assetItem:GetResource(self.effectPath)
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

function DungeonMapFinishElement:onDown()
	self:_onDown()
end

function DungeonMapFinishElement:_onDown()
	self._sceneElements:setElementDown(self)
end

function DungeonMapFinishElement:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._config.type == DungeonEnum.ElementType.PuzzleGame then
		ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
			isFinish = true,
			elementCo = self._config
		})

		return
	end

	local fragmentCo = lua_chapter_map_fragment.configDict[self._config.fragment]

	if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
		ViewMgr.instance:openView(ViewName.VersionActivityNewsView, {
			fragmentId = fragmentCo.id
		})
	end
end

function DungeonMapFinishElement:_onSetEpisodeListVisible(value)
	gohelper.setActive(self._go, value)
end

function DungeonMapFinishElement:addEventListeners()
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
end

function DungeonMapFinishElement:removeEventListeners()
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
end

function DungeonMapFinishElement.addBoxCollider2D(go)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)
	local box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))

	box.enabled = true
	box.size = Vector2(1.5, 1.5)

	clickListener:SetIgnoreUI(true)

	return clickListener
end

function DungeonMapFinishElement.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = DungeonMapFinishElement.addBoxCollider2D(go)

	clickListener:AddClickListener(callback, callbackTarget)
end

function DungeonMapFinishElement:isValid()
	return not gohelper.isNil(self._go)
end

function DungeonMapFinishElement:onDestroy()
	gohelper.setActive(self._go, true)

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	if self._itemGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil
	end

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end
end

function DungeonMapFinishElement:getPathName(path)
	path = string.split(path, ".")[1]

	local pathArr = string.split(path, "/")

	return pathArr[#pathArr]
end

return DungeonMapFinishElement
