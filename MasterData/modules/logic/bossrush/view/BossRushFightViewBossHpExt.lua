-- chunkname: @modules/logic/bossrush/view/BossRushFightViewBossHpExt.lua

module("modules.logic.bossrush.view.BossRushFightViewBossHpExt", package.seeall)

local BossRushFightViewBossHpExt = class("BossRushFightViewBossHpExt", BaseViewExtended)

function BossRushFightViewBossHpExt:onInitView()
	self._txtmyblood = gohelper.findChildText(self.viewGO, "#txt_myblood")
	self._txtbloodnum = gohelper.findChildText(self.viewGO, "#txt_bloodnum")
	self._txtbloodnum.text = ""
end

function BossRushFightViewBossHpExt:onRefreshViewParam(parentGo)
	self._parentGo = parentGo
end

function BossRushFightViewBossHpExt:onOpen()
	self._isInitedInfinitBlood = false

	gohelper.setSiblingAfter(self.viewGO, self._parentGo)
	self:_setMyBossBlood(BossRushModel.instance:getBossCurHP(), BossRushModel.instance:getBossCurMaxHP())
	BossRushController.instance:registerCallback(BossRushEvent.OnBossDeadSumChange, self._onBossDeadSumChange, self)
	BossRushController.instance:registerCallback(BossRushEvent.OnHpChange, self._onHpChange, self)
end

function BossRushFightViewBossHpExt:onClose()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnHpChange, self._onHpChange, self)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnBossDeadSumChange, self._onBossDeadSumChange, self)

	self._isInitedInfinitBlood = false
end

function BossRushFightViewBossHpExt:_onBossDeadSumChange(last, cur)
	self:_setBossDeadNum(cur)
end

function BossRushFightViewBossHpExt:_onHpChange(last, cur)
	local max = BossRushModel.instance:getBossCurMaxHP()

	self:_setMyBossBlood(cur, max)
end

function BossRushFightViewBossHpExt:_setMyBossBlood(value, max)
	local hpCurCount = BossRushModel.instance:getBossBloodCount()
	local hpMaxCount = BossRushModel.instance:getBossBloodMaxCount()
	local percent = string.format("%.2f%%", value / max * 100)

	if hpCurCount == 1 and value == 0 and not self._isInitedInfinitBlood then
		self:_setBossDeadNum(0)

		self._isInitedInfinitBlood = true
	end

	self._txtmyblood.text = string.format("%s/%s (%s) %s/%s", value, max, percent, math.max(0, hpCurCount - 1), math.max(0, hpMaxCount - 1))
end

function BossRushFightViewBossHpExt:_setBossDeadNum(num)
	self._txtbloodnum.text = string.format("<color=#FFFF00>(x%s)</color>", num)
end

return BossRushFightViewBossHpExt
