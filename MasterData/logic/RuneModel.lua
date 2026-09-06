-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/model/RuneModel.lua

module("logic.extensions.rune.model.RuneModel", package.seeall)

local RuneModel = class("RuneModel", BaseModel)

function RuneModel:ctor()
	return
end

function RuneModel:onInit()
	self:onReset()
end

function RuneModel:onReset()
	self.suitInfo = nil
	self.allItems = nil
	self.currTabIdx = nil
end

function RuneModel:setCurrTabIdx(idx)
	self.currTabIdx = idx
end

function RuneModel:getCurrTabIdx()
	return self.currTabIdx
end

function RuneModel:changeInfo(msg)
	local runeinfo = msg.runeInfos

	if runeinfo then
		for i, v in ipairs(runeinfo) do
			self:setItemData(v)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.RUNE_ITEM_UPDATE)
end

function RuneModel:setItemData(msg)
	self.allItems = self.allItems or {}

	local mo = self.allItems[msg.runeId]

	if mo == nil then
		mo = RuneItemMo.New()
	end

	mo:initData(msg)

	if mo.state == RuneItemMo.STATE_DELETED then
		self.allItems[msg.runeId] = nil
	else
		self.allItems[msg.runeId] = mo
	end
end

function RuneModel:getItemData(runeId)
	if self.allItems then
		return self.allItems[runeId]
	end
end

function RuneModel:getAllItems()
	local tb = {}

	if self.allItems then
		for k, v in pairs(self.allItems) do
			table.insert(tb, v)
		end
	end

	return tb
end

function RuneModel:getAllFreeRune()
	local tb = {}

	if self.allItems then
		for k, v in pairs(self.allItems) do
			if v.state == RuneItemMo.STATE_FREE then
				table.insert(tb, v)
			end
		end
	end

	ArraySort.sortOn(tb, {
		"getQuality",
		"getTotalExp"
	})

	return tb
end

function RuneModel:getAllTypeItems(attType, curSuitId, curRuneMo)
	local tb = {}
	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, curSuitId)
	local qualityLimit = cfg.qualityLimit

	if self.allItems then
		local suitMo = self:getSuitMo(curSuitId)

		for k, v in pairs(self.allItems) do
			if v:getQuality() and qualityLimit >= v:getQuality() and v ~= curRuneMo and (suitMo == nil or not suitMo:checkHasRune(v.runeId)) then
				if attType == -1 then
					table.insert(tb, v)
				elseif v:getType() == attType then
					table.insert(tb, v)
				end
			end
		end
	end

	return tb
end

function RuneModel:initSuitData(suits)
	for i, v in ipairs(suits) do
		self:updateSuitInfo(v)
	end
end

function RuneModel:updateSuitInfo(msg)
	if msg then
		self.suitInfo = self.suitInfo or {}

		local mo = self.suitInfo[msg.suitId]

		if mo == nil then
			mo = RuneSuitMo.New()
		end

		mo:initData(msg)

		self.suitInfo[mo.suitId] = mo

		GlobalDispatcher:dispatch(GlobalNotify.RUNE_SUIT_UPDATE)
	end
end

function RuneModel:getSuitMo(suitId)
	if self.suitInfo then
		return self.suitInfo[suitId]
	end
end

function RuneModel:getCurrSuitId()
	if self.currSuitId == -1 then
		for k, v in pairs(self.suitInfo) do
			self.currSuitId = v.suitId

			break
		end
	end

	return self.currSuitId
end

function RuneModel:setCurrSuitId(suitId)
	suitId = suitId or -1
	self.currSuitId = suitId
end

function RuneModel:setCurrSelectRuneById(runeId)
	self.currSelectRune = self:getItemData(runeId)

	GlobalDispatcher:dispatch(GlobalNotify.SUIT_RIGHT_RUNE_SELECT)
end

function RuneModel:setCurrLvlupMo(mo)
	self.currLvlRune = mo
end

function RuneModel:addOrDelToDepart(mo, isAdd)
	self.departPool = self.departPool or {}
	self.departPool[mo.runeId] = isAdd and (self.departPool[mo.runeId] == nil and mo or nil) or nil
end

function RuneModel:clearDepart()
	self.departPool = {}
end

function RuneModel:onekeyAddDepart()
	self.departPool = self.departPool or {}

	for k, v in pairs(self.allItems) do
		if v.isLocked or v.state == RuneItemMo.STATE_EQUIPED then
			-- block empty
		else
			self.departPool[v.runeId] = v
		end
	end
end

function RuneModel:chaceInDepartPool(id)
	if self.departPool then
		return self.departPool[id]
	end

	return nil
end

function RuneModel:getCurrLvlupMo()
	if self.currLvlRune == nil and self.allItems then
		for k, v in pairs(self.allItems) do
			self.currLvlRune = v

			break
		end
	end

	return self.currLvlRune
end

function RuneModel:findUseSuitPets(suitId)
	local list = {}
	local pets = BagModel.instance:getBagPets()

	for k, mo in pairs(pets) do
		local suit = mo.runeSuit

		if suit and suit.runeSuitId == suitId then
			table.insert(list, mo)
		end
	end

	return list
end

RuneModel.instance = RuneModel.New()

return RuneModel
