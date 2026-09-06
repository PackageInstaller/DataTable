-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingShopMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingShopMO", package.seeall)

local ZooBuildingShopMO = class("ZooBuildingShopMO", ZooBuildingMO)

function ZooBuildingShopMO:ctor()
	ZooBuildingShopMO.super.ctor(self)
end

function ZooBuildingShopMO:getUpgradeCost()
	local buildingCo = ZooConfig.instance:getShopBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.upgradeCost
	end
end

function ZooBuildingShopMO:getMaxLevel()
	return #ZooConfig.instance:getAllShopsBuildingCos()
end

function ZooBuildingShopMO:getNeedMainBuildingLv()
	local buildingCo = ZooConfig.instance:getShopBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.needMainBuildingLv or 0
	end

	return 0
end

function ZooBuildingShopMO:getBuildingOpTypes()
	return {
		ZooBuildingOpType.Upgrade,
		ZooBuildingOpType.Shop
	}
end

function ZooBuildingShopMO:_requestLevelup()
	ZooAgent.instance:sendPM_ZooUpgradeExchangeShopReq()
end

function ZooBuildingShopMO:_onClickShop()
	ViewMgr.instance:open(ViewName.ZooShopView)
end

return ZooBuildingShopMO
