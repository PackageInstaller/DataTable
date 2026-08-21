-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/AdjustTeamTipsView.lua

module("logic.extensions.battle.viewcampadjustment.AdjustTeamTipsView", package.seeall)

local AdjustTeamTipsView = class("AdjustTeamTipsView", ViewComponent)
local kCurrentTeamId = -100
local kSaveDuration = 0.25

function AdjustTeamTipsView:ctor()
	self._teamData = nil
end

function AdjustTeamTipsView:buildUI()
	self._btnClose = self:getBtn("0&middle_tips_common_bg_-1205189576")
	self._btnBg = self:getBtn("middle_tips_common_bg_-1572128605")
	self._goTeamContent = self:getGo("adjust_team_tips_1433290819")
	self._gridLayoutGroup = self:getGo("adjust_team_tips_1433290819"):GetComponent(UIComponentType.GridLayoutGroup)
	self._scrollRect = self:getGo("adjust_team_tips_884751907"):GetComponent(UIComponentType.ScrollRect)
	self._teamScroll = Astral.ScrollRectLoop.Get(self:getGo("adjust_team_tips_884751907"))

	self._teamScroll:InitFix(kScrollDirV, 1087, 132, 0, 5, 1, self._onCellUpdate, self)
	self._teamScroll:SetCellsUpdateFinishHandler(self._onCellUpdateFinish, self)

	self._teamItemCollection = ViewlibCollection:create(ViewlibResPath.BattleTeamCellItem, 5)
	self._goCurTeamParent = self:getGo("adjust_team_tips_-1934959780")
	self._curTeamRect = self._goCurTeamParent:GetComponent(UIComponentType.RectTransform)
	self._curTeamItem = ViewlibUtil.getItem(ViewlibResPath.BattleTeamCellItem, self._goCurTeamParent)

	self._curTeamItem:setViewComponent(self)
	self._curTeamItem:setClickHandler(self)
	self._curTeamItem:setSelected(true)

	self._cellHeight = self._gridLayoutGroup.cellSize.y + self._gridLayoutGroup.spacing.y
	self._curTeamInitPos = self._curTeamRect.anchoredPosition
	self._lastTeamNum = 0
	self._saveAnimDuration = self._curTeamItem:getSaveAnimDuration()
end

function AdjustTeamTipsView:destroyUI()
	self._curTeamItem:destroy()
	self._teamItemCollection:clear()

	self._btnClose = nil
	self._teamScroll = nil
	self._teamItemList = nil
	self._curTeamItem = nil
	self._curTeamMO = nil
	self._teamItemCollection = nil
	self._lastTeamNum = nil
	self._teamData = nil
end

function AdjustTeamTipsView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
end

function AdjustTeamTipsView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function AdjustTeamTipsView:onEnter()
	self:_setEvent(true)

	self._isOpenView = true

	self._curTeamItem:changeButtonState(BattleTeamCellItem.State.SAVE)

	self._curTeamMO = {
		id = kCurrentTeamId,
		teamName = lang("tip_current_team"),
		roles = {}
	}

	self:_updateCurrentTeamView()
	self:_updateTeamView(false)
end

function AdjustTeamTipsView:onExit()
	self:_setEvent(false)

	self._isOpenView = false

	self._teamItemCollection:clearAllInstance()
end

function AdjustTeamTipsView:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_TEAM_INFO, self._onRefreshTeamInfo, self)
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._updateCurrentTeamView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_TEAM_INFO, self._onRefreshTeamInfo, self)
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._updateCurrentTeamView, self)
	end
end

function AdjustTeamTipsView:_onRefreshTeamInfo()
	self:_updateTeamView(true)
end

function AdjustTeamTipsView:_updateTeamView(isTeamInfoUpdate)
	local teamNum = TeamModel.instance:getTeamData():getMoCount()

	if teamNum > self._lastTeamNum and isTeamInfoUpdate then
		self._teamData = self:_createPreviousTeamData()

		self._curTeamItem:playSaveAnim()

		self._scrollRect.verticalNormalizedPosition = 1

		ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
		DG.Tweening.DOTween.Kill(self._goCurTeamParent)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:AppendInterval(0.4)
		sequence:AppendCallback(self._onBeginSaveTeam, self)
		sequence:AppendInterval(kSaveDuration)
		sequence:AppendCallback(self._onEndSaveTeam, self)
		sequence:SetTarget(self._goCurTeamParent)
	else
		self._teamData = TeamModel.instance:getTeamData()
		self._teamScroll.TotalCellNum = teamNum

		self:_onCellUpdateFinish()
	end

	self._lastTeamNum = teamNum
end

function AdjustTeamTipsView:_createPreviousTeamData()
	local teamData = TeamModel.instance:getTeamData()
	local previousTeamData = BaseListModel.New()

	for i, mo in ipairs(teamData:getMoList()) do
		if i ~= 1 then
			previousTeamData:addMo(mo)
		end
	end

	return previousTeamData
end

function AdjustTeamTipsView:_onBeginSaveTeam()
	self._scrollRect.enabled = false

	local tempVec2 = Vector2.New()

	tempVec2:Set(self._curTeamInitPos.x, self._curTeamInitPos.y - self._cellHeight)
	self._curTeamRect:DOAnchorPos(tempVec2, kSaveDuration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

	for i = 0, self._goTeamContent.transform.childCount - 1 do
		local itemRect = self._goTeamContent.transform:GetChild(i).gameObject:GetComponent(UIComponentType.RectTransform)
		local anchoredPos = itemRect.anchoredPosition

		tempVec2:Set(anchoredPos.x, anchoredPos.y - self._cellHeight)
		itemRect:DOAnchorPos(tempVec2, kSaveDuration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	end
end

function AdjustTeamTipsView:_onEndSaveTeam()
	self._curTeamRect:DOKill(true)

	for i = 0, self._goTeamContent.transform.childCount - 1 do
		self._goTeamContent.transform:GetChild(i).gameObject:GetComponent(UIComponentType.RectTransform):DOKill(true)
	end

	self._curTeamItem:stopSaveAnim()
	self._curTeamItem:setSelected(true)
	self._curTeamItem:resetPlaceHolder()
	self._curTeamItem:changeButtonState(BattleTeamCellItem.State.SAVE)
	RectTransformUtils.SetAnchoredPosition(self._curTeamRect, self._curTeamInitPos.x, self._curTeamInitPos.y)

	self._teamData = TeamModel.instance:getTeamData()
	self._scrollRect.enabled = true
	self._teamScroll.TotalCellNum = self._lastTeamNum

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
end

function AdjustTeamTipsView:_updateCurrentTeamView()
	local teamIdList = BattleCampAdjustmentModel.instance:getCurrentTeamCharacterCodeList()

	teamIdList = BattleCampAdjustmentUtil.getValidCharacterCodeList(teamIdList)

	table.clear(self._curTeamMO.roles)
	table.insertto(self._curTeamMO.roles, teamIdList)
	self._curTeamItem:setTeamMO(self._curTeamMO, true)
end

function AdjustTeamTipsView:_onCellUpdate(cellTransform, index, preIndex)
	if not self._isOpenView then
		return
	end

	index = index + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, "item")
	local teamItem

	if not itemGO then
		teamItem = self._teamItemCollection:createInstance(cellTransform.gameObject)
		teamItem.mainGO.name = "item"

		teamItem:setClickHandler(self)
		teamItem:setViewComponent(self)
	else
		teamItem = Astral.SimpleLuaComponentContainer.Get(itemGO, BattleTeamCellItem)
	end

	local teamMO = self._teamData:getMoByIndex(index)

	teamItem:changeButtonState(BattleTeamCellItem.State.BATTLE)
	teamItem:setTeamMO(teamMO, false)
end

function AdjustTeamTipsView:_onCellUpdateFinish()
	return
end

function AdjustTeamTipsView:_onClickClose()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_window_close, nil, nil, nil)
	self:close()
end

function AdjustTeamTipsView:onClickTeamCellSave(teamMO)
	if teamMO.teamName == lang("tip_current_team") then
		FloatWordMgr.instance:show(lang("tip_edit_team_name"))

		return
	end

	if teamMO.roles == nil or #teamMO.roles == 0 then
		FloatWordMgr.instance:show(lang("tip_battle_one_role"))

		return
	end

	local teamNumLimit = CharacterPreinstallConfig.instance:getConstCfg().TeamNumLimit.numValue

	if teamNumLimit <= TeamModel.instance:getTeamData():getMoCount() then
		FloatWordMgr.instance:show(lang("tip_max_team_limit"))

		return
	end

	local heroIdList = self._curTeamMO.roles

	TeamAgent.instance:sendSaveTeamRoleRequest(teamMO.id, teamMO.teamName, heroIdList)
end

function AdjustTeamTipsView:_isTeamEmpty(teamMO)
	local heroIdList = teamMO.roles

	for _, heroId in pairs(heroIdList) do
		if heroId > 0 then
			return false
		end
	end

	return true
end

function AdjustTeamTipsView:onClickTeamCellBattle(teamMO)
	if teamMO.id == kCurrentTeamId then
		if enableErrorLog then
			printError("unexpected teamId", teamMO.id)
		end
	else
		local removeUnits = {}
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local model = BattleMgr.instance:getModel()
		local operateCampId = model:getOperateCampId()
		local availableBornIndexList = {}

		BattleTableUtil.insertto(availableBornIndexList, BattleCampAdjustmentModel.instance:getBornUnionIndexList())
		BattleTableUtil.insertto(removeUnits, unitMgr:getUnitsByCampId(operateCampId))

		for _, unit in pairs(removeUnits) do
			if not BattleCampAdjustmentUtil.isLockedUnit(unit) then
				BattleCampAdjustmentUtil.requestRemoveEntity(unit)
			else
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

				table.removebyvalue(availableBornIndexList, unionIndex)
			end
		end

		local lockedHeroIdList = {}
		local ignoredHeroIdList = {}
		local placeHeroIdList = {}
		local placeUnionIndexList = {}
		local forbiddenHeroByCampLst = {}
		local forbiddenHeroByCareerLst = {}
		local forbiddenHeroByRoleIdLst = {}
		local heroIdList = teamMO.roles
		local remainPlaceCount = BattleCampAdjustmentModel.instance:getRemainPlaceCount()

		for _, heroId in pairs(heroIdList) do
			if heroId > 0 then
				if BattleCampAdjustmentModel.instance:isLockedCharacter(heroId) then
					table.insert(lockedHeroIdList, heroId)
				elseif remainPlaceCount > 0 then
					if BattleCampAdjustmentModel.instance:isHeroForbiddenByCamp(heroId) then
						table.insert(forbiddenHeroByCampLst, heroId)
					elseif BattleCampAdjustmentModel.instance:isHeroForbiddenByCareer(heroId) then
						table.insert(forbiddenHeroByCareerLst, heroId)
					elseif BattleCampAdjustmentModel.instance:isHeroForbiddenByRole(heroId) then
						table.insert(forbiddenHeroByRoleIdLst, heroId)
					else
						local unionIndex = table.remove(availableBornIndexList)

						table.insert(placeHeroIdList, heroId)
						table.insert(placeUnionIndexList, unionIndex)
					end

					remainPlaceCount = remainPlaceCount - 1
				else
					table.insert(ignoredHeroIdList, heroId)
				end
			end
		end

		BattleCampAdjustmentUtil.requestPlaceEntityBatch(placeHeroIdList, placeUnionIndexList)

		local audioHeroId = placeHeroIdList[math.random(#placeHeroIdList)]

		if audioHeroId then
			BattleAudioUtil.playVoiceByHeroId(audioHeroId, BattleAudioUtil.VoiceEnum.speech_shangzhen)
		end

		local messageInfoList = {}

		if #lockedHeroIdList > 0 then
			table.insert(messageInfoList, BattleTeamMessageView:createMessage(lang("tip_adjustteam_locked_title"), "", lockedHeroIdList))
		end

		if #forbiddenHeroByCampLst > 0 then
			local title = string.format(lang("tip_adjustteam_forbidden_title"), self:_getForbiddenCampListString())

			table.insert(messageInfoList, BattleTeamMessageView:createMessage(title, lang("tip_adjustteam_forbidden_content"), forbiddenHeroByCampLst))
		end

		if #forbiddenHeroByCareerLst > 0 then
			local title = string.format(lang("tip_adjustteam_forbidden_title"), self:_getForbiddenCareerListString())

			table.insert(messageInfoList, BattleTeamMessageView:createMessage(title, lang("tip_adjustteam_forbidden_content"), forbiddenHeroByCareerLst))
		end

		if #forbiddenHeroByRoleIdLst > 0 then
			table.insert(messageInfoList, BattleTeamMessageView:createMessage(lang("tip_adjustteam_forbidden_role_title"), lang("tip_adjustteam_forbidden_content"), forbiddenHeroByRoleIdLst))
		end

		if #ignoredHeroIdList > 0 then
			table.insert(messageInfoList, BattleTeamMessageView:createMessage(lang("tip_adjustteam_count_limit_title"), lang("tip_adjustteam_forbidden_content"), ignoredHeroIdList))
		end

		if #messageInfoList > 0 then
			ViewMgr.instance:open(ViewName.BattleTeamMessageViewPresentor, messageInfoList)
		end

		BattleScenePickerViewFacade.instance:simulatePickCoordinates(-1, -1)
		self:close()
	end
end

function AdjustTeamTipsView:_getForbiddenCareerListString()
	local sb = StringBuffer.New()
	local forbiddenCareerList = BattleCampAdjustmentModel.instance:getForbiddenCareerList()

	for _, career in pairs(forbiddenCareerList) do
		sb:append(CharacterCOUtil.getCareerName(career))
	end

	return sb:toString("/")
end

function AdjustTeamTipsView:_getForbiddenCampListString()
	local sb = StringBuffer.New()
	local forbiddenCampList = BattleCampAdjustmentModel.instance:getForbiddenCampList()

	for _, camp in pairs(forbiddenCampList) do
		sb:append(CommEnum.CampType2Name[camp])
	end

	return sb:toString("/")
end

return AdjustTeamTipsView
