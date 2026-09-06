-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/model/FamilyTechModel.lua

module("logic.extensions.familytech.model.FamilyTechModel", package.seeall)

local FamilyTechModel = class("FamilyTechModel", BaseModel)

function FamilyTechModel:ctor()
	return
end

function FamilyTechModel:onInit()
	self:onReset()
end

function FamilyTechModel:onReset()
	print("FamilyTechModel onReset")

	self._techInfoDic = {}
end

function FamilyTechModel:setTechInfos(techInfos)
	if techInfos ~= nil then
		for _, v in ipairs(techInfos) do
			self._techInfoDic[v.techId] = v.level
		end
	end
end

function FamilyTechModel:getTechLevel(techId)
	return checknumber(self._techInfoDic[techId])
end

function FamilyTechModel:setTechLevel(techId, value)
	self._techInfoDic[techId] = checknumber(value)
end

function FamilyTechModel:getTechUnlocked(techId)
	if self:getTechLevel(techId) > 0 then
		return true
	end

	local cfg = FamilyTechConfig.instance:getFamilyTechCfg(techId)

	if cfg == nil then
		return false
	end

	local preTechs = cfg.preTechs

	if preTechs then
		local preTechOpened = false

		for _, v in ipairs(preTechs) do
			if self:getTechLevel(v) > 0 then
				local preCfg = FamilyTechConfig.instance:getFamilyTechCfg(v)

				preTechOpened = true

				break
			end
		end

		if not preTechOpened then
			return false, lang("family_pretech_locked")
		end
	end

	if MofangModel.instance:getCurLv() < cfg.needPlayerLv then
		return false, langPara("family_tech_player_lv_limited", cfg.needPlayerLv)
	end

	return true
end

FamilyTechModel.instance = FamilyTechModel.New()

return FamilyTechModel
