-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldBuffView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldBuffView", package.seeall)

local HolyDragonFieldBuffView = class("HolyDragonFieldBuffView", ViewComponent)

function HolyDragonFieldBuffView:buildUI()
	HolyDragonFieldBuffView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._txtName = self:getTxt("content/name/txt")
	self._txtLevel = self:getTxt("content/level/txt")
	self._txtLockGo = self:getGo("content/txtLock")
	self._txtLock = self:getTxt("content/txtLock")
	self._btnJump = self:getGo("content/txtLock/btnJump")
	self._buffIcon = self:getGo("content/buffIcon")
	self._effectPanels = {
		left = self:_createEffectPanel("content/left"),
		middle = self:_createEffectPanel("content/middle"),
		right = self:_createEffectPanel("content/right")
	}
	self._btnSure = self:getGo("content/btnSure")
	self._txtBtnSure = self:getTxt("content/btnSure/txt")
	self._costGo = self:getGo("content/gold")
	self._txtCost = self:getTxt("content/gold/txt")
	self._costItem = self:getGo("content/gold/txt/item")
	self._goldBarCon = self:getGo("goldBarCon")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function HolyDragonFieldBuffView:_createEffectPanel(path)
	return {
		go = self:getGo(path),
		txtTitle = self:getTxt(path .. "/title/txt"),
		txtDesc = self:getTxt(path .. "/txtDesc"),
		tagUpgrade = goutil.findChild(self:getGo(path), "tagUpgrade")
	}
end

function HolyDragonFieldBuffView:bindEvents()
	HolyDragonFieldBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
end

function HolyDragonFieldBuffView:unbindEvents()
	HolyDragonFieldBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnJump)
end

function HolyDragonFieldBuffView:onEnter()
	HolyDragonFieldBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curFieldId = checknumber(params[2])

	if self._activityId <= 0 then
		self._activityId = HolyDragonFieldController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)
	self._actData = HolyDragonFieldConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HolyDragonField_InfoRefresh, self._onInfoRefresh, self)
	self.addGEvent(self, GlobalNotify.HolyDragonField_BuffUpgrade, self._onBuffUpgrade, self)
	self:_onUpdate()
	HolyDragonFieldController.instance:sendPM_HolyDragonFieldInfoReq(self._activityId)
end

function HolyDragonFieldBuffView:onExit()
	HolyDragonFieldBuffView.super.onExit(self)

	if self._tabScrollerList then
		self._tabScrollerList:dispose()
	end

	self:_clearBuffIcon()
	self:_clearCostIcon()
end

function HolyDragonFieldBuffView:_onInfoRefresh(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldBuffView:_onBuffUpgrade(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldBuffView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonFieldBuffView:_onUpdateData()
	self._tabDataList = {}

	local fieldDatas = HolyDragonFieldConfig.instance:getFieldDatas(self._activityId)

	for fieldId, fieldData in pairs(fieldDatas or {}) do
		local level = self._subMo:getBuffLevel(fieldId)
		local isUnlocked = self._subMo:isBuffUnlocked(fieldId)
		local var_10_0 = self._tabDataList
		local var_10_1 = {
			fieldId = fieldId,
			fieldData = fieldData,
			level = level,
			isUnlocked = isUnlocked
		}

		var_10_1.curBuffData = isUnlocked and HolyDragonFieldConfig.instance:getBuffData(self._activityId, fieldId, level) or nil
		var_10_1.nextBuffData = HolyDragonFieldController.instance:getNextBuffData(self._activityId, fieldId)
		var_10_1.canUpgrade = HolyDragonFieldController.instance:isBuffCanUpgrade(self._activityId, fieldId)

		table.insert(var_10_0, var_10_1)
	end

	table.sort(self._tabDataList, function(a, b)
		return a.fieldId < b.fieldId
	end)

	if not self:_hasFieldData(self._curFieldId) then
		local firstData = self._tabDataList[1]

		if firstData then
			self._curFieldId = firstData.fieldId or 0
		end
	end

	self._curData = self:_getCurData()

	if self._curData then
		self._curBuffData = self._curData.curBuffData or nil
	end

	if self._curData then
		self._nextBuffData = self._curData.nextBuffData or nil
	end

	if self._curData then
		self._canUpgrade = self._curData.canUpgrade or false
	end
end

function HolyDragonFieldBuffView:_onUpdateUI()
	self._tabScrollerList:reloadData(self._tabDataList)
	self:_onUpdateBuffUI()
	self:_updateGoldBar()
	self:_onUpdateBtnSure()
end

function HolyDragonFieldBuffView:_onUpdateBuffUI()
	self:_clearBuffIcon()
	self:_clearCostIcon()

	if self._curData == nil then
		self._txtName.text = ""
		self._txtLevel.text = ""
		self._txtLock.text = ""
		self._txtCost.text = ""

		self:_hideAllEffectPanels()
		GameUtil.SetActive(self._txtLockGo, false)
		GameUtil.SetActive(self._costGo, false)

		return
	end

	self._txtName.text = lang(self._curData.fieldData.nameLangkey)
	self._txtLevel.text = self._curData.isUnlocked and string.format("LV.%s", self._curData.level) or "未解锁"

	self:_updateEffectPanels()
	self:_updateLockTips()

	if self._curBuffData then
		if not self._curBuffData.icon then
			local costStr

			costStr = self._nextBuffData

			if self._nextBuffData then
				local icon = self._nextBuffData.icon

				if not string.nilorempty(icon) then
					uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, self:_getBuffIconUrl(icon))
				end

				if self._curData.isUnlocked and self._nextBuffData then
					costStr = self._nextBuffData.unlockCost
				end

				GameUtil.SetActive(self._costGo, self._curData.isUnlocked and not string.nilorempty(costStr))

				if not string.nilorempty(costStr) then
					local matType, matId, matNum = MaterialMgr.getMatParams(costStr)

					MaterialMgr.setIcon(self._costItem, matType, matId)

					self._txtCost.text = tostring(matNum)
				else
					self._txtCost.text = ""
				end
			end
		end
	end
end

function HolyDragonFieldBuffView:_updateEffectPanels()
	self:_hideAllEffectPanels()

	if self._curBuffData and self._nextBuffData then
		self:_setEffectPanel(self._effectPanels.left, "本级效果", self._curBuffData.desc, false)
		self:_setEffectPanel(self._effectPanels.right, "下级效果", self._nextBuffData.desc, true)
	elseif self._curBuffData then
		self:_setEffectPanel(self._effectPanels.middle, "本级效果", self._curBuffData.desc, false)
	elseif self._nextBuffData then
		self:_setEffectPanel(self._effectPanels.middle, "下级效果", self._nextBuffData.desc, false)
	end
end

function HolyDragonFieldBuffView:_hideAllEffectPanels()
	for _, panel in pairs(self._effectPanels or {}) do
		GameUtil.SetActive(panel.go, false)
	end
end

function HolyDragonFieldBuffView:_setEffectPanel(panel, title, desc, isUpgrade)
	GameUtil.SetActive(panel.go, true)

	panel.txtTitle.text = title
	panel.txtDesc.text = desc or ""

	if panel.tagUpgrade then
		GameUtil.SetActive(panel.tagUpgrade, isUpgrade)
	end
end

function HolyDragonFieldBuffView:_updateLockTips()
	if self._curData then
		GameUtil.SetActive(self._txtLockGo, self._curData)

		if self._curData then
			local floorData = self:_getCurTempleFloorData()

			if floorData then
				if not floorData.name then
					local floorName = "圣殿"

					self._txtLock.text = string.format("通关<color=#20b376>%s</color>解锁", floorName)
				end
			end
		else
			self._txtLock.text = ""
		end
	end
end

function HolyDragonFieldBuffView:_getBuffIconUrl(icon)
	local iconUrl = icon

	if string.sub(iconUrl, 1, 3) ~= "ui/" then
		iconUrl = "ui/" .. iconUrl
	end

	return iconUrl .. ".png"
end

function HolyDragonFieldBuffView:_onUpdateBtnSure()
	local canShowBtn = self._curData ~= nil and self._curData.isUnlocked

	GameUtil.SetActive(self._btnSure, canShowBtn)

	if canShowBtn then
		self._txtBtnSure.text = self._nextBuffData and "升级" or "已满级"

		GameUtil.SetGray(self._btnSure, not self._canUpgrade)
	end
end

function HolyDragonFieldBuffView:_updateGoldBar()
	local costStr = self:_getGoldBarCostStr()
	local showGoldBar = not string.nilorempty(costStr)

	GameUtil.SetActive(self._goldBarCon, showGoldBar)

	if not showGoldBar then
		return
	end

	local matType, matId = MaterialMgr.getMatParams(costStr)
	local matCfg = MaterialMgr.getMatCfg(matType, matId)
	local goldInfo = {
		id = costStr,
		showAdd = matCfg ~= nil and not string.nilorempty(matCfg.source)
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	}, false)
end

function HolyDragonFieldBuffView:_getGoldBarCostStr()
	if self._nextBuffData and not string.nilorempty(self._nextBuffData.unlockCost) then
		return self._nextBuffData.unlockCost
	end

	local buffDatas = HolyDragonFieldConfig.instance:getBuffDatas(self._activityId, self._curFieldId)

	if buffDatas then
		for _, buffData in ipairs(buffDatas) do
			if buffData and not string.nilorempty(buffData.unlockCost) then
				return buffData.unlockCost
			end
		end
	end

	return nil
end

function HolyDragonFieldBuffView:_updateTabCell(view, cell, data)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "level/txt")
	local tagLock = goutil.findChild(go, "tagLock")
	local redpoint = goutil.findChild(go, "redpoint")
	local isSelected = self._curFieldId == data.fieldId

	txtName.text = lang(data.fieldData.nameLangkey)
	txtLevel.text = data.isUnlocked and string.format("LV.%s", data.level) or "未解锁"

	GameUtil.setUIGroupIdx(go, isSelected and 1 or 0)
	GameUtil.SetActive(tagLock, not data.isUnlocked)
	GameUtil.SetActive(redpoint, data.canUpgrade)
	uGuiUtil.clearImage(img)
	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, data.fieldId))
end

function HolyDragonFieldBuffView:_clearTabCell(cell)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")

	GameUtil.rmClickHandler(go)
	uGuiUtil.clearImage(img)
end

function HolyDragonFieldBuffView:_onClickTab(fieldId)
	self._curFieldId = fieldId

	self:_onUpdate()
end

function HolyDragonFieldBuffView:_hasFieldData(fieldId)
	for _, data in ipairs(self._tabDataList or {}) do
		if data.fieldId == fieldId then
			return true
		end
	end

	return false
end

function HolyDragonFieldBuffView:_getCurData()
	for _, data in ipairs(self._tabDataList or {}) do
		if data.fieldId == self._curFieldId then
			return data
		end
	end

	return nil
end

function HolyDragonFieldBuffView:_getTempleActivityId()
	return self._actData and checknumber(self._actData.relevantActivityId) or 0
end

function HolyDragonFieldBuffView:_getCurTempleFloorId()
	if self._curData then
		if not self._curData.fieldData then
			local fieldData

			return fieldData and checknumber(fieldData.relevantFloorId) or 0
		end
	end
end

function HolyDragonFieldBuffView:_getCurTempleFloorData()
	local activityId = self:_getTempleActivityId()
	local floorId = self:_getCurTempleFloorId()

	if activityId <= 0 or floorId <= 0 then
		return nil
	end

	return HolyDragonTempleConfig.instance:getFloorData(activityId, floorId)
end

function HolyDragonFieldBuffView:_clearBuffIcon()
	uGuiUtil.clearImage(self._buffIcon)
end

function HolyDragonFieldBuffView:_clearCostIcon()
	MaterialMgr.clearIcon(self._costItem)
end

function HolyDragonFieldBuffView:_onClickBtnTip()
	if self._actData and self._actData.mainRuleKey then
		TipsFacade.instance:openRulesView(self._actData.mainRuleKey)
	end
end

function HolyDragonFieldBuffView:_onClickBtnSure()
	if self._curData == nil then
		return
	end

	if not self._curData.isUnlocked then
		FloatWordMgr.instance:show("未解锁")

		return
	end

	if self._nextBuffData == nil then
		FloatWordMgr.instance:show("已满级")

		return
	end

	if not MaterialMgr.getMatEnough(self._nextBuffData.unlockCost) then
		FloatWordMgr.instance:show("材料不足")

		return
	end

	if not self._canUpgrade then
		return
	end

	HolyDragonFieldController.instance:sendPM_HolyDragonFieldUpgradeBuffReq(self._activityId, self._curFieldId)
end

function HolyDragonFieldBuffView:_onClickBtnJump()
	if self._curData == nil then
		return
	end

	local activityId = self:_getTempleActivityId()
	local floorId = self:_getCurTempleFloorId()

	if activityId <= 0 or floorId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.HolyDragonTempleMainView, activityId, floorId)
end

return HolyDragonFieldBuffView
