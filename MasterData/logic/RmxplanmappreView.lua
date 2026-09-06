-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanmappreView.lua

module("logic.extensions.richmanxplan.view.RmxplanmappreView", package.seeall)

local RmxplanmappreView = class("RmxplanmappreView", ViewComponent)

function RmxplanmappreView:ctor()
	RmxplanmappreView.super.ctor(self)
end

function RmxplanmappreView:unbindEvents()
	RmxplanmappreView.super.unbindEvents(self)
	self._btnGridTip:RemoveClickListener()
	self._btnTudiTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function RmxplanmappreView:bindEvents()
	RmxplanmappreView.super.bindEvents(self)
	self._btnGridTip:AddClickListener(self._onClickbtnGridTip, self)
	self._btnTudiTip:AddClickListener(self._onClickbtnTudiTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function RmxplanmappreView:buildUI()
	RmxplanmappreView.super.buildUI(self)

	self._btnGridTip = self:getBtn("grid/btnGridTip")
	self._btnTudiTip = self:getBtn("tudi/btnTudiTip")
	self._btnClose = self:getBtn("btnClose")
	self._txtTudiHave = self:getTxt("tudi/txtTudiHave")
	self._gridcellGo = self:getGo("grid/gridcell")
	self._gridsGo = self:getGo("grid/grids")
	self._itemGroup = ItemGroup.New(self._gridsGo, self._gridcellGo, nil, nil, true, self._clearItem, self)
	self._singleLine = self:getGo("grid/grids"):GetComponent(typeof(UILayoutMulLines))

	self:_buildMapItems()
end

function RmxplanmappreView:_buildMapItems()
	self._mapGo = self:getGo("map")
	self._mapItems = {}

	for i = 1, 3 do
		local go = goutil.findChild(self._mapGo, "map" .. i)

		self._mapItems[i] = {
			go = go,
			goCurr = goutil.findChild(go.gameObject, "curr"),
			goIcon = goutil.findChild(go.gameObject, "icon"),
			txtLockTip = goutil.findChildTextComponent(go.gameObject, "txtLockTip"),
			txtName = goutil.findChildTextComponent(go.gameObject, "txtName")
		}
	end
end

function RmxplanmappreView:onExit()
	RmxplanmappreView.super.onExit(self)
	self._itemGroup:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function RmxplanmappreView:onEnter()
	RmxplanmappreView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._info = RichmanxplanModel.instance:getInfo(self._activityId)
	self._curZoneId = self._info.location.zoneId

	self:_updateUI()
	self:_setEffect()
end

function RmxplanmappreView:_onClickbtnGridTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "geziTypeRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RmxplanmappreView:_onClickbtnTudiTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "hasTudiRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RmxplanmappreView:_onClickbtnClose()
	self:close()
end

function RmxplanmappreView:_updateUI()
	self:_updateTudi()
	self:_updateGrids()
	self:_updateMaps()
end

function RmxplanmappreView:_updateTudi()
	local haveCount = 0
	local totalCount = 0

	for i, v in ipairs(self._info.zones or {}) do
		haveCount = haveCount + #v.grids
	end

	local zoneCfgs = RichmanxplanConfig.instance:getZoneCfgs(self._activityId)

	for i, v in ipairs(zoneCfgs) do
		local gridCfgs = RichmanxplanConfig.instance:getGridCfgs(self._activityId, v.zoneId)

		for _, gridCfg in ipairs(gridCfgs) do
			if gridCfg.eventType == RichmanxplanController.EventType.Tudi then
				totalCount = totalCount + 1
			end
		end
	end

	self._txtTudiHave.text = string.format("%s/%s", haveCount, totalCount)
end

function RmxplanmappreView:_updateGrids()
	local cfgs = RichmanxplanConfig.instance:getEventDefineCfgs()

	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		local goImg = goutil.findChild(item.mainGO, "img")
		local txtName = goutil.findChildTextComponent(item.mainGO, "txtName")

		txtName.text = cfg.name

		uGuiUtil.setSpriteToImage(goImg, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.iconRes))
	end)
	self._singleLine:Layout()
end

function RmxplanmappreView:_clearItem(item)
	local goImg = goutil.findChild(item.mainGO, "img")

	uGuiUtil.clearImage(goImg)
end

function RmxplanmappreView:_updateMaps()
	local now = ServerTime.now()
	local zoneCfgs = RichmanxplanConfig.instance:getZoneCfgs(self._activityId)

	for i, v in ipairs(zoneCfgs) do
		local item = self._mapItems[v.zoneId]
		local openTime = GameUtil.string2time(v.openDateTime)
		local isOpen = openTime <= now

		item.txtName.text = v.name

		goutil.setActive(item.goCurr, self._curZoneId == v.zoneId)
		goutil.setActive(item.txtLockTip.gameObject, not isOpen)

		if not isOpen then
			local date = GameUtil.string2date(v.openDateTime)

			item.txtLockTip.text = string.format("%s月%s日%02d:%02d后解锁", date.month, date.day, date.hour, date.min)
		end
	end
end

function RmxplanmappreView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return RmxplanmappreView
