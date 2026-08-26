-- chunkname: @modules/logic/player/view/PlayerClothGuideView.lua

module("modules.logic.player.view.PlayerClothGuideView", package.seeall)

local PlayerClothGuideView = class("PlayerClothGuideView", BaseView)

function PlayerClothGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerClothGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function PlayerClothGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function PlayerClothGuideView:_btnlookOnClick()
	if Time.realtimeSinceStartup - self._startTime <= 3 then
		return
	end

	self:closeThis()

	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		return
	end

	local episodeId = 10113
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterId = episodeCfg.chapterId
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	self._jumpParam = self._jumpParam or {}
	self._jumpParam.chapterType = chapterConfig.type
	self._jumpParam.chapterId = chapterId

	DungeonController.instance:jumpDungeon(self._jumpParam)
end

function PlayerClothGuideView:_editableInitView()
	self._startTime = Time.realtimeSinceStartup

	self._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function PlayerClothGuideView:onUpdateParam()
	return
end

function PlayerClothGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function PlayerClothGuideView:onClose()
	return
end

function PlayerClothGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return PlayerClothGuideView
