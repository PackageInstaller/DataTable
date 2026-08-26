-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeNodeItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeNodeItem", package.seeall)

local Rouge2_TalentTreeNodeItem = class("Rouge2_TalentTreeNodeItem", LuaCompBase)

function Rouge2_TalentTreeNodeItem:init(go)
	self.go = go
	self._simagetalenicon = gohelper.findChildSingleImage(self.go, "normal/#image_talenicon")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._golocked = gohelper.findChild(self.go, "#go_locked")
	self._simagetaleniconLocked = gohelper.findChildSingleImage(self.go, "#go_locked/locked/#image_taleniconLocked")
	self._gocanlight = gohelper.findChild(self.go, "#go_canlight")
	self._golighted = gohelper.findChild(self.go, "#go_lighted")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_TalentTreeNodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Rouge2_TalentTreeNodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function Rouge2_TalentTreeNodeItem:_btnclickOnClick()
	local selectId = Rouge2_TalentModel.instance:getCurSelectId()

	if selectId and selectId == self.id then
		return
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectCommonTalent, self.id)
end

function Rouge2_TalentTreeNodeItem:_editableInitView()
	self._goBigFx = gohelper.findChild(self.go, "#refresh1")
	self._goSmallFx = gohelper.findChild(self.go, "#refresh2")
	self._goreddot = gohelper.findChild(self.go, "#go_canlight/#go_reddot")

	gohelper.setActive(self._goBigFx, true)
	gohelper.setActive(self._goSmallFx, false)

	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function Rouge2_TalentTreeNodeItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_TalentTreeNodeItem:setInfo(id, index)
	self.id = id
	self.index = index
	self._config = Rouge2_OutSideConfig.instance:getTalentConfigById(id)

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a2_Rouge_Talent_Button, id)
	self:refreshUI()
end

function Rouge2_TalentTreeNodeItem:playRefresh(isRefresh)
	local animName = isRefresh and "refresh" or "idle"

	self.animator:Play(animName, 0, 0)
end

function Rouge2_TalentTreeNodeItem:playLight()
	self.animator:Play("light", 0, 0)
end

function Rouge2_TalentTreeNodeItem:refreshUI()
	local talentId = self.id
	local isActive = Rouge2_TalentModel.instance:isTalentActive(talentId)
	local canActive = false
	local isUnlock = false

	if not isActive then
		isUnlock = Rouge2_TalentModel.instance:isTalentUnlock(talentId)
		canActive = isUnlock and Rouge2_TalentModel.instance:isTalentCanActive(talentId)
	end

	gohelper.setActive(self._golocked, not isActive and not isUnlock)
	gohelper.setActive(self._gocanlight, not isActive and canActive)
	gohelper.setActive(self._golighted, isActive)
	Rouge2_IconHelper.setTalentIcon(talentId, self._simagetalenicon)
	Rouge2_IconHelper.setTalentIcon(talentId, self._simagetaleniconLocked)
	self:setSelect(false)
end

function Rouge2_TalentTreeNodeItem:setSelect(selectId)
	gohelper.setActive(self._goselect, self.id == selectId)
end

function Rouge2_TalentTreeNodeItem:onDestroy()
	return
end

return Rouge2_TalentTreeNodeItem
