-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapItem105.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapItem105", package.seeall)

local VersionActivity_1_2_DungeonMapItem105 = class("VersionActivity_1_2_DungeonMapItem105", BaseViewExtended)

function VersionActivity_1_2_DungeonMapItem105:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._gopickupbg = gohelper.findChild(self.viewGO, "rotate/#go_pickupbg")
	self._gopickup = gohelper.findChild(self.viewGO, "rotate/#go_pickupbg/#go_pickup")
	self._txtcontent = gohelper.findChildText(self.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_content")
	self._goop = gohelper.findChild(self.viewGO, "rotate/#go_op")
	self._txtdoit = gohelper.findChildText(self.viewGO, "rotate/#go_op/bg/#txt_doit")
	self._btndoit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op/bg/#btn_doit")
	self._simagebgimag = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_pickupbg/bgimag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapItem105:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndoit:AddClickListener(self._btndoitOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapItem105:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndoit:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapItem105:_btncloseOnClick()
	self:_onBtnCloseSelf()
end

function VersionActivity_1_2_DungeonMapItem105:_onBtnCloseSelf()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.DESTROYSELF, self)
end

function VersionActivity_1_2_DungeonMapItem105:_btndoitOnClick()
	if self._finishedFight then
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	else
		local episodeId = tonumber(self._config.param)

		DungeonModel.instance.curLookEpisodeId = episodeId

		if TeachNoteModel.instance:isTeachNoteEpisode(episodeId) then
			TeachNoteController.instance:enterTeachNoteDetailView(episodeId)
		else
			local config = DungeonConfig.instance:getEpisodeCO(episodeId)

			DungeonFightController.instance:enterFight(config.chapterId, episodeId)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	end

	self:DESTROYSELF()
end

function VersionActivity_1_2_DungeonMapItem105:_editableInitView()
	self._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function VersionActivity_1_2_DungeonMapItem105:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_2_DungeonMapItem105:onOpen()
	local episodeId = tonumber(self._config.param)

	self._finishedFight = DungeonModel.instance:hasPassLevel(episodeId)

	if self._finishedFight then
		self._txtcontent.text = self._config.finishText
		self._txtdoit.text = luaLang("confirm_text")
	else
		self._txtcontent.text = self._config.desc
		self._txtdoit.text = self._config.acceptText
	end

	self._txttitle.text = self._config.title
end

function VersionActivity_1_2_DungeonMapItem105:onClose()
	return
end

function VersionActivity_1_2_DungeonMapItem105:onDestroyView()
	self._simagebgimag:UnLoadImage()
end

return VersionActivity_1_2_DungeonMapItem105
