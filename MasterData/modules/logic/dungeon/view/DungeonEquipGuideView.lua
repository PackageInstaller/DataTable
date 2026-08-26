-- chunkname: @modules/logic/dungeon/view/DungeonEquipGuideView.lua

module("modules.logic.dungeon.view.DungeonEquipGuideView", package.seeall)

local DungeonEquipGuideView = class("DungeonEquipGuideView", BaseView)

function DungeonEquipGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._simageequip = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_equip")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonEquipGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function DungeonEquipGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function DungeonEquipGuideView:_btnlookOnClick()
	TaskDispatcher.cancelTask(self._delayClick, self)
	TaskDispatcher.runDelay(self._delayClick, self, 0.015)
end

function DungeonEquipGuideView:_delayClick()
	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end

	JumpController.instance:jumpTo("5#2")
end

function DungeonEquipGuideView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function DungeonEquipGuideView:onUpdateParam()
	return
end

function DungeonEquipGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)

	local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.EquipDungeon].episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(openEpisodeId)
	local bonusCfg = lua_bonus.configDict[episodeCfg.firstBonus]
	local params = string.splitToNumber(bonusCfg.fixBonus, "#")

	self._equipId = 1306
	self._showMax = false

	if not self._equipMO and self._equipId then
		self._showMax = true
		self._equipMO = EquipHelper.createMaxLevelEquipMo(self._equipId)
	end

	self._config = self._equipMO.config

	local heroMO = EquipTeamListModel.instance:getHero()

	self._heroId = heroMO and heroMO.heroId

	self._simageequip:LoadImage(ResUrl.getEquipSuit(self._config.icon))
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function DungeonEquipGuideView:_onOpenViewFinish(viewName)
	return
end

function DungeonEquipGuideView:_onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonEquipGuideView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function DungeonEquipGuideView:onOpenFinish()
	return
end

function DungeonEquipGuideView:onClose()
	TaskDispatcher.cancelTask(self._delayClick, self)
end

function DungeonEquipGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return DungeonEquipGuideView
