-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameViewContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameViewContainer", package.seeall)

local V3a1_GaoSiNiao_GameViewContainer = class("V3a1_GaoSiNiao_GameViewContainer", Activity210CorvusViewBaseContainer)
local kTabContainerId_NavigateButtonsView = 1

function V3a1_GaoSiNiao_GameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a1_GaoSiNiao_GameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function V3a1_GaoSiNiao_GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigateView
		}
	end
end

function V3a1_GaoSiNiao_GameViewContainer:_overrideClose()
	GameFacade.showMessageBox(MessageBoxIdDefine.V3a1_GaoSiNiao_GameView_Exit, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function V3a1_GaoSiNiao_GameViewContainer:_endYesCallback()
	if self:isSP() then
		self.completeGame(self, nil, self.closeThis, self)
	else
		self:track_exit()
		self:closeThis()
	end
end

function V3a1_GaoSiNiao_GameViewContainer:onContainerInit()
	self:_recoverBadPrefsData()
end

function V3a1_GaoSiNiao_GameViewContainer:_recoverBadPrefsData()
	local curEpisodeId = self:episodeId()
	local episodeCOList, _SPCOList = self:getEpisodeCOList()

	for _, v in ipairs(episodeCOList) do
		local episodeId = v.episodeId
		local isOpen = self:isEpisodeOpen(episodeId)
		local hasPass = self:hasPassLevelAndStory(episodeId)
		local guideId = self:guideId(episodeId)

		if hasPass then
			self:directFinishGuide(guideId)
			self:saveHasPlayedGuide(episodeId)
		elseif self:hasPlayedGuide(episodeId) and not isOpen then
			self:unsaveHasPlayedGuide(episodeId)
			GuideStepController.instance:clearFlow()
		end

		if self:isGuideRunning(guideId) then
			GuideStepController.instance:clearFlow(guideId)
		end

		if episodeId ~= curEpisodeId then
			GuideStepController.instance:clearFlow(guideId)
		end
	end

	for _, v in ipairs(_SPCOList) do
		local episodeId = v.episodeId
		local isOpen = self:isEpisodeOpen(episodeId)
		local hasPass = self:hasPassLevelAndStory(episodeId)
		local guideId = self:guideId(episodeId)

		if hasPass then
			self:directFinishGuide(guideId)
			self:saveHasPlayedGuide(episodeId)
		elseif self:hasPlayedGuide(episodeId) and not isOpen then
			self:unsaveHasPlayedGuide(episodeId)
			GuideStepController.instance:clearFlow(guideId)
		end

		if self:isGuideRunning(guideId) then
			GuideStepController.instance:clearFlow(guideId)
		end

		if episodeId ~= curEpisodeId then
			GuideStepController.instance:clearFlow(guideId)
		end
	end
end

function V3a1_GaoSiNiao_GameViewContainer:onContainerDestroy()
	self:dragContext():clear()
end

function V3a1_GaoSiNiao_GameViewContainer:isSP()
	return GaoSiNiaoConfig.instance:isSP(self:episodeId())
end

function V3a1_GaoSiNiao_GameViewContainer:episodeId()
	return GaoSiNiaoBattleModel.instance:episodeId()
end

function V3a1_GaoSiNiao_GameViewContainer:mapMO()
	return GaoSiNiaoBattleModel.instance:mapMO()
end

function V3a1_GaoSiNiao_GameViewContainer:dragContext()
	return GaoSiNiaoBattleModel.instance:dragContext()
end

function V3a1_GaoSiNiao_GameViewContainer:trackMO()
	return GaoSiNiaoBattleModel.instance:trackMO()
end

function V3a1_GaoSiNiao_GameViewContainer:restart()
	GaoSiNiaoBattleModel.instance:restart(self:episodeId())
end

function V3a1_GaoSiNiao_GameViewContainer:completeGame(progress, callback, cbObj)
	GaoSiNiaoController.instance:completeGame(self:episodeId(), progress, callback, cbObj)
	self:track_finish()
end

function V3a1_GaoSiNiao_GameViewContainer:exitGame()
	GaoSiNiaoController.instance:exitGame(self:episodeId())
end

function V3a1_GaoSiNiao_GameViewContainer:bagDataList()
	return self:mapMO():bagList()
end

function V3a1_GaoSiNiao_GameViewContainer:gridDataList()
	return self:mapMO():gridDataList()
end

function V3a1_GaoSiNiao_GameViewContainer:mapSize()
	return self:mapMO():mapSize()
end

function V3a1_GaoSiNiao_GameViewContainer:rowCol()
	return self:mapMO():rowCol()
end

function V3a1_GaoSiNiao_GameViewContainer:setLocalRotZ(transform, zRotInDeg)
	transformhelper.setLocalRotation(transform, 0, 0, zRotInDeg)
end

function V3a1_GaoSiNiao_GameViewContainer:setSprite(imageCmp, spriteName)
	UISpriteSetMgr.instance:setV3a1GaoSiNiaoSprite(imageCmp, spriteName)

	imageCmp.enabled = true
end

function V3a1_GaoSiNiao_GameViewContainer:setSpriteByPathType(imageCmp, ePathType)
	if ePathType == GaoSiNiaoEnum.PathType.None then
		imageCmp.enabled = false

		return
	end

	local pathInfo = GaoSiNiaoEnum.PathInfo[ePathType]

	self:setSprite(imageCmp, GaoSiNiaoConfig.instance:getPathSpriteName(pathInfo.spriteId))
	self:setLocalRotZ(imageCmp.transform, pathInfo.zRot)
end

function V3a1_GaoSiNiao_GameViewContainer:setBloodByPathType(imageCmp, ePathType)
	if ePathType == GaoSiNiaoEnum.PathType.None then
		imageCmp.enabled = false

		return
	end

	local pathInfo = GaoSiNiaoEnum.PathInfo[ePathType]

	self:setSprite(imageCmp, GaoSiNiaoConfig.instance:getBloodSpriteName(pathInfo.spriteId))
	self:setLocalRotZ(imageCmp.transform, pathInfo.zRot)
end

function V3a1_GaoSiNiao_GameViewContainer:setSpriteByGridType(imageCmp, eGridType, gridItem)
	if eGridType == GaoSiNiaoEnum.GridType.Empty then
		imageCmp.enabled = false

		return
	end

	self:setSprite(imageCmp, GaoSiNiaoConfig.instance:getGridSpriteName(eGridType))
	self:setLocalRotZ(imageCmp.transform, gridItem.zRot)
end

function V3a1_GaoSiNiao_GameViewContainer:guideId(episodeId)
	episodeId = episodeId or self:episodeId()

	return GaoSiNiaoConfig.instance:getEpisodeCO_guideId(episodeId)
end

function V3a1_GaoSiNiao_GameViewContainer:isGuideRunning(guideId)
	guideId = guideId or self:guideId()

	return GuideModel.instance:isGuideRunning(guideId)
end

function V3a1_GaoSiNiao_GameViewContainer:_prefKey_HasPlayedGuide(episodeId)
	episodeId = episodeId or self:episodeId()

	return self:getPrefsKeyPrefix_episodeId(episodeId) .. "HasPlayedGuide"
end

function V3a1_GaoSiNiao_GameViewContainer:saveHasPlayedGuide(episodeId)
	local key = self:_prefKey_HasPlayedGuide(episodeId)

	self:saveInt(key, 1)
end

function V3a1_GaoSiNiao_GameViewContainer:unsaveHasPlayedGuide(episodeId)
	local key = self:_prefKey_HasPlayedGuide(episodeId)

	self:saveInt(key, 0)
end

function V3a1_GaoSiNiao_GameViewContainer:hasPlayedGuide(episodeId)
	local key = self:_prefKey_HasPlayedGuide(episodeId)

	return self:getInt(key, 0) == 1
end

function V3a1_GaoSiNiao_GameViewContainer:directFinishGuide(guideId)
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	GuideStepController.instance:clearFlow(guideId)

	local stepList = GuideConfig.instance:getStepList(guideId)
	local currStepId = math.max(1, (not guideMO.currStepId or nil) and 1)

	for j = #stepList, currStepId, -1 do
		local stepCO = stepList[j]
		local stepId = stepCO.stepId

		if stepCO.keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(guideId, stepId)

			break
		else
			GuideModel.instance:clientFinishStep(guideId, stepId)
		end
	end
end

function V3a1_GaoSiNiao_GameViewContainer:track_reset()
	self:trackMO():onGameReset()
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.reset)
end

function V3a1_GaoSiNiao_GameViewContainer:track_finish()
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.finish)
end

function V3a1_GaoSiNiao_GameViewContainer:track_exit()
	GaoSiNiaoBattleModel.instance:track_act210_operation(GaoSiNiaoEnum.operation_type.exit)
end

return V3a1_GaoSiNiao_GameViewContainer
