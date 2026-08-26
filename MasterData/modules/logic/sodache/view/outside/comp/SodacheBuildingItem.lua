-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheBuildingItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheBuildingItem", package.seeall)

local SodacheBuildingItem = class("SodacheBuildingItem", LuaCompBase)

function SodacheBuildingItem:init(go)
	self.go = go
	self._transform = go.transform
	self._goLevel = gohelper.findChild(go, "go_Level")
	self._txtLevel = gohelper.findChildText(go, "go_Level/txt_Level")
	self._txtName = gohelper.findChildTextMesh(go, "txt_Name")
	self._btnBuild = gohelper.findChildButtonWithAudio(go, "btn_Build")
	self._btnUp = gohelper.findChildButtonWithAudio(go, "btn_Up")
	self._btnEnter = gohelper.findChildButtonWithAudio(go, "btn_Enter")
	self._goReddot = gohelper.findChild(go, "btn_Enter/go_Reddot")
	self._btnMax = gohelper.findChildButtonWithAudio(go, "btn_Max")

	self.addClickCb(self, self._btnBuild, self._btnUpOnClick, self)
	self.addClickCb(self, self._btnUp, self._btnUpOnClick, self)
	self.addClickCb(self, self._btnEnter, self._btnEnterOnClick, self)
	self.addClickCb(self, self._btnMax, self._btnUpOnClick, self)

	self.reddot = RedDotController.instance:addNotEventRedDot(self._goReddot, self.checkReddot, self)
end

function SodacheBuildingItem:addEventListeners()
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnBuildingUpgrade, self.onBuildingUpgrade, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.GuideClickBuilding, self.onGuildClickBuilding, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.PlayBuildingUpEffect, self.onPlayEffect, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgrade, self.refreshReddot, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnRelicUpgradeOneKey, self.refreshReddot, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnBagUpdate, self.refreshReddot, self)
end

function SodacheBuildingItem:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.clickListener then
		self.clickListener:RemoveClickListener()
	end
end

function SodacheBuildingItem:setData(data, goScene)
	self.data = data
	self.goScene = goScene

	if not data.co then
		local config = data.baseCo
		local anchorPos = string.splitToNumber(config.location, "#")

		recthelper.setAnchor(self._transform, anchorPos[1], anchorPos[2])
		self:refreshUI()

		self.loader = MultiAbLoader.New()

		for _, v in ipairs(lua_sodache_building.configDict[self.data.type]) do
			self.loader:addPath(SodacheUtil.getBuildingResUrl(v.prefab))
		end

		self.loader:startLoad(self.loadResFinish, self)
	end
end

function SodacheBuildingItem:loadResFinish()
	self:refreshBuilding()
end

function SodacheBuildingItem:refreshUI()
	local outsideMo = SodacheModel.instance:getOutsideMo()
	local adventureLvl = outsideMo.prop.level
	local curLvl = self.data.level
	local nextCo = lua_sodache_building.configDict[self.data.type][curLvl + 1]
	local levelEnough = nextCo and adventureLvl >= nextCo.requiredLevel

	if curLvl == 0 and not levelEnough then
		gohelper.setActive(self.go, false)
	else
		self._txtName.text = self.data.baseCo.name

		gohelper.setActive(self._btnEnter, curLvl ~= 0)

		if self.data.type == SodacheEnum.BuildingType.Enter then
			gohelper.setActive(self._goLevel, false)
		else
			local isMax = curLvl == self.data.maxLevel

			gohelper.setActive(self._btnMax, isMax)
			gohelper.setActive(self._btnBuild, levelEnough and curLvl == 0)
			gohelper.setActive(self._btnUp, levelEnough and curLvl ~= 0)

			self._txtLevel.text = "Lv" .. curLvl

			gohelper.setActive(self._goLevel, true)
		end

		gohelper.setActive(self.go, true)
	end
end

function SodacheBuildingItem:refreshBuilding()
	local config = self.data.co

	if not config then
		return
	end

	if not gohelper.isNil(self.handleBuilding) then
		if self.clickListener then
			self.clickListener:RemoveClickListener()

			self.clickListener = nil
		end

		gohelper.destroy(self.handleBuilding)
	end

	local path = SodacheUtil.getBuildingResUrl(config.prefab)
	local assetItem = self.loader:getAssetItem(path)
	local res = assetItem:GetResource(path)

	self.handleBuilding = gohelper.clone(res, self.goScene)
	self.animBuilding = gohelper.findComponentAnim(self.handleBuilding)

	self:addBoxCollinderClick()
end

function SodacheBuildingItem:onBuildingUpgrade(type)
	if self.data.type == type then
		self:refreshUI()
		self:refreshBuilding()
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.building_lvup_effect)
	end
end

function SodacheBuildingItem:_btnEnterOnClick()
	if self.data.type == SodacheEnum.BuildingType.Enter then
		ViewMgr.instance:openView(ViewName.SodacheMapSelectView)
	elseif self.data.type == SodacheEnum.BuildingType.Cost then
		ViewMgr.instance:openView(ViewName.SodacheCostView)
	elseif self.data.type == SodacheEnum.BuildingType.Relic then
		ViewMgr.instance:openView(ViewName.SodacheRelicView)
	end
end

function SodacheBuildingItem:_btnUpOnClick()
	ViewMgr.instance:openView(ViewName.SodacheUpgradeView, self.data)
end

function SodacheBuildingItem:addBoxCollinderClick()
	local goElement = gohelper.findChild(self.handleBuilding, "element")

	self.clickListener = ZProj.BoxColliderClickListener.Get(goElement)

	self.clickListener:SetIgnoreUI(false)
	self.clickListener:AddClickListener(self.clickBoxCollinder, self)
end

function SodacheBuildingItem:clickBoxCollinder()
	if ViewHelper.instance:checkViewOnTheTop(ViewName.SodacheMainView, {
		ViewName.GMGuideStatusView,
		ViewName.GuideStepEditor,
		ViewName.SodacheToastView,
		ViewName.SodacheCardToastView
	}) then
		self:_btnEnterOnClick()
	end
end

function SodacheBuildingItem:onGuildClickBuilding(buildingId)
	if self.data.type == tonumber(buildingId) then
		self:_btnEnterOnClick()
	end
end

function SodacheBuildingItem:onPlayEffect(type)
	if self.data.type == type then
		self.animBuilding:Play("leveup", 0, 0)
	end
end

function SodacheBuildingItem:checkReddot()
	if self.data and self.data.type == SodacheEnum.BuildingType.Relic then
		return SodacheUtil.checkOneKeyUpRelic()
	end

	return false
end

function SodacheBuildingItem:refreshReddot()
	self.reddot:refreshRedDot()
end

return SodacheBuildingItem
