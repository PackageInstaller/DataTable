-- chunkname: @modules/logic/sodache/view/inside/SodacheHeroGroupFightView.lua

module("modules.logic.sodache.view.inside.SodacheHeroGroupFightView", package.seeall)

local SodacheHeroGroupFightView = class("SodacheHeroGroupFightView", HeroGroupFightView)

function SodacheHeroGroupFightView:_refreshPowerShow()
	gohelper.setActive(self._gopowercontent, false)
	self:refreshFightCount(false)
end

return SodacheHeroGroupFightView
