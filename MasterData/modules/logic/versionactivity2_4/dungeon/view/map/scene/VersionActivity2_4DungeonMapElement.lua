-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/scene/VersionActivity2_4DungeonMapElement.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.scene.VersionActivity2_4DungeonMapElement", package.seeall)

local VersionActivity2_4DungeonMapElement = class("VersionActivity2_4DungeonMapElement", LuaCompBase)
local FINISH_ANIM_TIME = 1.6
local BOX_COLLIDER_SIZE = Vector2(1.5, 1.5)

function VersionActivity2_4DungeonMapElement:ctor(param)
	self._config = param[1]
	self._sceneElements = param[2]
end

function VersionActivity2_4DungeonMapElement:getElementId()
	return self._config.id
end

function VersionActivity2_4DungeonMapElement:hide()
	gohelper.setActive(self._go, false)
end

function VersionActivity2_4DungeonMapElement:show()
	gohelper.setActive(self._go, true)
end

function VersionActivity2_4DungeonMapElement:init(go)
	self._go = go
	self._transform = go.transform

	self:updatePos()

	if self._resLoader then
		return
	end

	self._resLoader = MultiAbLoader.New()
	self._resPath = self._config.res

	if not string.nilorempty(self._resPath) then
		self._resLoader:addPath(self._resPath)
	end

	self._effectPath = self._config.effect

	if not string.nilorempty(self._effectPath) then
		self._resLoader:addPath(self._effectPath)
	end

	self._resLoader:startLoad(self._onResLoaded, self)
end

function VersionActivity2_4DungeonMapElement:_onResLoaded()
	self:createMainPrefab()
	self:createEffectPrefab()
	self:autoPopInteractView()
	self:tryHideSelf()
end

function VersionActivity2_4DungeonMapElement:createMainPrefab()
	if string.nilorempty(self._resPath) then
		return
	end

	local assetItem = self._resLoader:getAssetItem(self._resPath)
	local mainPrefab = assetItem:GetResource(self._resPath)

	self._itemGo = gohelper.clone(mainPrefab, self._go)
	self.posTransform = self._itemGo.transform

	local resScale = self._config.resScale

	if resScale and resScale ~= 0 then
		transformhelper.setLocalScale(self.posTransform, resScale, resScale, 1)
	end

	gohelper.setLayer(self._itemGo, UnityLayer.Scene, true)
	self.addBoxColliderListener(self._itemGo, self._onClickDown, self)
	transformhelper.setLocalPos(self.posTransform, 0, 0, -1)
end

function VersionActivity2_4DungeonMapElement.addBoxColliderListener(go, callback, callbackTarget)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function VersionActivity2_4DungeonMapElement:createEffectPrefab()
	if string.nilorempty(self._effectPath) then
		return
	end

	local offset = self._config.tipOffsetPos
	local offsetPos = string.splitToNumber(offset, "#")

	self._offsetX = offsetPos[1] or 0
	self._offsetY = offsetPos[2] or 0

	local assetItem = self._resLoader:getAssetItem(self._effectPath)
	local effectPrefab = assetItem:GetResource(self._effectPath)

	self._effectGo = gohelper.clone(effectPrefab, self._go)
	self.posTransform = self._effectGo.transform

	transformhelper.setLocalPos(self._effectGo.transform, self._offsetX, self._offsetY, -10)
	self.addBoxColliderListener(self._effectGo, self._onClickDown, self)

	local isShowInteractView = VersionActivity2_4DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self:hideElement()
	end
end

function VersionActivity2_4DungeonMapElement:autoPopInteractView()
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(self._config.param) == DungeonMapModel.instance.lastElementBattleId then
		self:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function VersionActivity2_4DungeonMapElement:tryHideSelf()
	if VersionActivity2_4DungeonModel.instance:checkIsShowInteractView() then
		self:hideElement()
	end
end

function VersionActivity2_4DungeonMapElement:hideElement()
	self:playEffectAnim("wenhao_a_001_out")
end

function VersionActivity2_4DungeonMapElement:showElement()
	self:playEffectAnim("wenhao_a_001_in")
end

function VersionActivity2_4DungeonMapElement:setFinish()
	if not self._effectGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil

		return
	end

	self:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self.onFinishAnimDone, self, FINISH_ANIM_TIME)
end

function VersionActivity2_4DungeonMapElement:onFinishAnimDone()
	self:onDestroy()
end

function VersionActivity2_4DungeonMapElement:playEffectAnim(name)
	if gohelper.isNil(self._effectGo) then
		return
	end

	if not self._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(self._effectAnimator) then
		self._effectAnimator = SLFramework.AnimatorPlayer.Get(self._effectGo)
	end

	if not gohelper.isNil(self._effectAnimator) then
		self._effectAnimator:Play(name, self._effectAnimDone, self)
	end
end

function VersionActivity2_4DungeonMapElement:_effectAnimDone()
	return
end

function VersionActivity2_4DungeonMapElement:updatePos()
	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
end

function VersionActivity2_4DungeonMapElement:getTransform()
	return self._transform
end

function VersionActivity2_4DungeonMapElement:getElementPos()
	if not self.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(self.posTransform)
end

function VersionActivity2_4DungeonMapElement:getConfig()
	return self._config
end

function VersionActivity2_4DungeonMapElement:_onClickDown()
	self._sceneElements:setMouseElementDown(self)
end

function VersionActivity2_4DungeonMapElement:onClick()
	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.OnClickElement, self)
end

function VersionActivity2_4DungeonMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function VersionActivity2_4DungeonMapElement:isConfigShowArrow()
	return self._config.showArrow == 1
end

function VersionActivity2_4DungeonMapElement:onDestroy()
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

	self.destroyed = true
end

return VersionActivity2_4DungeonMapElement
