-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameStartView.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameStartView", package.seeall)

local V3a4_Chg_GameStartView = class("V3a4_Chg_GameStartView", BaseView)

function V3a4_Chg_GameStartView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/Title_mask/#txt_Title")
	self._txtTips = gohelper.findChildText(self.viewGO, "Root/#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameStartView:addEvents()
	self._button:AddClickListener(self.onClickModalMask, self)
end

function V3a4_Chg_GameStartView:removeEvents()
	self._button:RemoveClickListener()
end

function V3a4_Chg_GameStartView:_editableInitView()
	self._button = gohelper.findChildButtonWithAudio(self.viewGO, "Mask")
end

function V3a4_Chg_GameStartView:onClickModalMask()
	self:closeThis()
end

function V3a4_Chg_GameStartView:onUpdateParam()
	self._txtTitle.text = self.viewParam.title or ""
	self._txtTips.text = self.viewParam.desc or ""
end

function V3a4_Chg_GameStartView:onOpen()
	self:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_start)
end

local kDelayAutoCloseSec = 3

function V3a4_Chg_GameStartView:onOpenFinish()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.runDelay(self.closeThis, self, kDelayAutoCloseSec)
end

function V3a4_Chg_GameStartView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function V3a4_Chg_GameStartView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return V3a4_Chg_GameStartView
