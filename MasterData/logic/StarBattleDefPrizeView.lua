-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefPrizeView.lua

module("logic.extensions.starbattle.view.StarBattleDefPrizeView", package.seeall)

local StarBattleDefPrizeView = class("StarBattleDefPrizeView", ViewComponent)

function StarBattleDefPrizeView:ctor()
	StarBattleDefPrizeView.super.ctor(self)
end

function StarBattleDefPrizeView:unbindEvents()
	StarBattleDefPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StarBattleDefPrizeView:bindEvents()
	StarBattleDefPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StarBattleDefPrizeView:buildUI()
	StarBattleDefPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtRacePrize1 = self:getTxt("subTitle/txtRacePrize1")
	self._txtRacePrize2 = self:getTxt("subTitle/txtRacePrize2")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._tablelist = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function StarBattleDefPrizeView:onExit()
	StarBattleDefPrizeView.super.onExit(self)
	self._tablelist:dispose()
end

local SubItemCount = 6

function StarBattleDefPrizeView:onEnter()
	StarBattleDefPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGainDefensePrize, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGainDefenseRacePrize, self._updateUIByInfo, self)

	self._activityId = 510001
	self._periodId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)

		if params[2] then
			self._isNewHand = checkbool(params[2])
		end
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function StarBattleDefPrizeView:_updateUIByCfg()
	self._curActCfg = StarBattleConfig.instance:getActCfg(self._activityId)
	self._periodCfg = StarBattleConfig.instance:getPeriodCfg(self._activityId, self._periodId)
	self._prizeCfgs = {}
	self._prizeCfgs = self._isNewHand and StarBattleConfig.instance:getDefensePrizeCfgs(self._periodCfg.newDefensePlanId) or StarBattleConfig.instance:getDefensePrizeCfgs(self._periodCfg.oldDefensePlanId)
	self._addRaces = {}

	if self._prizeCfgs then
		if self._prizeCfgs then
			self._addRaces = StarBattleConfig.instance:getDefenseRaces(self._prizeCfgs.defenseRacePlanId)
		end

		self._showItem = self._curActCfg.showItem or ""
		self._txtRacePrize1.text = self._addRaces[1] and string.format("上阵%s", MaterialMgr.getMaterialsName(MatType.Pet, self._addRaces[1])) or ""
		self._txtRacePrize2.text = self._addRaces[2] and string.format("上阵%s", MaterialMgr.getMaterialsName(MatType.Pet, self._addRaces[2])) or ""
	end
end

function StarBattleDefPrizeView:_updateUIByInfo()
	self._gainPrizeIdMap = {}
	self._curDefenseZdl = 0
	self._racePrizeInfoMap = self._racePrizeInfoMap or {}

	table.clear(self._racePrizeInfoMap)

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._curDefenseZdl = info.maxDefenseZdl or 0

		if not info.defenseRaceInfos then
			local defenseRaceInfos = {}

			for _, v in ipairs(defenseRaceInfos) do
				for i, raceId in ipairs(self._addRaces) do
					if v.raceId == raceId then
						self._racePrizeInfoMap[raceId] = v
					end
				end
			end

			if not info.hasGainDefencePrizeIds then
				for _, v in ipairs(info.hasGainDefencePrizeIds) do
					self._gainPrizeIdMap[v] = true
				end
			end
		end
	end

	self._tablelist:reloadData(self._prizeCfgs)
end

function StarBattleDefPrizeView:_updateCell(view, cell, data)
	local txtRange = goutil.findChildTextComponent(cell, "txtRange")

	txtRange.text = self:_formatNum(data.range)

	local item_1 = goutil.findChild(cell, "item_1")
	local item_2 = goutil.findChild(cell, "item_2")
	local item_3 = goutil.findChild(cell, "item_3")
	local item_4 = goutil.findChild(cell, "item_4")
	local item_5 = goutil.findChild(cell, "item_5")
	local item_6 = goutil.findChild(cell, "item_6")

	self:_updateItem(item_1, data, true, 0)
	self:_updateItem(item_2, data, false, 0)
	self:_updateItem(item_3, data, true, self._addRaces[1])
	self:_updateItem(item_4, data, false, self._addRaces[1])
	self:_updateItem(item_5, data, true, self._addRaces[2])
	self:_updateItem(item_6, data, false, self._addRaces[2])
end

function StarBattleDefPrizeView:_updateItem(item, data, isSocre, raceId)
	local icon = goutil.findChild(item, "icon")
	local effect = goutil.findChild(item, "effect")
	local geted = goutil.findChild(item, "geted")
	local btnGet = goutil.findChild(item, "btnGet")

	if not data.prizeId then
		local prizeId = 0
		local matStr = ""
		local isGain = false
		local isMatchGain = false

		if not data.range then
			local range = 0

			if not raceId then
				goutil.setActive(icon, false)
				goutil.setActive(geted, false)
				goutil.setActive(btnGet, false)

				return
			end

			if raceId <= 0 then
				matStr = isSocre and (GameUtil.isEmptyString(self._showItem) or self._showItem .. ":" .. data.score) or data.prize
				isGain = self._gainPrizeIdMap[prizeId]
				isMatchGain = not self._gainPrizeIdMap[prizeId] and range <= self._curDefenseZdl
			else
				local cfg = StarBattleConfig.instance:getDefenseRacePrizeCfg(data.defenseRacePlanId, raceId)

				if cfg then
					matStr = isSocre and self._showItem .. ":" .. cfg.score or cfg.prize
				end

				local info = self._racePrizeInfoMap[raceId]

				if info then
					if not info.maxZdl then
						if not info.hasGainDefenceRacePrizeIds then
							local hasGainDefenceRacePrizeIds = {}

							for i, v in ipairs(hasGainDefenceRacePrizeIds) do
								if v == prizeId then
									isGain = true

									break
								end
							end

							isMatchGain = not isGain and range <= info.maxZdl
						end
					end
				end
			end

			goutil.setActive(geted, isGain)

			if GameUtil.isEmptyString(matStr) then
				goutil.setActive(icon, false)
				goutil.setActive(geted, false)
				goutil.setActive(btnGet, false)
			else
				MaterialMgr.setCellByCfg(matStr, icon)
			end

			goutil.setActive(btnGet, isMatchGain)

			if isMatchGain then
				self:_playCellEffect(effect)
				GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, prizeId, raceId))
			else
				self:_clearCellEffect(effect)
				GameUtil.rmClickHandler(btnGet)
			end
		end
	end
end

function StarBattleDefPrizeView:_onClickGainPrize(prizeId, raceId)
	if raceId > 0 then
		StarBattleController.instance:oneClickGainDefensePrize(self._activityId, self._periodId, 2, raceId)
	else
		StarBattleController.instance:oneClickGainDefensePrize(self._activityId, self._periodId, 1)
	end
end

function StarBattleDefPrizeView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function StarBattleDefPrizeView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function StarBattleDefPrizeView:_clearCell(cell)
	for i = 1, SubItemCount do
		local item = goutil.findChild(cell, "item_" .. i)
		local icon = goutil.findChild(item, "icon")
		local effect = goutil.findChild(item, "effect")
		local btnGet = goutil.findChild(item, "btnGet")
		local geted = goutil.findChild(item, "geted")

		goutil.setActive(geted, false)
		GameUtil.rmClickHandler(btnGet)
		self:_clearCellEffect(effect)
		MaterialMgr.instance:resetAll(icon)
	end
end

function StarBattleDefPrizeView:_formatNum(num)
	local num = checknumber(num)

	num = Mathf.Max(num, 0)

	if num >= 100000000 then
		if num % 100000000 == 0 then
			return string.format("%.0f亿", num / 100000000)
		end

		return string.format("%.2f亿", num / 100000000)
	elseif num >= 10000 then
		if num % 10000 == 0 then
			return string.format("%.0f万", num / 10000)
		end

		return string.format("%.2f万", num / 10000)
	else
		return tostring(num)
	end
end

return StarBattleDefPrizeView
