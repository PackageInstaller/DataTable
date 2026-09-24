-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ResetView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ResetView", package.seeall)

local V3a9_BossRush_ResetView = class("V3a9_BossRush_ResetView", MessageOptionBoxView)

function V3a9_BossRush_ResetView:onInitView()
	V3a9_BossRush_ResetView.super.onInitView(self)

	self._btnyes1 = gohelper.findChildButtonWithAudio(self.viewGO, "tipContent/btnContent/#btn_yes1")
	self._txtYes1 = gohelper.findChildText(self._btnyes1.gameObject, "yes")
	self._txtYes1en = gohelper.findChildText(self._btnyes1.gameObject, "yesen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ResetView:addEvents()
	V3a9_BossRush_ResetView.super.addEvents(self)
	self._btnyes1:AddClickListener(self._btnyes1OnClick, self)
end

function V3a9_BossRush_ResetView:removeEvents()
	V3a9_BossRush_ResetView.super.removeEvents(self)
	self._btnyes1:RemoveClickListener()
end

function V3a9_BossRush_ResetView:_btnyes1OnClick()
	if self._toggleoption.isOn then
		self:saveOptionData()
	end

	if self.viewParam.yes1Callback then
		self.viewParam.yes1Callback(self.viewParam.yes1CallbackObj)
	end

	self:closeThis()
end

function V3a9_BossRush_ResetView:refreshBtn()
	V3a9_BossRush_ResetView.super.refreshBtn(self)

	if not self.viewParam.yes1Str then
		local yesStr1 = luaLang("p_v3a9_bossrushleveldetail_txt_comfirm_reset_1")

		if not self.viewParam.yes1StrEn then
			self._txtYes1.text = self.viewParam.yes1Str
			self._txtYes1en.text = luaLang("p_v3a9_bossrushleveldetail_txt_comfirm_resetten_2")
		end
	end
end

function V3a9_BossRush_ResetView:refreshOptionUI()
	gohelper.setActive(self._toggleoption.gameObject, false)
end

return V3a9_BossRush_ResetView
