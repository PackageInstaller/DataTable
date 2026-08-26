-- chunkname: @modules/logic/commandstation/view/CommandStationDungeonMapView.lua

module("modules.logic.commandstation.view.CommandStationDungeonMapView", package.seeall)

local CommandStationDungeonMapView = class("CommandStationDungeonMapView", BaseView)

function CommandStationDungeonMapView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_commandstation")
end

function CommandStationDungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._updateReddot, self)
end

function CommandStationDungeonMapView:_loadSceneFinish(param)
	self.mapCfg = param[1]
	self.sceneGo = param[2]
	self.mapScene = param[3]
	self.episodeConfig = param.episodeConfig

	self:refreshView()
end

function CommandStationDungeonMapView:removeEvents()
	return
end

function CommandStationDungeonMapView:_initBtn()
	self:_checkBtnVisible()

	if self._loader then
		return
	end

	local path = "ui/viewres/commandstation/commandstation_dungeonmapenteritem.prefab"

	self._loader = PrefabInstantiate.Create(self._goroot)

	self._loader:startLoad(path, self._onResLoaded, self)
end

function CommandStationDungeonMapView:_checkBtnVisible()
	if self._btnRelationShip then
		gohelper.setActive(self._btnRelationShip, self.chapterId ~= CommandStationEnum.NoRelationShipChapterId and CommandStationEnterView.isUnlockRelationShipBoard())
	end
end

function CommandStationDungeonMapView:_updateReddot()
	gohelper.setActive(self._goRelationShipBoardRedDot, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CommandStationRelationShipBoard))
end

function CommandStationDungeonMapView:_onResLoaded()
	self._btnGo = self._loader:getInstGO()
	self._goRelationShipBoardRedDot = gohelper.findChild(self._btnGo, "#btn_relationship/#go_Update")

	self:_updateReddot()

	self._btnRelationShip = gohelper.findChildButtonWithAudio(self._btnGo, "#btn_relationship")

	self._btnRelationShip:AddClickListener(self.onClickRelationShip, self)
	self:_checkBtnVisible()

	self._btnEnter = gohelper.findChildButtonWithAudio(self._btnGo, "#btn_enter")

	self._btnEnter:AddClickListener(self.onClickEnter, self)

	self._gored = gohelper.findChild(self._btnGo, "#btn_enter/#go_reddot")
	self._goFinish = gohelper.findChild(self._btnGo, "#btn_enter/inside/finish")
	self._goFinishHintLight = gohelper.findChild(self._btnGo, "#btn_enter/inside/finish/#effect_hint")
	self._goFinishHintLoop = gohelper.findChild(self._btnGo, "#btn_enter/inside/finish/#effect_hint1")
	self._goFinishEffect = gohelper.findChild(self._btnGo, "#btn_enter/inside/finish/#saoguang")

	gohelper.setActive(self._goFinishEffect, false)

	self._goNotFinish = gohelper.findChild(self._btnGo, "#btn_enter/inside/unfinish")
	self._txt = gohelper.findChildText(self._btnGo, "#btn_enter/inside/finish/time/#txt_time")
	self._anim = self._btnGo:GetComponent("Animator")

	self:refreshView()

	if self._anim then
		self._anim:Play("open", 0, 0)
	end
end

function CommandStationDungeonMapView:refreshView()
	if not self.viewParam then
		return
	end

	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()
	self:_updateInfo()

	if self._gored then
		-- block empty
	end
end

function CommandStationDungeonMapView:_updateInfo(showFinishEffect)
	if gohelper.isNil(self._txt) or not self.episodeConfig then
		return
	end

	self._versionId = nil
	self._timeId = nil

	if self.episodeConfig.chainEpisode > 0 then
		if not self.episodeConfig.chainEpisode then
			local episodeId = self.episodeConfig.id
			local isFinished = DungeonModel.instance:hasPassLevelAndStory(episodeId)

			if showFinishEffect and not self._isFinished and isFinished then
				gohelper.setActive(self._goFinishEffect, false)
				gohelper.setActive(self._goFinishEffect, true)
			end

			self._isFinished = isFinished
			self._episodeId = episodeId

			gohelper.setActive(self._goFinish, isFinished)
			gohelper.setActive(self._goNotFinish, not isFinished)

			if isFinished then
				local timeGroup = CommandStationConfig.instance:getTimeGroupByEpisodeId(episodeId)

				if timeGroup then
					if not timeGroup.id then
						local timePoint = 0

						self._versionId = timeGroup and timeGroup.versionId
						self._timeId = CommandStationConfig.instance:getTimeIdByEpisodeId(episodeId)
						self._txt.text = timePoint > 0 and CommandStationConfig.instance:getTimePointName(timePoint) or ""
					end
				end
			else
				gohelper.setActive(self._goFinishHintLight, false)
			end

			self._prevShowEffect = self._showEffect
			self._showEffect = isFinished and not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.DungeonMapLoopEffect, self._episodeId)

			self:_updateEffect()
		end
	end
end

function CommandStationDungeonMapView:_updateEffect()
	gohelper.setActive(self._goFinishHintLoop, self._showEffect)

	self._isChangeShowEffect = false

	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.LoadingView) then
		self._isChangeShowEffect = self._prevShowEffect ~= self._showEffect and self._showEffect

		return
	end

	self:_updateLightEffect()
end

function CommandStationDungeonMapView:_updateLightEffect(force)
	if not self._isFinished then
		return
	end

	if not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.DungeonMapLightEffect, self._episodeId) or force then
		CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.DungeonMapLightEffect, self._episodeId)
		gohelper.setActive(self._goFinishHintLight, false)
		gohelper.setActive(self._goFinishHintLight, true)
	end
end

function CommandStationDungeonMapView:_playAnim(name, value1, value2)
	return
end

function CommandStationDungeonMapView:_playAnim2(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end
end

function CommandStationDungeonMapView:onOpen()
	if self.episodeConfig then
		self:refreshView()
	end
end

function CommandStationDungeonMapView:onUpdateParam()
	if self.episodeConfig then
		self:refreshView()
	end
end

function CommandStationDungeonMapView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_playAnim("close", 0, 0)
	end
end

function CommandStationDungeonMapView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_playAnim("open", 0, 0)
	end

	if (viewName == ViewName.StoryFrontView or viewName == ViewName.LoadingView) and self._isChangeShowEffect then
		self._isChangeShowEffect = false

		self:_updateLightEffect()
	end

	if viewName == ViewName.CommonPropView then
		self:_updateLightEffect(true)
	end
end

function CommandStationDungeonMapView:setEpisodeListVisible(value)
	local show = value and self._showRoot

	if not gohelper.isNil(self._btnEnter) then
		self._btnEnter.button.interactable = show
	end

	if show then
		self:_playAnim2("open", 0, 0)
	else
		self:_playAnim2("close", 0, 0)
	end
end

function CommandStationDungeonMapView:_checkShowRoot()
	self._showRoot = self:_isShowRoot()

	if self._showRoot then
		self:_initBtn()
		gohelper.setActive(self._goroot, true)
	else
		gohelper.setActive(self._goroot, false)
	end
end

function CommandStationDungeonMapView:_isShowRoot()
	return CommandStationController.instance:chapterInCommandStation(self.chapterId)
end

function CommandStationDungeonMapView:onActStateChange()
	self:_checkShowRoot()
end

function CommandStationDungeonMapView:onClickRelationShip()
	CommandStationController.instance:openCommandStationRelationShipBoard({
		fromMapView = true
	})
end

function CommandStationDungeonMapView:onClickEnter()
	if self._versionId and self._timeId then
		CommandStationMapModel.instance:setVersionId(self._versionId)
		CommandStationMapModel.instance:setTimeId(self._timeId)

		if self._showEffect then
			self._showEffect = false

			CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.DungeonMapLoopEffect, self._episodeId)
			self:_updateEffect()
		end

		if not ViewMgr.instance:isOpen(ViewName.CommandStationMapView) then
			module_views_preloader.CommandStationMapViewPreload(function()
				CommandStationController.instance:openCommandStationMapView()
			end)
		else
			CommandStationController.instance:openCommandStationMapView()
		end

		return
	end

	GameFacade.showToast(ToastEnum.CommandStationTip1)
end

function CommandStationDungeonMapView:onClose()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._btnEnter then
		self._btnEnter:RemoveClickListener()
	end

	if self._btnRelationShip then
		self._btnRelationShip:RemoveClickListener()
	end
end

function CommandStationDungeonMapView:_onUpdateDungeonInfo()
	self:_updateInfo(true)
	self:_updateReddot()
end

return CommandStationDungeonMapView
