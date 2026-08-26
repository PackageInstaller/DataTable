-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionSetNextStepGOPath.lua

module("modules.logic.guide.controller.action.impl.GuideActionSetNextStepGOPath", package.seeall)

local GuideActionSetNextStepGOPath = class("GuideActionSetNextStepGOPath", BaseGuideAction)

function GuideActionSetNextStepGOPath:ctor(guideId, stepId, actionParam)
	GuideActionSetNextStepGOPath.super.ctor(self, guideId, stepId, actionParam)

	local temp = string.split(actionParam, "#")

	self._funcName = temp[1]

	table.remove(temp, 1)

	self._params = temp
end

function GuideActionSetNextStepGOPath:onStart(context)
	GuideActionSetNextStepGOPath.super.onStart(self, context)

	local func = self[self._funcName]
	local goPath = func(self, self._params)

	if not string.nilorempty(goPath) then
		GuideModel.instance:setNextStepGOPath(self.guideId, self.stepId, goPath)
	end

	self:onDone(true)
end

function GuideActionSetNextStepGOPath:getCritterMood(params)
	local mood = tonumber(params[1])
	local list = ManufactureModel.instance:getAllPlacedManufactureBuilding()
	local goPath

	if list then
		local focusIndex

		for i, v in ipairs(list) do
			local count = v:getCanPlaceCritterCount()

			if count > 0 then
				for slot = 1, count do
					local uid = v:getWorkingCritter(slot - 1)

					if uid then
						local critterMO = CritterModel.instance:getById(uid)

						if mood >= critterMO:getMoodValue() then
							focusIndex = i
							goPath = string.format("UIRoot/POPUP_TOP/RoomOverView/#go_subView/roommanufactureoverview(Clone)/centerArea/#go_building/#scroll_building/viewport/content/%s/critterInfo/id-%s_i-%s", i, slot - 1, slot)
						end
					end
				end
			end

			if focusIndex then
				break
			end
		end

		ManufactureController.instance:dispatchEvent(ManufactureEvent.GuideFocusCritter, focusIndex)
	end

	return goPath
end

function GuideActionSetNextStepGOPath:roomBuilding(params)
	local buildingId = tonumber(params[1])

	if buildingId then
		local buildingList = RoomMapBuildingModel.instance:getBuildingMOList()

		for _, buildingMO in ipairs(buildingList) do
			if buildingMO.buildingId == buildingId then
				local scene = GameSceneMgr.instance:getCurScene()

				if scene.buildingmgr then
					local entity = scene.buildingmgr:getBuildingEntity(buildingMO.id, SceneTag.RoomBuilding)

					return entity and SLFramework.GameObjectHelper.GetPath(entity.go)
				end
			end
		end
	else
		logError("设置下一步骤GameObject路径，但建筑id未配置 " .. self.guideId .. "_" .. self.stepId)
	end
end

function GuideActionSetNextStepGOPath:findTalentFirstChess()
	local container = ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView)

	if not container then
		return
	end

	local viewGo = container.viewGO
	local chessContainer = gohelper.findChild(viewGo, "chessboard/#go_chessContainer")

	if not chessContainer then
		return
	end

	local child = chessContainer.transform:GetChild(0)

	if not child then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(child.gameObject)
end

function GuideActionSetNextStepGOPath:getEquipChapterItem()
	local s1 = "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem"
	local s2 = "/anim/#btn_click"

	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return s1 .. "1" .. s2
	else
		local resList = DungeonChapterListModel.getChapterListByType(false, true, false, nil)

		return s1 .. tostring(#resList) .. s2
	end
end

function GuideActionSetNextStepGOPath:getRemainStarsElement()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()
	local battleInfos = mapInfo.battleInfos
	local battleId

	for i, v in ipairs(battleInfos) do
		if v.star ~= 2 then
			battleId = v.battleId

			break
		end
	end

	if not battleId then
		return
	end

	local elementInfos = mapInfo.elementInfos
	local elementInfo

	for i, v in ipairs(elementInfos) do
		if v:getType() == WeekWalkEnum.ElementType.Battle and v:getBattleId() == battleId then
			elementInfo = v

			break
		end
	end

	local battleInfo = mapInfo:getBattleInfo(battleId)

	if battleInfo.index == 5 then
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1_red(Clone)", mapInfo.id, elementInfo.elementId)
	else
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1(Clone)", mapInfo.id, elementInfo.elementId)
	end
end

function GuideActionSetNextStepGOPath:getEquipPool()
	local list = SummonMainModel.getValidPools()

	for i, v in ipairs(list) do
		if v.id == 10001 then
			return (string.format("UIRoot/POPUP_TOP/SummonADView/#go_ui/#go_category/#scroll_category/Viewport/Content/tabitem_%s/#btn_self", i))
		end
	end
end

function GuideActionSetNextStepGOPath:getRoomCharacterPlace1()
	GuideActionSetNextStepGOPath.RoomCharacterPlace1 = nil

	local list = RoomCharacterPlaceListModel.instance:getList()
	local first = list[1]
	local heroId = first.heroId
	local skinId = first.skinId
	local bestParam = RoomCharacterHelper.getRecommendHexPoint(heroId, skinId)

	if bestParam then
		local nearParam = RoomCharacterHelper.getGuideRecommendHexPoint(heroId, skinId, bestParam.hexPoint)

		if nearParam then
			local blockMO = RoomMapBlockModel.instance:getBlockMO(nearParam.hexPoint.x, nearParam.hexPoint.y)
			local blockEntity = GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if blockEntity then
				GuideActionSetNextStepGOPath.RoomCharacterPlace1 = SLFramework.GameObjectHelper.GetPath(blockEntity.go)

				return GuideActionSetNextStepGOPath.RoomCharacterPlace1
			end
		end
	end

	return "no block"
end

function GuideActionSetNextStepGOPath:getRoomCharacterPlace2()
	if GuideActionSetNextStepGOPath.RoomCharacterPlace1 then
		return GuideActionSetNextStepGOPath.RoomCharacterPlace1
	end

	local list = RoomCharacterPlaceListModel.instance:getList()
	local first = list[1]
	local heroId = first.heroId
	local skinId = first.skinId
	local bestParam = RoomCharacterHelper.getRecommendHexPoint(heroId, skinId)

	if bestParam then
		local blockMO = RoomMapBlockModel.instance:getBlockMO(bestParam.hexPoint.x, bestParam.hexPoint.y)
		local blockEntity = GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

		if blockEntity then
			return SLFramework.GameObjectHelper.GetPath(blockEntity.go)
		end
	end

	return GuideActionSetNextStepGOPath:getRoomCharacterPlace1()
end

function GuideActionSetNextStepGOPath:getMoveHeroPath()
	local index = HeroGroupEditListModel.instance:getMoveHeroIndex() or 1

	return string.format("UIRoot/POPUP_TOP/HeroGroupEditView/#go_rolecontainer/#scroll_card/scrollcontent/cell%s/prefabInst/hero/commonheroitemnew(Clone)", index - 1)
end

function GuideActionSetNextStepGOPath:getConnectPuzzlePipeEntry()
	local x = DungeonPuzzlePipeModel.instance._connectEntryX
	local y = DungeonPuzzlePipeModel.instance._connectEntryY

	return string.format("UIRoot/POPUP_TOP/DungeonPuzzlePipeView/#go_connect/%s_%s", x, y)
end

function GuideActionSetNextStepGOPath:getMainSceneSkinItem()
	local index = MainSceneSwitchListModel.instance:getFirstUnlockSceneIndex()

	return string.format("UIRoot/POPUP_TOP/MainSwitchView/#go_container/mainswitchclassifyview(Clone)/root/mainsceneswitchnewview(Clone)/right/mask/#scroll_card/scrollcontent/cell%s/prefabInst", index - 1)
end

function GuideActionSetNextStepGOPath:getMainSceneBgmObj()
	local resName = MainSceneSwitchModel.instance:getCurSceneResName()

	return string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Obj/s01_obj_b", resName)
end

function GuideActionSetNextStepGOPath:getFirstNoneExpEquip()
	local list = CharacterBackpackEquipListModel.instance:getList()
	local index = 1

	for i, v in ipairs(list) do
		local config = v.config

		if config and config.isExpEquip ~= 1 and config.isSpRefine ~= 1 then
			index = i

			break
		end
	end

	return string.format("UIRoot/POPUP_TOP/BackpackView/#go_container/characterbackpackequipview(Clone)/#scroll_equip/viewport/scrollcontent/cell%s/prefabInst", index - 1)
end

function GuideActionSetNextStepGOPath:getRoomResFbChapter()
	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem4/anim/#btn_click"
	else
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem3/anim/#btn_click"
	end
end

function GuideActionSetNextStepGOPath:getSpecificCardPath()
	local specificCardIdx = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightSetSpecificCardIndex)

	return string.format("UIRoot/HUD/FightView/root/handcards/handcards/cardItem%s", specificCardIdx or 1)
end

function GuideActionSetNextStepGOPath:getPlayerSoliderChessPath()
	local allEntity = TeamChessUnitEntityMgr.instance:getAllEntity()

	if allEntity then
		for i = 1, #allEntity do
			local entity = allEntity[i]
			local uid = entity._unitMo:getUid()

			if uid > 0 then
				return string.format("cameraroot/SceneRoot/EliminateSceneView/Unit/%s", uid)
			end
		end
	end
end

function GuideActionSetNextStepGOPath:getAct178OperHolePath(params)
	local index = PinballModel.instance.guideHole

	return string.format("UIRoot/POPUP_TOP/PinballCityView/#go_buildingui/UI_%s%s", index, (type(params) == "table" or nil) and table.concat(params, "#"))
end

function GuideActionSetNextStepGOPath:findSurvivalSpBlockPath()
	if not SurvivalMapModel.instance.guideSpBlockPos then
		return ""
	end

	local pos = SurvivalMapModel.instance.guideSpBlockPos
	local posV3 = Vector3.New(SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r))

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, posV3, 0.3)

	return string.format("cameraroot/SceneRoot/SurvivalScene/SPBlockRoot/%s", tostring(pos))
end

function GuideActionSetNextStepGOPath:getBossTowerFirstBossPath()
	local bossOpenMOList = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #bossOpenMOList > 1 then
		table.sort(bossOpenMOList, TowerAssistBossModel.sortBossList)
	end

	if bossOpenMOList[1] then
		if not bossOpenMOList[1].id then
			local firstBossId = 1

			return string.format("UIRoot/POPUP_TOP/TowerBossSelectView/root/#scroll_boss/Viewport/#go_bossContent/boss%s/towerbossselectitem(Clone)/click", firstBossId)
		end
	end
end

function GuideActionSetNextStepGOPath:getNecrologistStoryLastItemPath()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.NecrologistStoryView)

	if not viewContainer then
		return
	end

	local lastItem = viewContainer:getLastItem()

	if not lastItem then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(lastItem.viewGO)
end

function GuideActionSetNextStepGOPath:getNecrologistStoryLastLinkTextPath()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.NecrologistStoryView)

	if not viewContainer then
		return
	end

	local lastItem = viewContainer:getLastItem()

	if not lastItem then
		return
	end

	local linkGO = lastItem:getLinkRectGO()

	if not linkGO then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(linkGO)
end

function GuideActionSetNextStepGOPath:getNecrologistStoryLastMagicPath()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.NecrologistStoryView)

	if not viewContainer then
		return
	end

	local lastItem = viewContainer:getLastItem()

	if not lastItem then
		return
	end

	local go = gohelper.findChild(lastItem.viewGO, "root/#btn_zhouyu")

	if not go then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(go)
end

function GuideActionSetNextStepGOPath:getNecrologistStoryBranchPath()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.NecrologistStoryReviewView)

	if not viewContainer then
		return
	end

	local item = viewContainer:getBranchItem()

	if not item then
		return
	end

	local go = item.goBranch

	if not go then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(go)
end

function GuideActionSetNextStepGOPath:getRouge2FirstNodePath()
	local sceneType = GameSceneMgr.instance:getCurSceneType()
	local sceneComp = GameSceneMgr.instance:getScene(SceneType.Rouge2)
	local isNormalLayer = Rouge2_MapModel.instance:isNormalLayer()
	local mapContainer = ViewMgr.instance:getContainer(ViewName.Rouge2_MapView)

	if sceneType ~= SceneType.Rouge2 or not sceneComp or not isNormalLayer or not mapContainer then
		return
	end

	if sceneComp.map then
		local mapComp = sceneComp.map:getMapComp()
		local nodeDict = Rouge2_MapModel.instance:getNodeDict()
		local focusNode

		for _, nodeMo in pairs(nodeDict or {}) do
			local arriveStatus = nodeMo.arriveStatus
			local isNormalNode = nodeMo:checkIsNormal()
			local canArrive = arriveStatus == Rouge2_MapEnum.Arrive.CanArrive or arriveStatus == Rouge2_MapEnum.Arrive.ArrivingNotFinish

			if isNormalNode and canArrive then
				focusNode = nodeMo

				break
			end
		end

		if not focusNode then
			logError("肉鸽路线层找不到可以到达的节点")

			return
		end

		local nodeId = focusNode and focusNode.nodeId
		local nodeItem = mapComp and mapComp:getMapItem(nodeId)
		local iconGO = nodeItem and nodeItem:getIconGO()

		if not iconGO then
			return
		end

		local goFullScreen = gohelper.findChild(mapContainer.viewGO, "#go_guide_click")

		if gohelper.isNil(goFullScreen) then
			logError("肉鸽地图点击响应节点不存在")

			return
		end

		local tempGuideGO = goFullScreen
		local iconPosX, iconPosY = recthelper.worldPosToAnchorPos2(iconGO.transform.position, mapContainer.viewGO.transform)

		recthelper.setAnchor(tempGuideGO.transform, iconPosX, iconPosY)

		return SLFramework.GameObjectHelper.GetPath(tempGuideGO)
	end
end

function GuideActionSetNextStepGOPath:getRouge2CanActiveTalent()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.Rouge2_BackpackTabView)
	local skillTabView = viewContainer and viewContainer:getTabViewByTabType(Rouge2_Enum.BagTabType.ActiveSkill)
	local talentView = skillTabView and skillTabView:getView(Rouge2_BackpackSkillRootView.ViewType.TalentTree)

	if not talentView then
		return
	end

	local newUnlockTalentId = Rouge2_BackpackController.instance:getNewUnlockTalentId()

	if not newUnlockTalentId then
		return
	end

	local talentItem = talentView:getTalentItemById(newUnlockTalentId)
	local goClick = talentItem and talentItem:getClickGO()

	if not goClick then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(goClick)
end

function GuideActionSetNextStepGOPath:getAbyssCanClickStagePath()
	local actId = AbyssModel.instance:getCurActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return
	end

	local info = AbyssModel.instance:getInfoMo(actId)

	if info.stageInfoList and next(info.stageInfoList) then
		for _, stageInfo in ipairs(info.stageInfoList) do
			if stageInfo:isChallenged() and stageInfo.star > 0 then
				return string.format("UIRoot/POPUP_TOP/AbyssMainView/#go_clipNode/clip%s/#btn_click", stageInfo.stageId)
			end
		end
	end
end

function GuideActionSetNextStepGOPath:getAbyssCanResetStagePath()
	local actId = AbyssModel.instance:getCurActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return
	end

	local info = AbyssModel.instance:getInfoMo(actId)

	if info.stageInfoList and next(info.stageInfoList) then
		for _, stageInfo in ipairs(info.stageInfoList) do
			if stageInfo:isChallenged() and stageInfo.star > 0 then
				return string.format("UIRoot/POPUP_TOP/AbyssStageDetailsView/Left/#scroll_herogroup/Viewport/Content/%s/#btn_reset", stageInfo.stageId)
			end
		end
	end
end

function GuideActionSetNextStepGOPath:getV3a8DianJiShiMapAreaTagPath()
	return (DianJiShiGameModel.instance:getLastUpdateAreaTagPath())
end

function GuideActionSetNextStepGOPath:getAtomicDungeonEmergencyElementPath()
	local isOpen = AtomicDungeonController.instance:isUnlockDungeon()

	if not isOpen then
		return
	end

	local elementCo = AtomicDungeonModel.instance:getCurMapEmergencyElement()

	if not elementCo then
		return
	end

	return string.format("UIRoot/POPUP_TOP/AtomicDungeonMainView/root/#go_elementClickRoot/%s/btn_click", elementCo.id)
end

return GuideActionSetNextStepGOPath
