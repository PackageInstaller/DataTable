-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEntranceCellComponent.lua

module("logic.extensions.dungeon.view.DungeonEntranceCellComponent", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("DungeonEntranceCellComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._nameTxt = registry:findUIElement("entry_item_1212443654", UIComponentType.Text)
	self._iconImg = registry:findUIElement("entry_item_1855861361", UIComponentType.Image)
	self._lockGo = registry:findUIElement("entry_item_-452580227")
	self._timeTxt = registry:findUIElement("entry_item_562437007", UIComponentType.Text)
	self._timeSignGo = registry:findUIElement("entry_item_-469101358")
	self._normalSignGo = registry:findUIElement("branchline_entry_item_1564107940")
	self._difficultSignGo = registry:findUIElement("branchline_entry_item_1410542261")
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("entry_item_1855861361"))

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:_clickSelf()
	self._cell:setSelect(true)
end

function M:updateData(entranceMo)
	self._entranceMo = entranceMo
	self._nameTxt.text = entranceMo:getName()

	IconLoader.setSprite(self._iconImg, IconType.DynSpriteAtlas_DungeonEntrance, entranceMo:getBgName())
	self:_handleDungeonProgress()
	goutil.setActive(self._lockGo, false)

	if entranceMo:getStartTime() then
		goutil.setActive(self._timeTxt.gameObject, true)

		if ServerTime.now() < entranceMo:getStartTime() then
			goutil.setActive(self._timeSignGo.gameObject, false)
			goutil.setActive(self._lockGo, true)

			local second = entranceMo:getStartTime() - ServerTime.now()
			local day = math.floor(second / 86400)
			local hour = math.floor((second - day * 86400) / 3600)

			self._timeTxt.text = string.format("%02d天%02d时", day, hour)
			self._timeTxt.color = Astral.ColorUtil.ParseColor("#FFFFFF")
		elseif entranceMo:getWeekDays() then
			self:_handleWeekDays()
		else
			goutil.setActive(self._lockGo, false)
			goutil.setActive(self._timeSignGo, true)
			goutil.setActive(self._timeTxt.gameObject, true)

			local second = entranceMo:getEndTime() - ServerTime.now()
			local day = math.floor(second / 86400)
			local hour = math.floor((second - day * 86400) / 3600)

			self._timeTxt.text = string.format("%02d天%02d时", day, hour)
		end
	elseif entranceMo:getWeekDays() then
		self:_handleWeekDays()
	else
		goutil.setActive(self._timeSignGo, false)
		goutil.setActive(self._timeTxt.gameObject, false)
	end
end

function M:_handleDungeonProgress()
	goutil.setActive(self._normalSignGo, false)
	goutil.setActive(self._difficultSignGo, false)
end

function M:_handleWeekDays()
	local entranceMo = self._entranceMo

	if entranceMo:getIsInWeekDay() then
		goutil.setActive(self._lockGo, false)
		goutil.setActive(self._timeSignGo, true)
		goutil.setActive(self._timeTxt.gameObject, true)

		local second = 86400 - ServerTime.now() % 86400
		local hour = math.floor(second / 3600)
		local minute = math.floor((second - hour * 3600) / 60)

		self._timeTxt.text = string.format("剩余%02d时%02d分", hour, minute)
	else
		goutil.setActive(self._lockGo, true)
		goutil.setActive(self._timeSignGo, false)
		goutil.setActive(self._timeTxt.gameObject, true)

		local weekDays = entranceMo:getWeekDays()
		local weekStr = ""

		for i, v in ipairs(weekDays) do
			if i == 1 then
				weekStr = tostring(v)
			else
				weekStr = string.format("%s,%s", weekStr, v)
			end
		end

		self._timeTxt.text = string.format("每周%s开启", weekStr)
	end
end

function M:onDestroy()
	return
end

return M
