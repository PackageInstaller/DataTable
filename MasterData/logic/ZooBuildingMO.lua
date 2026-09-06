-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingMO", package.seeall)

local ZooBuildingMO = class("ZooBuildingMO")

function ZooBuildingMO:ctor()
	self.buildingLevel = 1
	self.isUnlocked = false
	self.buildingCo = nil
	self.zooMo = nil
end

function ZooBuildingMO:getBuildingId()
	return self.buildingCo.id
end

function ZooBuildingMO:getBuildingType()
	return self.buildingCo.buildingType
end

function ZooBuildingMO:getBuildingIcon()
	return self.buildingCo.icon
end

function ZooBuildingMO:getBuildingName()
	return self.buildingCo.name
end

function ZooBuildingMO:getBuildingInfo()
	return self.buildingCo.desc
end

function ZooBuildingMO:getBuildingLvInstructions()
	return
end

function ZooBuildingMO:getUnlockNeedMainLv()
	return self.buildingCo.unlockNeedMainLv
end

function ZooBuildingMO:isUnlockable()
	local mainBuildingMo = self.zooMo:getMainBuilding()
	local needMainBuildingLv = self:getUnlockNeedMainLv()

	if needMainBuildingLv > 0 and mainBuildingMo and needMainBuildingLv > mainBuildingMo.buildingLevel then
		return false
	end

	return true
end

function ZooBuildingMO:getUnlockCost()
	return self.buildingCo.unlockCost
end

function ZooBuildingMO:onUnlocked()
	if not self:isUnlockable() then
		FloatWordMgr.instance:show(lang("petzoo_building_locktips"))

		return
	end

	local unlockCost = self:getUnlockCost()

	if string.nilorempty(unlockCost) then
		ZooController.instance:unlockBuilding(self:getBuildingId())
	else
		local mats = self:toMaterials(unlockCost)
		local itemName = MaterialMgr.getMaterialsName(mats[1][1], mats[1][2])

		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("petzoo_building_unlock_tips"), mats[1][3], itemName, self:getBuildingName()), function()
			ZooController.instance:unlockBuilding(self:getBuildingId())
		end, function()
			return
		end, lang("confirm"), lang("mail_cancel"))
	end
end

function ZooBuildingMO:getUpgradeCost()
	return
end

function ZooBuildingMO:onLevelup()
	local mainBuildingMo = self.zooMo:getMainBuilding()
	local needMainBuildingLv = self:getNeedMainBuildingLv()

	if needMainBuildingLv > 0 and mainBuildingMo and needMainBuildingLv > mainBuildingMo.buildingLevel then
		FloatWordMgr.instance:show(string.format(lang("petzoo_building_lvup_maincity_lv_limit"), needMainBuildingLv))

		return
	end

	local upCost = self:getUpgradeCost()

	if not self:isMaterialsEnougth(upCost) then
		local mats = self:toMaterials(upCost)
		local itemName = MaterialMgr.getMaterialsName(mats[1][1], mats[1][2])

		FloatWordMgr.instance:show(string.format(lang("petzoo_building_lvup_items_limit"), mats[1][3], itemName, itemName))

		return
	end

	self:_requestLevelup()
end

function ZooBuildingMO:onBuildingLevelup()
	self.buildingLevel = self.buildingLevel + 1
end

function ZooBuildingMO:isUpgradable()
	local mainBuildingMo = self.zooMo:getMainBuilding()
	local needMainBuildingLv = self:getNeedMainBuildingLv()

	if needMainBuildingLv > 0 and mainBuildingMo and needMainBuildingLv > mainBuildingMo.buildingLevel then
		return false
	end

	local upCost = self:getUpgradeCost()

	return self:isMaterialsEnougth(upCost)
end

function ZooBuildingMO:toMaterials(mat)
	if not string.nilorempty(mat) then
		local items = string.split(mat, "#")
		local mats = {}

		for i = 1, #items do
			local it = string.split(items[i], ":")
			local matType = checknumber(it[1])
			local matId = checknumber(it[2])
			local matNum = checknumber(it[3])

			table.insert(mats, {
				matType,
				matId,
				matNum
			})
		end

		return mats
	end
end

function ZooBuildingMO:isMaterialsEnougth(mat)
	if mat then
		local items = string.split(mat, "#")

		for i = 1, #items do
			local it = string.split(items[i], ":")
			local matType = checknumber(it[1])
			local matId = checknumber(it[2])
			local matNum = checknumber(it[3])
			local currNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if currNum < matNum then
				return false
			end
		end
	end

	return true
end

function ZooBuildingMO:getMaxLevel()
	return 0
end

function ZooBuildingMO:isMaxLevel()
	return self.buildingLevel >= self:getMaxLevel()
end

function ZooBuildingMO:getNeedMainBuildingLv()
	return 0
end

function ZooBuildingMO:getBuildingAttrDescs(level)
	return
end

function ZooBuildingMO:onSelected()
	if self.zooMo:isMyZoo() then
		GlobalDispatcher:dispatch(GlobalNotify.OnSelectZooBuilding, self)
	end
end

function ZooBuildingMO:getBuildingOpTypesOffset()
	return self.buildingCo.optionsPos
end

function ZooBuildingMO:getBuildingOpTypes()
	return
end

function ZooBuildingMO:onBuildingOpType(opType)
	if opType == ZooBuildingOpType.Infomation then
		self:_onClickInfomation()
	elseif opType == ZooBuildingOpType.Upgrade then
		self:_onClickUpgrade()
	elseif opType == ZooBuildingOpType.Shop then
		self:_onClickShop()
	elseif opType == ZooBuildingOpType.HatchEgg then
		self:_onClickHatchEgg()
	elseif opType == ZooBuildingOpType.Deployment then
		self:_onClickDeployment()
	elseif opType == ZooBuildingOpType.Get then
		self:_onClickGet()
	elseif opType == ZooBuildingOpType.GetAll then
		self:_onClickGetAll()
	end
end

function ZooBuildingMO:_onClickInfomation()
	ViewMgr.instance:open(ViewName.ZooBuildingInfo, self)
end

function ZooBuildingMO:_onClickUpgrade()
	ViewMgr.instance:open(ViewName.ZooBuildingLevelup, self)
end

function ZooBuildingMO:_onClickShop()
	return
end

function ZooBuildingMO:_onClickHatchEgg()
	return
end

function ZooBuildingMO:_onClickDeployment()
	UIStateManager.instance:push(ViewName.ZooWorkingView, self)
end

function ZooBuildingMO:_onClickGet()
	return
end

function ZooBuildingMO:_onClickGetAll()
	return
end

function ZooBuildingMO:_requestLevelup()
	return
end

return ZooBuildingMO
