-- chunkname: @modules/logic/rouge/dlc/101/view/RougeMainView_1_101.lua

module("modules.logic.rouge.dlc.101.view.RougeMainView_1_101", package.seeall)

local RougeMainView_1_101 = class("RougeMainView_1_101", BaseViewExtended)

RougeMainView_1_101.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
RougeMainView_1_101.ParentObjPath = "Right/#go_dlc/#go_dlc_101/go_limiterroot/go_pos"

function RougeMainView_1_101:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self:getParentView().viewGO, "Right/#go_dlc/#go_dlc_101/go_limiterroot/btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMainView_1_101:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeMainView_1_101:removeEvents()
	self._btnclick:RemoveClickListener()
end

local LimiterDifficultyFontSize = 61

function RougeMainView_1_101:createAndInitDLCRes()
	self._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, RougeLimiterBuffEntry)

	self._buffEntry:refreshUI(true)
	self._buffEntry:setDifficultyTxtFontSize(LimiterDifficultyFontSize)
	self._buffEntry:setInteractable(false)
	AudioMgr.instance:trigger(AudioEnum.UI.ShowRougeLimiter)
end

function RougeMainView_1_101:_btnclickOnClick()
	local inRouge = RougeModel.instance:inRouge()

	if inRouge then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	RougeDLCController101.instance:openRougeLimiterView()
end

function RougeMainView_1_101:onOpen()
	self:createAndInitDLCRes()
end

return RougeMainView_1_101
