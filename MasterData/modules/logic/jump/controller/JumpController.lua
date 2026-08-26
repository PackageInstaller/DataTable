-- chunkname: @modules/logic/jump/controller/JumpController.lua

module("modules.logic.jump.controller.JumpController", package.seeall)

local JumpController = class("JumpController", BaseController)

function JumpController:onInit()
	JumpControllerCanJumpFunc.activateCanJumpFuncController()
	JumpControllerHandleFunc.activateHandleFuncController()

	self.isInitLogicDefine = false
end

function JumpController:onInitFinish()
	return
end

function JumpController:clear()
	self.waitOpenViewNames = nil
	self.remainViewNames = nil
	self.closeViewNames = nil
	self._callback = nil
	self._callbackObj = nil
	self.jumpStage = JumpEnum.JumpStage.None
end

function JumpController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
end

function JumpController:reInit()
	self:clear()
end

function JumpController:initLogicDefine()
	if self.isInitLogicDefine then
		return
	end

	self:initJumpViewBelongScene()

	self.isInitLogicDefine = true
end

function JumpController:initJumpViewBelongScene()
	self.jumpViewBelongScene = {
		[JumpEnum.JumpView.StoreView] = {
			SceneType.Main,
			SceneType.Room
		},
		[JumpEnum.JumpView.RoomProductLineView] = {
			SceneType.Main,
			SceneType.Room
		},
		[JumpEnum.JumpView.DungeonViewWithChapter] = SceneType.Main,
		[JumpEnum.JumpView.DungeonViewWithEpisode] = SceneType.Main,
		[JumpEnum.JumpView.DungeonViewWithType] = SceneType.Main,
		[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = SceneType.Main,
		[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = SceneType.Main,
		[JumpEnum.JumpView.HeroGroupView] = SceneType.Main,
		[JumpEnum.JumpView.BackpackView] = SceneType.Main,
		[JumpEnum.JumpView.PlayerClothView] = SceneType.Main,
		[JumpEnum.JumpView.MainView] = SceneType.Main,
		[JumpEnum.JumpView.TaskView] = SceneType.Main,
		[JumpEnum.JumpView.TeachNoteView] = SceneType.Main,
		[JumpEnum.JumpView.HandbookView] = SceneType.Main,
		[JumpEnum.JumpView.SocialView] = SceneType.Main,
		[JumpEnum.JumpView.NoticeView] = SceneType.Main,
		[JumpEnum.JumpView.SignInView] = SceneType.Main,
		[JumpEnum.JumpView.SignInViewWithBirthDay] = SceneType.Main,
		[JumpEnum.JumpView.SeasonMainView] = SceneType.Main,
		[JumpEnum.JumpView.EquipView] = SceneType.Main,
		[JumpEnum.JumpView.BpView] = SceneType.Main,
		[JumpEnum.JumpView.Show] = SceneType.Main,
		[JumpEnum.JumpView.ActivityView] = SceneType.Main,
		[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = SceneType.Main,
		[JumpEnum.JumpView.SummonView] = SceneType.Main,
		[JumpEnum.JumpView.V1a5Dungeon] = SceneType.Main,
		[JumpEnum.JumpView.RoomView] = SceneType.Room,
		[JumpEnum.JumpView.RoomFishing] = SceneType.Room,
		[JumpEnum.JumpView.PushBox] = SceneType.PushBox,
		[JumpEnum.JumpView.ShelterBuilding] = SceneType.SurvivalShelter
	}
end

function JumpController:_onOpenView(viewName)
	if self.jumpStage ~= JumpEnum.JumpStage.Jumping then
		return
	end

	if not self.canDispatchCallback then
		return
	end

	if self.waitOpenViewNames and tabletool.indexOf(self.waitOpenViewNames, viewName) then
		tabletool.removeValue(self.waitOpenViewNames, viewName)
	end

	self:dispatchCallback()
end

function JumpController:checkJumpDone()
	return not self.waitOpenViewNames or not next(self.waitOpenViewNames)
end

function JumpController:dispatchCallback()
	if not self:checkJumpDone() then
		return
	end

	if self._callback then
		self._callback(self._callbackObj)
	end

	self:reInit()
end

function JumpController:jump(jumpId, callback, callbackObj, recordFarmItem)
	if not LoginController.instance:isEnteredGame() then
		return false
	end

	jumpId = tonumber(jumpId)

	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if jumpConfig then
		if not self:isJumpOpen(jumpId) then
			local toast, paramList = OpenHelper.getToastIdAndParam(jumpConfig.openId)

			if toast then
				GameFacade.showToastWithTableParam(toast, paramList)
			end

			return false
		else
			local canJump, toastId, toastParamList = self:canJumpNew(jumpConfig.param)

			if not canJump then
				GameFacade.showToastWithTableParam(toastId, toastParamList)

				return false
			end
		end

		local jumpParam = jumpConfig.param
		local jumpResult = self:jumpTo(jumpParam, callback, callbackObj, recordFarmItem)

		return jumpResult == JumpEnum.JumpResult.Success
	end

	return false
end

function JumpController:jumpByAdditionParam(additionParam, callback, callbackObj, recordFarmItem)
	local paramsList = string.split(additionParam, "#")
	local jumpId = tonumber(paramsList[1])
	local _additionParam = ""

	for i = 2, #paramsList do
		_additionParam = string.format("%s#%s", _additionParam, paramsList[i])
	end

	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if jumpConfig then
		if not self:isJumpOpen(jumpId) then
			local toast, toastParamList = OpenHelper.getToastIdAndParam(jumpConfig.openId)

			if toast then
				GameFacade.showToastWithTableParam(toast, toastParamList)
			end

			return false
		else
			local canJump, toastId, toastParamList = self:canJumpNew(jumpConfig.param)

			if not canJump then
				GameFacade.showToastWithTableParam(toastId, toastParamList)

				return false
			end
		end

		local jumpParam = jumpConfig.param

		jumpParam = string.format("%s%s", jumpParam, _additionParam)

		local jumpResult = self:jumpTo(jumpParam, callback, callbackObj, recordFarmItem)

		return jumpResult == JumpEnum.JumpResult.Success
	end

	return false
end

function JumpController:jumpByParamWithCondition(jumpParam, callback, callbackObj, recordFarmItem)
	local canJump, toastId, toastParamList = self:canJumpNew(jumpParam)

	if not canJump then
		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return false
	end

	local jumpResult = self:jumpTo(jumpParam, callback, callbackObj, recordFarmItem)

	return jumpResult == JumpEnum.JumpResult.Success
end

function JumpController:jumpByParam(jumpParam)
	self:jumpTo(jumpParam)
end

local _notAllowJumpViewNames = {
	"PartyGameLobbyMainView",
	"ActivityDoubleFestivalSignPaiLianView_1_3",
	"ActivityStarLightSignPart1PaiLianView_1_3",
	"ActivityStarLightSignPart2PaiLianView_1_3",
	"V1a4_Role_PanelSignView_Part1",
	"V1a4_Role_PanelSignView_Part2",
	"V1a5_Role_PanelSignView_Part1",
	"V1a5_Role_PanelSignView_Part2",
	"V1a6_Role_PanelSignView_Part1",
	"V1a6_Role_PanelSignView_Part2",
	"V1a5_DoubleFestival_PanelSignView",
	"V1a6_Spring_PanelSignView",
	"V1a7_Role_PanelSignView_Part1",
	"V1a7_Role_PanelSignView_Part2",
	"LanternFestivalView",
	"V1a8_Role_PanelSignView_Part1",
	"V1a8_Role_PanelSignView_Part2",
	"V1a8_Work_PanelSignView",
	"V1a9_Role_PanelSignView_Part1",
	"V1a9_Role_PanelSignView_Part2",
	"DragonBoatFestivalView",
	"V1a9_AnniversarySign_PanelSignView",
	"V2a0_SummerSign_PanelView",
	"V2a0_Role_PanelSignView_Part1",
	"V2a0_Role_PanelSignView_Part2",
	"V2a1_Role_PanelSignView_Part1",
	"V2a1_Role_PanelSignView_Part2",
	"V2a1_MoonFestival_PanelView",
	"V2a2_Role_PanelSignView_Part1",
	"V2a2_Role_PanelSignView_Part2",
	"V2a2_RedLeafFestival_PanelView",
	"V2a3_Role_PanelSignView_Part1",
	"V2a3_Role_PanelSignView_Part2",
	"V2a3_Special_PanelsView",
	"V2a4_Role_PanelSignView_Part1",
	"V2a4_Role_PanelSignView_Part2",
	"V2a5_Role_PanelSignView_Part1",
	"V2a5_Role_PanelSignView_Part2",
	"V2a7_Labor_PanelSignView",
	"V2a9_VersionSummonPanel_Part1",
	"V2a9_VersionSummonPanel_Part2",
	"V2a9_FreeMonthCard_PanelView",
	"V3a0_SummerSign_PanelView",
	"RoomFormulaMsgBoxView",
	"V3a1_AutumnSign_PanelView"
}

function JumpController:checkCanJumpView(jumpView)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) and (ViewMgr.instance:isOpen(ViewName.MaterialTipView) or ViewMgr.instance:isOpen(ViewName.RoomMaterialTipView)) or ViewMgr.instance:isOpen(ViewName.BpPropView) and (ViewMgr.instance:isOpen(ViewName.MaterialTipView) or ViewMgr.instance:isOpen(ViewName.RoomMaterialTipView)) or ViewMgr.instance:isOpen(ViewName.BpPropView2) or ViewMgr.instance:isOpen(ViewName.FightSuccView) then
		return false, ToastEnum.MaterialTipJump
	end

	if VirtualSummonScene.instance:isOpen() and jumpView ~= JumpEnum.JumpView.StoreView then
		return false, ToastEnum.MaterialTipJump
	end

	self:_notAllowJumpViewNames_RoleSignPanelView()
	self:_notAllowJumpViewNames_SpecialSignPanelView()

	for _, name in ipairs(_notAllowJumpViewNames) do
		local viewName = ViewName[name]

		if ViewMgr.instance:isOpen(viewName) then
			return false, ToastEnum.MaterialTipJump
		end
	end

	return true, nil
end

function JumpController:jumpTo(jumpParam, callback, callbackObj, recordFarmItem)
	self:dispatchEvent(JumpEvent.BeforeJump, jumpParam)
	self:initLogicDefine()

	if string.nilorempty(jumpParam) then
		logError("跳转参数为空")

		return JumpEnum.JumpResult.Fail
	end

	self.jumpStage = JumpEnum.JumpStage.Jumping

	local jumps = string.splitToNumber(jumpParam, "#")
	local jumpView = jumps[1]
	local checkViewResult, toastId = self:checkCanJumpView(jumpView)

	if not checkViewResult then
		if toastId then
			GameFacade.showToast(toastId)
		end

		return checkViewResult
	end

	if self:_checkNeedSwitchScene(jumpView) then
		DungeonModel.instance.curSendEpisodeId = nil

		ViewMgr.instance:closeAllPopupViews()

		local jumpViewDefaultScene = self:_getJumpViewDefaultScene(jumpView)

		if jumpViewDefaultScene == SceneType.Main then
			MainController.instance:enterMainScene(true)
		elseif jumpViewDefaultScene == SceneType.Room then
			RoomController.instance:enterRoom((jumpView == JumpEnum.JumpView.RoomFishing or nil) and RoomEnum.GameMode.Fishing, nil, nil, nil, nil, true)
		elseif jumpViewDefaultScene == SceneType.PushBox then
			PushBoxController.instance:enterPushBoxGame()
		else
			jumpViewDefaultScene = SceneType.Main

			MainController.instance:enterMainScene()
		end

		ViewMgr.instance:closeAllPopupViews()
		SceneHelper.instance:waitSceneDone(jumpViewDefaultScene, function()
			self:jumpTo(jumpParam, callback, callbackObj, recordFarmItem)
		end)

		return JumpEnum.JumpResult.Success
	end

	JumpModel.instance:setRecordFarmItem(recordFarmItem)

	self._callback = callback
	self._callbackObj = callbackObj
	self.waitOpenViewNames = {}
	self.remainViewNames = {}
	self.closeViewNames = {}

	local jumpToHandleFunc = JumpController.JumpViewToHandleFunc[jumpView]

	if not jumpToHandleFunc then
		logError("跳转参数错误: " .. jumpParam)
		self:reInit()

		return JumpEnum.JumpResult.Fail
	end

	self.canDispatchCallback = false

	local jumpResult = jumpToHandleFunc(self, jumpParam)

	self.canDispatchCallback = true

	if jumpResult ~= JumpEnum.JumpResult.Success then
		self:reInit()

		return jumpResult
	end

	table.insert(self.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(self.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(self.closeViewNames, ViewName.HeroGroupEditView)
	table.insert(self.closeViewNames, ViewName.VersionActivity_1_2_HeroGroupEditView)
	table.insert(self.closeViewNames, ViewName.PlayerClothView)
	table.insert(self.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.VersionActivityDungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.GiftMultipleChoiceView)
	table.insert(self.closeViewNames, ViewName.DungeonCumulativeRewardsView)
	table.insert(self.closeViewNames, ViewName.DungeonCumulativeRewardPackView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(self.closeViewNames, ViewName.WeekWalkRewardView)
	table.insert(self.closeViewNames, ViewName.MaterialTipView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5RevivalTaskView)
	self:_closeModelViews(self.remainViewNames)
	self:_closeViews(self.closeViewNames, self.remainViewNames)
	self:removeOpenedView()
	self:dispatchCallback()

	return jumpResult
end

function JumpController:_checkNeedSwitchScene(jumpView)
	local currentScene = GameSceneMgr.instance:getCurSceneType()

	if not self.jumpViewBelongScene[jumpView] then
		local jumpViewBelongScene = SceneType.Main

		if type(jumpViewBelongScene) == "table" then
			return not tabletool.indexOf(jumpViewBelongScene, currentScene)
		end

		return currentScene ~= jumpViewBelongScene
	end
end

function JumpController:_getJumpViewDefaultScene(jumpView)
	if not self.jumpViewBelongScene[jumpView] then
		if type(self.jumpViewBelongScene[jumpView]) == "table" then
			return (self.jumpViewBelongScene[jumpView] or nil) and (self.jumpViewBelongScene[jumpView][1] or SceneType.Main)
		end

		return self.jumpViewBelongScene[jumpView]
	end
end

function JumpController:removeOpenedView()
	for i = #self.waitOpenViewNames, 1, -1 do
		if ViewMgr.instance:isOpen(self.waitOpenViewNames[i]) then
			table.remove(self.waitOpenViewNames, i)
		end
	end
end

function JumpController:cantJump(jumpParam)
	local jumps = string.split(jumpParam, "#")
	local jumpView = tonumber(jumps[1])
	local canJumpFunc = JumpController.JumpViewToCanJumpFunc[jumpView]

	canJumpFunc = canJumpFunc or JumpController.defaultCanJump

	local canJump, toastId, toastParamList = canJumpFunc(self, jumpParam)

	if canJump then
		return nil
	else
		return toastId, toastParamList
	end
end

function JumpController:canJumpNew(jumpParam)
	local jumps = string.split(jumpParam, "#")
	local jumpView = tonumber(jumps[1])
	local canJumpFunc = JumpController.JumpViewToCanJumpFunc[jumpView]

	canJumpFunc = canJumpFunc or JumpController.defaultCanJump

	local canJump, toastId, toastParamList = canJumpFunc(self, jumpParam)

	return canJump, toastId, toastParamList
end

function JumpController:_closeModelViews(remainViewNames)
	local willCloseViewNames = {}

	remainViewNames = remainViewNames or {}

	table.insert(remainViewNames, ViewName.ActivityNormalView)
	table.insert(remainViewNames, ViewName.SignInView)
	table.insert(remainViewNames, ViewName.MaterialTipView)
	table.insert(remainViewNames, ViewName.ActivityBeginnerView)

	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local popUpBlurGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local popUpFourGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewNameList) do
		local setting = ViewMgr.instance:getSetting(viewName)

		if (not remainViewNames or not tabletool.indexOf(remainViewNames, viewName)) and setting.layer == UILayerName.PopUpTop and setting.viewType == ViewType.Modal then
			local oneViewGO = ViewMgr.instance:getContainer(viewName).viewGO

			if oneViewGO and (oneViewGO.transform.parent == popUpTopGO.transform or oneViewGO.transform.parent == popUpBlurGO.transform or oneViewGO.transform.parent == popUpFourGO.transform) then
				table.insert(willCloseViewNames, viewName)
			end
		end
	end

	for i = 1, #willCloseViewNames do
		ViewMgr.instance:closeView(willCloseViewNames[i], true)
	end
end

function JumpController:_closeViews(closeViewNames, remainViewNames)
	local willCloseViewNames = {}

	for _, closeViewName in ipairs(closeViewNames) do
		if not tabletool.indexOf(remainViewNames, closeViewName) then
			table.insert(willCloseViewNames, closeViewName)
		end
	end

	for i, willCloseViewName in ipairs(willCloseViewNames) do
		ViewMgr.instance:closeView(willCloseViewName, true)
	end
end

function JumpController:isJumpOpen(jumpId)
	local config = JumpConfig.instance:getJumpConfig(jumpId)

	if config then
		local openId = config.openId

		if openId and openId ~= 0 then
			return OpenModel.instance:isFunctionUnlock(openId)
		end

		return true
	end

	return false
end

function JumpController:isOnlyShowJump(jumpId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if jumpConfig then
		local jumpParam = jumpConfig.param

		if string.nilorempty(jumpParam) then
			return true
		end

		local jumps = string.split(jumpParam, "#")
		local jumpView = tonumber(jumps[1])

		if jumpView == JumpEnum.JumpView.Show then
			return true
		end
	end

	return false
end

function JumpController:getCurrentOpenedView(excludeView)
	self.ignoreViewName = self.ignoreViewName or {
		[ViewName.RoomView] = true,
		[ViewName.ToastView] = true,
		[ViewName.MainView] = true,
		[ViewName.GMToolView] = true,
		[ViewName.DungeonView] = true,
		[ViewName.DungeonMapView] = true,
		[ViewName.DungeonMapLevelView] = true,
		[ViewName.DungeonMapLevelView] = true,
		[ViewName.HeroGroupFightView] = true,
		[ViewName.HeroGroupEditView] = true,
		[ViewName.VersionActivity_1_2_HeroGroupEditView] = true,
		[ViewName.MaterialTipView] = true,
		[SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.HeroGroupFightView)] = true,
		[Season123Controller.instance:getHeroGroupFightViewName()] = true,
		[Season123Controller.instance:getHeroGroupEditViewName()] = true,
		[ViewName.TowerHeroGroupFightView] = true,
		[ViewName.TowerDeepHeroGroupFightView] = true,
		[ViewName.CommandStationDispatchEventMainView] = true
	}

	local openedViewList = {}
	local openedViewTable, viewContainer

	for _, viewName in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if viewName ~= excludeView and not self.ignoreViewName[viewName] then
			openedViewTable = {
				viewName = viewName
			}
			viewContainer = ViewMgr.instance:getContainer(viewName)
			openedViewTable.viewParam = viewContainer.getCurrentViewParam and viewContainer:getCurrentViewParam() or viewContainer.viewParam

			table.insert(openedViewList, openedViewTable)
		end
	end

	return openedViewList
end

function JumpController.commonIconBeforeClickSetRecordItem(view, param, commonItemIcon)
	commonItemIcon:setRecordFarmItem({
		type = commonItemIcon._itemType,
		id = commonItemIcon._itemId,
		quantity = commonItemIcon._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

local s_RoleSignPanelView = false

function JumpController:_notAllowJumpViewNames_RoleSignPanelView()
	if s_RoleSignPanelView then
		return
	end

	s_RoleSignPanelView = true

	local view1 = GameBranchMgr.instance:Vxax_ViewName("Role_PanelSignView_Part1", ViewName.Role_PanelSignView_Part1)
	local view2 = GameBranchMgr.instance:Vxax_ViewName("Role_PanelSignView_Part2", ViewName.Role_PanelSignView_Part2)

	table.insert(_notAllowJumpViewNames, view1)
	table.insert(_notAllowJumpViewNames, view2)
end

local s_SpecialSignPanelView = false

function JumpController:_notAllowJumpViewNames_SpecialSignPanelView()
	if s_SpecialSignPanelView then
		return
	end

	s_SpecialSignPanelView = true

	local view = GameBranchMgr.instance:Vxax_ViewName("Special_PanelsView", ViewName.V2a3_Special_PanelsView)

	table.insert(_notAllowJumpViewNames, view)
end

JumpController.instance = JumpController.New()

return JumpController
