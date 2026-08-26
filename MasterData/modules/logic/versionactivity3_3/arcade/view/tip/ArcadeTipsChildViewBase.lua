-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeTipsChildViewBase.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeTipsChildViewBase", package.seeall)

local ArcadeTipsChildViewBase = class("ArcadeTipsChildViewBase", LuaCompBase)

function ArcadeTipsChildViewBase:init(go)
	self.viewGO = go
end

function ArcadeTipsChildViewBase:addEventListeners()
	return
end

function ArcadeTipsChildViewBase:removeEventListeners()
	return
end

function ArcadeTipsChildViewBase:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function ArcadeTipsChildViewBase:showView(isShow)
	self._isChange = self.viewGO.activeSelf ~= isShow

	gohelper.setActive(self.viewGO, isShow)
end

function ArcadeTipsChildViewBase:onUpdateMO(mo, tipview)
	self._mo = mo

	if self:isPlayOpenAnim() then
		self._animPlayer:Play(UIAnimationName.Open, nil, self)
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_tips_open)
	end

	self._tipView = tipview

	self:refreshView()
end

function ArcadeTipsChildViewBase:isPlayOpenAnim()
	return true
end

function ArcadeTipsChildViewBase:playCloseAnim(callback, callbackObj)
	self._animPlayer:Play(UIAnimationName.Close, callback, callbackObj)
end

function ArcadeTipsChildViewBase:refreshView()
	return
end

function ArcadeTipsChildViewBase:setAnchor(mo, x, y)
	recthelper.setAnchor(self.viewGO.transform, x, y)
end

function ArcadeTipsChildViewBase:onDestroy()
	return
end

return ArcadeTipsChildViewBase
