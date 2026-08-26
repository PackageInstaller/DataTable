-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_HeroGroupBuildView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupBuildView", package.seeall)

local VersionActivity_1_2_HeroGroupBuildView = class("VersionActivity_1_2_HeroGroupBuildView", BaseViewExtended)

function VersionActivity_1_2_HeroGroupBuildView:onInitView()
	self._facilitycontain = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain")
	self._txtplacedcount = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount")
	self._btnfacilitydetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount/#btn_facilitydetail", AudioEnum.TeachNote.play_ui_activity_switch)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_HeroGroupBuildView:addEvents()
	self._btnfacilitydetail:AddClickListener(self._onBtnDetail, self)
end

function VersionActivity_1_2_HeroGroupBuildView:removeEvents()
	self._btnfacilitydetail:RemoveClickListener()
end

function VersionActivity_1_2_HeroGroupBuildView:_onBtnDetail()
	if #self._gainList == 0 then
		GameFacade.showToast(ToastEnum.Act114BuildingIsEmpty)
	else
		ViewMgr.instance:openView(ViewName.VersionActivity_1_2_FacilityTipsView)
	end
end

function VersionActivity_1_2_HeroGroupBuildView:_editableInitView()
	return
end

function VersionActivity_1_2_HeroGroupBuildView:onRefreshViewParam()
	return
end

function VersionActivity_1_2_HeroGroupBuildView:onOpen()
	local isOpen = DungeonModel.instance:hasPassLevelAndStory(1210105)
	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

		if episodeConfig and episodeConfig.chapterId == 12102 then
			isOpen = false
		end
	end

	gohelper.setActive(self._facilitycontain, isOpen)

	self._gainList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()
	self._txtplacedcount.text = formatLuaLang("versionactivity_1_2_herogroupview_placedcount", #self._gainList)
end

function VersionActivity_1_2_HeroGroupBuildView:onClose()
	return
end

function VersionActivity_1_2_HeroGroupBuildView:onDestroyView()
	return
end

return VersionActivity_1_2_HeroGroupBuildView
