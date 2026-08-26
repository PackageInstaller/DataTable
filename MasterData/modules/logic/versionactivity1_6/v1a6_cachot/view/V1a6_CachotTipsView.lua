-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTipsView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsView", package.seeall)

local V1a6_CachotTipsView = class("V1a6_CachotTipsView", BaseView)

function V1a6_CachotTipsView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txttips1 = gohelper.findChildTextMesh(self.viewGO, "#txt_tips1")
	self._txttips2 = gohelper.findChildTextMesh(self.viewGO, "#txt_tips2")
	self._goWin = gohelper.findChild(self.viewGO, "#win")
	self._goFail = gohelper.findChild(self.viewGO, "#fail")
end

function V1a6_CachotTipsView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function V1a6_CachotTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function V1a6_CachotTipsView:onOpen()
	if not self.viewParam.style then
		local style = V1a6_CachotEnum.TipStyle.Normal
		local txt, bgPath

		self._txttips1.text = ""
		self._txttips2.text = ""

		if style == V1a6_CachotEnum.TipStyle.Normal then
			txt = self._txttips1
			bgPath = "v1a6_cachot_tipsbg2"

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_popups_prompt)
		elseif style == V1a6_CachotEnum.TipStyle.ChangeConclusion then
			txt = self._txttips2
			bgPath = "v1a6_cachot_tipsbg1"

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_newendings_enter)
		end

		gohelper.setActive(self._goFail, style == V1a6_CachotEnum.TipStyle.ChangeConclusion)
		gohelper.setActive(self._goWin, style == V1a6_CachotEnum.TipStyle.Normal)

		txt.text = self.viewParam.strExtra and GameUtil.getSubPlaceholderLuaLang(self.viewParam.str, self.viewParam.strExtra) or self.viewParam.str
	end
end

function V1a6_CachotTipsView:onClose()
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Tips)
end

return V1a6_CachotTipsView
