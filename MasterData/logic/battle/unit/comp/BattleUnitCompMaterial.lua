-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompMaterial.lua

module("logic.battle.unit.comp.BattleUnitCompMaterial", package.seeall)

local BattleUnitCompMaterial = class("BattleUnitCompMaterial", BattleUnitCompBase)
local kMaterialSwitcherType = {
	REPLACE = 1,
	ADD = 2,
	NONE = 0
}
local kMaterialLayerType = {
	GAMEPLAY = 2,
	BASE = 1
}
local kDarkenCustomBlendColor = "#1A1A1AD4"
local kNormalCustomBlendColor = "#FFFFFF00"

function BattleUnitCompMaterial:onInit()
	self._materialSetter = BatchMaterialSetter.Get(self._unit.go)
	self._materialSwitcher = MaterialSwitcher.Get(self._unit.go)
	self._meshModel = self._unit.meshModel or false
	self._materialUrlList = {}
	self._materialSwitcherTypeList = {}

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function BattleUnitCompMaterial:onReset()
	table.clear(self._materialUrlList)
	table.clear(self._materialSwitcherTypeList)

	if self._materialSetter then
		self._materialSetter:Clear()
	end

	if self._materialSwitcher then
		self._materialSwitcher:Clear()
	end
end

function BattleUnitCompMaterial:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	if self._materialSetter then
		self._materialSetter:Clear()

		self._materialSetter = nil
	end

	if self._materialSwitcher then
		self._materialSwitcher:Clear()

		self._materialSwitcher = nil
	end
end

function BattleUnitCompMaterial:setMainColor(colorString)
	if self._materialSetter then
		self._materialSetter:SetColor(ShaderConstants.ID_MainColorID, colorString)
	end
end

function BattleUnitCompMaterial:setCustomColor2(colorString)
	if self._materialSetter then
		self._materialSetter:SetColor(ShaderConstants.ID_CustomColorId, colorString)
	end
end

function BattleUnitCompMaterial:doOutlineColor(colorString, intensity)
	if self._materialSetter then
		self._materialSetter:KillAll(true)
		self._materialSetter:SetColor(ShaderConstants.ID_SelectOutline, colorString, intensity)
		self._materialSetter:DOAlpha(ShaderConstants.ID_SelectOutline, 0.2, BattleConst.DelayOnePointFive):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
	end
end

function BattleUnitCompMaterial:setOutlineWidth(width)
	if self._materialSetter then
		self._materialSetter:SetFloat(ShaderConstants.ID_SelectOutlineWidth, width)
	end
end

function BattleUnitCompMaterial:doCustomAlphaLoop(toAlpha, duration)
	if self._materialSetter then
		self._materialSetter:KillAll(true)

		return self._materialSetter:DOAlphaLoop(ShaderConstants.ID_CustomColorId, toAlpha, duration)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doMainAlpha faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:setDecolorEffect()
	if self._materialSetter then
		self._materialSetter:SetFloat(ShaderConstants.ID_DarkenColorLerp, 1)
		self._materialSetter:SetColor(ShaderConstants.ID_CustomBlendColor, kDarkenCustomBlendColor)
	end
end

function BattleUnitCompMaterial:clearDecolorEffect()
	if self._materialSetter then
		self._materialSetter:SetFloat(ShaderConstants.ID_DarkenColorLerp, 0)
		self._materialSetter:SetColor(ShaderConstants.ID_CustomBlendColor, kNormalCustomBlendColor)
	end
end

function BattleUnitCompMaterial:killAll(complete)
	if self._materialSetter then
		self._materialSetter:KillAll(complete)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::killAll faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:setAlphaEnable(enable)
	if self._materialSetter then
		self._materialSetter:SetBool(ShaderConstants.KEY_SCREEN, enable)
	end
end

function BattleUnitCompMaterial:doMainAlpha(toAlpha, duration)
	if self._materialSetter then
		local fromAlpha = toAlpha > 0.5 and 0 or 1

		self._materialSetter:KillAll(true)

		return self._materialSetter:DOFloat(ShaderConstants.ID_Transparency, fromAlpha, toAlpha, duration)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doMainAlpha faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:doLuminance(from, to, duration)
	if self._materialSetter then
		self._materialSetter:KillAll(true)

		return self._materialSetter:DOFloat(ShaderConstants.ID_LuminanceRatio, from, to, duration)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doLuminance faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:turnOnLayerMask(layer)
	if self._materialSetter then
		return self._materialSetter:TurnOnLayerMask(layer)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doLuminance faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:turnOffLayerMask(layer)
	if self._materialSetter then
		return self._materialSetter:TurnOffLayerMask(layer)
	elseif BattleLog.enableError then
		BattleLog.error("BattleUnitCompMaterial::doLuminance faild,_materialSetter is null.")
	end
end

function BattleUnitCompMaterial:setOriginalMaterial(url, isReplace)
	self:_changeLayerMaterial(kMaterialLayerType.BASE, url, isReplace)
end

function BattleUnitCompMaterial:switchMaterial(url, isReplace)
	self:_changeLayerMaterial(kMaterialLayerType.GAMEPLAY, url, isReplace)
end

function BattleUnitCompMaterial:resumeOriginalMaterial()
	self:_changeLayerMaterial(kMaterialLayerType.GAMEPLAY, false, false)
end

function BattleUnitCompMaterial:_changeLayerMaterial(layer, url, isReplace)
	if self._materialUrlList[layer] == url then
		return
	end

	self._materialUrlList[layer] = url
	self._materialSwitcherTypeList[layer] = isReplace and kMaterialSwitcherType.REPLACE or kMaterialSwitcherType.ADD

	self:_switchMaterial()
end

function BattleUnitCompMaterial:_onMeshModelLoaded()
	local goInst = self._unit.meshModel:getInst()

	if goInst then
		self._materialSetter:SetGameObject(goInst)
		self._materialSwitcher:SetGameObject(goInst)
		self:_switchMaterial()
	else
		self._materialSetter:Clear()
		self._materialSwitcher:Clear()
	end
end

function BattleUnitCompMaterial:_switchMaterial()
	local goInst = self._unit.meshModel:getInst()

	if not goInst then
		return
	end

	if self._unit.property:isModelFuzzy() then
		self:turnOnLayerMask(RenderingLayerMask.Layer9)
	end

	self._materialSwitcher:ResumeOriginalMaterial()

	for layer = kMaterialLayerType.GAMEPLAY, 1, -1 do
		local materialUrl = self._materialUrlList[layer]

		if materialUrl then
			local materialSwitcherType = self._materialSwitcherTypeList[layer]

			if materialSwitcherType == kMaterialSwitcherType.ADD then
				self._materialSwitcher:AddSharedMaterialByUrl(materialUrl)
			elseif materialSwitcherType == kMaterialSwitcherType.REPLACE then
				self._materialSwitcher:ReplaceSharedMaterialByUrl(materialUrl)
			end

			return
		end
	end
end

return BattleUnitCompMaterial
