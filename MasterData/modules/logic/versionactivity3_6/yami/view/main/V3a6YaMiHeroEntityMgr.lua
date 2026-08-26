-- chunkname: @modules/logic/versionactivity3_6/yami/view/main/V3a6YaMiHeroEntityMgr.lua

module("modules.logic.versionactivity3_6.yami.view.main.V3a6YaMiHeroEntityMgr", package.seeall)

local V3a6YaMiHeroEntityMgr = class("V3a6YaMiHeroEntityMgr", BaseView)

function V3a6YaMiHeroEntityMgr:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "root/hero")
	self._gofloat = gohelper.findChild(self.viewGO, "root/float")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiHeroEntityMgr:addEvents()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self.showHeros, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onEnterPerform, self.hideHeros, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockSeat, self.showHeros, self)
end

function V3a6YaMiHeroEntityMgr:removeEvents()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self.showHeros, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self.showHeros, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockSeat, self.showHeros, self)
end

function V3a6YaMiHeroEntityMgr:_editableInitView()
	self._heroEntities = self:getUserDataTb_()
	self._heroRootList = self:getUserDataTb_()

	for i = 1, 8 do
		self._heroRootList[i] = gohelper.findChild(self._gohero, i)
	end

	self._scene = V3a6YaMiController.instance:getScene()
end

function V3a6YaMiHeroEntityMgr:onOpen()
	self:checkLoadRes()
end

function V3a6YaMiHeroEntityMgr:onOpenFinish()
	self:showHeros()
end

function V3a6YaMiHeroEntityMgr:checkLoadRes()
	self._heroPrefab = self._heroPrefab or self.viewContainer:getRes(V3a6YaMiEnum.ResPath.HeroEntity)
end

function V3a6YaMiHeroEntityMgr:showHeros()
	gohelper.setActive(self._gohero, true)

	local heros = self:_getRamdonHeros()

	self._heroDict = {}

	local count = 0

	if heros then
		for i, heroId in ipairs(heros) do
			local mo = V3a6YaMiModel.instance:getHeroMoById(heroId)
			local item = self:_getHeroEntity(i)

			item:refreshMo(mo)
			item:refreshHero(heroId, i)
			item:appear()

			self._heroDict[heroId] = i
			count = count + 1
		end
	end

	for i = 1, #self._heroEntities do
		self._heroEntities[i]:setActive(i <= count)
	end
end

function V3a6YaMiHeroEntityMgr:_getHeroEntity(index)
	local entity = self._heroEntities[index]

	if not entity then
		local go = gohelper.clone(self._heroPrefab, self._heroRootList[index])

		recthelper.setAnchor(go.transform, 0, 0)

		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiHeroEntity)

		entity:setActive(false)

		self._heroEntities[index] = entity
	end

	return entity
end

function V3a6YaMiHeroEntityMgr:_getRamdonHeros()
	local maxSeat = V3a6YaMiModel.instance:getSeatCount()
	local unlockSeatCount = 0

	for i = 1, maxSeat do
		if V3a6YaMiModel.instance:isUnlockSeat(i) then
			unlockSeatCount = unlockSeatCount + 1
		end
	end

	local heroIdList = {}
	local heroDict = V3a6YaMiModel.instance:getHeroDict()

	for _, heroMo in pairs(heroDict) do
		if not heroMo.isLock then
			table.insert(heroIdList, heroMo.id)
		end
	end

	local heroCount = #heroIdList
	local randomCount = math.min(unlockSeatCount, heroCount)
	local heroList = {}

	if randomCount > 0 then
		math.randomseed(os.time())

		for _, index in ipairs((self:_getRamdonList(heroCount, randomCount))) do
			table.insert(heroList, heroIdList[index])
		end
	end

	return heroList
end

function V3a6YaMiHeroEntityMgr:_getRamdonList(max, count)
	local list = {}
	local list1 = {}

	for i = 1, max do
		table.insert(list1, i)
	end

	for i = 1, count do
		local idx = math.random(#list1)

		table.insert(list, table.remove(list1, idx))
	end

	return list
end

function V3a6YaMiHeroEntityMgr:hideHeros()
	gohelper.setActive(self._gohero, false)
end

function V3a6YaMiHeroEntityMgr:onClose()
	return
end

return V3a6YaMiHeroEntityMgr
