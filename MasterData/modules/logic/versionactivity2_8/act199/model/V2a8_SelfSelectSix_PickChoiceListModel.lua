-- chunkname: @modules/logic/versionactivity2_8/act199/model/V2a8_SelfSelectSix_PickChoiceListModel.lua

module("modules.logic.versionactivity2_8.act199.model.V2a8_SelfSelectSix_PickChoiceListModel", package.seeall)

local V2a8_SelfSelectSix_PickChoiceListModel = class("V2a8_SelfSelectSix_PickChoiceListModel", MixScrollModel)

function V2a8_SelfSelectSix_PickChoiceListModel:onInit()
	self:clear()
end

function V2a8_SelfSelectSix_PickChoiceListModel:reInit()
	self:clear()
end

function V2a8_SelfSelectSix_PickChoiceListModel:initDatas(actId)
	self._actId = actId
	self._selectIdList = {}
	self._selectIdMap = {}

	self:initList()
end

V2a8_SelfSelectSix_PickChoiceListModel.SkillLevel2Order = {
	[0] = 50,
	40,
	30,
	20,
	10,
	60
}

local function sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo ~= nil
	local bHasHero = bHeroMo ~= nil

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	if aHeroMo then
		if not aHeroMo.exSkillLevel then
			local aSkillLevel = -1

			if bHeroMo then
				if not bHeroMo.exSkillLevel then
					local bSkillLevel = -1

					if aSkillLevel ~= bSkillLevel then
						if not V2a8_SelfSelectSix_PickChoiceListModel.SkillLevel2Order[aSkillLevel] then
							local aOrder = 999

							if not V2a8_SelfSelectSix_PickChoiceListModel.SkillLevel2Order[bSkillLevel] then
								local bOrder = 999

								return aOrder < bOrder
							end
						end
					end

					return a.id > b.id
				end
			end
		end
	end
end

function V2a8_SelfSelectSix_PickChoiceListModel:initList()
	local charIdList = self:getCharIdList()
	local moList = {}
	local ownList = {}
	local noGainList = {}
	local fullOwnList = {}

	for _, characterId in ipairs(charIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(characterId)

		if mo:hasHero() then
			if mo:checkHeroFullExSkillLevel() then
				table.insert(fullOwnList, mo)
			else
				table.insert(ownList, mo)
			end
		else
			table.insert(noGainList, mo)
		end
	end

	table.sort(ownList, sortFunc)
	table.sort(noGainList, sortFunc)
	table.sort(fullOwnList, sortFunc)

	if #ownList > 0 then
		table.insert(moList, {
			isUnlock = true,
			isTitle = true,
			langTitle = luaLang("p_v2a2_fivestarsupgradepickchoiceview_txt_title2")
		})
		table.insert(moList, {
			isUnlock = true,
			heroIdList = ownList
		})
	end

	if #noGainList > 0 then
		table.insert(moList, {
			isTitle = true,
			langTitle = luaLang("p_achievementlevelview_unget")
		})
		table.insert(moList, {
			heroIdList = noGainList
		})
	end

	if #fullOwnList > 0 then
		local isUnlock = #ownList < 1

		table.insert(moList, {
			isTitle = true,
			isFull = true,
			langTitle = luaLang("anniversary_bonus_max")
		})
		table.insert(moList, {
			heroIdList = fullOwnList,
			isUnlock = isUnlock
		})
	end

	self:setList(moList)
end

function V2a8_SelfSelectSix_PickChoiceListModel:haveAllRole()
	return self._actId and self.noGainList and #self.noGainList <= 0
end

function V2a8_SelfSelectSix_PickChoiceListModel:setSelectId(heroId)
	if not self._selectIdList then
		return
	end

	if self._selectIdMap[heroId] then
		self._selectIdMap[heroId] = nil

		tabletool.removeValue(self._selectIdList, heroId)
	else
		self._selectIdMap[heroId] = true

		table.insert(self._selectIdList, heroId)
	end

	V2a8_SelfSelectSix_PickChoiceController.instance:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.OnCustomPickListChanged)
end

function V2a8_SelfSelectSix_PickChoiceListModel:clearSelectIds()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function V2a8_SelfSelectSix_PickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function V2a8_SelfSelectSix_PickChoiceListModel:getMaxSelectCount()
	return SummonNewCustomPickViewModel.instance:getMaxSelectCount(self._actId)
end

function V2a8_SelfSelectSix_PickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function V2a8_SelfSelectSix_PickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

function V2a8_SelfSelectSix_PickChoiceListModel:getActivityId()
	return self._actId
end

function V2a8_SelfSelectSix_PickChoiceListModel:getCharIdList()
	local summonConfig = Activity199Config.instance:getSummonConfigById(self._actId)

	if summonConfig then
		local summonIdStr = summonConfig.heroIds

		return (string.splitToNumber(summonIdStr, "#"))
	end

	return {}
end

function V2a8_SelfSelectSix_PickChoiceListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local isTitle = mo.isTitle
		local lineMaxNode = 7
		local type = isTitle and 0 or 1
		local lineWidth = isTitle and 66 or 200 * ((not isTitle or nil) and math.ceil(#mo.heroIdList / lineMaxNode))
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineWidth, nil)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

function V2a8_SelfSelectSix_PickChoiceListModel:clearAllSelect()
	self._selectIdMap = {}
	self._selectIdList = {}
end

V2a8_SelfSelectSix_PickChoiceListModel.instance = V2a8_SelfSelectSix_PickChoiceListModel.New()

return V2a8_SelfSelectSix_PickChoiceListModel
