-- chunkname: @modules/logic/fight/entity/mgr/FightNameMgr.lua

module("modules.logic.fight.entity.mgr.FightNameMgr", package.seeall)

local FightNameMgr = class("FightNameMgr")

function FightNameMgr:ctor()
	self._hasReplaceNameBar = nil
	self._nameParent = nil
	self._fightNameUIList = nil
end

function FightNameMgr:init()
	local hudLayer = self:getHudGO()

	self._nameParent = gohelper.create2d(hudLayer, "NameBar")
	self._fightNameUIList = {}
end

function FightNameMgr:getHudGO()
	return ViewMgr.instance:getUILayer(UILayerName.Hud)
end

function FightNameMgr:dispose()
	self._hasReplaceNameBar = nil

	if self._nameParent then
		gohelper.destroy(self._nameParent)

		self._nameParent = nil
	end

	self._fightNameUIList = {}

	TaskDispatcher.cancelTask(self._delayAdujstUISibling, self)
end

function FightNameMgr:onRestartStage()
	self._fightNameUIList = {}

	TaskDispatcher.cancelTask(self._delayAdujstUISibling, self)
end

function FightNameMgr:getNameParent()
	return self._nameParent
end

function FightNameMgr:register(fightNameUI)
	table.insert(self._fightNameUIList, fightNameUI)
	TaskDispatcher.cancelTask(self._delayAdujstUISibling, self)
	TaskDispatcher.runDelay(self._delayAdujstUISibling, self, 1)
	self:_replaceNameBar()
end

function FightNameMgr:unregister(fightNameUI)
	tabletool.removeValue(self._fightNameUIList, fightNameUI)
end

function FightNameMgr:_replaceNameBar()
	if self._hasReplaceNameBar or #self._fightNameUIList == 0 then
		return
	end

	local first = self._fightNameUIList[1]
	local firstGO = first:getUIGO()

	if gohelper.isNil(firstGO) then
		return
	end

	self._hasReplaceNameBar = true

	local nameBarGOWithCanvas = gohelper.findChild(firstGO, "NameBar")

	if gohelper.isNil(nameBarGOWithCanvas) then
		return
	end

	local hudLayer = self:getHudGO()
	local newNameParent = gohelper.clone(nameBarGOWithCanvas, hudLayer, "NameBar")

	if gohelper.isNil(self._nameParent) or gohelper.isNil(newNameParent) then
		return
	end

	local nameParentTr = self._nameParent.transform
	local newNameParentTr = newNameParent.transform
	local count = nameParentTr.childCount

	for i = count - 1, 0, -1 do
		local tr = nameParentTr:GetChild(i)

		if not gohelper.isNil(tr) then
			tr:SetParent(newNameParentTr, false)
		end
	end

	gohelper.setSiblingAfter(newNameParent, self._nameParent)
	gohelper.destroy(self._nameParent)

	self._nameParent = newNameParent

	gohelper.setActive(self._nameParent, true)
end

function FightNameMgr:_delayAdujstUISibling()
	self:_replaceNameBar()

	if #self._fightNameUIList <= 1 then
		return
	end

	table.sort(self._fightNameUIList, function(nameUI1, nameUI2)
		local pos1 = nameUI1.entity.go.transform.position
		local pos2 = nameUI2.entity.go.transform.position
		local hasYaMiShield1 = FightMsgMgr.sendMsg(FightMsgId.GetYaMiShieldData, nameUI1.entity.id)
		local hasYaMiShield2 = FightMsgMgr.sendMsg(FightMsgId.GetYaMiShieldData, nameUI2.entity.id)

		if hasYaMiShield1 and not hasYaMiShield2 then
			return false
		elseif not hasYaMiShield1 and hasYaMiShield2 then
			return true
		elseif pos1.z ~= pos2.z then
			return pos1.z > pos2.z
		elseif pos1.x ~= pos2.x then
			return math.abs(pos1.x) > math.abs(pos2.x)
		else
			return nameUI1.entity.id > nameUI2.entity.id
		end
	end)
	gohelper.setAsFirstSibling(self._fightNameUIList[1]:getGO())

	for i = 2, #self._fightNameUIList do
		local curNameUI = self._fightNameUIList[i]
		local preNameUI = self._fightNameUIList[i - 1]

		gohelper.setSiblingAfter(curNameUI:getGO(), preNameUI:getGO())
	end
end

FightNameMgr.instance = FightNameMgr.New()

return FightNameMgr
