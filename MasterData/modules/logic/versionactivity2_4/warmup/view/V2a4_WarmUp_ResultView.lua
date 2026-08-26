-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_ResultView.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_ResultView", package.seeall)

local V2a4_WarmUp_ResultView = class("V2a4_WarmUp_ResultView", BaseView)

function V2a4_WarmUp_ResultView:onInitView()
	self._simagepanelbg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_panelbg1")
	self._simagepanelbg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_panelbg2")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtfail = gohelper.findChildText(self.viewGO, "#go_fail/#txt_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._txtsuccess = gohelper.findChildText(self.viewGO, "#go_success/#txt_success")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V2a4_WarmUp_ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V2a4_WarmUp_ResultView:_btncloseOnClick()
	self:closeThis()
end

function V2a4_WarmUp_ResultView:_editableInitView()
	self._animPlayer = csAnimatorPlayer.Get(self.viewGO)
end

function V2a4_WarmUp_ResultView:onUpdateParam()
	gohelper.setActive(self._gofail, not self:_isSucc())
	gohelper.setActive(self._gosuccess, self:_isSucc())

	self._txtsuccess.text = self:_desc()
	self._txtfail.text = self:_desc()
end

function V2a4_WarmUp_ResultView:onOpen()
	self:onUpdateParam()
	self._animPlayer:Play(self:_isSucc() and "success" or "fail", nil, nil)
	AudioMgr.instance:trigger((self:_isSucc() or nil) and (AudioEnum.UI.play_ui_diqiu_yure_success_20249043 or AudioEnum.UI.play_ui_mln_remove_effect_20249042))
end

function V2a4_WarmUp_ResultView:onClose()
	self:_callCloseCallback()
end

function V2a4_WarmUp_ResultView:onDestroyView()
	return
end

function V2a4_WarmUp_ResultView:_isSucc()
	return self.viewParam.isSucc
end

function V2a4_WarmUp_ResultView:_desc()
	return self.viewParam.desc
end

function V2a4_WarmUp_ResultView:_callCloseCallback()
	local cb = self.viewParam.closeCb

	if cb then
		self.viewParam.closeCb(self.viewParam.closeCbObj)
	end
end

return V2a4_WarmUp_ResultView
