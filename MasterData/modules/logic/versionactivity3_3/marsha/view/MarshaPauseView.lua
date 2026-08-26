-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaPauseView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaPauseView", package.seeall)

local MarshaPauseView = class("MarshaPauseView", BaseView)

function MarshaPauseView:onInitView()
	self._goBG1 = gohelper.findChild(self.viewGO, "LeftTime/#go_BG1")
	self._goBG2 = gohelper.findChild(self.viewGO, "LeftTime/#go_BG2")
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "LeftTime/#txt_LeftTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MarshaPauseView:onClickModalMask()
	self:closeThis()
end

function MarshaPauseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_pause)

	local leftTime = self.viewParam

	gohelper.setActive(self._goBG1, leftTime > 10)
	gohelper.setActive(self._goBG2, leftTime <= 10)

	local txt = luaLang("v3a3_marsha_gameview_remaintime")

	self._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, leftTime)
end

return MarshaPauseView
