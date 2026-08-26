-- chunkname: @modules/logic/rouge/dlc/103/view/RougeMapBossCollectionComp.lua

module("modules.logic.rouge.dlc.103.view.RougeMapBossCollectionComp", package.seeall)

local RougeMapBossCollectionComp = class("RougeMapBossCollectionComp", BaseViewExtended)

function RougeMapBossCollectionComp:definePrefabUrl()
	self:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleview.prefab")
end

function RougeMapBossCollectionComp:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "Bg/normal")
	self._gohard = gohelper.findChild(self.viewGO, "Bg/hard")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_collection/#go_collectionitem")
	self._btnfresh = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fresh")
	self._txtrule = gohelper.findChildText(self.viewGO, "RuleView/Viewport/Content/#txt_rule")
	self._gopic = gohelper.findChild(self.PARENT_VIEW.viewGO, "#go_layer_right/#go_pic")
	self._gofreshnormal = gohelper.findChild(self.viewGO, "fresh_normal")
	self._gofreshhard = gohelper.findChild(self.viewGO, "fresh_hard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapBossCollectionComp:addEvents()
	self._btnfresh:AddClickListener(self._btnfreshOnClick, self)
end

function RougeMapBossCollectionComp:removeEvents()
	self._btnfresh:RemoveClickListener()
end

function RougeMapBossCollectionComp:_btnfreshOnClick()
	if not self._selectLayerId or not self._canFreshMapRule then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeMapRule)

	if self._layerChoiceInfo then
		local ruleCo = self._layerChoiceInfo:getMapRuleCo()
		local ruleType = ruleCo and ruleCo.type

		gohelper.setActive(self._gofreshnormal, ruleType == RougeDLCEnum103.MapRuleType.Normal)
		gohelper.setActive(self._gofreshhard, ruleType == RougeDLCEnum103.MapRuleType.Hard)

		local season = RougeModel.instance:getSeason()

		RougeRpc.instance:sendRougeRefreshMapRuleRequest(season, self._selectLayerId)
	end
end

function RougeMapBossCollectionComp:_editableInitView()
	self._collectionItemTab = self:getUserDataTb_()
	self._gofresh_light = gohelper.findChild(self.viewGO, "#btn_fresh/light")
	self._gofresh_dark = gohelper.findChild(self.viewGO, "#btn_fresh/dark")

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, self.onChangeMapInfo, self)
end

function RougeMapBossCollectionComp:onOpen()
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	self:initData(RougeMapModel.instance:getSelectLayerId())
	self:refresh()
end

function RougeMapBossCollectionComp:initData(layerId)
	self._selectLayerId = layerId
	self._layerChoiceInfo = RougeMapModel.instance:getLayerChoiceInfo(self._selectLayerId)
	self._mapRuleCanFreshNum = self._layerChoiceInfo and self._layerChoiceInfo:getMapRuleCanFreshNum()
	self._canFreshMapRule = self._mapRuleCanFreshNum and self._mapRuleCanFreshNum > 0
	self._isPathSelect = RougeMapModel.instance:isPathSelect()
end

function RougeMapBossCollectionComp:refresh()
	gohelper.setActive(self._gopic, not self._isPathSelect)

	if not self._isPathSelect then
		return
	end

	self:refreshFreshBtn()
	self:refreshMapRuleInfos()
	self:refreshCollections()
end

function RougeMapBossCollectionComp:refreshFreshBtn()
	gohelper.setActive(self._gofresh_light, self._canFreshMapRule)
	gohelper.setActive(self._gofresh_dark, not self._canFreshMapRule)
end

function RougeMapBossCollectionComp:refreshMapRuleInfos()
	if self._layerChoiceInfo then
		local ruleCo = self._layerChoiceInfo:getMapRuleCo()
		local ruleType = ruleCo and ruleCo.type

		if ruleCo then
			if not ruleCo.desc then
				local ruleDesc = ""

				self._txtrule.text = SkillHelper.buildDesc(ruleDesc)

				SkillHelper.addHyperLinkClick(self._txtrule)
				gohelper.setActive(self._gonormal, ruleType == RougeDLCEnum103.MapRuleType.Normal)
				gohelper.setActive(self._gohard, ruleType == RougeDLCEnum103.MapRuleType.Hard)
			end
		end
	end
end

function RougeMapBossCollectionComp:refreshCollections()
	self._collectionCfgIds = self._layerChoiceInfo and self._layerChoiceInfo:getCurLayerCollection()

	local useMap = {}

	for index, collectionCfgId in ipairs(self._collectionCfgIds or {}) do
		local collectionItem = self:_getOrCreateCollectionItem(index)
		local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
		local collectionIconUrl = RougeCollectionHelper.getCollectionIconUrl(collectionCfgId)

		collectionItem.simageicon:LoadImage(collectionIconUrl)

		local showRare = collectionCo and collectionCo.showRare

		UISpriteSetMgr.instance:setRougeSprite(collectionItem.imagebg, "rouge_episode_collectionbg_" .. tostring(showRare))
		gohelper.setActive(collectionItem.viewGO, true)

		useMap[collectionItem] = true
	end

	for _, collectionItem in pairs(self._collectionItemTab) do
		if not useMap[collectionItem] then
			gohelper.setActive(collectionItem.viewGO, false)
		end
	end
end

function RougeMapBossCollectionComp:_getOrCreateCollectionItem(index)
	local collectionItem = self._collectionItemTab[index]

	if not collectionItem then
		collectionItem = self:getUserDataTb_()
		collectionItem.viewGO = gohelper.cloneInPlace(self._gocollectionitem, "collection_" .. index)
		collectionItem.imagebg = gohelper.findChildImage(collectionItem.viewGO, "#image_bg")
		collectionItem.simageicon = gohelper.findChildSingleImage(collectionItem.viewGO, "#simage_collection")
		collectionItem.btnclick = gohelper.findChildButtonWithAudio(collectionItem.viewGO, "#btn_click")

		collectionItem.btnclick:AddClickListener(self._btncollectionOnClick, self, index)

		self._collectionItemTab[index] = collectionItem
	end

	return collectionItem
end

function RougeMapBossCollectionComp:_btncollectionOnClick(index)
	local collectionCfgId = self._collectionCfgIds[index]

	if not collectionCfgId then
		return
	end

	local params = {
		interactable = false,
		collectionCfgId = collectionCfgId,
		viewPosition = RougeEnum.CollectionTipPos.MapRule
	}

	RougeController.instance:openRougeCollectionTipView(params)
end

function RougeMapBossCollectionComp:_releaseAllCollectionItems()
	for _, collectionItem in pairs(self._collectionItemTab) do
		collectionItem.simageicon:UnLoadImage()
		collectionItem.btnclick:RemoveClickListener()
	end
end

function RougeMapBossCollectionComp:onSelectLayerChange(layerId)
	self:initData(layerId)
	gohelper.setActive(self._gofreshnormal, false)
	gohelper.setActive(self._gofreshhard, false)
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.runDelay(self.refresh, self, RougeMapEnum.WaitMapRightRefreshTime)
end

function RougeMapBossCollectionComp:onChangeMapInfo()
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	self:initData(RougeMapModel.instance:getSelectLayerId())
	self:refresh()
end

function RougeMapBossCollectionComp:onClose()
	TaskDispatcher.cancelTask(self.refresh, self)
	self:_releaseAllCollectionItems()
end

return RougeMapBossCollectionComp
