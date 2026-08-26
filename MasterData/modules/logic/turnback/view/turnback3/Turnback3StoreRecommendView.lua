-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3StoreRecommendView.lua

module("modules.logic.turnback.view.turnback3.Turnback3StoreRecommendView", package.seeall)

local Turnback3StoreRecommendView = class("Turnback3StoreRecommendView", MainThumbnailRecommendView)

function Turnback3StoreRecommendView:onInitView()
	self._goslider = gohelper.findChild(self.viewGO, "root/banner/#go_slider")
	self._gocontent = gohelper.findChild(self.viewGO, "root/banner/#go_bannercontent")
	self._goscroll = gohelper.findChild(self.viewGO, "root/banner/#go_bannerscroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3StoreRecommendView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	local relationStoreIdsDic = self:_initPages(true)

	if tabletool.len(relationStoreIdsDic) > 0 then
		local storeIds = {}

		for i, v in pairs(relationStoreIdsDic) do
			table.insert(storeIds, i)
		end

		StoreRpc.instance:sendGetStoreInfosRequest(storeIds)
	end
end

function Turnback3StoreRecommendView:_initPages(checkRequest)
	recthelper.setAnchorX(self._gocontent.transform, 0)

	local tempPageCfgs = {}

	self._pagesCo = {}
	self._totalPageCount = 0

	local relationStoreIdsDic = {}
	local SummonPools = SummonMainModel.getValidPools()

	self._openSummonPoolDic = {}

	for i, v in ipairs(SummonPools) do
		self._openSummonPoolDic[v.id] = v
	end

	for i, v in ipairs(lua_store_recommend.configList) do
		local pass, _, storeIdsDic = self:_checkRelations(v.relations, nil, checkRequest)

		if v.type == 1 and self:_inOpenTime(v) and pass then
			local jumpId = string.splitToNumber(v.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(v.systemJumpCode) or JumpConfig.instance:isOpenJumpId(jumpId) then
				table.insert(tempPageCfgs, v)

				self._totalPageCount = self._totalPageCount + 1
			end
		end

		if storeIdsDic then
			for storeId, _ in pairs(storeIdsDic) do
				relationStoreIdsDic[storeId] = true
			end
		end
	end

	local pageCount = CommonConfig.instance:getConstNum(ConstEnum.MainThumbnailRecommendItemCount) or 14

	self:sortPage(tempPageCfgs)

	for i = 1, pageCount do
		if tempPageCfgs[i] and tempPageCfgs[i].isShowTurnback then
			self._pagesCo[#self._pagesCo + 1] = tempPageCfgs[i]
		end
	end

	local index = self:_getEnterPageIndex()

	self:setTargetPageIndex(index)
	self:setSelectItem()
	self:setContentItem()
	self:_startAutoSwitch()
	self:_startCheckExpire()
	self:_updateSelectedItem()
	self:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.First)

	return relationStoreIdsDic
end

return Turnback3StoreRecommendView
