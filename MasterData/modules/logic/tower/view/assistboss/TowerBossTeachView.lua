-- chunkname: @modules/logic/tower/view/assistboss/TowerBossTeachView.lua

module("modules.logic.tower.view.assistboss.TowerBossTeachView", package.seeall)

local TowerBossTeachView = class("TowerBossTeachView", BaseView)

function TowerBossTeachView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._txttitleName = gohelper.findChildText(self.viewGO, "title/#txt_titleName")
	self._simagebossIcon = gohelper.findChildSingleImage(self.viewGO, "boss/#simage_bossIcon")
	self._simagebossShadow = gohelper.findChildSingleImage(self.viewGO, "boss/#simage_shadow")
	self._txtbossDesc = gohelper.findChildText(self.viewGO, "info/scroll_bossDesc/Viewport/Content/#txt_bossDesc")
	self._btnskillTips = gohelper.findChildButtonWithAudio(self.viewGO, "info/#btn_skillTips")
	self._goskillTip = gohelper.findChild(self.viewGO, "#go_skillTip")
	self._scrollepisode = gohelper.findChildScrollRect(self.viewGO, "#scroll_episode")
	self._goepisodeContent = gohelper.findChild(self.viewGO, "#scroll_episode/Viewport/#go_episodeContent")
	self._goepisodeItem = gohelper.findChild(self.viewGO, "#scroll_episode/Viewport/#go_episodeContent/#go_episodeItem")
	self._goepisodeSelect = gohelper.findChild(self.viewGO, "#go_episodeSelect")
	self._txtepisodeDesc = gohelper.findChildText(self.viewGO, "#go_episodeSelect/scroll_episodeDesc/Viewport/Content/#txt_episodeDesc")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_episodeSelect/#btn_start")
	self._txtstart = gohelper.findChildText(self.viewGO, "#go_episodeSelect/#btn_start/txt")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossTeachView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnskillTips:AddClickListener(self._btnskillTipsOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerBossTeachView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnskillTips:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function TowerBossTeachView:_btncloseFullViewOnClick()
	self:_btncloseOnClick()
end

function TowerBossTeachView:_btnskillTipsOnClick()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = self.bossId
	})
end

function TowerBossTeachView:_btnstartOnClick()
	local teachConfig = TowerConfig.instance:getBossTeachConfig(self.towerId, self.selectTeachId)

	if not teachConfig then
		return
	end

	local param = {}

	param.towerType = self.towerType
	param.towerId = self.towerId
	param.layerId = 0
	param.episodeId = teachConfig.episodeId
	param.difficulty = teachConfig.teachId

	TowerController.instance:enterFight(param)
	TowerBossTeachModel.instance:setLastFightTeachId(teachConfig.teachId)
end

function TowerBossTeachView:_btncloseOnClick()
	self:closeThis()
end

function TowerBossTeachView:onEpisodeItemClick(episodeItem)
	if self.selectTeachId == episodeItem.config.teachId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_main_switch_scene_2_2)

	self.selectTeachId = episodeItem.config.teachId

	self:refreshSelectUI()
end

function TowerBossTeachView:_editableInitView()
	gohelper.setActive(self._goepisodeItem, false)
	NavigateMgr.instance:addEscape(ViewName.TowerBossTeachView, self.closeThis, self)
end

function TowerBossTeachView:onUpdateParam()
	return
end

function TowerBossTeachView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play__ui_main_fit_scane_2_2)
	self:initData()
	self:refreshUI()
end

function TowerBossTeachView:initData()
	self.towerType = self.viewParam.towerType
	self.towerId = self.viewParam.towerId
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.bossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	self.bossId = self.towerConfig.bossId
	self.skinConfig = FightConfig.instance:getSkinCO(self.bossConfig.skinId)
	self.towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, self.towerId)
	self.lastFightTeachId = self.viewParam.lastFightTeachId or 0
	self.episodeItemMap = self:getUserDataTb_()
	self.allTeachConfigList = TowerConfig.instance:getAllBossTeachConfigList(self.towerId)
end

function TowerBossTeachView:refreshUI()
	self._simagebossIcon:LoadImage(self.bossConfig.bossPic)
	self._simagebossShadow:LoadImage(self.bossConfig.bossShadowPic)

	self._txttitleName.text = self.towerConfig.name
	self._txtbossDesc.text = self.bossConfig.bossDesc

	self:createAndRefreshEpisodeItem()
	self:refreshSelectUI()
end

function TowerBossTeachView:createAndRefreshEpisodeItem()
	for index, config in ipairs(self.allTeachConfigList) do
		local episodeItem = self.episodeItemMap[config.teachId]

		if not episodeItem then
			episodeItem = {
				config = config
			}
			episodeItem.isFinish = false
			episodeItem.go = gohelper.cloneInPlace(self._goepisodeItem)
			episodeItem.simageBoss = gohelper.findChildSingleImage(episodeItem.go, "boss/image_boss")
			episodeItem.goSelect = gohelper.findChild(episodeItem.go, "go_select")
			episodeItem.txtEpisodeName = gohelper.findChildText(episodeItem.go, "name/txt_episodeName")
			episodeItem.goFinishIcon = gohelper.findChild(episodeItem.go, "name/txt_episodeName/go_finishIcon")
			episodeItem.btnClick = gohelper.findChildClickWithAudio(episodeItem.go, "btn_click")

			episodeItem.btnClick:AddClickListener(self.onEpisodeItemClick, self, episodeItem)

			self.episodeItemMap[config.teachId] = episodeItem
		end

		gohelper.setActive(episodeItem.go, true)
		episodeItem.simageBoss:LoadImage(ResUrl.monsterHeadIcon(self.skinConfig and self.skinConfig.headIcon))

		episodeItem.txtEpisodeName.text = config.name
		episodeItem.isFinish = self.towerInfo:isPassBossTeach(config.teachId)

		gohelper.setActive(episodeItem.goFinishIcon, episodeItem.isFinish)
	end

	if not self.selectTeachId then
		if self.lastFightTeachId > 0 then
			self.selectTeachId = self.lastFightTeachId or TowerBossTeachModel.instance:getFirstUnFinishTeachId(self.bossId)
		end
	end
end

function TowerBossTeachView:refreshSelectUI()
	for teachId, episodeItem in pairs(self.episodeItemMap) do
		gohelper.setActive(episodeItem.goSelect, episodeItem.config.teachId == self.selectTeachId)

		local scale = episodeItem.config.teachId == self.selectTeachId and 1 or 0.9

		transformhelper.setLocalScale(episodeItem.go.transform, scale, scale, scale)
	end

	gohelper.setActive(self._goepisodeSelect, true)

	local teachConfig = TowerConfig.instance:getBossTeachConfig(self.towerId, self.selectTeachId)

	if teachConfig then
		self._txtepisodeDesc.text = teachConfig.desc or ""
	end

	self._txtstart.text = self.episodeItemMap[self.selectTeachId].isFinish and luaLang("towerbossteachpass") or luaLang("towerbossteachstart")
end

function TowerBossTeachView:onClose()
	for _, episodeItem in pairs(self.episodeItemMap) do
		episodeItem.btnClick:RemoveClickListener()
		episodeItem.simageBoss:UnLoadImage()
	end

	self._simagebossIcon:UnLoadImage()
	self._simagebossShadow:UnLoadImage()
end

function TowerBossTeachView:onDestroyView()
	return
end

return TowerBossTeachView
