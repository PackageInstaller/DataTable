-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/treasureraider/UnitCompTreasureRaiderHead.lua

module("logicscene.scene.unit.component.treasureraider.UnitCompTreasureRaiderHead", package.seeall)

local UnitCompTreasureRaiderHead = class("UnitCompTreasureRaiderHead", UnitComponentBase)

function UnitCompTreasureRaiderHead:onInit()
	self._iconResObject = nil
end

function UnitCompTreasureRaiderHead:onDestroy()
	self:_clearHeadIcon()
end

function UnitCompTreasureRaiderHead:onUnitVisible(go)
	self:reloadHeadIcon()
end

function UnitCompTreasureRaiderHead:onUnitInVisible(go)
	self:_clearHeadIcon()
end

function UnitCompTreasureRaiderHead:reloadHeadIcon()
	self:_clearHeadIcon()

	if self._unit:isClipping() or not self._unit.data then
		return
	end

	local playerMo = self._unit.data

	if not playerMo.playerInfo then
		return
	end

	local headIconIds = {
		[GameEnum.Gender.Male] = 1,
		[GameEnum.Gender.Female] = 2
	}
	local gender = playerMo.playerInfo.gender
	local headIcon = headIconIds[gender]

	if headIcon ~= nil then
		local cfg = MaterialMgr._getIconChangeCfg(MatType.HeadIcon, headIcon)

		if cfg and checknumber(cfg.isSpine) ~= 1 then
			local iconResPath = GameUrl.getIconFolderUrl("headicon", cfg.icon)

			self._iconResObject = self._unit.scene.resCache:newObject(iconResPath)
			self._iconResObject.loadedHandler = self._onHeadIconLoadedFinish
			self._iconResObject.loadedHandlerTarget = self
		end
	end
end

function UnitCompTreasureRaiderHead:_clearHeadIcon()
	if self._iconResObject then
		self._unit.scene.resCache:recycleObject(self._iconResObject)

		self._iconResObject = nil
	end
end

function UnitCompTreasureRaiderHead:_onHeadIconLoadedFinish()
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

return UnitCompTreasureRaiderHead
