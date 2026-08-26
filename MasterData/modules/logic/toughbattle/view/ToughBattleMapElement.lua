-- chunkname: @modules/logic/toughbattle/view/ToughBattleMapElement.lua

module("modules.logic.toughbattle.view.ToughBattleMapElement", package.seeall)

local ToughBattleMapElement = class("ToughBattleMapElement", LuaCompBase)
local BOX_COLLIDER_SIZE = Vector2(1.5, 1.5)

function ToughBattleMapElement:ctor(param)
	self._config = param[1]
	self._sceneElements = param[2]
end

function ToughBattleMapElement:init(go)
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

function ToughBattleMapElement:updatePos()
	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
end

function ToughBattleMapElement:_onResLoaded()
	self:createMainPrefab()
	self:createEffectPrefab()
end

function ToughBattleMapElement:createMainPrefab()
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
	self.addBoxColliderListener(self._itemGo, self._onClickDown, self._onClickUp, self)
	transformhelper.setLocalPos(self.posTransform, 0, 0, -1)
end

function ToughBattleMapElement.addBoxColliderListener(go, callback, clickUpCall, callbackTarget)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
	clickListener:AddMouseUpListener(clickUpCall, callbackTarget)
end

function ToughBattleMapElement:createEffectPrefab(effectPath, offset)
	if string.nilorempty(effectPath) then
		effectPath = self._effectPath
		offset = self._config.tipOffsetPos

		if string.nilorempty(self._effectPath) then
			return
		end
	end

	local offsetPos = string.splitToNumber(offset, "#")

	self._offsetX = offsetPos[1] or 0
	self._offsetY = offsetPos[2] or 0

	local assetItem = self._resLoader:getAssetItem(effectPath)
	local effectPrefab = assetItem:GetResource(effectPath)

	self._effectGo = gohelper.clone(effectPrefab, self._go)
	self.posTransform = self._effectGo.transform

	transformhelper.setLocalPos(self._effectGo.transform, self._offsetX, self._offsetY, -3)
	self.addBoxColliderListener(self._effectGo, self._onClickDown, self._onClickUp, self)
end

function ToughBattleMapElement:_onClickDown()
	self._sceneElements:setMouseElementDown(self, self._config)
end

function ToughBattleMapElement:_onClickUp()
	self._sceneElements:setMouseElementUp(self, self._config)
end

function ToughBattleMapElement:hide()
	gohelper.setActive(self._go, false)
end

function ToughBattleMapElement:show()
	gohelper.setActive(self._go, true)
end

function ToughBattleMapElement:getElementId()
	return self._config.id
end

function ToughBattleMapElement:getTransform()
	return self._transform
end

function ToughBattleMapElement:getElementPos()
	if not self.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(self.posTransform)
end

function ToughBattleMapElement:getConfig()
	return self._config
end

function ToughBattleMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function ToughBattleMapElement:setFinish()
	if not self._effectGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil

		return
	end

	self:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self.onFinishAnimDone, self, 1.6)
end

function ToughBattleMapElement:onFinishAnimDone()
	self:onDestroy()
end

function ToughBattleMapElement:playEffectAnim(name)
	self._wenhaoAnimName = name

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

function ToughBattleMapElement:_effectAnimDone()
	logNormal("effect anim done")
end

function ToughBattleMapElement:onDestroy()
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

return ToughBattleMapElement
