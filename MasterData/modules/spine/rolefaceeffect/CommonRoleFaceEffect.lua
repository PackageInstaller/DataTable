-- chunkname: @modules/spine/rolefaceeffect/CommonRoleFaceEffect.lua

module("modules.spine.rolefaceeffect.CommonRoleFaceEffect", package.seeall)

local CommonRoleFaceEffect = class("CommonRoleFaceEffect", BaseSpineRoleFaceEffect)

function CommonRoleFaceEffect:init(config)
	self._config = config
	self._spineGo = self._spine._spineGo
	self._faceList = string.split(config.face, "|")
	self._nodeList = GameUtil.splitString2(config.node, false, "|", "#")
end

function CommonRoleFaceEffect:showFaceEffect(name)
	self:_setNodeVisible(self._index, false)

	self._index = tabletool.indexOf(self._faceList, name)

	self:_setNodeVisible(self._index, true)
end

function CommonRoleFaceEffect:_setNodeVisible(index, visible)
	if not index then
		return
	end

	local nodeList = self._nodeList[index]

	for i, v in ipairs(nodeList) do
		local go = gohelper.findChild(self._spineGo, v)

		gohelper.setActive(go, visible)
	end
end

function CommonRoleFaceEffect:onDestroy()
	self._spineGo = nil
end

return CommonRoleFaceEffect
