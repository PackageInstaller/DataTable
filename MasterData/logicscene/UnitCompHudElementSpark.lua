-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudElementSpark.lua

module("logicscene.scene.unit.component.hud.UnitCompHudElementSpark", package.seeall)

local UnitCompHudElementSpark = class("UnitCompHudElementSpark", UnitCompHudBase)

function UnitCompHudElementSpark:_updateHudInfo(hudGo)
	hudGo.name = self._unit:getGameObject().name

	local name = goutil.findChild(hudGo, "Name"):GetComponent("Text")
	local nameBg = goutil.findChild(hudGo, "NameBg"):GetComponent("RectTransform")
	local nameTxt = self._unit:getUnitHudDesc()

	name.text = nameTxt

	local sizeDelta = nameBg.sizeDelta

	sizeDelta.x = name.preferredWidth + 50
	nameBg.sizeDelta = sizeDelta

	if not nameTxt or nameTxt == "" or tostring(nameTxt) == "0" then
		nameBg.gameObject:SetActive(false)
		name.gameObject:SetActive(false)
	else
		nameBg.gameObject:SetActive(true)
		name.gameObject:SetActive(true)
	end

	self:_updateWinEffect()
end

function UnitCompHudElementSpark:_getResPath()
	return "scene/misc/prefabs/hudelementspark.prefab"
end

function UnitCompHudElementSpark:onUnitInVisible(go)
	UnitCompHudElementSpark.super.onUnitInVisible(self, go)
	self:_stopEffect()
end

function UnitCompHudElementSpark:_updateWinEffect()
	if ElementSparkController.instance:isResultTime() then
		local chunkId = ElementSparkSceneController.instance:getWinnerChunkId()

		if self._unit.chunkId == chunkId then
			self:_playEffect()

			return
		end
	end

	self:_stopEffect()
end

function UnitCompHudElementSpark:_stopEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	self._effectHandler = nil
end

function UnitCompHudElementSpark:_playEffect()
	if self._effectHandler or not self._hudGameObject then
		return
	end

	local effName = "20231222/shenyuneizhan/fx_ui_yanhua_lyzc.prefab"

	self._effectHandler = UIEffectManager.instance:playHUDEffect(effName, self._hudGameObject, true)

	self._effectHandler:setParent(self._hudObj.go.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return UnitCompHudElementSpark
