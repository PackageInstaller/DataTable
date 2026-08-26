-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushViewRule.lua

module("modules.logic.bossrush.view.V1a4_BossRushViewRule", package.seeall)

local V1a4_BossRushViewRule = class("V1a4_BossRushViewRule", WeekWalkEnemyInfoViewRule)

function V1a4_BossRushViewRule:onInitView()
	local isDiff = self.viewContainer:diffRootChild(self)

	if not isDiff then
		V1a4_BossRushViewRule.super.onInitView(self)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRushViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)

	tagicon.maskable = true
	simage.maskable = true
end

function V1a4_BossRushViewRule:_btnadditionRuleOnClick()
	self.offsetAnchor = self.offsetAnchor or {
		-180,
		0
	}

	local param = {
		offSet = self.offsetAnchor,
		ruleList = self._ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	}

	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, param)

	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

return V1a4_BossRushViewRule
