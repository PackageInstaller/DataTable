-- chunkname: @modules/logic/fight/view/FightPaTaComposePlaneComp.lua

module("modules.logic.fight.view.FightPaTaComposePlaneComp", package.seeall)

local FightPaTaComposePlaneComp = class("FightPaTaComposePlaneComp", UserDataDispose)
local prefabPath = "ui/viewres/fight/fighttower/fighttowercomposeplane.prefab"

function FightPaTaComposePlaneComp:init(goContainer)
	self:__onInit()

	self.goContainer = goContainer
	self.loadDone = false

	loadAbAsset(prefabPath, false, self.onLoadCallback, self)
end

function FightPaTaComposePlaneComp:onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self.loadDone = true
		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.instanceGo = gohelper.clone(self._assetItem:GetResource(prefabPath), self.goContainer)
		self.plan1Bg = gohelper.findChild(self.instanceGo, "txt/1/bg")
		self.plan1Active = gohelper.findChild(self.instanceGo, "txt/1/fg")
		self.plan2Bg = gohelper.findChild(self.instanceGo, "txt/2/bg")
		self.plan2Active = gohelper.findChild(self.instanceGo, "txt/2/fg")

		self:refreshActive()
	end
end

function FightPaTaComposePlaneComp:refreshActive()
	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)

	if customData then
		if not customData.planeId then
			local planeId = 1

			if customData then
				if not customData.maxPlaneId then
					local maxPlane = 1

					gohelper.setActive(self.plan1Bg, planeId ~= 1)
					gohelper.setActive(self.plan1Active, planeId == 1)
					gohelper.setActive(self.plan2Bg, maxPlane > 1 and planeId ~= 2)
					gohelper.setActive(self.plan2Active, maxPlane > 1 and planeId == 2)
				end
			end
		end
	end
end

function FightPaTaComposePlaneComp:destroy()
	removeAssetLoadCb(prefabPath, self._onLoadCallback, self)
	self:__onDispose()
end

return FightPaTaComposePlaneComp
