-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/cutepet/UnitCompHudCutePetBuilding.lua

module("logicscene.scene.unit.component.cutepet.UnitCompHudCutePetBuilding", package.seeall)

local UnitCompHudCutePetBuilding = class("UnitCompHudCutePetBuilding", UnitCompHudBase)

function UnitCompHudCutePetBuilding:_getResPath()
	return "ui/views/cutepet/unithud/cutepethudbuildinginfo.prefab"
end

function UnitCompHudCutePetBuilding:_updateHudInfo(hudGo)
	local info = goutil.findChild(hudGo, "info")

	GameUtil.setAnchoredPos(info, 0, 110)

	local txtName = goutil.findChildTextComponent(hudGo, "info/node/txtName")
	local tag = goutil.findChild(hudGo, "info/tag")
	local txtTag = goutil.findChildTextComponent(hudGo, "info/tag/Text")
	local redPoint = goutil.findChild(hudGo, "info/redpoint")

	GameUtil.SetActive(tag, false)
	GameUtil.SetActive(info, not self._hudHide)
	RedPointController.instance:unregRedPoint(redPoint)

	if self._unit.type == CutePetBuildingType.Management then
		txtName.text = lang("管理处")

		RedPointController.instance:regRedPoint(redPoint, RedPointModel.ID_CUTEPET_MANAGEMENT)

		local isCanLvUp = false
		local gardenLv = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)
		local nextGardenCfg = CutePetConfig.instance:getGardenCfg(gardenLv + 1)

		if nextGardenCfg then
			local matType, matId, matNumber = MaterialMgr.getMatParams(nextGardenCfg.lvlUpMaterialCost)

			isCanLvUp = MaterialModel.instance:IsEnough(matType, matId, matNumber)
		end

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_CUTEPET_MANAGEMENT, isCanLvUp)
		GameUtil.setAnchoredPos(info, -116, 91)
	elseif self._unit.type == CutePetBuildingType.Travel then
		txtName.text = lang("旅行社")
		txtTag.text = lang("次数增加")

		local isInPrivilegeTime, _ = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

		GameUtil.SetActive(tag, isInPrivilegeTime)
		GameUtil.SetActive(redPoint, false)
		GameUtil.setAnchoredPos(info, -154, 75.5)
	elseif self._unit.type == CutePetBuildingType.Adventure then
		txtName.text = lang("冒险协会")
		txtTag.text = lang("翻倍")

		local isInPrivilegeTime, _ = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_AdventureBuildingResMultiply", false))

		GameUtil.SetActive(tag, isInPrivilegeTime)
		RedPointController.instance:regRedPoint(redPoint, RedPointModel.ID_CUTEPET_ADVENTURE)
		GameUtil.setAnchoredPos(info, -90.5, 109)
	elseif self._unit.type == CutePetBuildingType.Shop then
		txtName.text = lang("商店")

		GameUtil.SetActive(redPoint, false)
		GameUtil.setAnchoredPos(info, 146.5, 56)
	elseif self._unit.type == CutePetBuildingType.Guest then
		txtName.text = lang("招待所")
		txtTag.text = lang("打扫加速")

		local isInPrivilegeTime, _ = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_GuestHouseGenCutePet", false))

		GameUtil.SetActive(tag, isInPrivilegeTime)
		RedPointController.instance:regRedPoint(redPoint, RedPointModel.ID_CUTEPET_GUEST)
		GameUtil.setAnchoredPos(info, -140, 78)
	end
end

function UnitCompHudCutePetBuilding:onUnitInVisible(go)
	local redPoint = goutil.findChild(go, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	UnitCompHudCutePetBuilding.super.onUnitInVisible(self, go)
end

function UnitCompHudCutePetBuilding:getInfoGoPos()
	local pos = {
		x = 0,
		y = 0
	}

	if self._hudGameObject then
		pos = GameUtil.getAnchoredPos(self._hudGameObject)

		local info = goutil.findChild(self._hudGameObject, "info")

		pos = pos + GameUtil.getAnchoredPos(info)
	end

	return pos
end

function UnitCompHudCutePetBuilding:setHudHide(bool)
	self._hudHide = bool

	self:_updateHudInfo(self._hudGameObject)
end

return UnitCompHudCutePetBuilding
