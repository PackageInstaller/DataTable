-- chunkname: @modules/logic/achievement/view/AchievementItemFoldAnimComp.lua

module("modules.logic.achievement.view.AchievementItemFoldAnimComp", package.seeall)

local AchievementItemFoldAnimComp = class("AchievementItemFoldAnimComp", LuaCompBase)

function AchievementItemFoldAnimComp.Get(go, foldRootGo)
	local animComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, AchievementItemFoldAnimComp)

	animComp:setFoldRoot(foldRootGo)

	return animComp
end

function AchievementItemFoldAnimComp:init(go)
	self.go = go
	self._btnpopup = gohelper.getClickWithDefaultAudio(self.go)
	self._gooff = gohelper.findChild(self.go, "#go_off")
	self._goon = gohelper.findChild(self.go, "#go_on")
end

function AchievementItemFoldAnimComp:addEventListeners()
	self._btnpopup:AddClickListener(self._btnpopupOnClick, self)
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnPlayGroupFadeAnim, self._onPlayGroupFadeAnimation, self)
end

function AchievementItemFoldAnimComp:removeEventListeners()
	self._btnpopup:RemoveClickListener()
end

function AchievementItemFoldAnimComp:_btnpopupOnClick()
	local isFold = self._mo:getIsFold()
	local groupId = self._mo:getGroupId()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, groupId, not isFold)
end

function AchievementItemFoldAnimComp:onDestroy()
	self:killTween()
end

function AchievementItemFoldAnimComp:setFoldRoot(foldRootGo)
	self._gofoldroot = foldRootGo
end

function AchievementItemFoldAnimComp:onUpdateMO(mo)
	if self._mo ~= mo then
		self:killTween()
	end

	self._mo = mo

	self:refreshUI()
end

function AchievementItemFoldAnimComp:_onPlayGroupFadeAnimation(effectParams)
	if not effectParams or effectParams.mo ~= self._mo then
		return
	end

	self._isFold = effectParams.isFold

	if not self._isFold then
		self._mo:setIsFold(self._isFold)
	end

	local orginLineHeight = effectParams.orginLineHeight
	local targetLineHeight = effectParams.targetLineHeight
	local duration = effectParams.duration

	self._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(orginLineHeight, targetLineHeight, duration, self._onOpenTweenFrameCallback, self._onOpenTweenFinishCallback, self, nil)
end

function AchievementItemFoldAnimComp:_onOpenTweenFrameCallback(value)
	self._mo:overrideLineHeight(value)

	local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()

	modelInst:onModelUpdate()
end

function AchievementItemFoldAnimComp:_onOpenTweenFinishCallback()
	self._mo:clearOverrideLineHeight()
	self._mo:setIsFold(self._isFold)

	local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()

	modelInst:onModelUpdate()
end

function AchievementItemFoldAnimComp:refreshUI()
	local isFold = self._mo:getIsFold()

	gohelper.setActive(self._goon, not isFold)
	gohelper.setActive(self._gooff, isFold)
	gohelper.setActive(self._gofoldroot, not isFold)
end

function AchievementItemFoldAnimComp:killTween()
	if self._openAnimTweenId then
		ZProj.TweenHelper.KillById(self._openAnimTweenId)

		self._openAnimTweenId = nil
	end
end

return AchievementItemFoldAnimComp
