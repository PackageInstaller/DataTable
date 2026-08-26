-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameHeroView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameHeroView", package.seeall)

local Activity186GameHeroView = class("Activity186GameHeroView", Activity186HeroView)

function Activity186GameHeroView:_onClick()
	return
end

function Activity186GameHeroView:_onLightSpineLoaded()
	self._uiSpine:showModel()
	self._uiSpine:setActionEventCb(self._onAnimEnd, self)
	self._uiSpine:play("b_daoju", true)
	gohelper.setActive(self._gocontentbg, true)
end

function Activity186GameHeroView:showText(text)
	if string.nilorempty(text) then
		gohelper.setActive(self._gocontentbg, false)
	else
		gohelper.setActive(self._gocontentbg, true)

		self._txtanacn.text = text
	end
end

return Activity186GameHeroView
