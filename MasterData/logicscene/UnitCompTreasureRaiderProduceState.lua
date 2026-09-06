-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/treasureraider/UnitCompTreasureRaiderProduceState.lua

module("logicscene.scene.unit.component.treasureraider.UnitCompTreasureRaiderProduceState", package.seeall)

local UnitCompTreasureRaiderProduceState = class("UnitCompTreasureRaiderProduceState", UnitComponentBase)

function UnitCompTreasureRaiderProduceState:onInit()
	return
end

function UnitCompTreasureRaiderProduceState:onDestroy()
	return
end

function UnitCompTreasureRaiderProduceState:onUnitVisible(go)
	self:updateProduceStatus()
end

function UnitCompTreasureRaiderProduceState:onUnitInVisible(go)
	self:_clearProduceIcon()
end

function UnitCompTreasureRaiderProduceState:updateProduceStatus()
	self:_clearProduceIcon()
	self._unit:setVisible(false)

	if self._unit:isClipping() then
		return
	end

	local buildingMo = self._unit:getBuildingMo()

	if buildingMo then
		local isEditing = TREditorController.instance:isInState(TREditorController.EMode_EditorMode)
		local var_5_0 = buildingMo:getProduceCount() > 0 and self._unit.scene:getSceneMo():isMyScene() or false
		local isNeeShowProduce = true

		goto label_5_0

		::label_5_0::

		if isNeeShowProduce and not isEditing then
			self._unit:setVisible(true)

			local itemStr = string.split(buildingMo.buildingConfig.itemKey, "#")[1]
			local matType, id = MaterialMgr.getMatParams(itemStr)
			local cfg = MaterialMgr._getIconChangeCfg(matType, id)
			local iconResPath = GameUrl.getItemIconUrl(cfg.icon)

			self._iconResObject = self._unit.scene.resCache:newObject(iconResPath)
			self._iconResObject.loadedHandler = self._onIconLoadedFinish
			self._iconResObject.loadedHandlerTarget = self
		end
	end
end

function UnitCompTreasureRaiderProduceState:_onIconLoadedFinish()
	local go = self._unit:getGameObject()

	if not go then
		return
	end

	GoUtil.SetVisible(go, true)

	local icon = goutil.findChild(go, "icon")

	if not icon then
		return
	end

	local renderer = icon:GetComponent(ComponentType.Renderer)

	if not renderer then
		return
	end

	local iconRes = self._iconResObject.res:GetMainAsset()

	MaterialUtils.SetTexture(renderer, MaterialUtils.mainTexId, iconRes)
end

function UnitCompTreasureRaiderProduceState:_clearProduceIcon()
	if self._iconResObject then
		self._unit.scene.resCache:recycleObject(self._iconResObject)

		self._iconResObject = nil
	end
end

return UnitCompTreasureRaiderProduceState
