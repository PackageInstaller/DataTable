-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7DungeonMapView.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7DungeonMapView", package.seeall)

local TowerV3a7DungeonMapView = class("TowerV3a7DungeonMapView", BaseView)

function TowerV3a7DungeonMapView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_v3a7tower")
end

function TowerV3a7DungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._updateReddot, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.refreshView, self)
end

function TowerV3a7DungeonMapView:_loadSceneFinish(param)
	self.mapCfg = param[1]
	self.sceneGo = param[2]
	self.mapScene = param[3]
	self.episodeConfig = param.episodeConfig

	self:refreshView()
end

function TowerV3a7DungeonMapView:removeEvents()
	return
end

function TowerV3a7DungeonMapView:_initBtn()
	self:_checkBtnVisible()

	if self._loader then
		return
	end

	local path = "ui/viewres/versionactivity_3_7/v3a7_tower/v3a7_towerdungeonmapenteritem.prefab"

	self._loader = PrefabInstantiate.Create(self._goroot)

	self._loader:startLoad(path, self._onResLoaded, self)
end

function TowerV3a7DungeonMapView:_checkBtnVisible()
	return
end

function TowerV3a7DungeonMapView:_updateReddot()
	return
end

function TowerV3a7DungeonMapView:_onResLoaded()
	self._btnGo = self._loader:getInstGO()
	self._goRelationShipBoardRedDot = gohelper.findChild(self._btnGo, "#btn_relationship/#go_Update")

	self:_updateReddot()
	self:_checkBtnVisible()

	self._btnEnter = gohelper.findChildButtonWithAudio(self._btnGo, "#btn_enter")

	self._btnEnter:AddClickListener(self.onClickEnter, self)

	self._anim = self._btnGo:GetComponent("Animator")

	self:refreshView()
end

function TowerV3a7DungeonMapView:refreshView()
	if not self.viewParam then
		return
	end

	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()
	self:_updateInfo()

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		if not gohelper.isNil(self._btnGo) then
			recthelper.setAnchorX(self._btnGo.transform, 10000)
		end

		self:_playAnim("close", 0, 0)
	else
		self:_playAnim("open", 0, 0)
	end
end

function TowerV3a7DungeonMapView:_updateInfo(showFinishEffect)
	self:_updateEffect()
end

function TowerV3a7DungeonMapView:_updateEffect()
	self:_updateLightEffect()
end

function TowerV3a7DungeonMapView:_updateLightEffect(force)
	return
end

function TowerV3a7DungeonMapView:_playAnim(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end
end

function TowerV3a7DungeonMapView:_playAnim2(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end
end

function TowerV3a7DungeonMapView:onOpen()
	if self.episodeConfig then
		self:refreshView()
	end
end

function TowerV3a7DungeonMapView:onUpdateParam()
	if self.episodeConfig then
		self:refreshView()
	end
end

function TowerV3a7DungeonMapView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_playAnim("close", 0, 0)
	end
end

function TowerV3a7DungeonMapView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		if not gohelper.isNil(self._btnGo) then
			recthelper.setAnchorX(self._btnGo.transform, 0)
		end

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

function TowerV3a7DungeonMapView:setEpisodeListVisible(value)
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

function TowerV3a7DungeonMapView:_checkShowRoot()
	self._showRoot = self:_isShowRoot()

	if self._showRoot then
		self:_initBtn()
		gohelper.setActive(self._goroot, true)
	else
		gohelper.setActive(self._goroot, false)
	end
end

function TowerV3a7DungeonMapView:_isShowRoot()
	if self.episodeConfig and self.episodeConfig.chapterId == DungeonEnum.ChapterId.Main1_13 then
		local list = DungeonConfig.instance:getV3a7TowerTypeElements()

		for i, v in ipairs(list) do
			if not DungeonMapModel.instance:elementIsFinished(v.id) then
				return false
			end
		end

		return true
	end

	return false
end

function TowerV3a7DungeonMapView:onActStateChange()
	self:_checkShowRoot()
end

function TowerV3a7DungeonMapView:onClickEnter()
	TowerV3a7Controller.instance:openTowerV3a7MainView()
end

function TowerV3a7DungeonMapView:onClose()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._btnEnter then
		self._btnEnter:RemoveClickListener()
	end

	self._btnGo = nil
end

function TowerV3a7DungeonMapView:_onUpdateDungeonInfo()
	self:_updateInfo(true)
	self:_updateReddot()
end

return TowerV3a7DungeonMapView
