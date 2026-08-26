-- chunkname: @modules/logic/room/view/RoomViewContainer.lua

module("modules.logic.room.view.RoomViewContainer", package.seeall)

local RoomViewContainer = class("RoomViewContainer", BaseViewContainer)

function RoomViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "navigatebuttonscontainer"))
	table.insert(views, RoomView.New())
	table.insert(views, RoomViewTouch.New())
	table.insert(views, RoomViewBlur.New())
	table.insert(views, RoomViewCameraState.New())
	table.insert(views, RoomViewTips.New())

	if RoomController.instance:isEditMode() then
		table.insert(views, TabViewGroup.New(2, "blockop_tab"))
	end

	table.insert(views, TabViewGroup.New(3, "go_normalroot/go_confirm"))

	if RoomController.instance:isObMode() then
		table.insert(views, RoomViewNavigateBubble.New())
		table.insert(views, RoomViewSceneTask.New())
		table.insert(views, RoomViewTopRight.New("go_normalroot/go_topright", self._viewSetting.otherRes[3], {
			{
				type = 2,
				id = 5,
				onlyShowEvent = true,
				classDefine = RoomViewTopRightMaterialItem,
				listeningItems = {
					{
						id = 5,
						type = 2
					},
					{
						id = 3,
						type = 2
					}
				}
			},
			{
				type = 2,
				id = 3,
				onlyShowEvent = true,
				classDefine = RoomViewTopRightMaterialItem,
				listeningItems = {
					{
						id = 5,
						type = 2
					},
					{
						id = 3,
						type = 2
					}
				}
			},
			{
				classDefine = RoomViewTopRightMaterialItem,
				type = MaterialEnum.MaterialType.Currency,
				id = CurrencyEnum.CurrencyType.RoomTrade,
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = CurrencyEnum.CurrencyType.RoomTrade
					}
				}
			},
			{
				classDefine = RoomViewTopRightCharacterItem
			},
			{
				classDefine = RoomViewTopRightBuildItem
			}
		}))
	elseif RoomController.instance:isEditMode() then
		table.insert(views, RoomViewSceneTask.New())
		table.insert(views, RoomViewTopRight.New("go_normalroot/go_topright", self._viewSetting.otherRes[3], {
			{
				classDefine = RoomViewTopRightMaterialItem,
				type = MaterialEnum.MaterialType.Currency,
				id = CurrencyEnum.CurrencyType.RoomTrade,
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = CurrencyEnum.CurrencyType.RoomTrade
					}
				}
			},
			{
				classDefine = RoomViewTopRightBuildItem
			},
			{
				bgType = 2,
				classDefine = RoomViewTopRightBlockItem
			}
		}))
	elseif RoomController.instance:isVisitMode() then
		table.insert(views, TabViewGroup.New(4, "go_normalroot/go_confirm"))
		table.insert(views, RoomViewTopRight.New("go_normalroot/go_topright", self._viewSetting.otherRes[3], {
			{
				ismap = true,
				bgType = 2,
				classDefine = RoomViewTopRightLayoutShareItem
			},
			{
				classDefine = RoomViewTopRightBuildItem
			},
			{
				bgType = 2,
				classDefine = RoomViewTopRightBlockItem
			}
		}))
	elseif FishingModel.instance:isInFishing() then
		local costData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
		local exchangeCostId = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.ExchangeCostCurrency, true)

		table.insert(views, TabViewGroup.New(5, "go_normalroot/go_confirm"))
		table.insert(views, RoomViewTopRight.New("go_normalroot/go_topright", self._viewSetting.otherRes[3], {
			{
				classDefine = RoomViewTopRightMaterialItem,
				type = MaterialEnum.MaterialType.Currency,
				id = exchangeCostId,
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = exchangeCostId
					}
				}
			},
			{
				classDefine = RoomViewTopRightFishingItem,
				type = MaterialEnum.MaterialType.Currency,
				id = costData[1],
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = costData[1]
					}
				}
			}
		}))
	end

	table.insert(views, RoomViewUI.New())

	return views
end

function RoomViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = RoomController.instance:isObMode() and NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.RoomOb) or RoomController.instance:isEditMode() and NavigateButtonsView.New({
			true,
			false,
			false
		}) or RoomController.instance:isVisitMode() and NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.RoomOb) or RoomController.instance:isFishingMode() and NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.RoomFishing) or NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local roomWaterReformScrollView = self:buildRoomWaterReformScrollViews()
		local roomWaterReformMultiView = MultiView.New({
			RoomWaterReformView.New(),
			roomWaterReformScrollView
		})

		return {
			RoomBackBlockView.New(),
			roomWaterReformMultiView
		}
	elseif tabContainerId == 3 then
		return {
			RoomViewConfirm.New()
		}
	elseif tabContainerId == 4 then
		return {
			RoomLayoutVisitPlan.New()
		}
	elseif tabContainerId == 5 then
		local roomFishingFriendScrollView = self:buildRoomFishingFriendScrollViews()
		local roomFishingMultiView = MultiView.New({
			RoomFishingView.New(),
			roomFishingFriendScrollView
		})

		return {
			roomFishingMultiView
		}
	end
end

function RoomViewContainer:buildRoomWaterReformScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_bottom/#go_blockContent/layout/scroll_block"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_bottom/#go_blockContent/#go_item"
	scrollParam.cellClass = RoomWaterReformItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 231
	scrollParam.cellSpaceH = 0.5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5

	return (LuaListScrollView.New(RoomWaterReformListModel.instance, scrollParam))
end

function RoomViewContainer:buildRoomFishingFriendScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Root/Left/FriendList/#go_Expand/ScrollView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Root/Left/FriendList/#go_Expand/ScrollView/Viewport/Content/#go_Item"
	scrollParam.cellClass = RoomFishingFriendItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 530
	scrollParam.cellHeight = 120
	scrollParam.cellSpaceV = -4
	scrollParam.startSpace = 5
	scrollParam.emptyScrollParam = EmptyScrollParam.New()

	scrollParam.emptyScrollParam:setFromView("Root/Left/FriendList/#go_Expand/#go_empty")

	return (LuaListScrollView.New(FishingFriendListModel.instance, scrollParam))
end

function RoomViewContainer:onContainerOpenFinish()
	self._navigateButtonsView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self._navigateButtonsView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)

	if RoomController.instance:isEditMode() then
		local defaultBuildingResType
		local isJumpBuildingView = ManufactureModel.instance:getIsJump2ManufactureBuildingList()
		local isJumpTransportSite = RoomTransportPathModel.instance:getisJumpTransportSite()

		RoomTransportPathModel.instance:setIsJumpTransportSite()
		ManufactureModel.instance:setIsJump2ManufactureBuildingList()
		ViewMgr.instance:openView(ViewName.RoomInventorySelectView, {
			defaultBuildingResType = (isJumpBuildingView or nil) and RoomBuildingEnum.BuildingListViewResTabType.Produce,
			isJumpTransportSite = isJumpTransportSite
		})
	end

	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomOb)
	end

	if RoomController.instance:isEditMode() then
		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomManufacture)
	end
end

function RoomViewContainer:_overrideCloseFunc()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if scene.camera:isTweening() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)

		return
	end

	if self:shouldShowUI() then
		return
	end

	local targetState = RoomEnum.CameraState.Overlook
	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		targetState = RoomEnum.CameraState.OverlookAll
	end

	if scene.camera:getCameraState() ~= targetState then
		scene.camera:switchCameraState(targetState, {})

		return
	end

	RoomController.instance:exitRoom()
end

function RoomViewContainer:_overrideHelpFunc()
	ViewMgr.instance:openView(ViewName.HelpPageTabView)
end

function RoomViewContainer:_onEscape()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		if self:shouldShowUI() then
			return
		end

		if RoomBuildingController.instance:isBuildingListShow() then
			RoomBuildingController.instance:setBuildingListShow(false)
		elseif RoomDebugController.instance:isDebugPlaceListShow() then
			RoomDebugController.instance:setDebugPlaceListShow(false)
		elseif RoomDebugController.instance:isDebugPackageListShow() then
			RoomDebugController.instance:setDebugPackageListShow(false)
		elseif RoomDebugController.instance:isDebugBuildingListShow() then
			RoomDebugController.instance:setDebugBuildingListShow(false)
		elseif RoomCharacterController.instance:isCharacterListShow() then
			RoomCharacterController.instance:setCharacterListShow(false)
		end
	end
end

function RoomViewContainer:shouldShowUI()
	local isUIHide = RoomMapController.instance:isUIHide()

	if isUIHide then
		RoomMapController.instance:setUIHide(false)

		return true
	end

	return false
end

function RoomViewContainer:setNavigateButtonShow(isShow)
	if isShow then
		NavigateMgr.instance:removeEscape(ViewName.RoomView)

		if RoomController.instance:isObMode() then
			self._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif RoomController.instance:isEditMode() then
			self._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomManufacture)
		elseif RoomController.instance:isVisitMode() then
			self._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif FishingModel.instance:isInFishing() then
			self._navigateButtonsView:setParam({
				true,
				true,
				true
			})
			self._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomFishing)
		else
			self._navigateButtonsView:setParam({
				true,
				false,
				false
			})
		end
	else
		NavigateMgr.instance:addEscape(ViewName.RoomView, self._onEscape, self)
		self._navigateButtonsView:setParam({
			false,
			false,
			false
		})
	end
end

function RoomViewContainer:selectBlockOpTab(tabIndex)
	if not tabIndex then
		return
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex)
end

return RoomViewContainer
