-- chunkname: @modules/logic/rouge/dlc/101/view/RougeResultReView_1_101.lua

module("modules.logic.rouge.dlc.101.view.RougeResultReView_1_101", package.seeall)

local RougeResultReView_1_101 = class("RougeResultReView_1_101", BaseViewExtended)

RougeResultReView_1_101.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
RougeResultReView_1_101.ParentObjPath = "Left/#go_dlc/#go_dlc_101/#go_limiterroot"
RougeResultReView_1_101.LimiterDifficultyFontSize = 144

function RougeResultReView_1_101:onInitView()
	self._golimiteritem = gohelper.findChild(self.viewGO, "#go_dlc_101")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeResultReView_1_101:addEvents()
	return
end

function RougeResultReView_1_101:removeEvents()
	return
end

function RougeResultReView_1_101:_editableInitView()
	return
end

function RougeResultReView_1_101:onOpen()
	local riskValue = self._reviewInfo and self._reviewInfo:getLimiterRiskValue() or 0

	self._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, RougeResultReViewLimiterBuff, riskValue)

	self._buffEntry:setDifficultyTxtFontSize(RougeResultReView_1_101.LimiterDifficultyFontSize)
	self._buffEntry:setDifficultyVisible(false)
	self._buffEntry:refreshUI()
	self._buffEntry:setInteractable(false)
end

function RougeResultReView_1_101:onRefreshViewParam(viewParam)
	self._reviewInfo = viewParam and viewParam.reviewInfo
end

function RougeResultReView_1_101:onDestroyView()
	return
end

return RougeResultReView_1_101
