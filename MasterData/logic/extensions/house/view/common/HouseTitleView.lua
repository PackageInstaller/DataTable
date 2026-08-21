-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/HouseTitleView.lua

module("logic.extensions.house.view.common.HouseTitleView", package.seeall)

local M = class("HouseTitleView", TitleView)

function M:_onClickBack()
	self:back()
end

function M:_onClickHome()
	HouseMainFacade.instance:onClickHome()
end

return M
