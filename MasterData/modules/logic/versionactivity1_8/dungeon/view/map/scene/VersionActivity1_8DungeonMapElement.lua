-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/scene/VersionActivity1_8DungeonMapElement.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapElement", package.seeall)

local VersionActivity1_8DungeonMapElement = class("VersionActivity1_8DungeonMapElement", LuaCompBase)
local FINISH_ANIM_TIME = 1.6
local BOX_COLLIDER_SIZE = Vector2(1.5, 1.5)

function VersionActivity1_8DungeonMapElement:ctor(param)
	self._config = param[1]
	self._sceneElements = param[2]
end

function VersionActivity1_8DungeonMapElement:init(go)
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

function VersionActivity1_8DungeonMapElement:addEventListeners()
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
end

function VersionActivity1_8DungeonMapElement:removeEventListeners()
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
end

function VersionActivity1_8DungeonMapElement:onChangeInProgressMissionGroup()
	local isProgressOther = self:isInProgressOtherMissionGroup()

	if isProgressOther then
		self._disableAfterAnimDone = true

		self:hideElement()
	else
		self._disableAfterAnimDone = false

		self:showElement()
	end
end

function VersionActivity1_8DungeonMapElement:updatePos()
	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
end

function VersionActivity1_8DungeonMapElement:_onResLoaded()
	self:createMainPrefab()
	self:createEffectPrefab()
	self:refreshDispatchRemainTime()
	self:autoPopInteractView()
	self:tryHideSelf()
end

function VersionActivity1_8DungeonMapElement:createMainPrefab()
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

function VersionActivity1_8DungeonMapElement.addBoxColliderListener(go, callback, callbackTarget)
	gohelper.addBoxCollider2D(go, BOX_COLLIDER_SIZE)

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function VersionActivity1_8DungeonMapElement:createEffectPrefab(effectPath, offset)
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
	self.addBoxColliderListener(self._effectGo, self._onClickDown, self)

	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self:hideElement()
	end
end

function VersionActivity1_8DungeonMapElement:refreshDispatchRemainTime()
	if not self:isDispatch() then
		return
	end

	self._sceneElements:addTimeItem(self)
end

function VersionActivity1_8DungeonMapElement:autoPopInteractView()
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(self._config.param) == DungeonMapModel.instance.lastElementBattleId then
		self:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function VersionActivity1_8DungeonMapElement:tryHideSelf()
	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self:hideElement()
	end

	self:onChangeInProgressMissionGroup()
end

function VersionActivity1_8DungeonMapElement:onClick()
	local elementId = self:getElementId()
	local isProgressOther = self:isInProgressOtherMissionGroup()

	if isProgressOther then
		GameFacade.showToast(ToastEnum.V1a8Activity157HasDoingOtherMissionGroup)

		return
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnClickElement, elementId)
end

function VersionActivity1_8DungeonMapElement:_onClickDown()
	self._sceneElements:setMouseElementDown(self)
end

function VersionActivity1_8DungeonMapElement:isInProgressOtherMissionGroup()
	local elementId = self:getElementId()
	local actId = Activity157Model.instance:getActId()
	local missionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

	return ((missionId or nil) and Activity157Config.instance:isSideMission(actId, missionId) or nil) and Activity157Model.instance:isInProgressOtherMissionGroupByElementId(elementId)
end

function VersionActivity1_8DungeonMapElement:showElement()
	local isProgressOther = self:isInProgressOtherMissionGroup()

	if isProgressOther then
		return
	end

	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	gohelper.setActive(self._go, true)
	self:playEffectAnim("wenhao_a_001_in")
end

function VersionActivity1_8DungeonMapElement:hideElement()
	self:playEffectAnim("wenhao_a_001_out")
end

function VersionActivity1_8DungeonMapElement:getElementId()
	return self._config.id
end

function VersionActivity1_8DungeonMapElement:getTransform()
	return self._transform
end

function VersionActivity1_8DungeonMapElement:getElementPos()
	if not self.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(self.posTransform)
end

function VersionActivity1_8DungeonMapElement:getConfig()
	return self._config
end

function VersionActivity1_8DungeonMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function VersionActivity1_8DungeonMapElement:isConfigShowArrow()
	return self._config.showArrow == 1
end

function VersionActivity1_8DungeonMapElement:showArrow()
	local result = true
	local hasArrow = self:isConfigShowArrow()

	if hasArrow then
		local isProgressOther = self:isInProgressOtherMissionGroup()

		result = not isProgressOther and hasArrow
	else
		result = false
	end

	return result
end

function VersionActivity1_8DungeonMapElement:isDispatch()
	return self._config.type == DungeonEnum.ElementType.Dispatch
end

function VersionActivity1_8DungeonMapElement:onDispatchFinish()
	if self.destroyed then
		return
	end

	gohelper.destroy(self._effectGo)

	if self._itemGo then
		self.posTransform = self._itemGo.transform or nil
	end

	self._effectAnimator = nil

	self:createEffectPrefab()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	DispatchController.instance:dispatchEvent(DispatchEvent.OnDispatchFinish)
end

function VersionActivity1_8DungeonMapElement:setFinish()
	if not self._effectGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil

		return
	end

	self:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self.onFinishAnimDone, self, FINISH_ANIM_TIME)
end

function VersionActivity1_8DungeonMapElement:onFinishAnimDone()
	self:onDestroy()
end

function VersionActivity1_8DungeonMapElement:playEffectAnim(name)
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

function VersionActivity1_8DungeonMapElement:_effectAnimDone()
	if self._disableAfterAnimDone then
		gohelper.setActive(self._go, false)

		self._disableAfterAnimDone = false
	end
end

function VersionActivity1_8DungeonMapElement:onDestroy()
	TaskDispatcher.cancelTask(self.onFinishAnimDone, self)
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

return VersionActivity1_8DungeonMapElement
