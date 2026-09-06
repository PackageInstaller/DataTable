-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/UnitCompHudElementSparkTag.lua

module("logicscene.scene.unit.component.hud.UnitCompHudElementSparkTag", package.seeall)

local UnitCompHudElementSparkTag = class("UnitCompHudElementSparkTag", UnitCompHudBase)

function UnitCompHudElementSparkTag:ctor(unit)
	UnitCompHudElementSparkTag.super.ctor(self, unit)

	self._ofsY = 0.5
end

function UnitCompHudElementSparkTag:_getResPath()
	return "scene/misc/prefabs/hudelementsparktag.prefab"
end

function UnitCompHudElementSparkTag:_hasData()
	local tagInfo = ElementSparkModel.instance:getTagInfo(self._unit.chunkId)

	if tagInfo then
		if not tagInfo.signId then
			local signId = 0
			local inProtect = ElementSparkModel.instance:getChunkInProtect(self._unit.chunkId)
			local chunkId2TeamId = ElementSparkModel.instance:getDefenseChunkId2TeamId()
			local locationId = ElementSparkSceneController.instance:getLocationChunkId()
			local beAttack = ElementSparkModel.instance:isBeAttack(self._unit.chunkId)

			if signId <= 0 then
				local var_3_1

				if not inProtect then
					::label_3_0::

					var_3_1 = chunkId2TeamId[self._unit.chunkId] or locationId ~= self._unit.chunkId and beAttack or true
				end
			end

			return var_3_1
		end
	end
end

function UnitCompHudElementSparkTag:_updateHudInfo(hudGo)
	local tagChange = goutil.findChild(hudGo, "tag"):GetComponent(ComponentType.UIImageSpriteChange)
	local btnTag = Framework.ButtonAdapter.Get(tagChange.gameObject)
	local txtTag = goutil.findChildTextComponent(hudGo, "tag/txtTag")
	local iconBg = goutil.findChild(hudGo, "iconBg")
	local icon = goutil.findChild(hudGo, "iconBg/iconMask/icon")
	local defenseTag = goutil.findChild(hudGo, "defenseTag")
	local txtTime = goutil.findChildTextComponent(hudGo, "txtTime")
	local attackTag = goutil.findChild(hudGo, "attackTag")

	self:_startLocationAnim()

	local tagInfo = ElementSparkModel.instance:getTagInfo(self._unit.chunkId)

	if tagInfo then
		if not tagInfo.signId then
			local signId = 0
			local hasSign = signId > 0
			local inProtect = ElementSparkModel.instance:getChunkInProtect(self._unit.chunkId)

			goutil.setActive(tagChange.gameObject, hasSign)
			goutil.setActive(txtTag.gameObject, hasSign)
			goutil.setActive(defenseTag, inProtect)
			goutil.setActive(txtTime.gameObject, inProtect)

			if hasSign then
				tagChange:SetState(signId - 1)

				txtTag.text = ConstString.ElementSparkTagTypeName[signId]
			end

			if inProtect then
				self._targetTime = ElementSparkModel.instance:getGuardProtectTime(self._unit.chunkId)
				self._txtTime = txtTime

				if self._targetTime - ServerTime.now() > 1 then
					settimer(1, self._tick, self, true)
					self:_tick()
				end
			else
				removetimer(self._tick, self)
			end

			btnTag:AddClickListener(function()
				self:_onclicTagType(signId)
			end)

			local result = ElementSparkController.instance:setDefensePetIcon(icon, self._unit.chunkId)

			goutil.setActive(icon, result)
			goutil.setActive(iconBg, result)

			if hasSign then
				Framework.TransformUtil.SetAnchoredPos(iconBg.transform, 24.4, 10.9)
			else
				Framework.TransformUtil.SetAnchoredPos(iconBg.transform, 0, 10.9)
			end

			if result then
				Framework.TransformUtil.SetAnchoredPos(tagChange.gameObject.transform, -24.6, 1.9)
			else
				Framework.TransformUtil.SetAnchoredPos(tagChange.gameObject.transform, 0, 1.9)
			end

			local beAttack = ElementSparkModel.instance:isBeAttack(self._unit.chunkId)

			goutil.setActive(attackTag, beAttack)
		end
	end
end

function UnitCompHudElementSparkTag:_tick()
	if self._txtTime and self._targetTime then
		local leftTime = self._targetTime - ServerTime.now()

		self._txtTime.text = string.format("%ss", leftTime)

		if leftTime <= 0 then
			removetimer(self._tick, self)

			self._txtTime = nil
			self._targetTime = nil

			self:_setHud()
		end
	end
end

function UnitCompHudElementSparkTag:_onclicTagType(signId)
	if not ElementSparkController.instance:isCommander() then
		FloatWordMgr.instance:show("只有指挥官才能修改标记")

		return
	end

	if ElementSparkController.instance:isResultTime() then
		FloatWordMgr.instance:show("公示阶段，无法操作")

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.ElementReplaceSparkTag, self._unit.chunkId, self._unit.id, signId)
end

function UnitCompHudElementSparkTag:_setHud()
	local hasData = self:_hasData()

	if not hasData then
		self:_recycleHud()

		return
	end

	UnitCompHudElementSparkTag.super._setHud(self)
end

function UnitCompHudElementSparkTag:onDestroy()
	removetimer(self._tick, self)
	removetimer(self._stopLocationAnim, self)
	UnitCompHudElementSparkTag.super.onDestroy(self)
end

function UnitCompHudElementSparkTag:_recycleHud()
	removetimer(self._tick, self)

	local locationId = ElementSparkSceneController.instance:getLocationChunkId()

	if locationId == self._unit.chunkId then
		ElementSparkSceneController.instance:setLocationChunkId(-1)
	end

	if self._hudGameObject then
		local postag = goutil.findChild(self._hudGameObject, "postag")
		local tween = postag:GetComponent(UnityTweensType.TweenPosition)

		tween:Stop()
	end

	UnitCompHudElementSparkTag.super._recycleHud(self)
end

function UnitCompHudElementSparkTag:_onElementSparkLocationChunk(chunkId)
	if chunkId == self._unit.chunkId then
		self:_setHud()
	end
end

function UnitCompHudElementSparkTag:_startLocationAnim()
	if not self._hudGameObject then
		return
	end

	local postag = goutil.findChild(self._hudGameObject, "postag")
	local locationId = ElementSparkSceneController.instance:getLocationChunkId()
	local needAnim = locationId and locationId > 0 and locationId == self._unit.chunkId

	goutil.setActive(postag, needAnim)

	if not needAnim then
		return
	end

	local tween = postag:GetComponent(UnityTweensType.TweenPosition)

	settimer(2, self._stopLocationAnim, self, false)
	tween:Begin()
end

function UnitCompHudElementSparkTag:_stopLocationAnim()
	ElementSparkSceneController.instance:setLocationChunkId(-1)
	self:_startLocationAnim()
	self:_setHud()
end

return UnitCompHudElementSparkTag
