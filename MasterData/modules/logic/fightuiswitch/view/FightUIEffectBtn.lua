-- chunkname: @modules/logic/fightuiswitch/view/FightUIEffectBtn.lua

module("modules.logic.fightuiswitch.view.FightUIEffectBtn", package.seeall)

local FightUIEffectBtn = class("FightUIEffectBtn", MainSwitchClassifyItem)

function FightUIEffectBtn:onInitView()
	self._imageProgress = gohelper.findChildImage(self.viewGO, "#go_select/progress/#go_fill")

	FightUIEffectBtn.super.onInitView(self)
end

function FightUIEffectBtn:onUpdateMO(mo, index)
	FightUIEffectBtn.super.onUpdateMO(self, mo, index)
	self:killProgress()
end

function FightUIEffectBtn:onRefreshProgress(time)
	if not self._imageProgress then
		return
	end

	self:killProgress()
	ZProj.TweenHelper.DOFillAmount(self._imageProgress, 1, time, nil, self, nil, EaseType.Linear)
end

function FightUIEffectBtn:killProgress()
	ZProj.TweenHelper.KillByObj(self._imageProgress)

	self._imageProgress.fillAmount = 0
end

function FightUIEffectBtn:onSelect(isSelect)
	FightUIEffectBtn.super.onSelect(self, isSelect)

	if not isSelect then
		self:killProgress()
	end
end

function FightUIEffectBtn:onDestroy()
	FightUIEffectBtn.super.onDestroy(self)

	if not self._imageProgress then
		return
	end

	self:killProgress()
end

return FightUIEffectBtn
