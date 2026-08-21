-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/photo/EquipPhotoMaterailComponent.lua

module("logic.extensions.equipment.photo.EquipPhotoMaterailComponent", package.seeall)

local M = class("EquipPhotoMaterailComponent")
local kCustomColorFactorID = UnityEngine.Shader.PropertyToID("_CustomBlendColor")
local kCustomColorToggleFactorID = UnityEngine.Shader.PropertyToID("_EnableColorBlend")
local status = EquipEnum.ModelStatus
local CustomColor = "#ffffff00"
local CustomColor1 = "#ffffff96"

function M:ctor()
	self._modelGo = false
	self._equipCurStatus = {}
	self._equipTragetStatus = {}
end

function M:setEquipGo(modelGo)
	self._modelGo = modelGo
end

function M:setTargetStatus(index, tragetStatus)
	for i = 1, EquipEnum.MaxPartType do
		if i ~= index then
			self._equipTragetStatus[i] = status.Gray
		elseif tragetStatus then
			self._equipTragetStatus[index] = tragetStatus
		end

		self:turnToStatus(i)
	end
end

function M:setCurPos(index)
	for i = 1, EquipEnum.MaxPartType do
		if i ~= index then
			self._equipTragetStatus[i] = status.Gray
		else
			self._equipTragetStatus[index] = status.Normal
		end
	end
end

function M:onEquipModelLoaded(index)
	local parent = goutil.findChild(self._modelGo, "pos" .. index)
	local equip = parent.transform:GetChild(0)

	if not equip then
		if enableErrorLog then
			printError("装备模型对应位置装备为空", "pos" .. index)
		end

		return
	end

	local childCount = equip.childCount

	for i = 0, childCount - 1 do
		local child = equip:GetChild(i).gameObject

		self._equipCurStatus[index] = status.Normal
	end

	self:turnToStatus(index)
end

function M:turnToStatus(index)
	if not self._materialSetter[index] or not self._equipTragetStatus[index] then
		return
	end

	local targetStatus = self._equipTragetStatus[index]

	if self._equipCurStatus[index] and self._equipCurStatus[index] == targetStatus then
		return
	end

	self._equipCurStatus[index] = targetStatus

	if targetStatus == status.Normal then
		self:setNormalStatus(self._materialSetter[index])
	elseif targetStatus == status.Bright then
		-- block empty
	else
		self:setGrayStatus(self._materialSetter[index])
	end
end

function M:setNormalStatus(setter)
	setter:SetBool("_COLOR_BLEND_ON", true)
	setter:SetFloat(kCustomColorToggleFactorID, 1)
	setter:SetColor(kCustomColorFactorID, CustomColor1)
	setter:DOAlpha(kCustomColorFactorID, 0, 0.5)
end

function M:setGrayStatus(setter)
	setter:SetBool("_COLOR_BLEND_ON", true)
	setter:SetFloat(kCustomColorToggleFactorID, 1)
	setter:SetColor(kCustomColorFactorID, CustomColor)
	setter:DOAlpha(kCustomColorFactorID, 0.5882352941176471, 0.5)
end

function M:clear()
	table.clear(self._materialSetter)
	table.clear(self._equipCurStatus)
	table.clear(self._equipTragetStatus)
end

return M
