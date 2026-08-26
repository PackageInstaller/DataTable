-- chunkname: @modules/logic/story/view/actChapter/RoleStoryChapterOpen.lua

module("modules.logic.story.view.actChapter.RoleStoryChapterOpen", package.seeall)

local RoleStoryChapterOpen = class("RoleStoryChapterOpen", StoryActivityChapterBase)

function RoleStoryChapterOpen:_playTextAnim()
	FrameTimerController.onDestroyViewMember(self, "_txtFrameTimer")
	self._txtTitleAnim:Stop()
	self._txtTitleEnAnimClip:Stop()

	self._txtFrameTimer = FrameTimerController.instance:register(self._onPlayTextAnim, self, 1, 1)

	self._txtFrameTimer:Start()
end

function RoleStoryChapterOpen:_onPlayTextAnim()
	self._txtTitleAnim:Play()
	self._txtTitleEnAnimClip:Play()
end

function RoleStoryChapterOpen:onCtor()
	self.assetPath = "ui/viewres/story/rolestorychapteropen.prefab"
end

function RoleStoryChapterOpen:onInitView()
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._txtTitle = gohelper.findChildTextMesh(self._goBg, "#txt_Title")
	self._txtTitleEn = gohelper.findChildTextMesh(self._goBg, "#txt_TitleEn")
	self._txtEpisode = gohelper.findChildTextMesh(self._goBg, "#txt_Episode")
	self._txtTitleGo = self._txtTitle.gameObject
	self._txtTitleEnGo = self._txtTitleEn.gameObject
	self._txtTitleAnim = self._txtTitleGo:GetComponent(gohelper.Type_Animation)
	self._txtTitleEnAnimClip = self._txtTitleEnGo:GetComponent(gohelper.Type_Animation)
end

function RoleStoryChapterOpen:onUpdateView()
	local chapterCo = self.data

	self._txtTitle.text = chapterCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	self._txtTitleEn.text = chapterCo.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	self:_playTextAnim()

	self._txtEpisode.text = chapterCo.navigateChapterEn
end

function RoleStoryChapterOpen:onHide()
	FrameTimerController.onDestroyViewMember(self, "_txtFrameTimer")
end

function RoleStoryChapterOpen:onDestory()
	FrameTimerController.onDestroyViewMember(self, "_txtFrameTimer")
	RoleStoryChapterOpen.super.onDestory(self)
end

return RoleStoryChapterOpen
