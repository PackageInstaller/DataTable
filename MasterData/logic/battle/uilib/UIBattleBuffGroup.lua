-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleBuffGroup.lua

module("logic.battle.uilib.UIBattleBuffGroup", package.seeall)

local UIBattleBuffGroup = class("UIBattleBuffGroup")
local kDuration = 3

function UIBattleBuffGroup:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()

	self._buffList = {}
end

function UIBattleBuffGroup:reset()
	BattleTableUtil.clearTable(self._buffMOList)
	BattleTableUtil.clearTable(self._buffList)
	self._buffCollection:clear()
end

function UIBattleBuffGroup:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function UIBattleBuffGroup:buildUI()
	self._buffCollection = BattleReusableCollection.New(BattleBuffIcon)
	self._buffMOList = {}
	self._limitCount = 0
	self._passTime = 0
end

function UIBattleBuffGroup:destroyUI()
	BattleTableUtil.clearTable(self._buffMOList)
	BattleTableUtil.clearTable(self._buffList)
	self._buffCollection:clear()

	self._buffCollection = nil
	self._buffMOList = nil
end

function UIBattleBuffGroup:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function UIBattleBuffGroup:setLimitCount(limit)
	self._limitCount = limit
end

function UIBattleBuffGroup:updateBuffTable(buffMOTable)
	BattleTableUtil.clearTable(self._buffMOList)
	BattleTableUtil.insertfrommap(self._buffMOList, buffMOTable)

	if #self._buffMOList == 0 then
		goutil.setActive(self.mainGO, false)

		return
	end

	goutil.setActive(self.mainGO, true)

	self._passTime = 0

	self:_updateVisibleList()
	self:_judgeAutoUpdateVisibleList()
end

function UIBattleBuffGroup:luaUpdate(deltaTime)
	self._passTime = self._passTime + deltaTime

	if self._passTime >= kDuration then
		self._passTime = 0

		self:_updateVisibleList()
	end
end

function UIBattleBuffGroup:_judgeAutoUpdateVisibleList()
	return
end

function UIBattleBuffGroup:_updateVisibleList()
	self._buffCollection:clear()
	BattleTableUtil.clearTable(self._buffList)

	for i, buffMO in ipairs(self._buffMOList) do
		if i <= self._limitCount then
			local buffIcon = self._buffCollection:createInstance()

			buffIcon:setBuffMO(buffMO)
			goutil.addChildToParent(buffIcon.mainGO, self.mainGO)
			table.insert(self._buffList, buffIcon)
		else
			break
		end
	end
end

function UIBattleBuffGroup:setMask(isMask)
	for k, buffIcon in pairs(self._buffList) do
		buffIcon:setMask(isMask)
	end
end

return UIBattleBuffGroup
