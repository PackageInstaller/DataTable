-- chunkname: @modules/logic/dungeon/view/DungeonExploreLevelItem.lua

module("modules.logic.dungeon.view.DungeonExploreLevelItem", package.seeall)

local DungeonExploreLevelItem = class("DungeonExploreLevelItem", LuaCompBase)

function DungeonExploreLevelItem:init(go)
	self._goselected = gohelper.findChild(go, "#go_selected")
	self._btnclick = gohelper.findChildButton(go, "#btn_click")
	self._txtindex = gohelper.findChildText(go, "#txt_index")
	self._goline = gohelper.findChild(go, "line")
	self._goexploring = gohelper.findChild(go, "#go_exploring")
	self._golock = gohelper.findChild(go, "#go_lock")

	self._btnclick:AddClickListener(self._click, self)

	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._progressItems = {}

	for i = 1, 3 do
		self._progressItems[i] = {}
		self._progressItems[i].dark = gohelper.findChild(go, "progress/#go_progressitem" .. i .. "/dark")
		self._progressItems[i].light = gohelper.findChild(go, "progress/#go_progressitem" .. i .. "/light")
		self._progressItems[i].unlockEffect = gohelper.findChild(go, "progress/#go_progressitem" .. i .. "/click_light")
	end

	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, self.onLevelClick, self)
end

function DungeonExploreLevelItem:setData(config, index, isLast)
	self._index = index
	self._config = config
	self._txtindex.text = index

	gohelper.setActive(self._goline, not isLast)

	self._lock = false

	local mapCo = lua_explore_scene.configDict[config.chapterId][config.id]

	if not mapCo then
		logError("缺失密室地图配置" .. config.chapterId .. " + " .. config.id)

		return
	end

	gohelper.setActive(self._goexploring, mapCo.id == ExploreSimpleModel.instance.nowMapId)
	gohelper.setActive(self._golock, not ExploreSimpleModel.instance:getMapIsUnLock(mapCo.id))

	if not ExploreSimpleModel.instance:getMapIsUnLock(mapCo.id) then
		self._txtindex.text = ""
		self._lock = true
	end

	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getCoinCountByMapId(mapCo.id)
	local isPurpleCoinFull = purpleCoin == purpleCoinTotal
	local isGoldCoinFull = goldCoin == goldCoinTotal
	local isBonusFull = bonusNum == bonusNumTotal

	gohelper.setActive(self._progressItems[1].dark, not isPurpleCoinFull)
	gohelper.setActive(self._progressItems[1].light, isPurpleCoinFull)
	gohelper.setActive(self._progressItems[2].dark, not isGoldCoinFull)
	gohelper.setActive(self._progressItems[2].light, isGoldCoinFull)
	gohelper.setActive(self._progressItems[3].dark, not isBonusFull)
	gohelper.setActive(self._progressItems[3].light, isBonusFull)

	if not ((not self._lock or nil) and ExploreSimpleModel.instance:getEpisodeIsShowUnlock(config.chapterId, config.id)) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		self._anim:Play("unlock", 0, 0)
		ExploreSimpleModel.instance:markEpisodeShowUnlock(config.chapterId, config.id)
	else
		self._anim:Play("idle", 0, 0)
	end

	self:_hideUnlockEffect()

	local haveUnlockShow = false

	if isBonusFull and not ExploreSimpleModel.instance:getCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.Bonus, config.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.Bonus, config.id)
		gohelper.setActive(self._progressItems[3].unlockEffect, true)

		haveUnlockShow = true
	end

	if isGoldCoinFull and not ExploreSimpleModel.instance:getCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.GoldCoin, config.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.GoldCoin, config.id)
		gohelper.setActive(self._progressItems[2].unlockEffect, true)

		haveUnlockShow = true
	end

	if isPurpleCoinFull and not ExploreSimpleModel.instance:getCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.PurpleCoin, config.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(config.chapterId, ExploreEnum.CoinType.PurpleCoin, config.id)
		gohelper.setActive(self._progressItems[1].unlockEffect, true)

		haveUnlockShow = true
	end

	TaskDispatcher.cancelTask(self._hideUnlockEffect, self)

	if haveUnlockShow then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		TaskDispatcher.runDelay(self._hideUnlockEffect, self, 1.5)
	end
end

function DungeonExploreLevelItem:_hideUnlockEffect()
	for i = 1, 3 do
		gohelper.setActive(self._progressItems[i].unlockEffect, false)
	end
end

function DungeonExploreLevelItem:_click()
	if self._lock then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreLock)

		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, self._index)
end

function DungeonExploreLevelItem:onLevelClick(index)
	gohelper.setActive(self._goselected, index == self._index)
end

function DungeonExploreLevelItem:destroy()
	TaskDispatcher.cancelTask(self._hideUnlockEffect, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, self.onLevelClick, self)
	self._btnclick:RemoveClickListener()

	self._index = 0
	self._config = nil
	self._goselected = nil
	self._btnclick = nil
	self._txtindex = nil
	self._goline = nil
	self._goexploring = nil
	self._golock = nil

	for k in pairs(self._progressItems) do
		for kk in pairs(self._progressItems[k]) do
			self._progressItems[k][kk] = nil
		end

		self._progressItems[k] = nil
	end
end

return DungeonExploreLevelItem
