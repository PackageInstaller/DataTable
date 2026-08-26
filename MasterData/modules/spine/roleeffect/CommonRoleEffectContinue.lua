-- chunkname: @modules/spine/roleeffect/CommonRoleEffectContinue.lua

module("modules.spine.roleeffect.CommonRoleEffectContinue", package.seeall)

local CommonRoleEffectContinue = class("CommonRoleEffectContinue", BaseCommonRoleEffect)

function CommonRoleEffectContinue:init(roleEffectConfig)
	CommonRoleEffectContinue.super.init(self, roleEffectConfig)

	self._roleEffectConfig = roleEffectConfig
	self._spineGo = self._spine._spineGo
	self._motionList = string.split(roleEffectConfig.motion, "|")
	self._nodeList = GameUtil.splitString2(roleEffectConfig.node, false, "|", "#")
	self._firstShow = false
	self._showEverEffect = false
	self._effectVisible = false
end

function CommonRoleEffectContinue:isShowEverEffect()
	return self._showEverEffect
end

function CommonRoleEffectContinue:showBodyEffect(bodyName, callback, callbackTarget)
	CommonRoleEffectContinue.super.showBodyEffect(self, bodyName, callback, callbackTarget)

	self._effectVisible = false

	local nextIndex = tabletool.indexOf(self._motionList, bodyName)

	self:_setNodeVisible(self._index, false, nextIndex and self._nodeList[nextIndex])

	self._index = nextIndex

	self:_setNodeVisible(self._index, true)

	if not self._firstShow then
		self._firstShow = true

		self:showEverNodes(false)
		TaskDispatcher.cancelTask(self._delayShowEverNodes, self)
		TaskDispatcher.runDelay(self._delayShowEverNodes, self, 0.3)
	end

	if callback and callbackTarget then
		callback(callbackTarget, self._effectVisible or self._showEverEffect)
	end
end

function CommonRoleEffectContinue:forceHideBodyEffect()
	if not self._index then
		return
	end

	self:_setNodeVisible(self._index, false)
end

function CommonRoleEffectContinue:_delayShowEverNodes()
	self:showEverNodes(true)
end

function CommonRoleEffectContinue:showEverNodes(value)
	if string.nilorempty(self._roleEffectConfig.everNode) or not self._spineGo then
		return
	end

	local _resPath = self._spine._resPath

	if _resPath and not string.find(_resPath, self._roleEffectConfig.heroResName .. ".prefab") then
		return
	end

	local nodeList = string.split(self._roleEffectConfig.everNode, "#")

	for i, v in ipairs(nodeList) do
		local go = gohelper.findChild(self._spineGo, v)

		gohelper.setActive(go, value)

		self._showEverEffect = true

		if not go and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", _resPath, v))
		end
	end
end

function CommonRoleEffectContinue:_playShakeEffect(go, visible)
	if not self._spine:isInMainView() then
		return
	end

	local shakeConfigGo = gohelper.findChild(go, "root/shakeconfig")

	if shakeConfigGo then
		local effectShakeComp = shakeConfigGo:GetComponent(typeof(ZProj.EffectShakeComponent))

		if effectShakeComp then
			if visible then
				gohelper.setActive(shakeConfigGo, true)

				effectShakeComp.enabled = true

				effectShakeComp:Play(CameraMgr.instance:getCameraShake(), 1, 1)
			else
				CameraMgr.instance:getCameraShake():StopShake()
				gohelper.setActive(shakeConfigGo, false)
			end
		end
	end
end

function CommonRoleEffectContinue:_setNodeVisible(index, visible, nextNodeList)
	if not index then
		return
	end

	local nodeList = self._nodeList[index]

	for i, v in ipairs(nodeList) do
		local go = gohelper.findChild(self._spineGo, v)

		if not nextNodeList or not tabletool.indexOf(nextNodeList, v) then
			gohelper.setActive(go, visible)
		end

		self:_playShakeEffect(go, visible)

		if not go and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", self._spine._resPath, v))
		end

		if visible then
			self._effectVisible = true
		end
	end
end

function CommonRoleEffectContinue:playBodyEffect(showEffect, child, bodyName)
	return
end

function CommonRoleEffectContinue:onDestroy()
	CommonRoleEffectContinue.super.onDestroy(self)

	self._spineGo = nil

	TaskDispatcher.cancelTask(self._delayShowEverNodes, self)
end

return CommonRoleEffectContinue
