-- chunkname: @modules/logic/box/equiplvup/defines/EquipLvUpEnum.lua

module("modules.logic.box.equiplvup.defines.EquipLvUpEnum", package.seeall)

local EquipLvUpEnum = _M

EquipLvUpEnum.EffectType = {
	All = 1,
	Specify = 2,
	None = 0
}
EquipLvUpEnum.ShowUseTipKey = "EquipLvUpEnum_ShowUseTipKey_"

return EquipLvUpEnum
