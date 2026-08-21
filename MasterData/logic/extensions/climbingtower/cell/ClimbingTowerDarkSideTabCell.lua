-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/cell/ClimbingTowerDarkSideTabCell.lua

module("logic.extensions.climbingtower.cell.ClimbingTowerDarkSideTabCell", package.seeall)

local M = class("ClimbingTowerDarkSideTabCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))

	goutil.setActive(self._btnClick.gameObject, true)

	self._goDisasterPoint = goutil.findChild(self.mainGO, "imgDisasterPoint")
	self._goMarkNormal = goutil.findChild(self.mainGO, "normalType")
	self._goMarkSelect = goutil.findChild(self.mainGO, "select")
	self._goMarkLock = goutil.findChild(self.mainGO, "lockType")
	self._goMarkFinish = goutil.findChild(self.mainGO, "finishType")
	self._txtNumber = goutil.findChildComponent(self.mainGO, "number/txtNumber", UIComponentType.Text)

	goutil.setActive(goutil.findChild(self.mainGO, "number").gameObject, true)

	self._pointer = {}
	self._pointer[ClimbingTowerEnum.EntryTyp.Normal] = {
		[ClimbingTowerEnum.PointerTyp.Hour] = goutil.findChildComponent(self.mainGO, "normalType/imgPointer1/imgPointer4", UIComponentType.RectTransform),
		[ClimbingTowerEnum.PointerTyp.Min] = goutil.findChildComponent(self.mainGO, "normalType/imgPointer1/imgPointer3", UIComponentType.RectTransform)
	}
	self._pointer[ClimbingTowerEnum.EntryTyp.Finish] = {
		[ClimbingTowerEnum.PointerTyp.Hour] = goutil.findChildComponent(self.mainGO, "finishType/imgPointer1/imgPointer4", UIComponentType.RectTransform),
		[ClimbingTowerEnum.PointerTyp.Min] = goutil.findChildComponent(self.mainGO, "finishType/imgPointer1/imgPointer3", UIComponentType.RectTransform)
	}
	self._pointer[ClimbingTowerEnum.EntryTyp.Lock] = {
		[ClimbingTowerEnum.PointerTyp.Hour] = goutil.findChildComponent(self.mainGO, "lockType/imgPointer1/imgPointer4", UIComponentType.RectTransform),
		[ClimbingTowerEnum.PointerTyp.Min] = goutil.findChildComponent(self.mainGO, "lockType/imgPointer1/imgPointer3", UIComponentType.RectTransform)
	}
end

function M:destroyUI()
	self.mainGO = nil
	self._btnClick = nil
	self._goDisasterPoint = nil
	self._goMarkNormal = nil
	self._goMarkSelect = nil
	self._goMarkLock = nil
	self._goMarkFinish = nil
	self._txtNumber = nil
	self._pointer = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self:setSelected(false)
end

function M:onExit()
	self._handler = nil
	self._dungeonId = nil
	self._towerCfgId = nil
	self._entryTyp = nil
end

function M:getMainGo()
	return self.mainGO
end

function M:setActive(active)
	goutil.setActive(self:getMainGo(), active)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setEntryTyp(entryTyp)
	self._entryTyp = entryTyp

	goutil.setActive(self._goMarkNormal, entryTyp == ClimbingTowerEnum.EntryTyp.Normal)
	goutil.setActive(self._goMarkFinish, entryTyp == ClimbingTowerEnum.EntryTyp.Finish)
	goutil.setActive(self._goMarkLock, entryTyp == ClimbingTowerEnum.EntryTyp.Lock)
	goutil.setActive(self._goDisasterPoint, entryTyp ~= ClimbingTowerEnum.EntryTyp.Finish)
end

function M:getEntryTyp()
	return self._entryTyp
end

function M:setTimePointer(entryTyp, dungeonData)
	local pointerGroup = self._pointer[entryTyp]

	if pointerGroup then
		local timeLst = dungeonData:getDifficultAngle()
		local timeData = timeLst[entryTyp]
		local hour, min = -1, -1

		if timeData and timeData.hour >= 0 then
			hour = timeData.hour
			min = timeData.min
		else
			local nowTime = ServerTime.now()

			hour = tonumber(os.date("%I", nowTime))
			min = tonumber(os.date("%M", nowTime))
		end

		local zeroAngle = 90
		local dir = -1
		local angleZHour, angleZMinute = ClimbingTowerConfig.instance:getTimePointerAngleZ(hour, min)

		Astral.TransformUtil.SetLocalRotation(pointerGroup[ClimbingTowerEnum.PointerTyp.Hour], 0, 0, zeroAngle + angleZHour * dir)
		Astral.TransformUtil.SetLocalRotation(pointerGroup[ClimbingTowerEnum.PointerTyp.Min], 0, 0, zeroAngle + angleZMinute * dir)
	end
end

function M:getIsLock()
	return self:getEntryTyp() == ClimbingTowerEnum.EntryTyp.Lock
end

function M:getDungeonId()
	return self._dungeonId
end

function M:getTowerCfgId()
	return self._towerCfgId
end

function M:setSelected(selected)
	goutil.setActive(self._goMarkSelect, selected)
end

function M:setData(dungeonData, index)
	self._dungeonId = dungeonData:getDungeonId()
	self._towerCfgId = dungeonData:getTowerCfgId()

	local entryTitleName, entryTyp

	if dungeonData:getIsLock() then
		entryTyp = ClimbingTowerEnum.EntryTyp.Lock
		entryTitleName = string.format("<color=#323232>%s</color>", dungeonData:getIndex())
	else
		entryTyp = dungeonData:getIsClear() and ClimbingTowerEnum.EntryTyp.Finish or ClimbingTowerEnum.EntryTyp.Normal
		entryTitleName = string.format("<color=#E7E7E7>%s</color>", dungeonData:getIndex())
	end

	self:setEntryTyp(entryTyp)
	self:setTimePointer(entryTyp, dungeonData)
	self:updateNumber(entryTitleName)
end

function M:updateNumber(str)
	self._txtNumber.text = str
end

function M:_onClickSelf()
	if self._handler then
		self._handler:onEntryTabClick(self)
	end
end

return M
