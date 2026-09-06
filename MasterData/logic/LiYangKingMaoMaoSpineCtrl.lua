-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingMaoMaoSpineCtrl.lua

module("logic.extensions.liyangking.view.LiYangKingMaoMaoSpineCtrl", package.seeall)

local LiYangKingMaoMaoSpineCtrl = class("LiYangKingMaoMaoSpineCtrl", HLSpineCtrl)

function LiYangKingMaoMaoSpineCtrl:onInit(spineRoot, view, spinePath)
	self._spinePath = spinePath

	LiYangKingMaoMaoSpineCtrl.super.onInit(self, spineRoot, view)
end

function LiYangKingMaoMaoSpineCtrl:_getUrl()
	return {
		self._spinePath
	}
end

function LiYangKingMaoMaoSpineCtrl:_getDefaultScale()
	return 1
end

function LiYangKingMaoMaoSpineCtrl:playDefaultAnim()
	self:_playAnim("talk_idle", true)
end

return LiYangKingMaoMaoSpineCtrl
