-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiHeroMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiHeroMO", package.seeall)

local V3a6YaMiHeroMO = class("V3a6YaMiHeroMO")

function V3a6YaMiHeroMO:initConfig(co)
	self.co = co
	self.id = co.id
	self.isNew = GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.HankbookHeroNew .. self.id, 0) == 0
	self._attrMo = V3a6YaMiAttrMO.New()

	if not string.nilorempty(co.attribute) then
		local attribute = string.splitToNumber(co.attribute, "#")

		for i, v in ipairs(attribute) do
			self._attrMo:setAttrValue(i, v)
		end
	end

	local unlockCondition = co.unlockCondition

	self._unlockCondition = {}

	if not string.nilorempty(unlockCondition) then
		local split = string.split(unlockCondition, "#")

		self._unlockCondition[split[1]] = split[2]
	end
end

function V3a6YaMiHeroMO:refreshInfo(info)
	self._attrMo:refreshInfo(info.attr)
end

function V3a6YaMiHeroMO:setLock(isLock)
	self.isLock = isLock
end

function V3a6YaMiHeroMO:isCanUnlock()
	local curCost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
	local unlockLevel = self:getUnlockLevel()
	local _, level, _ = V3a6YaMiModel.instance:getLevelExp()

	if level < unlockLevel then
		return false, V3a6YaMiEnum.ToastId.NoEnoughLevel
	end

	local isEnoughCurrency = V3a6YaMiModel.instance:isEnoughCurrency(self.co.cost + curCost)

	if not isEnoughCurrency then
		return false, V3a6YaMiEnum.ToastId.NoEnoughMoney
	end

	return true
end

function V3a6YaMiHeroMO:getUnlockLevel()
	if not self._unlockLevel then
		local unlockLevel = self._unlockCondition[V3a6YaMiEnum.UnlockCondition.ResearchLevel]

		self._unlockLevel = tonumber(unlockLevel) or 0
	end

	return self._unlockLevel
end

function V3a6YaMiHeroMO:refreshNewTag(isNew)
	self.isNew = isNew

	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.HankbookHeroNew .. self.id, isNew and 0 or 1)
end

function V3a6YaMiHeroMO:getAttrMo()
	return self._attrMo
end

function V3a6YaMiHeroMO:getAttrValue(type)
	return self._attrMo:getAttrValue(type)
end

function V3a6YaMiHeroMO:getCurTalkCo(type)
	if not self._talkCoList then
		self._talkCoList = V3a6YaMiConfig.instance:getHeroTalkCoList(self.id)

		if not self._talkCoList then
			return
		end

		self._maxRandom = {}

		for _type, list in ipairs(self._talkCoList) do
			local max = 0

			for _, co in ipairs(list) do
				max = max + co.weight
			end

			self._maxRandom[_type] = max
		end
	end

	local coList = self._talkCoList[type]

	if not coList then
		return
	end

	if self._maxRandom then
		if not self._maxRandom[type] then
			local maxRandom = 0
			local random = math.random(0, maxRandom)

			for _, co in ipairs(coList) do
				if random <= co.weight then
					return co
				end

				random = random - co.weight
			end

			logError("没找到随机气泡对话")
		end
	end
end

function V3a6YaMiHeroMO:getNameColor()
	if not self.co.quality then
		return V3a6YaMiEnum.HeroQuality[self.co.quality]
	end
end

return V3a6YaMiHeroMO
