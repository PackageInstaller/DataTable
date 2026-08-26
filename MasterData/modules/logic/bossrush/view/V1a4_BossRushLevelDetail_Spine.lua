-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushLevelDetail_Spine.lua

module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail_Spine", package.seeall)

local V1a4_BossRushLevelDetail_Spine = class("V1a4_BossRushLevelDetail_Spine", LuaCompBase)

function V1a4_BossRushLevelDetail_Spine:init(go)
	self._gospine = gohelper.findChild(go, "#go_spine")
	self._gospineTran = self._gospine.transform
	self._gospineX, self._gospineY = recthelper.getAnchor(self._gospineTran)
	self._uiSpine = GuiSpine.Create(self._gospine, false)
end

function V1a4_BossRushLevelDetail_Spine:setData(skinId)
	local skinCO = FightConfig.instance:getSkinCO(skinId)

	if skinCO then
		local resPath = ResUrl.getSpineUIPrefab(skinCO.spine)

		self._uiSpine:showModel()
		self._uiSpine:setResPath(resPath, self._onSpineLoaded, self, true)
	else
		self._uiSpine:hideModel()
	end
end

function V1a4_BossRushLevelDetail_Spine:setOffsetXY(offsetX, offsetY)
	local x = self._gospineX + (offsetX or 0)
	local y = self._gospineY + (offsetY or 0)

	recthelper.setAnchor(self._gospineTran, x, y)
end

function V1a4_BossRushLevelDetail_Spine:setScale(scale)
	if not scale then
		return
	end

	transformhelper.setLocalScale(self._gospineTran, scale, scale, scale)
end

function V1a4_BossRushLevelDetail_Spine:settVariant(variant)
	self._skeletonGraphic = self._skeletonGraphic or self._uiSpine:getSkeletonGraphic()

	local variantPath = V3a2BossRushEnum.Variant[variant]

	if string.nilorempty(variantPath) then
		return
	end

	IconMaterialMgr.instance:loadMaterialAddSet(variantPath, self._skeletonGraphic)
end

function V1a4_BossRushLevelDetail_Spine:onDestroy()
	if self._uiSpine then
		self._uiSpine:doClear()
	end

	self._uiSpine = nil
end

function V1a4_BossRushLevelDetail_Spine:onDestroyView()
	self:onDestroy()
end

return V1a4_BossRushLevelDetail_Spine
