-- chunkname: @modules/logic/enemyinfo/view/tab/EnemyInfoSeason123TabView.lua

module("modules.logic.enemyinfo.view.tab.EnemyInfoSeason123TabView", package.seeall)

local EnemyInfoSeason123TabView = class("EnemyInfoSeason123TabView", UserDataDispose)

function EnemyInfoSeason123TabView:onInitView()
	self.goseasontab = gohelper.findChild(self.viewGO, "#go_tab_container/#go_season123tab")
	self.simagebg = gohelper.findChildSingleImage(self.goseasontab, "#simage_bg")
	self.golayeritem = gohelper.findChild(self.goseasontab, "scroll_layer/Viewport/layer_content/#go_layeritem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoSeason123TabView:addEvents()
	return
end

function EnemyInfoSeason123TabView:removeEvents()
	return
end

function EnemyInfoSeason123TabView:_editableInitView()
	gohelper.setActive(self.golayeritem, false)

	self.layerItemList = {}

	self.simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))
end

function EnemyInfoSeason123TabView:onOpen()
	gohelper.setActive(self.goseasontab, true)

	self.actId = self.viewParam.activityId
	self.stage = self.viewParam.stage

	local coList = Season123Config.instance:getSeasonEpisodeByStage(self.actId, self.stage)

	for index, co in ipairs(coList) do
		local layerItem = self:getLayerItem()

		layerItem.layer = co.layer
		layerItem.txt.text = string.format("%02d", index)
	end

	local layer = self.viewParam.layer

	layer = layer or coList[1].layer

	self:selectLayer(layer)
end

function EnemyInfoSeason123TabView:getLayerItem()
	local layerItem = self:getUserDataTb_()

	layerItem.go = gohelper.cloneInPlace(self.golayeritem)
	layerItem.txt = gohelper.findChildText(layerItem.go, "txt")
	layerItem.goSelect = gohelper.findChild(layerItem.go, "select")
	layerItem.click = gohelper.getClickWithDefaultAudio(layerItem.go)

	layerItem.click:AddClickListener(self.onClickLayerItem, self, layerItem)
	gohelper.setActive(layerItem.go, true)
	table.insert(self.layerItemList, layerItem)

	return layerItem
end

function EnemyInfoSeason123TabView:onClickLayerItem(layerItem)
	self:selectLayer(layerItem.layer)
end

function EnemyInfoSeason123TabView:updateLayerItemSelect()
	for _, layerItem in ipairs(self.layerItemList) do
		gohelper.setActive(layerItem.goSelect, layerItem.layer == self.selectLayerId)
	end
end

function EnemyInfoSeason123TabView:selectLayer(layerId)
	if self.selectLayerId == layerId then
		return
	end

	self.selectLayerId = layerId

	self:updateLayerItemSelect()

	local co = Season123Config.instance:getSeasonEpisodeCo(self.actId, self.stage, self.selectLayerId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(co.episodeId)

	self.enemyInfoMo:updateBattleId(episodeCo.battleId)
end

function EnemyInfoSeason123TabView:onClose()
	return
end

function EnemyInfoSeason123TabView:onDestroyView()
	self.simagebg:UnLoadImage()

	for _, layerItem in ipairs(self.layerItemList) do
		layerItem.click:RemoveClickListener()
	end
end

return EnemyInfoSeason123TabView
