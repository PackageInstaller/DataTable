-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTips.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTips", package.seeall)

local SportsNewsTips = class("SportsNewsTips", ActivityWarmUpTips)

function SportsNewsTips:onOpen()
	SportsNewsTips.super.onOpen(self)

	local orderId = self.viewParam.orderId
	local actId = self.viewParam.actId

	SportsNewsModel.instance:onReadEnd(actId, orderId)
end

return SportsNewsTips
