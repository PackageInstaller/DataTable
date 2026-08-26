-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapTrapItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapItem", package.seeall)

local VersionActivity_1_2_DungeonMapTrapItem = class("VersionActivity_1_2_DungeonMapTrapItem", BaseViewExtended)

function VersionActivity_1_2_DungeonMapTrapItem:onInitView()
	self._topRight = gohelper.findChild(self.viewGO, "topRight")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapTrapItem:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, self._btncloseOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapTrapItem:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapTrapItem:_btncloseOnClick()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", nil, nil)

	self._closeTween = ZProj.TweenHelper.DOTweenFloat(5, 6.75, 0.5, self._tweenFloatFrameCb, self.DESTROYSELF, self)
end

function VersionActivity_1_2_DungeonMapTrapItem:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_2_DungeonMapTrapItem:onOpen()
	MainCameraMgr.instance:setLock(true)
	gohelper.setActive(self.viewGO, false)

	self._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	self._putTrap = VersionActivity1_2DungeonModel.instance.putTrap

	local configList = {}
	local objList = {}

	for k, v in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(self._config.id)) do
		table.insert(configList, v)

		if not self._modelItem then
			self._modelItem = gohelper.findChild(self.viewGO, "Root/rotate/choicelayout/choice")

			table.insert(objList, self._modelItem)
		else
			table.insert(objList, gohelper.cloneInPlace(self._modelItem))
		end
	end

	table.sort(configList, function(item1, item2)
		return item1.id < item2.id
	end)

	for i, v in ipairs(configList) do
		self:openSubView(VersionActivity_1_2_DungeonMapTrapChildItem, objList[i], nil, v)
	end

	TaskDispatcher.runDelay(self._showOpenCameraAni, self, 0.3)
end

function VersionActivity_1_2_DungeonMapTrapItem:_showOpenCameraAni()
	gohelper.setActive(self.viewGO, true)

	self._openTween = ZProj.TweenHelper.DOTweenFloat(6.75, 5, 0.5, self._tweenFloatFrameCb, nil, self)
end

function VersionActivity_1_2_DungeonMapTrapItem:_tweenFloatFrameCb(value)
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = value
end

function VersionActivity_1_2_DungeonMapTrapItem:_showCurrency()
	self:com_loadAsset(CurrencyView.prefabPath, self._onCurrencyLoaded)
end

function VersionActivity_1_2_DungeonMapTrapItem:_onCurrencyLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._topRight)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.DryForest
	}
	local currencyView = self:openSubView(CurrencyView, obj, nil, currencyParam)

	currencyView.foreShowBtn = true

	currencyView:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function VersionActivity_1_2_DungeonMapTrapItem:onClose()
	TaskDispatcher.cancelTask(self._showOpenCameraAni, self)

	if self._openTween then
		ZProj.TweenHelper.KillById(self._openTween)
	end

	if self._closeTween then
		ZProj.TweenHelper.KillById(self._closeTween)
	end

	MainCameraMgr.instance:setLock(false)
end

function VersionActivity_1_2_DungeonMapTrapItem:onDestroyView()
	return
end

return VersionActivity_1_2_DungeonMapTrapItem
