-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191BossHpItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191BossHpItem", package.seeall)

local Act191BossHpItem = class("Act191BossHpItem", LuaCompBase)

function Act191BossHpItem:init(go)
	self.go = go
	self.hpImg = gohelper.findChildImage(go, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	self.signRoot = gohelper.findChild(go, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	self.signItem = gohelper.findChild(go, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	self.hpEffect = gohelper.findChild(go, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(self.hpEffect, false)
end

function Act191BossHpItem:addEventListeners()
	return
end

function Act191BossHpItem:onStart()
	self.data = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]
	self.curRate = (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000
	self.bgWidth = recthelper.getWidth(self.signRoot.transform)
	self.halfWidth = self.bgWidth / 2
	self.itemDataList = GameUtil.splitString2(self.data.bloodReward, true)

	self:refreshItems()
	TaskDispatcher.runDelay(self.openAnimFinish, self, 1)
end

function Act191BossHpItem:openAnimFinish()
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(1, self.curRate, 0.3, self.frameCallback, self.tweenDone, self, nil, EaseType.Linear)
end

function Act191BossHpItem:frameCallback(value)
	self.hpImg.fillAmount = value
end

function Act191BossHpItem:tweenDone()
	self.tweenId = nil
end

function Act191BossHpItem:refreshItems()
	gohelper.CreateObjList(self, self.onItemShow, self.itemDataList, self.signRoot, self.signItem)
	gohelper.setActive(self.signItem, false)
end

function Act191BossHpItem:onItemShow(obj, data, index)
	local unfinish = gohelper.findChild(obj, "unfinish")
	local finish = gohelper.findChild(obj, "finished")
	local hp = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_MIN_HP_RATE]
	local signHp = data[1]

	if hp <= signHp then
		gohelper.setActive(unfinish, false)
		gohelper.setActive(finish, true)
	else
		gohelper.setActive(unfinish, true)
		gohelper.setActive(finish, false)
	end

	local posX = signHp / 1000 * self.bgWidth - self.halfWidth

	recthelper.setAnchorX(obj.transform, posX)
end

function Act191BossHpItem:onDestroy()
	TaskDispatcher.cancelTask(self.openAnimFinish, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

return Act191BossHpItem
