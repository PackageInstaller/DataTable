-- chunkname: @modules/logic/sp01/odyssey/controller/OdysseyHeroGroupController.lua

module("modules.logic.sp01.odyssey.controller.OdysseyHeroGroupController", package.seeall)

local OdysseyHeroGroupController = class("OdysseyHeroGroupController", BaseController)

function OdysseyHeroGroupController:onInit()
	return
end

function OdysseyHeroGroupController:reInit()
	return
end

function OdysseyHeroGroupController:addConstEvents()
	return
end

function OdysseyHeroGroupController:saveHeroGroupInfo(heroGroupInfo, saveType, callback, callbackObj)
	heroGroupInfo = heroGroupInfo or HeroGroupModel.instance:getCurGroupMO()

	local odysseyForm = OdysseyHeroGroupModel.instance:getCurFormInfo()

	odysseyForm.clothId = heroGroupInfo.clothId
	saveType = saveType or OdysseyEnum.HeroGroupSaveType.FormUpdate

	OdysseyHeroGroupModel.instance:setSaveType(saveType)

	for _, heroInfo in ipairs(odysseyForm.heroes) do
		local pos = heroInfo.position
		local groupHeroId = heroGroupInfo:getHeroByIndex(pos)
		local groupEquipInfo = heroGroupInfo:getPosEquips(pos - 1)
		local heroGroupSingleMo = HeroSingleGroupModel.instance:getById(pos)

		if not string.nilorempty(groupHeroId) then
			local heroId = tonumber(groupHeroId)

			if heroId > 0 then
				local heroMo = HeroModel.instance:getById(groupHeroId)

				if heroMo == nil then
					logError("奥德赛活动角色保存 uid：" .. groupHeroId .. "不存在")
				else
					heroInfo.heroId = heroMo.heroId
					heroInfo.trialId = 0
				end
			elseif heroId == 0 then
				heroInfo.heroId = 0
				heroInfo.trialId = 0
			else
				local trialId = heroGroupSingleMo.trial

				heroInfo.heroId = 0
				heroInfo.trialId = tonumber(trialId)
			end

			tabletool.clear(heroInfo.equips)

			local odysseyEquip = heroGroupInfo:getOdysseyEquips(pos - 1)

			for slot, equipUid in ipairs(odysseyEquip.equipUid) do
				local equipMo = OdysseyDef_pb.OdysseyFormEquip()

				equipMo.slotId = slot
				equipMo.equipUid = tonumber(equipUid)

				table.insert(heroInfo.equips, equipMo)
			end
		end

		if groupEquipInfo ~= nil and groupEquipInfo.equipUid ~= nil and not string.nilorempty(groupEquipInfo.equipUid[1]) then
			heroInfo.mindId = tonumber(groupEquipInfo.equipUid[1])
		end
	end

	logNormal(tostring(odysseyForm))
	OdysseyRpc.instance:sendOdysseyFormSaveRequest(odysseyForm, callback, callbackObj)
end

function OdysseyHeroGroupController:switchHeroGroup(index, callback, callbackObj)
	OdysseyRpc.instance:sendOdysseyFormSwitchRequest(index, callback, callbackObj)
end

function OdysseyHeroGroupController:setOdysseyEquip(heroPos, equipIndex, equipUid)
	local heroGroupInfo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	heroGroupInfo:setOdysseyEquip(heroPos, equipIndex, equipUid)
	self:saveHeroGroupInfo(heroGroupInfo, OdysseyEnum.HeroGroupSaveType.ItemEquip)
end

function OdysseyHeroGroupController:replaceOdysseyEquip(heroPos, equipIndex, equipUid)
	local heroGroupInfo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	heroGroupInfo:replaceOdysseyEquip(heroPos, equipIndex, equipUid)
	self:saveHeroGroupInfo(heroGroupInfo, OdysseyEnum.HeroGroupSaveType.ItemReplace)
end

function OdysseyHeroGroupController:unloadOdysseyEquip(heroPos, equipIndex)
	local heroGroupInfo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	heroGroupInfo:unloadOdysseyEquip(heroPos, equipIndex)
	self:saveHeroGroupInfo(heroGroupInfo, OdysseyEnum.HeroGroupSaveType.ItemUnload)
end

function OdysseyHeroGroupController:swapOdysseyEquip(posA, posB, indexA, indexB)
	local heroGroupInfo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	heroGroupInfo:swapOdysseyEquip(posA, posB, indexA, indexB)
	self:saveHeroGroupInfo(heroGroupInfo)
end

OdysseyHeroGroupController.instance = OdysseyHeroGroupController.New()

return OdysseyHeroGroupController
