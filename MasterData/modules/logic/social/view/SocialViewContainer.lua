-- chunkname: @modules/logic/social/view/SocialViewContainer.lua

module("modules.logic.social.view.SocialViewContainer", package.seeall)

local SocialViewContainer = class("SocialViewContainer", BaseViewContainer)

function SocialViewContainer:buildViews()
	local views = {}

	table.insert(views, SocialView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "container/tabviews"))

	return views
end

function SocialViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif tabContainerId == 2 then
		local friendsScrollParam = self:getFriendsScrollParam()
		local requestScrollParam = self:getRequestScrollParam()
		local recommendScrollParam = self:getRecommendScrollParam()
		local searchScrollParam = self:getSearchScrollParam()
		local blackListScrollParam = self:getBlackListScrollParam()
		local messageListScrollParam = self:getMessageListScrollParam()

		return {
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Friend), friendsScrollParam),
				LuaMixScrollView.New(SocialMessageListModel.instance, messageListScrollParam),
				SocialFriendsView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Recommend), recommendScrollParam),
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Search), searchScrollParam),
				SocialSearchView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Request), requestScrollParam),
				SocialRequestView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Black), blackListScrollParam),
				SocialBlackListView.New()
			})
		}
	end
end

function SocialViewContainer:getFriendsScrollParam()
	local friendsScrollParam = ListScrollParam.New()

	friendsScrollParam.scrollGOPath = "#go_has/left/hasscrollview"
	friendsScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	friendsScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	friendsScrollParam.cellClass = SocialFriendItem
	friendsScrollParam.scrollDir = ScrollEnum.ScrollDirV
	friendsScrollParam.lineCount = 1
	friendsScrollParam.cellWidth = 555
	friendsScrollParam.cellHeight = 152
	friendsScrollParam.cellSpaceH = 0
	friendsScrollParam.cellSpaceV = 10
	friendsScrollParam.startSpace = 8

	return friendsScrollParam
end

function SocialViewContainer:getRequestScrollParam()
	local requestScrollParam = ListScrollParam.New()

	requestScrollParam.scrollGOPath = "scrollview"
	requestScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	requestScrollParam.prefabUrl = self._viewSetting.otherRes[7]
	requestScrollParam.cellClass = SocialContentItem
	requestScrollParam.scrollDir = ScrollEnum.ScrollDirV
	requestScrollParam.lineCount = 2
	requestScrollParam.cellWidth = 744
	requestScrollParam.cellHeight = 428
	requestScrollParam.cellSpaceH = 24
	requestScrollParam.cellSpaceV = 24

	return requestScrollParam
end

function SocialViewContainer:getRecommendScrollParam()
	local recommendScrollParam = ListScrollParam.New()

	recommendScrollParam.scrollGOPath = "container/#go_recommend/scrollview"
	recommendScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	recommendScrollParam.prefabUrl = self._viewSetting.otherRes[7]
	recommendScrollParam.cellClass = SocialContentItem
	recommendScrollParam.scrollDir = ScrollEnum.ScrollDirV
	recommendScrollParam.lineCount = 2
	recommendScrollParam.cellWidth = 744
	recommendScrollParam.cellHeight = 428
	recommendScrollParam.cellSpaceH = 24
	recommendScrollParam.cellSpaceV = 24

	return recommendScrollParam
end

function SocialViewContainer:getSearchScrollParam()
	local searchScrollParam = ListScrollParam.New()

	searchScrollParam.scrollGOPath = "container/#go_searchresults/scrollview"
	searchScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	searchScrollParam.prefabUrl = self._viewSetting.otherRes[7]
	searchScrollParam.cellClass = SocialContentItem
	searchScrollParam.scrollDir = ScrollEnum.ScrollDirV
	searchScrollParam.lineCount = 2
	searchScrollParam.cellWidth = 744
	searchScrollParam.cellHeight = 428
	searchScrollParam.cellSpaceH = 24
	searchScrollParam.cellSpaceV = 24

	return searchScrollParam
end

function SocialViewContainer:getBlackListScrollParam()
	local blackListScrollParam = ListScrollParam.New()

	blackListScrollParam.scrollGOPath = "#go_has/scrollview"
	blackListScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	blackListScrollParam.prefabUrl = self._viewSetting.otherRes[4]
	blackListScrollParam.cellClass = SocialBlackListItem
	blackListScrollParam.scrollDir = ScrollEnum.ScrollDirV
	blackListScrollParam.lineCount = 2
	blackListScrollParam.cellWidth = 755
	blackListScrollParam.cellHeight = 160
	blackListScrollParam.cellSpaceH = 6
	blackListScrollParam.cellSpaceV = 1.5

	return blackListScrollParam
end

function SocialViewContainer:getMessageListScrollParam()
	local messageListScrollParam = MixScrollParam.New()

	messageListScrollParam.scrollGOPath = "#go_has/right/#go_message/#scroll_message"
	messageListScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	messageListScrollParam.prefabUrl = self._viewSetting.otherRes[5]
	messageListScrollParam.cellClass = SocialMessageItem
	messageListScrollParam.scrollDir = ScrollEnum.ScrollDirV
	messageListScrollParam.lineCount = 1

	return messageListScrollParam
end

function SocialViewContainer:switchTab(tabId)
	if self.viewParam then
		local skinId = self.viewParam.skinId

		if not self.viewParam then
			local cardInfo = PlayerCardModel.instance:getCardInfo()

			skinId = cardInfo and cardInfo:getThemeId()
		end

		if tabId ~= 1 then
			self:_showSkinBG(self.viewParam)
		else
			self:_showSkinBG(self._curSkinId or self.viewParam)
		end

		self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
	end
end

function SocialViewContainer:checkBGView(skinId)
	self._socialBGList = self._socialBGList or {}
	self._curSkinId = skinId

	if skinId ~= 0 and not self._socialBGList[skinId] then
		local viewResPath = SocialEnum.ThemeViewResPath[skinId]

		if viewResPath and viewResPath.socialViewbg then
			self._bgabLoader = self._bgabLoader or MultiAbLoader.New()

			self._bgabLoader:addPath(viewResPath.socialViewbg)
			self._bgabLoader:startLoad(self._onBGLoadFinish, self)

			return
		end
	end

	self:_showSkinBG(self._curSkinId)
end

function SocialViewContainer:_onBGLoadFinish()
	local viewResPath = SocialEnum.ThemeViewResPath[self._curSkinId]

	if viewResPath and viewResPath.socialViewbg then
		local assetItem = self._bgabLoader:getAssetItem(viewResPath.socialViewbg)
		local prefab = assetItem:GetResource(viewResPath.socialViewbg)

		self._socialBGList[self._curSkinId] = gohelper.clone(prefab, gohelper.findChild(self.viewGO, "#simage_bg"), self._curSkinId)
	end

	self:_showSkinBG(self._curSkinId)
end

function SocialViewContainer:_showSkinBG(skin)
	if self._socialBGList then
		for _skin, go in pairs(self._socialBGList) do
			gohelper.setActive(go, skin == _skin)
		end
	end
end

function SocialViewContainer:closeInternal(isImmediate)
	if self._bgabLoader then
		self._bgabLoader:dispose()

		self._bgabLoader = nil
	end

	SocialViewContainer.super.closeInternal(self, isImmediate)
end

function SocialViewContainer:destroyView()
	if self._bgabLoader then
		self._bgabLoader:dispose()

		self._bgabLoader = nil
	end

	SocialViewContainer.super.destroyView(self)
end

return SocialViewContainer
