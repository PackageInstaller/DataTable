-- chunkname: @modules/logic/towercompose/view/TowerComposeThemeSpineComp.lua

module("modules.logic.towercompose.view.TowerComposeThemeSpineComp", package.seeall)

local TowerComposeThemeSpineComp = class("TowerComposeThemeSpineComp", LuaCompBase)

function TowerComposeThemeSpineComp:ctor(param)
	self.param = param
end

function TowerComposeThemeSpineComp:init(go)
	self:__onInit()

	self.goPos = go
end

function TowerComposeThemeSpineComp:addEventListeners()
	return
end

function TowerComposeThemeSpineComp:removeEventListeners()
	return
end

function TowerComposeThemeSpineComp:refreshSpine(param)
	self.bossSkinCo = param.bossSkinCo
	self.index = param.index

	local modOffsetList = param.modOffsetList

	self.spineOffsetData = modOffsetList[self.index]
	self.spineUrl = self:getUISpinePrefabBySkin(self.bossSkinCo)
	self.bossSpine = self.bossSpine or GuiSpine.Create(self.goPos, true)

	self.bossSpine:setResPath(self.spineUrl, self._onBossSpineLoaded, self, true)
end

function TowerComposeThemeSpineComp:_onBossSpineLoaded()
	self.spineGO = self.bossSpine:getSpineGo()
	self.skeletonGraphics = self.bossSpine:getSkeletonGraphic()

	self.bossSpine:setBodyAnimation("idle", true, 0.5)
	self.bossSpine:changeLookDir(-1)
	recthelper.setAnchor(self.goPos.transform, self.spineOffsetData[1], self.spineOffsetData[2])
	transformhelper.setLocalScale(self.goPos.transform, self.spineOffsetData[3], self.spineOffsetData[3], self.spineOffsetData[3])
end

function TowerComposeThemeSpineComp:getUISpinePrefabBySkin(skinCO)
	if not skinCO then
		return ""
	end

	return ResUrl.getSpineUIPrefab(skinCO.spine)
end

function TowerComposeThemeSpineComp:onDestroy()
	self.bossSpine:onDestroy()
end

return TowerComposeThemeSpineComp
