-- chunkname: @modules/logic/explore/view/ExploreArchivesDetailView.lua

module("modules.logic.explore.view.ExploreArchivesDetailView", package.seeall)

local ExploreArchivesDetailView = class("ExploreArchivesDetailView", BaseView)

function ExploreArchivesDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "#txt_title")
	self._txtinfo = gohelper.findChildTextMesh(self.viewGO, "mask/#txt_info")
	self._txtdec = gohelper.findChildTextMesh(self.viewGO, "mask/Scroll View/Viewport/Content/#txt_dec")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
end

function ExploreArchivesDetailView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnclose2:AddClickListener(self.closeThis, self)
end

function ExploreArchivesDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function ExploreArchivesDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)

	local archiveCo = lua_explore_story.configDict[self.viewParam.chapterId][self.viewParam.id]
	local title = archiveCo.title
	local first = GameUtil.utf8sub(title, 1, 1)
	local last = GameUtil.utf8sub(title, 2, #title)

	self._txttitle.text = string.format("<size=50>%s</size>%s", first, last)
	self._txtinfo.text = archiveCo.desc
	self._txtdec.text = archiveCo.content

	self._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. archiveCo.res))
end

function ExploreArchivesDetailView:onClickModalMask()
	self:closeThis()
end

function ExploreArchivesDetailView:onClose()
	self._simageicon:UnLoadImage()
end

return ExploreArchivesDetailView
