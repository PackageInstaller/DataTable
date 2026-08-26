-- chunkname: @modules/logic/activity/view/LinkageActivity_PageBase.lua

module("modules.logic.activity.view.LinkageActivity_PageBase", package.seeall)

local LinkageActivity_PageBase = class("LinkageActivity_PageBase", RougeSimpleItemBase)

function LinkageActivity_PageBase:ctor(...)
	self:__onInit()
	LinkageActivity_PageBase.super.ctor(self, ...)
end

function LinkageActivity_PageBase:onDestroyView()
	LinkageActivity_PageBase.super.onDestroyView(self)
	self:__onDispose()
end

function LinkageActivity_PageBase:actId()
	local p = self:_assetGetParent()

	return p:actId()
end

function LinkageActivity_PageBase:actCO()
	local p = self:_assetGetParent()

	return p:actCO()
end

function LinkageActivity_PageBase:getLinkageActivityCO()
	local p = self:_assetGetParent()

	return p:getLinkageActivityCO()
end

function LinkageActivity_PageBase:getDataList()
	local p = self:_assetGetParent()

	return p:getDataList()
end

function LinkageActivity_PageBase:getTempDataList()
	local p = self:_assetGetParent()

	return p:getTempDataList()
end

function LinkageActivity_PageBase:selectedPage(index)
	local p = self:_assetGetParent()

	return p:selectedPage(index)
end

function LinkageActivity_PageBase:getDurationTimeStr()
	local CO = self:getLinkageActivityCO()

	return StoreController.instance:getRecommendStoreTime(CO)
end

function LinkageActivity_PageBase:jump()
	local CO = self:getLinkageActivityCO()

	GameFacade.jumpByAdditionParam(CO.systemJumpCode or "10173")
end

function LinkageActivity_PageBase:getLinkageActivityCO_item(index)
	local CO = self:getLinkageActivityCO()

	return CO["item" .. index]
end

function LinkageActivity_PageBase:getLinkageActivityCO_res_video(index)
	local CO = self:getLinkageActivityCO()

	return CO["res_video" .. index]
end

function LinkageActivity_PageBase:getLinkageActivityCO_desc(index)
	local CO = self:getLinkageActivityCO()

	return CO["desc" .. index]
end

function LinkageActivity_PageBase:getItemIconResUrl(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:getItemIconResUrl(c:itemCo2TIQ(itemCO))
end

function LinkageActivity_PageBase:getItemConfig(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:getItemConfig(c:itemCo2TIQ(itemCO))
end

function LinkageActivity_PageBase:itemCo2TIQ(index)
	local itemCO = self:getLinkageActivityCO_item(index)
	local c = self:_assetGetViewContainer()

	return c:itemCo2TIQ(itemCO)
end

function LinkageActivity_PageBase:onPostSelectedPage(curPage, lastPage)
	return
end

return LinkageActivity_PageBase
