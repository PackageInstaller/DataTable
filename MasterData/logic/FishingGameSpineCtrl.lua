-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameSpineCtrl.lua

module("logic.extensions.fishinggame.model.FishingGameSpineCtrl", package.seeall)

local FishingGameSpineCtrl = class("FishingGameSpineCtrl", HLSpineCtrl)

function FishingGameSpineCtrl:_getUrl()
	return {
		self._resPath
	}
end

function FishingGameSpineCtrl:onInit(spineRoot, view, resPath)
	self._spineRoot = spineRoot
	self._view = view
	self._resPath = resPath

	self:_loadSpine()
end

function FishingGameSpineCtrl:_loadSpine()
	self:_clearSpine()

	local effParent = self._spineRoot
	local urlPath = self:_getUrl()

	if effParent then
		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setLocalEulerAngle(0, 0, 0)
			eff:setScale(self:_getDefaultScale())
			self:playDefaultAnim()

			if not goutil.isNil(eff.effGo) then
				self._skeletonGraphic = eff.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
				self._skeleton = self._skeletonGraphic and self._skeletonGraphic.Skeleton
			end

			GameUtil.callBack(self._callBackOfSpineLoaded)
		end

		local handlerTarget

		self._playerSpine = UIEffectManager.instance:playEffect(self._view, urlPath, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function FishingGameSpineCtrl:playDefaultAnim()
	self:_playAnim("idle", true)
end

function FishingGameSpineCtrl:playAttackAnim()
	self:_playAnim("jump", true)
end

return FishingGameSpineCtrl
