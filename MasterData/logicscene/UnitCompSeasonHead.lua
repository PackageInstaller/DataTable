-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/UnitCompSeasonHead.lua

module("logicscene.scene.unit.component.season.UnitCompSeasonHead", package.seeall)

local UnitCompSeasonHead = class("UnitCompSeasonHead", UnitComponentBase)

function UnitCompSeasonHead:onInit()
	self._iconResObject = nil
end

function UnitCompSeasonHead:onDestroy()
	self:_clearHeadIcon()
end

function UnitCompSeasonHead:setTeamData(teamData)
	self._teamData = teamData

	self:reloadHeadIcon()
end

function UnitCompSeasonHead:onUnitVisible(go)
	self:reloadHeadIcon()
end

function UnitCompSeasonHead:onUnitInVisible(go)
	self:_clearHeadIcon()
	self:destroyEffect()
end

function UnitCompSeasonHead:reloadHeadIcon()
	self:_clearHeadIcon()

	if self._unit:isClipping() or not self._teamData then
		return
	end

	local leaderSkinId = checknumber(self._teamData.leaderSkinId)

	if leaderSkinId <= 0 then
		leaderSkinId = 10144
	end

	local modelCo = CharacterConfig.instance:getModelCo(leaderSkinId)

	modelCo = modelCo or CharacterConfig.instance:getModelCo(10144)

	local iconResPath = GameUrl.getCharacterIconUrl(modelCo.headName)

	self._iconResObject = self._unit.scene.resCache:newObject(iconResPath)
	self._iconResObject.loadedHandler = self._onHeadIconLoadedFinish
	self._iconResObject.loadedHandlerTarget = self

	self:_updateTired()
	self:_updateTeamMate()
end

function UnitCompSeasonHead:_clearHeadIcon()
	if self._iconResObject then
		self._unit.scene.resCache:recycleObject(self._iconResObject)

		self._iconResObject = nil
	end
end

function UnitCompSeasonHead:_onHeadIconLoadedFinish()
	self:_updateIcon()
end

function UnitCompSeasonHead:_updateIcon()
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

function UnitCompSeasonHead:_updateTired()
	local go = self._unit:getGameObject()

	if not go then
		return
	end

	local tried = goutil.findChild(go, "tried")

	if not tried then
		return
	end

	local isTired = self._teamData:isServerLocked()

	GameUtil.SetActive(tried, isTired)

	if self._lastTired == true and isTired == false then
		local path = "effect/prefabs/ui/20221028/xiaolian/fx_ui_xiaolian.prefab"

		self.resObject = GameEffectManager.instance:playEffect(path, false)

		self.resObject:setParent(go.transform)
		self.resObject:setScale(0.1)
		self.resObject:setLocalPos(0.35, 1.1, 0)
		self.resObject:setLayer(self._unit:getLayer())
	end

	self._lastTired = isTired
end

function UnitCompSeasonHead:_updateTeamMate()
	local go = self._unit:getGameObject()

	if not go then
		return
	end

	local tried = goutil.findChild(go, "teamMate")

	if not tried then
		return
	end

	local isTeamMate = self._teamData:getIsOtherTeam()

	GameUtil.SetActive(tried, isTeamMate)
end

function UnitCompSeasonHead:destroyEffect()
	if self.resObject then
		GameEffectManager.instance:stopEffect(self.resObject)

		self.resObject = nil
	end
end

return UnitCompSeasonHead
