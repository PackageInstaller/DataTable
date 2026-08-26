-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossActDungeonMapView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActDungeonMapView", package.seeall)

local VersionActivity2_8BossActDungeonMapView = class("VersionActivity2_8BossActDungeonMapView", BaseView)

function VersionActivity2_8BossActDungeonMapView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_mapenter")
end

function VersionActivity2_8BossActDungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self)
end

function VersionActivity2_8BossActDungeonMapView:_loadSceneFinish(param)
	self.mapCfg = param[1]
	self.sceneGo = param[2]
	self.mapScene = param[3]

	self:_onRainEffectLoaded()
end

function VersionActivity2_8BossActDungeonMapView:_initRainEffect()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	if self._rainEffectLoader then
		self:_onRainEffectLoaded()

		return
	end

	self._rainEffectLoader = MultiAbLoader.New()

	local path = "scenes/common/vx_prefabs/vx_v2a8_rain.prefab"

	self._rainEffectLoader:addPath(path)
	self._rainEffectLoader:startLoad(self._onRainEffectLoaded, self)
end

function VersionActivity2_8BossActDungeonMapView:_onRainEffectLoaded()
	if not self._rainEffectLoader or self._rainEffectLoader.isLoading or gohelper.isNil(self.sceneGo) then
		return
	end

	if self.mapCfg.id < VersionActivity2_8BossEnum.RainMap.minId or self.mapCfg.id > VersionActivity2_8BossEnum.RainMap.maxId then
		return
	end

	local showEffect = DungeonModel.instance:hasPassLevelAndStory(VersionActivity2_8BossEnum.RainEffectEpisodeId)

	if not showEffect then
		return
	end

	local go = gohelper.findChild(self.sceneGo, "SceneEffect")
	local rainName = "vx_v2a8_rain"
	local transform = go.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		if child.name == rainName then
			return
		end
	end

	local prefabSource = self._rainEffectLoader:getFirstAssetItem():GetResource()

	gohelper.clone(prefabSource, go, rainName)
end

function VersionActivity2_8BossActDungeonMapView:removeEvents()
	return
end

function VersionActivity2_8BossActDungeonMapView:_initBtn()
	if self._loader then
		return
	end

	local path = "ui/viewres/versionactivity_2_8/v2a8_dungeon/v2a8_dungeonmapenteritem.prefab"

	self._loader = PrefabInstantiate.Create(self._goroot)

	self._loader:startLoad(path, self._onResLoaded, self)
end

function VersionActivity2_8BossActDungeonMapView:_onResLoaded()
	self._btnGo = self._loader:getInstGO()
	self._btnEnter = gohelper.findChildButtonWithAudio(self._btnGo, "#btn_enter")

	self._btnEnter:AddClickListener(self.onClickEnter, self)

	self._gored = gohelper.findChild(self._btnGo, "#btn_enter/#go_reddot")
	self._anim = self._btnGo:GetComponent("Animator")

	self:refreshView()
end

function VersionActivity2_8BossActDungeonMapView:refreshView()
	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()

	if self._gored then
		RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a8DungeonBossAct)
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		self:_playAnim("close", 0, 1)
	else
		self:_playAnim("open", 0, 0)
	end
end

function VersionActivity2_8BossActDungeonMapView:_playAnim(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end
end

function VersionActivity2_8BossActDungeonMapView:onOpen()
	self:refreshView()
	self:_openBgm()
	self:_initRainEffect()
end

function VersionActivity2_8BossActDungeonMapView:onUpdateParam()
	self._oldChapterId = self.chapterId

	local newChapterId = self.viewParam.chapterId

	if self._oldChapterId ~= newChapterId then
		self:_closeBgm()
	end

	self:refreshView()

	if self._oldChapterId ~= newChapterId then
		self:_openBgm()
	end
end

function VersionActivity2_8BossActDungeonMapView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_playAnim("close", 0, 0)
	end
end

function VersionActivity2_8BossActDungeonMapView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:_playAnim("open", 0, 0)
	end
end

function VersionActivity2_8BossActDungeonMapView:setEpisodeListVisible(value)
	if value and self._showRoot then
		self:_playAnim("open", 0, 0)
	else
		self:_playAnim("close", 0, 0)
	end
end

function VersionActivity2_8BossActDungeonMapView:onRefreshActivityState()
	self:_checkShowRoot()
end

function VersionActivity2_8BossActDungeonMapView:_checkShowRoot()
	self._showRoot = self:_isShowRoot()

	if self._showRoot then
		self:_initBtn()
		gohelper.setActive(self._goroot, true)
	else
		gohelper.setActive(self._goroot, false)
	end
end

function VersionActivity2_8BossActDungeonMapView:_isShowRoot()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return false
	end

	local status = ActivityHelper.getActivityStatus(VersionActivity2_8Enum.ActivityId.DungeonBoss)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	if not isNormal then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.V2a8BossAct)
end

function VersionActivity2_8BossActDungeonMapView:onActStateChange()
	self:_checkShowRoot()
end

function VersionActivity2_8BossActDungeonMapView:onClickEnter()
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossActEnterView)
end

function VersionActivity2_8BossActDungeonMapView:onClose()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._rainEffectLoader then
		self._rainEffectLoader:dispose()

		self._rainEffectLoader = nil
	end

	if self._btnEnter then
		self._btnEnter:RemoveClickListener()
	end

	self:_closeBgm()
end

function VersionActivity2_8BossActDungeonMapView:_onUpdateDungeonInfo()
	self:_onRainEffectLoaded()

	if self._isFinishChapter then
		return
	end

	self:_checkShowRoot()

	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10) then
		self:_openBgm()
	end
end

function VersionActivity2_8BossActDungeonMapView:_openBgm()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	self._isFinishChapter = DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10)

	if self._isFinishChapter then
		AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon, "music_vocal_filter", "accompaniment")

		local result = AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum2_8.DungeonBgm.dungeonMapView_2)

		if not result and AudioBgmManager.instance:getCurPlayingId() == AudioEnum2_8.DungeonBgm.dungeonMapView_2 and self._isFinishChapter then
			AudioBgmManager.instance:setSwitch(AudioBgmEnum.Layer.Dungeon)
		end

		AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		return
	end

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum2_8.DungeonBgm.dungeonMapView_1)
	AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function VersionActivity2_8BossActDungeonMapView:_closeBgm()
	if self.chapterId ~= DungeonEnum.ChapterId.Main1_10 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8EnterView) and not ViewMgr.instance:isOpen(ViewName.DungeonView) then
		if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_10) then
			AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon, "music_vocal_filter", "original")
			AudioBgmManager.instance:setSwitch(AudioBgmEnum.Layer.Dungeon)
		end

		return
	end

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.Dungeon)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music)
	AudioBgmManager.instance:setStopId(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Stop_UIMusic)
end

return VersionActivity2_8BossActDungeonMapView
