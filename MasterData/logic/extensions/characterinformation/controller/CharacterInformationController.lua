-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/controller/CharacterInformationController.lua

module("logic.extensions.characterinformation.controller.CharacterInformationController", package.seeall)

local M = class("CharacterInformationController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	self._isInit = nil
end

function M:initHeroData(msg)
	for _, v in ipairs(msg.heros) do
		CharacterInformationModel.instance:refreshHeroData(v)
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	end
end

function M:_handleRefreshHeroDepotData(e, heroData)
	local heroId = heroData:getId()
	local heroLv = heroData:getLevel()
	local powerLv = heroData:getPowerLv()
	local breakLv = heroData:getBreakLv()
	local tacitExp = heroData:getTacitExp()

	CharacterInformationModel.instance:setHeroCacheData(heroId, heroLv, powerLv, breakLv, tacitExp)
end

function M:_handleJumpViewToMain(e)
	if CharacterInformationModel.instance:getInAnchorSublimedView() then
		CharacterInformationModel.instance:setInAnchorSublimedView(false, false, true)
	end
end

function M:isConditionPass(heroId, conditionLst, useHeroData, heroLv, powerLv, breakLv, tacitExp)
	local nodesInfo = {}
	local extNodesInfo = {}

	if useHeroData then
		local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroData then
			heroLv = heroData:getLevel()
			powerLv = heroData:getPowerLv()
			nodesInfo = heroData:getNodesInfo()
			extNodesInfo = heroData:getExtNodesInfo()
			breakLv = heroData:getBreakLv()
			tacitExp = heroData:getTacitExp()
		end
	end

	local tacitLv = TacitConfig.instance:getCurLevelByExp(tacitExp)
	local unlock = true
	local len = conditionLst and #conditionLst or 0

	if len > 0 then
		for _, conDef in ipairs(conditionLst) do
			local typ = conDef.type
			local val = tonumber(conDef.value)

			if typ == CommEnum.ConditionType.HERO_LV then
				if heroLv < val then
					unlock = false
				end
			elseif typ == CommEnum.ConditionType.HERO_POWER_LV then
				if val <= 20 then
					if val > #nodesInfo then
						unlock = false
					end
				elseif val > 20 then
					unlock = false

					for k, v in ipairs(extNodesInfo) do
						if val == v then
							unlock = true

							break
						end
					end
				end
			elseif typ == CommEnum.ConditionType.HERO_TACIT_LV then
				if tacitLv < val then
					unlock = false
				end
			elseif typ == CommEnum.ConditionType.HERO_BREAK_LV and breakLv < val then
				unlock = false
			end
		end
	end

	return unlock
end

function M:getConditionUnlockDesc(conditionLst)
	local desc = ""
	local len = conditionLst and #conditionLst or 0

	if len > 0 then
		local t = {}

		for _, conDef in ipairs(conditionLst) do
			local typ = conDef.type
			local val = tonumber(conDef.value)

			if typ == CommEnum.ConditionType.HERO_LV then
				table.insert(t, langF("tip_tacit_unlock_herolv", val))
			elseif typ == CommEnum.ConditionType.HERO_POWER_LV then
				local nodeinfo = HeroPowerConfig.instance:getNodeInfo(2000022, val)

				table.insert(t, langF("tip_tacit_unlock_powerlv", nodeinfo.simpleName))
			elseif typ == CommEnum.ConditionType.HERO_TACIT_LV then
				table.insert(t, langF("tip_tacit_unlock_tacitlv", val))
			elseif typ == CommEnum.ConditionType.HERO_BREAK_LV then
				table.insert(t, langF("tip_break_lv", val))
			end
		end

		desc = table.concat(t, "\n")
	end

	return desc
end

function M:getPastInfoItemUnLockTacitLv(heroId, itemId)
	local tacitLv = -1
	local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstPastId(heroId, itemId)
	local len = conditionLst and #conditionLst or 0

	if len > 0 then
		for _, conDef in ipairs(conditionLst) do
			local typ = conDef.type
			local val = tonumber(conDef.value)

			if typ == CommEnum.ConditionType.HERO_TACIT_LV then
				tacitLv = val
			end
		end
	end

	return tacitLv
end

function M:checkRedPoint(heroId)
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleData, false) then
		return
	end

	local hasNewPastInfo = #CharacterInformationModel.instance:getNewPastInfoLst(heroId, false) > 0
	local hasNewVoice = #CharacterInformationModel.instance:getNewVoiceLst(heroId, true) > 0

	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		key = RedDotType.ERedDotKey.PROFILE,
		isActive = hasNewPastInfo or hasNewVoice
	})
end

function M:isCarryItem1New(heroId)
	if GameEnum.RedPointEnum.HeroCarryItem then
		local redPointLstFromServer = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.HeroCarryItem) or {}

		for k, v in ipairs(redPointLstFromServer) do
			if tonumber(v) == heroId then
				return true
			end
		end
	end

	return false
end

M.instance = M.New()

return M
