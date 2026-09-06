-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPreheatHudView.lua

module("logic.extensions.yearcard.view.YearCardPreheatHudView", package.seeall)

local YearCardPreheatHudView = class("YearCardPreheatHudView", ViewComponent)

function YearCardPreheatHudView:buildUI()
	YearCardPreheatHudView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goEnterList = self:getGo("enterList")
	self._enterList = {}

	for i = 1, 4 do
		local enterPath = "enterCell" .. i
		local enterCell = {}

		enterCell.go = goutil.findChild(self._goEnterList, enterPath)
		enterCell.tag = goutil.findChild(enterCell.go, "tag")
		enterCell.btn = GameUtil.asBtn(enterCell.go)
		enterCell.txt = goutil.findChildTextComponent(enterCell.go, "Text")
		enterCell.redPoint = goutil.findChild(enterCell.go, "redpoint")
		enterCell.matCellList = {}
		enterCell.goCellList = goutil.findChild(enterCell.go, "cellList")

		goutil.setActive(enterCell.redPoint, false)

		for k = 1, 3 do
			enterCell.matCellList[k] = goutil.findChild(enterCell.goCellList, "cell" .. k)
		end

		enterCell.cfg = nil
		self._enterList[enterPath] = enterCell
	end
end

function YearCardPreheatHudView:bindEvents()
	YearCardPreheatHudView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for k, v in pairs(self._enterList) do
		v.btn:AddClickListener(function()
			self:onClickJumpTo(k)
		end, self)
	end
end

function YearCardPreheatHudView:onClickJumpTo(cellKey)
	local onClickCell = self._enterList[cellKey]

	if onClickCell and onClickCell.cfg then
		SurveyController.instance:reportBehavior(onClickCell.cfg.reportBehavior)

		if string.nilorempty(onClickCell.cfg.params) then
			UIStateManager.instance:push(onClickCell.cfg.enterView)
		else
			GotoMgr.gotoByString(string.format("ui#%s#%s", onClickCell.cfg.enterView, onClickCell.cfg.params))
		end
	end
end

function YearCardPreheatHudView:unbindEvents()
	YearCardPreheatHudView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for k, v in pairs(self._enterList) do
		v.btn:RemoveClickListener()
	end
end

function YearCardPreheatHudView:onEnter()
	YearCardPreheatHudView.super.onEnter(self)

	for k, v in pairs(self._enterList) do
		v.cfg = nil

		goutil.setActive(v.go, false)
		RedPointController.instance:unregRedPoint(v.redPoint)

		for i = 1, 3 do
			MaterialMgr.resetAll(v.matCellList[i])
		end
	end

	self._preheatId = self:getFirstParam()
	self._preHeatCfgs = YearCardConfig.instance:getpreheatviewCfgById(self._preheatId)

	if self._preHeatCfgs then
		for k, cfg in ipairs(self._preHeatCfgs) do
			local enterCell = self._enterList[cfg.enterPath]

			if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) and enterCell then
				enterCell.cfg = cfg
				enterCell.txt.text = cfg.showTip == 0 and "" or lang(cfg.showTip)

				goutil.setActive(enterCell.tag, cfg.isShowTag)
				goutil.setActive(enterCell.go, true)

				if checkint(cfg.redpointId) > 0 then
					RedPointController.instance:regRedPoint(enterCell.redPoint, cfg.redpointId)
				end

				if string.nilorempty(cfg.showReward) then
					goutil.setActive(enterCell.goCellList, false)
				else
					goutil.setActive(enterCell.goCellList, true)

					local prizeStrs = string.split(cfg.showReward or "", "#")

					for i = 1, 3 do
						goutil.setActive(enterCell.matCellList[i], prizeStrs[i])
						MaterialMgr.setCellByCfg(prizeStrs[i], enterCell.matCellList[i])
					end
				end
			end
		end
	else
		self:close()
	end

	self:_createEff("20211217/nianfei/yuzhiwu/kapairenwu/fx_kapai_jin.prefab", self._enterList.enterCell1.go, "eff1")
	self:_createEff("20211217/nianfei/yuzhiwu/kapairenwu/fx_kapai_jin2.prefab", self._enterList.enterCell2.go, "eff2")
	self:_createEff("20211217/nianfei/yuzhiwu/kapairenwu/fx_kapai_zi.prefab", self._enterList.enterCell3.go, "eff3")
	self:_createEff("20211217/nianfei/yuzhiwu/kapairenwu/fx_kapai_long.prefab", self._enterList.enterCell4.go, "eff4")
end

function YearCardPreheatHudView:onExit()
	YearCardPreheatHudView.super.onExit(self)

	for k, v in pairs(self._enterList) do
		for i = 1, 3 do
			RedPointController.instance:unregRedPoint(v.redPoint)
			MaterialMgr.resetAll(v.matCellList[i])
		end
	end

	self:_removeAllEffect()
end

function YearCardPreheatHudView:_createEff(effPath, effParent, effKey)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
	end)
end

function YearCardPreheatHudView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

return YearCardPreheatHudView
