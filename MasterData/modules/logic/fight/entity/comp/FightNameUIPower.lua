-- chunkname: @modules/logic/fight/entity/comp/FightNameUIPower.lua

module("modules.logic.fight.entity.comp.FightNameUIPower", package.seeall)

local FightNameUIPower = class("FightNameUIPower", UserDataDispose)

function FightNameUIPower:ctor(parentView, powerId)
	self:__onInit()

	self._parentView = parentView
	self._entity = self._parentView.entity
	self._powerId = powerId
	self._objList = self:getUserDataTb_()
	self._cloneComp = UICloneComponent.New()
	self._point_ani_sequence = {}
end

function FightNameUIPower:onOpen()
	self._energyRoot = gohelper.findChild(self._parentView:getUIGO(), "layout/energy")
	self._eneryItem = gohelper.findChild(self._parentView:getUIGO(), "layout/energy/energyitem")

	self:_correctObjCount()
	self:_refreshUI()
	self.addEventCb(self, FightController.instance, FightEvent.PowerMaxChange, self._onPowerMaxChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self._onPowerChange, self)
end

function FightNameUIPower:_getPowerData()
	local entityMO = self._entity:getMO()

	if entityMO then
		return (entityMO:getPowerInfo(self._powerId))
	end
end

function FightNameUIPower:_refreshUI()
	local powerData = self:_getPowerData()

	if powerData then
		for i, obj in ipairs(self._objList) do
			local light = gohelper.findChild(obj, "light")

			gohelper.setActive(light, i <= powerData.num)
		end
	end
end

function FightNameUIPower:_onPowerMaxChange(entityId, powerId)
	if self._entity.id == entityId and self._powerId == powerId then
		self:_correctObjCount()
		self:_refreshUI()
	end
end

function FightNameUIPower:_onPowerChange(entityId, powerId, oldNum, newNum)
	if self._entity.id == entityId and self._powerId == powerId and oldNum ~= newNum then
		table.insert(self._point_ani_sequence, {
			oldNum,
			newNum
		})

		if self._pointPlayType == 1 and oldNum < newNum then
			self._change_ani_playing = nil
		elseif self._pointPlayType == 2 and newNum < oldNum then
			self._change_ani_playing = nil
		end

		if not self._change_ani_playing then
			self:_playPointChangeAni()
		end
	end
end

local aniOpen = "open"
local aniClose = "close"

function FightNameUIPower:_playPointChangeAni()
	local ani_data = table.remove(self._point_ani_sequence, 1)

	if ani_data then
		local oldNum = ani_data[1]
		local newNum = ani_data[2]

		if self._entity then
			if self._entity then
				if oldNum < newNum then
					self._pointPlayType = 1

					self:_playAni(aniOpen, oldNum, newNum)
				elseif newNum < oldNum then
					self._pointPlayType = 2

					self:_playAni(aniClose, oldNum, newNum)
				end
			end
		end
	else
		self._change_ani_playing = false
		self._pointPlayType = nil

		if self._entity and self._entity:getMO() then
			self:_refreshUI()
		end
	end
end

local stateName2MontionName = {
	open = "energyitem_open",
	close = "energyitem_close"
}

function FightNameUIPower:_playAni(stateName, oldNum, newNum)
	local tarAni
	local min = math.min(oldNum, newNum)
	local max = math.max(oldNum, newNum)

	for i = min + 1, max do
		local obj = self._objList[i]

		if obj then
			local light = gohelper.findChild(obj, "light")

			gohelper.setActive(light, true)

			local ani = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator))

			ani:Play(stateName, 0, 0)

			ani.speed = FightModel.instance:getSpeed()
			self._change_ani_playing = true
			tarAni = ani
		end
	end

	local duration = GameUtil.getMotionDuration(tarAni, stateName2MontionName[stateName])

	TaskDispatcher.runDelay(self._playPointChangeAni, self, duration)
end

function FightNameUIPower:_correctObjCount()
	local powerData = self:_getPowerData()

	if powerData then
		gohelper.setActive(self._energyRoot, true)
		self._cloneComp:createObjList(self, self._onItemShow, powerData.max or 0, self._energyRoot, self._eneryItem)
	else
		gohelper.setActive(self._energyRoot, false)
	end
end

function FightNameUIPower:_onItemShow(obj, data, index)
	local ani = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator))

	ani:Play("idle", 0, 0)

	self._objList[index] = self._objList[index] or obj
end

function FightNameUIPower:releaseSelf()
	self._cloneComp:releaseSelf()
	self:__onDispose()
end

return FightNameUIPower
