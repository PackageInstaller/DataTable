-- chunkname: @modules/ugui/icon/common/CommonHeroHelper.lua

module("modules.ugui.icon.common.CommonHeroHelper", package.seeall)

local CommonHeroHelper = class("CommonHeroHelper")

function CommonHeroHelper:setGrayState(id, flag)
	local grayTab = self:_getGrayStateTab()

	grayTab[id] = flag
end

function CommonHeroHelper:getGrayState(id)
	return self:_getGrayStateTab()[id]
end

function CommonHeroHelper:_getGrayStateTab()
	self.grayTab = self.grayTab or {}

	return self.grayTab
end

function CommonHeroHelper:resetGrayState()
	self.grayTab = {}
end

CommonHeroHelper.instance = CommonHeroHelper.New()

return CommonHeroHelper
