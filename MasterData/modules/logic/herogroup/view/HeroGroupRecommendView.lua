-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendView.lua

module("modules.logic.herogroup.view.HeroGroupRecommendView", package.seeall)

local HeroGroupRecommendView = class("HeroGroupRecommendView", BaseView)

function HeroGroupRecommendView:onInitView()
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "#scroll_group")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#siamge_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupRecommendView:addEvents()
	return
end

function HeroGroupRecommendView:removeEvents()
	return
end

function HeroGroupRecommendView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getHeroGroupBg("full/tuijianbeijingdi_036"))

	self._goScrollEpisode = gohelper.findChild(self.viewGO, "scroll_category")
	self._goStageItem = gohelper.findChild(self.viewGO, "scroll_category/viewport/categorycontent/#go_item")

	gohelper.setActive(self._goScrollEpisode, false)
	gohelper.setActive(self._goStageItem, false)

	self._episodeItemList = {}
end

function HeroGroupRecommendView:_refreshUI()
	if self.viewParam.episodeIdList and next(self.viewParam.episodeIdList) then
		self.episodeIdList = self.viewParam.episodeIdList

		local msg = self.viewParam.msg

		self.overrideRpcFunc = self.viewParam.overrideRpcFunc
		self.overrideRpcObj = self.viewParam.overrideRpcObj

		HeroGroupRecommendCharacterListModel.instance:setCharacterList(msg.racommends)
		self:_refreshEpisodeList()
		self:_onSelectEpisode(self.viewParam.episodeId)
	else
		local msg = self.viewParam

		HeroGroupRecommendCharacterListModel.instance:setCharacterList(msg.racommends)
		self:_refreshEpisodeList()
	end
end

function HeroGroupRecommendView:_refreshEpisodeList()
	local haveStage = self.episodeIdList ~= nil and next(self.episodeIdList)

	gohelper.setActive(self._goScrollEpisode, haveStage)

	if haveStage then
		gohelper.CreateObjList(self, self.onCreateEpisodeItem, self.episodeIdList, nil, self._goStageItem, nil, nil, nil, 1)
	end
end

function HeroGroupRecommendView:onCreateEpisodeItem(itemGo, data, index)
	local item = self:getUserDataTb_()

	item.itemGo = itemGo
	item.goSelect = gohelper.findChild(itemGo, "#go_selected")
	item.goUnSelect = gohelper.findChild(itemGo, "#go_unselected")
	item.txtSelect = gohelper.findChildTextMesh(itemGo, "#go_selected/#txt_selected")
	item.txtUnSelect = gohelper.findChildTextMesh(itemGo, "#go_unselected/#txt_unselected")
	item.episodeId = data

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(data)

	item.txtSelect.text = episodeConfig.name
	item.txtUnSelect.text = episodeConfig.name
	item.btnClick = SLFramework.UGUI.UIClickListener.Get(itemGo)

	local param = {}

	param.index = index
	param.target = self

	item.btnClick:AddClickListener(self.onClickEpisodeItem, param)

	self._episodeItemList[index] = item
end

function HeroGroupRecommendView.onClickEpisodeItem(param)
	local index = param.index
	local target = param.target

	target:clickEpisodeItem(index)
end

function HeroGroupRecommendView:clickEpisodeItem(index)
	local episodeId = self.episodeIdList[index]

	self:sendGetInfoRequest(episodeId)
end

function HeroGroupRecommendView:refreshEpisodeSelect()
	if self._episodeItemList and next(self._episodeItemList) then
		for _, item in ipairs(self._episodeItemList) do
			local isSelect = self._episodeId == item.episodeId

			gohelper.setActive(item.goSelect, isSelect)
			gohelper.setActive(item.goUnSelect, not isSelect)
		end
	end
end

function HeroGroupRecommendView:sendGetInfoRequest(episodeId)
	if self._episodeId == episodeId then
		return
	end

	self._tempEpisodeId = episodeId

	if self.overrideRpcFunc and self.overrideRpcObj then
		self.overrideRpcFunc(self.overrideRpcObj, episodeId, self.onRecommendInfoReply, self)

		return
	end

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(episodeId, self.onRecommendInfoReply, self)
end

function HeroGroupRecommendView:onRecommendInfoReply(cmd, resultCode, msg)
	if resultCode == 0 and msg then
		self:_onSelectEpisode(self._tempEpisodeId)
		HeroGroupRecommendCharacterListModel.instance:setCharacterList(msg.racommends)
	end
end

function HeroGroupRecommendView:_onSelectEpisode(episodeId)
	self._episodeId = episodeId

	self:refreshEpisodeSelect()
	HeroGroupRecommendGroupListModel.instance:setCurEpisodeId(episodeId)
end

function HeroGroupRecommendView:_onClickRecommendCharacter()
	self._scrollgroup.verticalNormalizedPosition = 1
end

function HeroGroupRecommendView:onOpen()
	self:_refreshUI()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickRecommendCharacter, self._onClickRecommendCharacter, self)
end

function HeroGroupRecommendView:onClose()
	HeroGroupRecommendGroupListModel.instance:setCurEpisodeId(nil)
	HeroGroupModel.instance:setAfterUpdateRecommendState(false)
end

function HeroGroupRecommendView:onDestroyView()
	self._simagebg:UnLoadImage()

	if self._episodeItemList and next(self._episodeItemList) then
		for _, item in ipairs(self._episodeItemList) do
			item.btnClick:RemoveClickListener()
		end

		tabletool.clear(self._episodeItemList)
	end
end

return HeroGroupRecommendView
