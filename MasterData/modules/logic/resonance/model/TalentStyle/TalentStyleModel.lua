-- chunkname: @modules/logic/resonance/model/TalentStyle/TalentStyleModel.lua

module("modules.logic.resonance.model.TalentStyle.TalentStyleModel", package.seeall)

local TalentStyleModel = class("TalentStyleModel", BaseModel)

function TalentStyleModel:openView(heroId)
	self._heroId = heroId
	self._heroMo = HeroModel.instance:getByHeroId(heroId)
	self._selectStyleId = nil
	self._unlockIdList = self:getUnlockStyle(heroId)
	self._newUnlockStyle = nil

	self:refreshNewState(heroId)
	TalentStyleListModel.instance:initData(heroId)
end

function TalentStyleModel:getHeroMainCubeMo(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	return heroMo and heroMo.talentCubeInfos:getMainCubeMo()
end

function TalentStyleModel:getHeroUseCubeStyleId(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	return heroMo and heroMo:getHeroUseCubeStyleId()
end

function TalentStyleModel:getHeroUseCubeId(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	return heroMo and heroMo:getHeroUseStyleCubeId()
end

function TalentStyleModel:UseStyle(heroId, mo)
	if mo then
		if mo._isUnlock then
			if not mo._isUse then
				local style = mo._styleId
				local useTalentTemplateId = self:getTalentTemplateId(heroId)

				HeroRpc.instance:setUseTalentStyleRequest(heroId, useTalentTemplateId, style)
				self:selectCubeStyle(heroId, mo._styleId)
			end
		else
			local heroMo = HeroModel.instance:getByHeroId(heroId)

			if heroMo.config.heroType == 6 then
				GameFacade.showToast(ToastEnum.TalentStyleLock2)
			else
				GameFacade.showToast(ToastEnum.TalentStyleLock1)
			end
		end
	end
end

function TalentStyleModel:getTalentTemplateId(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	return heroMo and heroMo.useTalentTemplateId
end

function TalentStyleModel:getHeroUseCubeMo(heroId)
	local style = self:getHeroUseCubeStyleId(heroId)

	return (self:getCubeMoByStyle(heroId, style))
end

function TalentStyleModel:getSelectStyleId(heroId)
	self._selectStyleId = self._selectStyleId or self:getHeroUseCubeStyleId(heroId)

	return self._selectStyleId
end

function TalentStyleModel:selectCubeStyle(heroId, style)
	if self._selectStyleId == style then
		return
	end

	self._selectStyleId = style

	self:setNewSelectStyle(style)
	TalentStyleListModel.instance:refreshData(heroId, style)
	CharacterController.instance:dispatchEvent(CharacterEvent.onSelectTalentStyle, style)
end

function TalentStyleModel:getSelectCubeMo(heroId)
	local style = self:getSelectStyleId(heroId)
	local list = self:getStyleCoList(heroId)

	if list and list[style] then
		return list[style]
	end

	self:selectCubeStyle(heroId, 0)
end

function TalentStyleModel:clear()
	self:setHeroUseSelectId()
end

function TalentStyleModel:getTalentStyle(cubeId, style)
	local styleList = HeroResonanceConfig.instance:getTalentStyle(cubeId)

	if styleList and styleList[style] then
		return styleList[style]
	end
end

function TalentStyleModel:getStyleCoList(heroId)
	local hero_mo_data = self:getHeroMainCubeMo(heroId)

	if hero_mo_data then
		local mainCubeId = hero_mo_data and hero_mo_data.id

		if mainCubeId then
			return (HeroResonanceConfig.instance:getTalentStyle(mainCubeId))
		end
	end
end

function TalentStyleModel:getStyleMoList(heroId)
	local style = self:getStyleCoList(heroId)

	return (self:refreshMoList(heroId, style))
end

function TalentStyleModel:refreshMoList(heroId, styleMoList)
	local moList = {}

	if styleMoList then
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if heroMo then
			if not heroMo.talent then
				local heroLevel = 0
				local useId, selectId, unlock = self:getCurInfo(heroId)

				for _, mo in pairs(styleMoList) do
					local _isCanUnlock = mo:isCanUnlock(heroLevel)

					if _isCanUnlock then
						local styleId = mo._styleId
						local isUnlock = LuaUtil.tableContains(unlock, styleId)

						mo:onRefresh(useId, selectId, isUnlock)
						table.insert(moList, mo)
					end
				end
			end
		end
	end

	return moList
end

function TalentStyleModel:refreshNewState(heroId)
	local moList = self:getStyleMoList(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	for _, mo in pairs(moList) do
		mo:setNew(heroMo.isShowTalentStyleRed)
	end
end

function TalentStyleModel:hideNewState(heroId)
	local moList = self:getStyleMoList(heroId)

	for _, mo in pairs(moList) do
		mo:setNew(false)
	end
end

function TalentStyleModel:getCurInfo(heroId)
	local useId = self:getHeroUseCubeStyleId(heroId)
	local selectId = self:getSelectStyleId(heroId)
	local unlock = self._unlockIdList

	return useId, selectId, unlock
end

function TalentStyleModel:getCubeMoByStyle(heroId, styleId)
	local styleList = self:getStyleCoList(heroId)

	if styleList and styleList[styleId] then
		return styleList[styleId]
	end

	return styleList and styleList[0]
end

function TalentStyleModel:refreshUnlockInfo(heroId)
	local styleList = self:getStyleCoList(heroId)

	self:refreshUnlockList(heroId)

	local useId, selectId, unlock = self:getCurInfo(heroId)

	for _, mo in pairs(styleList) do
		local isUnlock = LuaUtil.tableContains(unlock, mo._styleId)

		mo:onRefresh(useId, selectId, isUnlock)
	end
end

function TalentStyleModel:getUnlockStyle(heroId)
	local style = self:getStyleCoList(heroId)
	local count = 0

	if style then
		for k, v in pairs(style) do
			count = math.max(k, count)
		end
	end

	local unlock = HeroModel.instance:getByHeroId(heroId).talentStyleUnlock

	return (self:parseUnlock(unlock, count))
end

function TalentStyleModel:refreshUnlockList(heroId)
	self._unlockIdList = self:getUnlockStyle(heroId)
end

function TalentStyleModel:parseUnlock(num, max)
	local list = {}
	local temp = num

	for i = max, 0, -1 do
		local power = 2^i

		if power <= temp then
			table.insert(list, i)

			temp = temp - power

			if temp == 0 then
				break
			end
		end
	end

	if temp ~= 0 then
		logError("解锁数据计算错误：" .. num)
	end

	return list
end

function TalentStyleModel:getLevelUnlockStyle(cubeId, level)
	local styleList = HeroResonanceConfig.instance:getTalentStyle(cubeId)

	for _, style in pairs(styleList) do
		if style._styleCo.level == level then
			return true
		end
	end
end

function TalentStyleModel:isUnlockStyleSystem(level)
	return level >= 10
end

function TalentStyleModel:setNewUnlockStyle(style)
	self._newUnlockStyle = style
end

function TalentStyleModel:getNewUnlockStyle()
	return self._newUnlockStyle
end

function TalentStyleModel:setNewSelectStyle(style)
	self._newSelectStyle = style
end

function TalentStyleModel:getNewSelectStyle()
	return self._newSelectStyle
end

function TalentStyleModel:isPlayAnim(heroId, style)
	local isPlay = GameUtil.playerPrefsGetNumberByUserId(self:getPlayUnlockAnimKey(heroId, style), 0)

	return isPlay == 0
end

function TalentStyleModel:setPlayAnim(heroId, style)
	return GameUtil.playerPrefsSetNumberByUserId(self:getPlayUnlockAnimKey(heroId, style), 1)
end

function TalentStyleModel:getPlayUnlockAnimKey(heroId, style)
	return "TalentStyleModel_PlayUnlockAnim_" .. heroId .. "_" .. style
end

function TalentStyleModel:isPlayStyleEnterBtnAnim(heroId)
	local isPlay = GameUtil.playerPrefsGetNumberByUserId(self:getPlayStyleEnterBtnAnimKey(heroId), 0)

	return isPlay == 0
end

function TalentStyleModel:setPlayStyleEnterBtnAnim(heroId)
	return GameUtil.playerPrefsSetNumberByUserId(self:getPlayStyleEnterBtnAnimKey(heroId), 1)
end

function TalentStyleModel:getPlayStyleEnterBtnAnimKey(heroId)
	return "PlayStyleEnterBtnAnimKey_" .. heroId
end

function TalentStyleModel:setHeroTalentStyleStatInfo(msg)
	self.unlockStateInfo = self.unlockStateInfo or {}
	self.unlockStateInfo[msg.heroId] = self.unlockStateInfo[msg.heroId] or {}

	local hot = 0

	if msg.stylePercentList then
		for i = 1, #msg.stylePercentList do
			local info = msg.stylePercentList[i]
			local mo = self:getCubeMoByStyle(msg.heroId, info.style)

			mo:setUnlockPercent(info.percent)

			self.unlockStateInfo[msg.heroId][info.style] = mo
			hot = math.max(info.percent, hot)
		end
	end

	if self.unlockStateInfo[msg.heroId] then
		for _, mo in pairs(self.unlockStateInfo[msg.heroId]) do
			mo:setHotUnlockStyle(hot == mo:getUnlockPercent())
		end
	end
end

function TalentStyleModel.sortUnlockPercent(a, b)
	return a:getUnlockPercent() > b:getUnlockPercent()
end

function TalentStyleModel:getHeroTalentStyleStatInfo(heroId)
	return self.unlockStateInfo and self.unlockStateInfo[heroId]
end

TalentStyleModel.instance = TalentStyleModel.New()

return TalentStyleModel
