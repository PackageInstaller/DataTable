-- chunkname: @modules/logic/warmup/view/WarmUp_rewarditem.lua

module("modules.logic.warmup.view.WarmUp_rewarditem", package.seeall)

local WarmUp_rewarditem = class("WarmUp_rewarditem", RougeSimpleItemBase)

function WarmUp_rewarditem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function WarmUp_rewarditem:addEvents()
	return
end

function WarmUp_rewarditem:removeEvents()
	return
end

function WarmUp_rewarditem:ctor(ctorParam)
	WarmUp_rewarditem.super.ctor(self, ctorParam)
end

function WarmUp_rewarditem:onDestroyView()
	WarmUp_rewarditem.super.onDestroyView(self)
end

function WarmUp_rewarditem:_editableInitView()
	WarmUp_rewarditem.super._editableInitView(self)

	self._go_hasget = gohelper.findChild(self.viewGO, "go_receive/go_hasget")
	self._goreceive = gohelper.findChild(self.viewGO, "go_receive")
	self._gocanget = gohelper.findChild(self.viewGO, "go_canget")
	self._icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(self.viewGO, "go_icon"))
	self._hasgetAnim = self._go_hasget:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._goreceive, true)
end

function WarmUp_rewarditem:onSelect(isSelect)
	gohelper.setActive(self._goDateSelected, isSelect)
	gohelper.setActive(self._txtDateUnSelectedGo, not isSelect)
end

function WarmUp_rewarditem:_getRLOC(episodeId)
	return self:_assetGetViewContainer():getRLOC(episodeId)
end

function WarmUp_rewarditem:_getCurSelectedEpisode()
	return self:_assetGetViewContainer():getCurSelectedEpisode()
end

function WarmUp_rewarditem:_isWaitingPlayHasGetAnim()
	return self:_assetGetViewContainer():isWaitingPlayHasGetAnim()
end

function WarmUp_rewarditem:setData(mo)
	self._mo = mo

	local itemCo = mo
	local episodeId = self:_getCurSelectedEpisode()
	local isRecevied, _, _, canGetReward = self:_getRLOC(episodeId)
	local isShowReceived = isRecevied and not self:_isWaitingPlayHasGetAnim()

	self._icon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	self._icon:setCountFontSize(42)
	self._icon:setScale(0.5)
	self:_setActive_canget(canGetReward)
	self:_setActive_hasget(isShowReceived)

	if isShowReceived then
		self:_set_Received()
	end
end

local kHasGetAnim = "go_hasget_in"
local kIdleAnim = "go_hasget_idle"

function WarmUp_rewarditem:playAnim_hasget(isIdle)
	if isIdle then
		if not kIdleAnim then
			local animName = kHasGetAnim

			self:_setActive_canget(false)
			self:_setActive_hasget(not isIdle)
			self._hasgetAnim:Play(animName, 0, 0)
		end
	end
end

function WarmUp_rewarditem:_set_Received()
	self._hasgetAnim:Play(kHasGetAnim, 0, 1)
end

function WarmUp_rewarditem:_setActive_canget(isActive)
	gohelper.setActive(self._gocanget, isActive)
end

function WarmUp_rewarditem:_setActive_hasget(isActive)
	gohelper.setActive(self._go_hasget, isActive)
end

return WarmUp_rewarditem
