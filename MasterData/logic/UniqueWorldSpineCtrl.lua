-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldSpineCtrl.lua

module("logic.extensions.uniqueworld.view.UniqueWorldSpineCtrl", package.seeall)

local UniqueWorldSpineCtrl = class("UniqueWorldSpineCtrl", HLSpineCtrl)

function UniqueWorldSpineCtrl:_getUrl()
	return "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
end

function UniqueWorldSpineCtrl:playDefaultAnim()
	self:_playAnim("idle", true)
end

function UniqueWorldSpineCtrl:playDigMineAnim(param)
	self:_playAnim("1", false, function()
		self:playDefaultAnim()
		GameUtil.callBack(param)
	end)
end

function UniqueWorldSpineCtrl:playRunAnim()
	self:_playAnim("run", true)
end

return UniqueWorldSpineCtrl
