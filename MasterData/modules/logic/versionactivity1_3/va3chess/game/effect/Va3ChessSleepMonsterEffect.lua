-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessSleepMonsterEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessSleepMonsterEffect", package.seeall)

local Va3ChessSleepMonsterEffect = class("Va3ChessSleepMonsterEffect", Va3ChessEffectBase)

function Va3ChessSleepMonsterEffect:refreshEffect()
	return
end

function Va3ChessSleepMonsterEffect:onDispose()
	return
end

function Va3ChessSleepMonsterEffect:setSleep(num)
	self:_setSleepAnim(num, true)
end

function Va3ChessSleepMonsterEffect:_setSleepAnim(num, isPlayAnim)
	if self.isLoadFinish and self._target.avatar then
		local avatar = self._target.avatar
		local isZero = num <= 0

		if self._lastIsZreo ~= isZero then
			self._lastIsZreo = isZero

			gohelper.setActive(avatar.goNumber, not isZero)
			gohelper.setActive(avatar.goSleepB, not isZero)
			gohelper.setActive(avatar.goSleepA, isZero)
			gohelper.setActive(avatar.goTanhao, isZero)

			if isPlayAnim then
				avatar.animatorSleep:Play(isZero and "big" or "little")
			end

			if isPlayAnim and isZero then
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_monster_awake)
			end
		end

		if not isZero then
			local num1 = Mathf.Floor(num / 10) % 10
			local num2 = num % 10

			if num < 10 then
				num1 = num2
				num2 = 0
			end

			gohelper.setActive(avatar.meshEffNum2, num >= 10)

			if self._lastNum1 ~= num1 then
				self._lastNum1 = num1

				self:_setMeshNum(avatar.meshEffNum1, avatar.numPropertyBlock, num1)
			end

			if self._lastNum2 ~= num2 then
				self._lastNum2 = num2

				self:_setMeshNum(avatar.meshEffNum2, avatar.numPropertyBlock, num2)
			end
		end

		local handler = self._target:getHandler()

		handler:setAlertActive(isZero)
	end
end

function Va3ChessSleepMonsterEffect:_getOffsetByNum(num)
	if num >= 0 and num <= 9 then
		return num * 0.1
	end

	return 1
end

function Va3ChessSleepMonsterEffect:_setMeshNum(meshRenderer, propertyBlock, num)
	local offsetX = self:_getOffsetByNum(num - 1)

	propertyBlock:Clear()
	propertyBlock:SetVector("_MainTex_ST", Vector4.New(0.1, 1, offsetX, 0))
	meshRenderer:SetPropertyBlock(propertyBlock)
end

function Va3ChessSleepMonsterEffect:onAvatarLoaded()
	local loader = self._loader

	if not self._loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		local avatar = self._target.avatar
		local goTrack = gohelper.findChild(go, "vx_tracked")
		local goNumber = gohelper.findChild(go, "vx_number")
		local goTanhao = gohelper.findChild(go, "icon_tanhao")

		avatar.meshEffNum1 = gohelper.findChild(go, "vx_number/1"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		avatar.meshEffNum2 = gohelper.findChild(go, "vx_number/2"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		avatar.meshEffNum1.material = UnityEngine.Material.New(avatar.meshEffNum1.material)
		avatar.meshEffNum2.material = UnityEngine.Material.New(avatar.meshEffNum2.material)

		gohelper.setActive(avatar.goTrack, false)
		gohelper.setActive(goTrack, false)
		gohelper.setActive(goNumber, false)

		avatar.goTrack = goTrack
		avatar.goNumber = goNumber
		avatar.goTanhao = goTanhao
		avatar.numPropertyBlock = UnityEngine.MaterialPropertyBlock.New()

		local goAvatar = avatar.loader:getInstGO()

		avatar.goSleepA = gohelper.findChild(goAvatar, "a")
		avatar.goSleepB = gohelper.findChild(goAvatar, "b")
		avatar.animatorSleep = goAvatar:GetComponent(Va3ChessEnum.ComponentType.Animator)

		gohelper.setActive(avatar.goSleepA, false)

		local mo = Va3ChessGameModel.instance:getObjectDataById(self._target.id)
		local data = mo and mo.data

		if data and data.attributes and data.attributes.sleep then
			self:_setSleepAnim(data.attributes.sleep)
		end
	end
end

return Va3ChessSleepMonsterEffect
