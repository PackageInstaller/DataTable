-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleShowQueue.lua

BattleShowQueue = class("BattleShowQueue", objectlua.Object, _M)

local battleShowType = {
	bossShow = "bossShow",
	masterShow = "masterShow",
	battleItem = "battleItem",
	heroShow = "heroShow"
}

function BattleShowQueue:initialize()
	super.initialize(self)

	self._queue = {}
end

function BattleShowQueue:dispose()
	self._queue = nil
end

function BattleShowQueue:addHeroShow(heroShow)
	self._queue[#self._queue + 1] = {
		id = heroShow,
		showType = battleShowType.heroShow
	}

	self:show()
end

function BattleShowQueue:addMasterShow(friend, enemy)
	self._queue[#self._queue + 1] = {
		friendMaster = friend,
		enemyMaster = enemy,
		showType = battleShowType.masterShow
	}

	self:show()
end

function BattleShowQueue:addBattleItemShow(data, handler)
	if data.extraCards2 and #data.extraCards2 > 0 or data.extraTactics and #data.extraTactics > 0 then
		self._queue[#self._queue + 1] = {
			extraCards = data.extraCards2,
			tactics = data.extraTactics,
			handler = handler,
			showType = battleShowType.battleItem
		}

		self:show()
	end
end

function BattleShowQueue:addFirstBossShow()
	local queue = {}

	queue[1] = {
		paseSta = true,
		showType = battleShowType.bossShow
	}

	for _, v in ipairs(self._queue) do
		queue[#queue + 1] = v
	end

	self._queue = queue

	self:show()
end

function BattleShowQueue:addEndBossShow()
	self._queue[#self._queue + 1] = {
		showType = battleShowType.bossShow
	}

	self:show()
end

function BattleShowQueue:setViewContext(context)
	self._viewContext = context
	self._mainMediator = context:getValue("BattleMainMediator")
	self._battleUIMediator = context:getValue("BattleUIMediator")
end

function BattleShowQueue:show()
	if not self._battleUIMediator.getReadyStartSta or not self._battleUIMediator:getReadyStartSta() then
		return
	end

	if #self._queue > 0 then
		local infoFirst = table.remove(self._queue, 1)

		if infoFirst then
			if infoFirst.showType == battleShowType.heroShow and infoFirst.id then
				self._mainMediator:showHero(infoFirst.id)
			elseif infoFirst.showType == battleShowType.bossShow then
				self._mainMediator:showBossCome(infoFirst.paseSta)
			elseif infoFirst.showType == battleShowType.masterShow then
				self._mainMediator:showMaster(infoFirst.friendMaster, infoFirst.enemyMaster)
			elseif infoFirst.showType == battleShowType.battleItem then
				delayCallByTime(100, function()
					if not DisposableObject:isDisposed(self) then
						self._mainMediator:showBattleItem(infoFirst)
					end
				end)
			end
		end
	end
end
