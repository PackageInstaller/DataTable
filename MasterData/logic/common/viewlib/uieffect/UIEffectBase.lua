-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/UIEffectBase.lua

module("logic.common.viewlib.uieffect.UIEffectBase", package.seeall)

local UIEffectBase = class("UIEffectBase")

function UIEffectBase:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:_buildUI(compContainer.gameObject)

	self._isUIValid = true
end

function UIEffectBase:OnDestroy()
	self:_destroyUI()

	self._isUIValid = false
end

function UIEffectBase:_buildUI(mainGO)
	return
end

function UIEffectBase:_destroyUI()
	return
end

function UIEffectBase:checkUIValid()
	return self._isUIValid
end

function UIEffectBase:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

return UIEffectBase
