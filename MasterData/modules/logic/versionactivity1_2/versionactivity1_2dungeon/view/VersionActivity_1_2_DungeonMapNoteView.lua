-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapNoteView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapNoteView", package.seeall)

local VersionActivity_1_2_DungeonMapNoteView = class("VersionActivity_1_2_DungeonMapNoteView", BaseViewExtended)

function VersionActivity_1_2_DungeonMapNoteView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg3")
	self._gopaper = gohelper.findChild(self.viewGO, "content/#go_paper")
	self._txtpapertitle = gohelper.findChildText(self.viewGO, "content/#go_paper/#txt_papertitle")
	self._txtpaperdesc = gohelper.findChildText(self.viewGO, "content/#go_paper/#txt_papertitle/#txt_paperdesc")
	self._gonotebook = gohelper.findChild(self.viewGO, "content/#go_notebook")
	self._btnclose = gohelper.getClick(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapNoteView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapNoteView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	self._simagebg3:LoadImage(ResUrl.getYaXianImage("img_huode_bg"))
end

function VersionActivity_1_2_DungeonMapNoteView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapNoteView:_btncloseOnClick()
	if self._closed then
		return
	end

	SLFramework.AnimatorPlayer.Get(self.viewGO):Play("close", self.closeThis, self)

	self._closed = true
end

function VersionActivity_1_2_DungeonMapNoteView:onOpen()
	self._closed = nil
	self._activityId = VersionActivityEnum.ActivityId.Act121

	if self.viewParam then
		if self.viewParam then
			local showPaper = self.viewParam.showPaper

			gohelper.setActive(self._gonotebook, self.viewParam)
			gohelper.setActive(self._gopaper, showPaper)

			if showPaper then
				local config = lua_activity121_note.configDict[self.viewParam.id][self._activityId]

				self._txtpapertitle.text = config.name
				self._txtpaperdesc.text = config.desc

				VersionActivity1_2NoteModel.instance:setNote(self.viewParam.id)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
			else
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
			end
		end
	end
end

function VersionActivity_1_2_DungeonMapNoteView:onClose()
	return
end

function VersionActivity_1_2_DungeonMapNoteView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg3:UnLoadImage()
end

return VersionActivity_1_2_DungeonMapNoteView
