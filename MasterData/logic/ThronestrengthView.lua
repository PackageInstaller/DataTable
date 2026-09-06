-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronestrengthView.lua

module("logic.extensions.throne.view.ThronestrengthView", package.seeall)

local ThronestrengthView = class("ThronestrengthView", ViewComponent)

function ThronestrengthView:ctor()
	ThronestrengthView.super.ctor(self)
end

function ThronestrengthView:buildUI()
	ThronestrengthView.super.buildUI(self)

	self._strengthBtnDot = self:getGo("strengthBtn/dot")
	self._strengthBtn = self:getBtn("strengthBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._sourceBtn = self:getBtn("sourceBtn")
	self._stagebg = self:getGo("stagebg")
	self._descText = goutil.findChildTextComponent(self.mainGO, "descText")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "nameText")
	self._strengthBtntext = goutil.findChildTextComponent(self.mainGO, "strengthBtn/text")
	self._costDescTest = goutil.findChildTextComponent(self.mainGO, "costDescTest")
	self._itemCon = self:getGo("itemCon")
	self._costItemCon = self:getGo("costItemCon")
	self._costItemCell = self:getGo("costItemCon/cell")
	self._costItemGroup = ItemGroup.New(self._costItemCon, self._costItemCell, nil, nil, true)
	self._attrItemCon = self:getGo("attrCon")
	self._attrItemCell = self:getGo("attrCon/attrCell")
	self._attrItemGroup = ItemGroup.New(self._attrItemCon, self._attrItemCell, nil, nil, true)
	self._helpBtn = self:getBtn("helpBtn")
	self._stageText = goutil.findChildTextComponent(self.mainGO, "stageText")
	self._starList = {}

	local starRoot = self:getGo("starBg/con")

	for i = 1, 5 do
		self._starList[i] = {
			mainGO = goutil.findChild(starRoot, "start" .. i),
			lightGO = goutil.findChild(starRoot, "start" .. i .. "/start")
		}
	end
end

function ThronestrengthView:bindEvents()
	ThronestrengthView.super.bindEvents(self)
	self._strengthBtn:AddClickListener(self._onClickstrengthBtn, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._sourceBtn:AddClickListener(self._onClicksourceBtn, self)
	self._helpBtn:AddClickListener(self._onClickhelpBtn, self)
end

function ThronestrengthView:unbindEvents()
	ThronestrengthView.super.unbindEvents(self)
	self._strengthBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
	self._helpBtn:RemoveClickListener()
end

function ThronestrengthView:destroyUI()
	ThronestrengthView.super.destroyUI(self)
end

function ThronestrengthView:onEnter()
	ThronestrengthView.super.onEnter(self)
	GlobalDispatcher:addListener(ThroneController.PM_UpgradeThroneRes, self._updateView, self)
	GlobalDispatcher:addListener(ThroneController.UpdateRedDot, self._checkRedDot, self)

	self._throneId = self:getFirstParam()

	self:_updateView()
end

function ThronestrengthView:onEnterFinished()
	ThronestrengthView.super.onEnterFinished(self)
end

function ThronestrengthView:onExit()
	ThronestrengthView.super.onExit(self)
	GlobalDispatcher:removeListener(ThroneController.PM_UpgradeThroneRes, self._updateView, self)
	GlobalDispatcher:removeListener(ThroneController.UpdateRedDot, self._checkRedDot, self)
	self._costItemGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
	MaterialMgr.resetAll(self._itemCon)
end

function ThronestrengthView:onExitFinished()
	ThronestrengthView.super.onExitFinished(self)
end

function ThronestrengthView:_onClickstrengthBtn()
	if ThroneModel.instance:checkThronCanUpgradeRedDot(self._throneId) then
		ThroneAgent.instance:sendPM_UpgradeThroneReq(self._throneId)
	else
		FloatWordMgr.instance:show("所需材料不足")
	end
end

function ThronestrengthView:_onClickcloseBtn()
	ThroneModel.instance:setFactoryInitthroneId(0)
	self:close()
end

function ThronestrengthView:_onClicksourceBtn()
	if self._throneId then
		local data = {
			type = MatType.Throne,
			id = self._throneId
		}

		MaterialMgr.openGetSourceByData(data)
		ThroneModel.instance:setFactoryInitthroneId(self._throneId)
	end
end

function ThronestrengthView:_onClickhelpBtn()
	TipsFacade.instance:openRulesView("thronestrength")
end

function ThronestrengthView:_updateView()
	local cfg = ThroneConfig.instance:getThroneCfg(self._throneId)
	local data = ThroneModel.instance:getThroneData(self._throneId)
	local lvCfgs = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)
	local currLvCfg = lvCfgs[data.lv]
	local nextLvCfg = lvCfgs[data.lv + 1]

	self._nameText.text = cfg.name
	self._descText.text = cfg.desc

	self:_setAttr(currLvCfg, nextLvCfg)
	self:_setCost(nextLvCfg)
	self:_setBtnTextState(data.lv, lvCfgs, nextLvCfg)
	self:_setShowItem(cfg)
	self:_setStar()
	self:_checkRedDot()
end

function ThronestrengthView:_setAttr(currLvCfg, nextLvCfg)
	local currMainProps = {}
	local nextMainProps = {}
	local currSubProps = {}
	local nextSubProps = {}
	local tempList1 = string.split(currLvCfg.mainProps, "#")

	for i, v in ipairs(tempList1) do
		local tempList2 = string.split(v, "+")

		currMainProps[tempList2[1]] = checknumber(tempList2[2])
	end

	if not string.nilorempty(currLvCfg.subProps) then
		local tempList3 = string.split(currLvCfg.subProps, "#")

		for i, v in ipairs(tempList3) do
			local tempList4 = string.split(v, "+")

			currSubProps[tempList4[1]] = checknumber(tempList4[2])
		end
	end

	if nextLvCfg then
		local tempList1 = string.split(nextLvCfg.mainProps, "#")

		for i, v in ipairs(tempList1) do
			local tempList2 = string.split(v, "+")

			nextMainProps[tempList2[1]] = checknumber(tempList2[2])
		end

		if not string.nilorempty(currLvCfg.subProps) and not string.nilorempty(nextLvCfg.subProps) then
			local tempList3 = string.split(nextLvCfg.subProps, "#")

			for i, v in ipairs(tempList3) do
				local tempList4 = string.split(v, "+")

				nextSubProps[tempList4[1]] = checknumber(tempList4[2])
			end
		end

		for k, v in pairs(nextMainProps) do
			currMainProps[k] = currMainProps[k] or 0
		end

		for k, v in pairs(nextSubProps) do
			currSubProps[k] = currSubProps[k] or 0
		end
	end

	local list = {}

	for k, v in pairs(currMainProps) do
		table.insert(list, {
			name = k,
			preNum = v,
			lastNum = nextMainProps[k]
		})
	end

	for k, v in pairs(currSubProps) do
		table.insert(list, {
			name = k,
			preNum = v,
			lastNum = nextSubProps[k]
		})
	end

	self._attrItemGroup:updateWithMoArray(list, function(item, data)
		local preText = goutil.findChildTextComponent(item.mainGO, "preText")
		local lastText = goutil.findChildTextComponent(item.mainGO, "lastText")
		local arrow = goutil.findChild(item.mainGO, "image")

		goutil.setActive(arrow, data.lastNum)

		lastText.text = data.lastNum and string.format("+%s", data.lastNum) or ""
		preText.text = string.format("%s+%s", data.name, data.preNum)

		self:_handleLastNum(preText, data.lastNum)
	end)
end

function ThronestrengthView:_handleLastNum(preText, lastNum)
	if not lastNum then
		preText.alignment = UnityEngine.TextAnchor.MiddleCenter
		preText.transform.pivot = Vector2.New(0.5, 0.5)

		Framework.TransformUtil.SetAnchoredPos(preText.transform, 226, -16)
	else
		preText.alignment = UnityEngine.TextAnchor.MiddleRight
		preText.transform.pivot = Vector2.New(0, 1)

		Framework.TransformUtil.SetAnchoredPos(preText.transform, 0, 0)
	end
end

function ThronestrengthView:_setCost(uplvCfg)
	goutil.setActive(self._costItemCon, uplvCfg)

	if not uplvCfg then
		self._costDescTest.text = ""

		return
	end

	self._costDescTest.text = "消耗："

	local list = {}

	if uplvCfg.costNum > 0 then
		local hasNum = ThroneModel.instance:getThroneBagNum(self._throneId)

		if hasNum > 0 then
			hasNum = hasNum - 1
		end

		table.insert(list, {
			matStr = string.format("%s:%s", MatType.Throne, self._throneId),
			costNum = uplvCfg.costNum,
			hasNum = hasNum
		})
	end

	local matList = string.split(uplvCfg.costMp, "#")

	for i, v in ipairs(matList) do
		local list2 = string.split(v, ":")
		local hasNum = MaterialMgr.getMatCount(v)

		table.insert(list, {
			matStr = v,
			costNum = checknumber(list2[3]),
			hasNum = hasNum
		})
	end

	self._costItemGroup:updateWithMoArray(list, function(item, data)
		local proxy = MaterialMgr.setCellByCfg(data.matStr, item.mainGO)
		local hasNum = ThroneModel.instance:getThroneBagNum(self._throneId)

		if hasNum > 0 then
			hasNum = hasNum - 1
		end

		local str = string.format("<color=%s>%s</color>/%s", data.hasNum < data.costNum and "red" or data.hasNum > data.costNum and "#4eae1a", data.hasNum, data.costNum)

		proxy.binder:setNumStr(str)
	end)
end

function ThronestrengthView:_setBtnTextState(lv, lvCfgs)
	local nextLvCfg = lvCfgs[lv + 1]
	local currLvCfg = lvCfgs[lv]
	local preLvCfg = lvCfgs[lv - 1]

	if not nextLvCfg then
		goutil.setActive(self._strengthBtn.gameObject, false)

		return
	end

	goutil.setActive(self._strengthBtn.gameObject, true)

	if not preLvCfg then
		self._strengthBtntext.text = "强化"

		return
	end

	if not string.nilorempty(nextLvCfg.subProps) and string.nilorempty(currLvCfg.subProps) then
		self._strengthBtntext.text = "突破"

		return
	end

	if not string.nilorempty(nextLvCfg.subProps) and not string.nilorempty(currLvCfg.subProps) then
		self._strengthBtntext.text = "升阶"

		return
	end
end

function ThronestrengthView:_setShowItem(cfg)
	local cfgStr = string.format("%s:%s", MatType.Throne, self._throneId)

	MaterialMgr.setCellByCfg(cfgStr, self._itemCon)
end

function ThronestrengthView:_setStar()
	for i, v in ipairs(self._starList) do
		goutil.setActive(v.lightGO, false)
		goutil.setActive(v.mainGO, false)
	end

	local cfg = ThroneConfig.instance:getThroneCfg(self._throneId)
	local lvStrategyCfg = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)
	local starNum = 0

	for i, v in ipairs(lvStrategyCfg) do
		if not string.nilorempty(v.subProps) then
			break
		end

		starNum = i
	end

	local data = ThroneModel.instance:getThroneData(self._throneId)

	for i, v in ipairs(self._starList) do
		if starNum < i then
			break
		end

		goutil.setActive(v.mainGO, true)
		goutil.setActive(v.lightGO, i <= data.lv)
	end

	goutil.setActive(self._stagebg, starNum < data.lv)

	self._stageText.text = starNum < data.lv and string.format("%s阶", data.lv - starNum) or ""
end

function ThronestrengthView:_checkRedDot()
	goutil.setActive(self._strengthBtnDot, ThroneModel.instance:checkThronCanUpgradeRedDot(self._throneId))
end

return ThronestrengthView
