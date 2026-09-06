-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/model/RuneSuitMo.lua

module("logic.extensions.rune.model.RuneSuitMo", package.seeall)

local RuneSuitMo = class("RuneSuitMo")

function RuneSuitMo:ctor()
	self.suitId = -1
	self.slots = {}
end

function RuneSuitMo:initData(msg)
	self.suitId = msg.suitId
	self.slots = {}

	local slots = msg.slots

	if slots and #slots > 0 then
		for i, v in ipairs(slots) do
			local sMo = RuneSlotMo.New()

			sMo:initData(v)

			self.slots[sMo.posId] = sMo
		end
	end
end

function RuneSuitMo:initWithOtherData(msg)
	self.suitId = msg.runeSuitId
	self.slots = {}

	local slots = msg.slots

	if slots and #slots > 0 then
		for i, v in ipairs(slots) do
			local sMo = RuneSlotMo.New()

			sMo.posId = v.pos
			sMo.runeId = v.runeId or -1

			sMo:initByFake(v)

			self.slots[sMo.posId] = sMo
		end
	end
end

function RuneSuitMo:initByFake(slots)
	for k, v in ipairs(slots or {}) do
		local sMo = RuneSlotMo.New()

		sMo.posId = checknumber(k)

		sMo:initByFake(v)

		self.slots[sMo.posId] = sMo
	end
end

function RuneSuitMo:getDefineId()
	return self.suitId
end

function RuneSuitMo:checkHasRune(runeId)
	for k, v in pairs(self.slots) do
		if v.runeId == runeId then
			return true
		end
	end

	return false
end

function RuneSuitMo:checkIsInstall()
	for k, v in pairs(self.slots) do
		if v.runeId > 0 then
			return true
		end
	end

	return false
end

function RuneSuitMo:getRuneMoByIdx(idx)
	for k, v in pairs(self.slots) do
		if v.posId == idx - 1 then
			return v:getRuneMo()
		end
	end

	return nil
end

function RuneSuitMo:getTotalStar()
	local count = 0

	for k, v in pairs(self.slots) do
		local mo = v:getRuneMo()

		if mo then
			count = count + mo.level
		end
	end

	return count
end

function RuneSuitMo:getCurLvl()
	local totalStar = self:getTotalStar()

	print("totalStar = " .. totalStar)

	return self:getLvlByStatCount(totalStar)
end

function RuneSuitMo:getLvlByStatCount(totalStar)
	local arr = RuneConfig.instance:getSuitEffById(self.suitId)
	local lvl = 0

	for i = #arr, 1, -1 do
		if totalStar >= arr[i].needLevel then
			lvl = i

			break
		end
	end

	return lvl, arr[lvl], totalStar
end

function RuneSuitMo:getExtProps()
	local slots = self.slots
	local arr = {}

	if slots then
		for k, v in pairs(slots) do
			local mo = v:getRuneMo()

			if mo then
				local prop = mo:getProp()

				table.insert(arr, prop)
			end
		end
	end

	return GameUtil.propToList(arr)
end

function RuneSuitMo:getSuitZDL()
	return RuneConfig.instance:getSuitZDLByMo(self)
end

function RuneSuitMo:getRuneMoList()
	local res = {}

	for k, v in pairs(self.slots) do
		local mo = v:getRuneMo()

		if mo then
			table.insert(res, mo)
		end
	end

	return res
end

function RuneSuitMo:getSuitLimitPetCount()
	return RuneConfig.instance:getCurrCoutByStars(self.suitId, self:getTotalStar())
end

return RuneSuitMo
