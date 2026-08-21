-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\HeroSkillGridChild.lua

local GridHeroSkillMixin = require("UI/Common/Grid/Mixin/GridHeroSkillMixin")
local HeroSkillGridChild = Class("HeroSkillGridChild", UIControls.Child)

MixinClass(HeroSkillGridChild, GridHeroSkillMixin)

function HeroSkillGridChild:ctor()
	self:ctorMixin()
end

return HeroSkillGridChild
