-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanBuffView.lua

module("logic.extensions.watertianyan.view.WaterTianYanBuffView", package.seeall)

local WaterTianYanBuffView = class("WaterTianYanBuffView", ViewComponent)

function WaterTianYanBuffView:ctor()
	WaterTianYanBuffView.super.ctor(self)
end

function WaterTianYanBuffView:buildUI()
	WaterTianYanBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("main/btnClose")
	self._btnClose2 = self:getBtn("btnClose")
	self.cellGo = self:getGo("main/tablecell")
	self.scrollerGo1 = self:getGo("main/tableview1")
	self._scrollList1 = ScrollerList.create(self.scrollerGo1, self.cellGo, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearCell1, self))
	self.scrollerGo2 = self:getGo("main/tableview2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._upgrade = self:getGo("main/upgrade")
	self._icon = self:getGo("main/upgrade/icon")
	self._txtName = self:getTxt("main/upgrade/txtName")
	self._txtLv = self:getTxt("main/upgrade/txtLv")
	self._txtDesc = self:getTxt("main/upgrade/txtDesc")
	self._maxLvGo = self:getGo("main/upgrade/maxLv")
	self._costGo = self:getGo("main/upgrade/cost")
	self._costIcon = self:getGo("main/upgrade/cost/icon")
	self._txtNum = self:getTxt("main/upgrade/cost/txtNum")
	self._btnClick = self:getBtn("main/upgrade/cost/btn")
	self._txtBtn = self:getTxt("main/upgrade/cost/btn/txt")
end

function WaterTianYanBuffView:bindEvents()
	WaterTianYanBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnClose2:AddClickListener(self._onClickClose, self)
	self._btnClick:AddClickListener(self._onClickCost, self)
end

function WaterTianYanBuffView:unbindEvents()
	WaterTianYanBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function WaterTianYanBuffView:onEnter()
	WaterTianYanBuffView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanUpgradeBuffRes, self._onUpgradeBuffRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._buffViewType = params[2]
	self._index = params[3]
	self._curStageId = params[4]
	self._cfgActivity = WaterTianYanConfig.instance:getActivityCfg(self._activityId)
	self._isShowBuffTip = false
	self._curCfgBuffItem = nil
	self._showChoingEffectBuffs = nil

	self:_initGo()
	self:_updateBuffs()
end

function WaterTianYanBuffView:onExit()
	WaterTianYanBuffView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanUpgradeBuffRes, self._onUpgradeBuffRes, self)
	self:_resetBuffInfo()
end

function WaterTianYanBuffView:_onClickClose()
	if self._isShowBuffTip then
		self:_resetBuffInfo()
	else
		self:close()
	end
end

function WaterTianYanBuffView:_updateCell1(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local levelUp = goutil.findChild(cell, "levelUp")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local lock = goutil.findChild(cell, "lock")
	local used = goutil.findChild(cell, "used")
	local chosing = goutil.findChild(cell, "chosing")

	btn:AddClickListener(function()
		self:_onClickBuff(data)
	end)

	local cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, data.buffItemId, 1)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))

	local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, data.buffItemId)

	txtLv.text = level > 0 and string.format("Lv.%d", level) or "未解锁"

	goutil.setActive(lock, level == 0)

	local nextLevel = level + 1
	local cfgBuffItemLevel = WaterTianYanConfig.instance:getBuffItemLevelCfg(self._activityId, data.buffItemId, nextLevel)

	if cfgBuffItemLevel then
		local isEnough = MaterialMgr.getMatEnough(cfgBuffItemLevel.cost)

		goutil.setActive(levelUp, isEnough)
	else
		goutil.setActive(levelUp, false)
	end

	if self._buffViewType == WaterTianYanModel.BuffViewMain then
		local isUsedBuff = WaterTianYanModel.instance:isUsedBuff(self._activityId, data.buffItemId)

		goutil.setActive(used, isUsedBuff)

		if WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 1) == data.buffItemId then
			goutil.setActive(chosing, true)
		else
			goutil.setActive(chosing, false)
		end
	else
		goutil.setActive(used, false)
		goutil.setActive(chosing, false)
	end
end

function WaterTianYanBuffView:_clearCell1(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function WaterTianYanBuffView:_updateCell2(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local levelUp = goutil.findChild(cell, "levelUp")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local lock = goutil.findChild(cell, "lock")
	local used = goutil.findChild(cell, "used")
	local chosing = goutil.findChild(cell, "chosing")

	btn:AddClickListener(function()
		self:_onClickBuff(data)
	end)

	local cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, data.buffItemId, 1)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))

	local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, data.buffItemId)

	txtLv.text = level > 0 and string.format("Lv.%d", level) or "未解锁"

	goutil.setActive(lock, level == 0)

	local nextLevel = level + 1
	local cfgBuffItemLevel = WaterTianYanConfig.instance:getBuffItemLevelCfg(self._activityId, data.buffItemId, nextLevel)

	if cfgBuffItemLevel then
		local isEnough = MaterialMgr.getMatEnough(cfgBuffItemLevel.cost)

		goutil.setActive(levelUp, isEnough)
	else
		goutil.setActive(levelUp, false)
	end

	if self._buffViewType == WaterTianYanModel.BuffViewMain then
		local isUsedBuff = WaterTianYanModel.instance:isUsedBuff(self._activityId, data.buffItemId)

		goutil.setActive(used, isUsedBuff)

		if WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 2) == data.buffItemId then
			goutil.setActive(chosing, true)
		else
			goutil.setActive(chosing, false)
		end
	else
		goutil.setActive(used, false)
		goutil.setActive(chosing, false)
	end
end

function WaterTianYanBuffView:_clearCell2(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function WaterTianYanBuffView:_changeSelect(cell)
	local lastCell = self._showChoingEffectBuffs

	if lastCell then
		local lastChosingGo = goutil.findChild(lastCell, "chosing")

		GameUtil.SetActive(lastChosingGo, false)
	end

	local newChosingGo = goutil.findChild(cell, "chosing")

	GameUtil.SetActive(newChosingGo, true)

	self._showChoingEffectBuffs = cell
end

function WaterTianYanBuffView:_onClickBuff(cfgBuffItem)
	self:_updateBuffInfo(cfgBuffItem)

	if self._buffViewType == WaterTianYanModel.BuffViewMain then
		if WaterTianYanModel.instance:isUsedBuff(self._activityId, cfgBuffItem.buffItemId) then
			FloatWordMgr.instance:show("此轮关卡已使用，需重置关卡以再次使用。")
		elseif WaterTianYanModel.instance:isBuffUnlock(self._activityId, cfgBuffItem.buffItemId) then
			GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanSetBuff, cfgBuffItem.buffItemId)

			if cfgBuffItem.type == 1 then
				self._scrollList1:refresh()
			else
				self._scrollList2:refresh()
			end
		end
	end
end

function WaterTianYanBuffView:_initGo()
	goutil.setActive(self._upgrade, false)
end

function WaterTianYanBuffView:_updateBuffs()
	self._buffList1 = WaterTianYanConfig.instance:getBuffItemCfgs(self._activityId, 1)
	self._buffList2 = WaterTianYanConfig.instance:getBuffItemCfgs(self._activityId, 2)

	self._scrollList1:reloadData(self._buffList1)
	self._scrollList2:reloadData(self._buffList2)
end

function WaterTianYanBuffView:_updateBuffInfo(cfgBuffItem)
	self._isShowBuffTip = true
	self._curCfgBuffItem = cfgBuffItem

	goutil.setActive(self._upgrade, true)

	local buffItemLevelList = WaterTianYanConfig.instance:getBuffItemLevelCfgList(self._activityId, cfgBuffItem.buffItemId)
	local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, cfgBuffItem.buffItemId)
	local cfgLevel = level > 0 and level or 1
	local cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, cfgBuffItem.buffItemId, cfgLevel)
	local cfgBuffItemLevel = WaterTianYanConfig.instance:getBuffItemLevelCfg(self._activityId, cfgBuffItem.buffItemId, cfgLevel)

	if buffItemLevelList then
		if not #buffItemLevelList then
			local maxLevel = 1
			local isUnlock = level > 0
			local curLevel = isUnlock and level or 0

			if cfgBuff and cfgBuffItemLevel then
				self._txtName.text = cfgBuff.buffName
				self._txtDesc.text = cfgBuff.desc

				if isUnlock then
					self._txtLv.text = "Lv." .. curLevel or "未解锁"
				end

				self._txtBtn.text = isUnlock and "升级" or "解锁"

				uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))

				local proxy = MaterialMgr.setCellByCfg(cfgBuffItemLevel.cost, self._costIcon)

				if proxy then
					proxy.binder:setNum(0)
				end

				local matType, id, matNum = MaterialMgr.getMatParams(cfgBuffItemLevel.cost)
				local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, id)

				if curLevel == maxLevel then
					goutil.setActive(self._costGo, false)
					goutil.setActive(self._maxLvGo, true)
				else
					goutil.setActive(self._costGo, true)
					goutil.setActive(self._maxLvGo, false)

					local cfgBuffItemLevel2 = WaterTianYanConfig.instance:getBuffItemLevelCfg(self._activityId, cfgBuffItem.buffItemId, curLevel + 1)

					if cfgBuffItemLevel2 then
						local matType2, id2, matNum2 = MaterialMgr.getMatParams(cfgBuffItemLevel2.cost)
						local isEnough = matNum2 <= curMatNum

						if isEnough then
							if not ColorConst.Green then
								self._txtNum.text = string.format("<color=#%s>%d</color>/%d", ColorConst, curMatNum, matNum2)
							end
						end
					end
				end
			end
		end
	end
end

function WaterTianYanBuffView:_resetBuffInfo()
	self._isShowBuffTip = false
	self._curCfgBuffItem = nil

	goutil.setActive(self._upgrade, false)
	uGuiUtil.clearImage(self._icon)
	MaterialMgr.resetAll(self._costIcon)
end

function WaterTianYanBuffView:_onClickCost()
	if self._curCfgBuffItem then
		local buffItemLevelList = WaterTianYanConfig.instance:getBuffItemLevelCfgList(self._activityId, self._curCfgBuffItem.buffItemId)

		if buffItemLevelList then
			if not #buffItemLevelList then
				local maxLevel = 1
				local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, self._curCfgBuffItem.buffItemId)
				local isUnlock = level > 0
				local curLevel = isUnlock and level or 0

				if curLevel == maxLevel then
					FloatWordMgr.instance:show("已满级")
				else
					local cfgBuffItemLevel = WaterTianYanConfig.instance:getBuffItemLevelCfg(self._activityId, self._curCfgBuffItem.buffItemId, curLevel + 1)

					if cfgBuffItemLevel then
						local matType, id, matNum = MaterialMgr.getMatParams(cfgBuffItemLevel.cost)
						local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, id)
						local isEnough = matNum <= curMatNum

						if isEnough then
							WaterTianYanAgent.instance:sendPM_WaterTianYanUpgradeBuffReq(self._activityId, self._curCfgBuffItem.buffItemId)
						else
							FloatWordMgr.instance:show("道具数量不足")
						end
					end
				end
			end
		end
	end
end

function WaterTianYanBuffView:_onUpgradeBuffRes()
	if self._curCfgBuffItem then
		local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, self._curCfgBuffItem.buffItemId)
		local viewType

		if level == 1 then
			viewType = WaterTianYanModel.TipUnlock

			GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanSetBuff, self._curCfgBuffItem.buffItemId)
		else
			viewType = WaterTianYanModel.TipLevelup
		end

		UIStateManager.instance:push(self:_getTipView(), viewType, self._activityId, self._curCfgBuffItem.buffItemId, level)
		self:_updateBuffs()
		self:_updateBuffInfo(self._curCfgBuffItem)
	end
end

function WaterTianYanBuffView:_getTipView()
	return WaterTianYanEnum.ViewNames[self._activityId][WaterTianYanEnum.ViewTypes_TipView]
end

return WaterTianYanBuffView
