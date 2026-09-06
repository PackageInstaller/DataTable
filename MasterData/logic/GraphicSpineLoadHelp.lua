-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/util/GraphicSpineLoadHelp.lua

module("logic.extensions.spineinterface.util.GraphicSpineLoadHelp", package.seeall)

local GraphicSpineLoadHelp = class("GraphicSpineLoadHelp")

function GraphicSpineLoadHelp:ctor()
	self._spineCtrl = SimpleSpineCtrl.New()
end

function GraphicSpineLoadHelp:loadSpine(urlPath, spineRoot, view)
	self._urlPath = {
		urlPath
	}
	self._spineRoot = spineRoot
	self._view = view
	self._defaultScale = 1
	self._callBackOfSpineLoaded = nil

	self:unloadSpine()

	local effParent = self._spineRoot
	local urlPath = self._urlPath

	local function finishHandler(handlerTarget, eff)
		return
	end

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(effParent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(self._defaultScale)
		self._spineCtrl:onInit(eff.effGo)
		GameUtil.callBack(self._callBackOfSpineLoaded)
	end

	local handlerTarget

	self._spineEffect = UIEffectManager.instance:playEffect(self._view, urlPath, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)

	return self._spineCtrl
end

function GraphicSpineLoadHelp:unloadSpine()
	self._spineCtrl:onClear()

	if self._spineEffect then
		UIEffectManager.instance:stopEffect(self._spineEffect)
	end

	self._spineEffect = nil
end

function GraphicSpineLoadHelp:setDefaultScale(value)
	self._defaultScale = value
end

function GraphicSpineLoadHelp:regCallBackOfSpineLoaded(callBack)
	self._callBackOfSpineLoaded = callBack
end

function GraphicSpineLoadHelp:unregCallBackOfSpineLoaded()
	self._callBackOfSpineLoaded = nil
end

return GraphicSpineLoadHelp
