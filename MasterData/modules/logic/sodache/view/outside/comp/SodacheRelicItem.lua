-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheRelicItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheRelicItem", package.seeall)

local SodacheRelicItem = class("SodacheRelicItem", ListScrollCell)

function SodacheRelicItem:init(go)
	self.transform = go.transform

	local goCard = gohelper.findChild(go, "CardItem")

	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(goCard, SodacheCardItem)

	self.cardItem:showInfo()
	self.cardItem:setShowStar(true)

	self.goGrayBg = gohelper.findChild(go, "go_GrayBg")
	self.goActiveBg = gohelper.findChild(go, "go_ActiveBg")
	self.goMaxBg = gohelper.findChild(go, "go_MaxBg")
	self.goActiveTag = gohelper.findChild(go, "tag/go_ActiveTag")
	self.goUpTag = gohelper.findChild(go, "tag/go_UpTag")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function SodacheRelicItem:addEventListeners()
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgradeOneKey, self.onRelicUpgradeOneKey, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgrade, self.onRelicUpgrade, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicScrollMove, self.refreshPos, self)
end

function SodacheRelicItem:onUpdateMO(mo)
	self.data = mo

	self.cardItem:updateMo(SodacheCardMo.Create(mo.id))
	self:refreshActiveStatus()
	self:refreshPos()
end

function SodacheRelicItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshActiveStatus, self)
end

function SodacheRelicItem:onClick()
	ViewMgr.instance:openView(ViewName.SodacheRelicUpgradeView, {
		data = self.data,
		index = self._index
	})
end

function SodacheRelicItem:refreshActiveStatus()
	local level = self.data.level
	local maxLevel = self.data.maxLevel

	gohelper.setActive(self.goGrayBg, level == 0)
	gohelper.setActive(self.goActiveBg, level ~= 0 and level < maxLevel)
	gohelper.setActive(self.goMaxBg, level == maxLevel)

	if level == maxLevel then
		gohelper.setActive(self.goActiveTag, false)
		gohelper.setActive(self.goUpTag, false)
	else
		local canUp = true
		local nextCfg = lua_sodache_upgrade.configDict[self.data.id][level + 1]
		local params = GameUtil.splitString2(nextCfg.cost, true, "&", ":")

		for _, param in ipairs(params) do
			local itemCnt = SodacheUtil.getItemCount(param[1])

			if itemCnt < param[2] then
				canUp = false

				break
			end
		end

		gohelper.setActive(self.goActiveTag, canUp and level == 0)
		gohelper.setActive(self.goUpTag, canUp and level ~= 0)
	end

	self.cardItem:setRelicGray(level == 0)
end

function SodacheRelicItem:onRelicUpgrade(mo)
	self:refreshActiveStatus()

	if self.data.id == mo.id then
		self.cardItem:refreshStar()
	end
end

function SodacheRelicItem:onRelicUpgradeOneKey(relics)
	local isChange = false

	for _, relic in ipairs(relics) do
		if relic.id == self.data.id then
			isChange = true

			break
		end
	end

	if isChange then
		self.cardItem:playLevelUp(self.data.level == self.data.maxLevel)
		TaskDispatcher.runDelay(self.refreshActiveStatus, self, 0.34)
	else
		self:refreshActiveStatus()
	end
end

SodacheRelicItem.anglePerItem = 20
SodacheRelicItem.arcRadius = 350

function SodacheRelicItem:refreshPos()
	local camera = CameraMgr.instance:getMainCamera()
	local pos = camera:WorldToViewportPoint(self.transform.position)
	local indexScale = (pos.x - 0.5) * 5
	local angleOffset = indexScale * SodacheRelicItem.anglePerItem + 180
	local angleRad = angleOffset * Mathf.Deg2Rad
	local yBase = 350
	local y = math.cos(angleRad) * SodacheRelicItem.arcRadius + yBase

	recthelper.setAnchorY(self.transform, y)
	transformhelper.setLocalRotation(self.transform, 0, 0, indexScale * 6)
end

return SodacheRelicItem
