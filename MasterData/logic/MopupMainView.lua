-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/view/MopupMainView.lua

module("logic.extensions.mopup.view.MopupMainView", package.seeall)

local MopupMainView = class("MopupMainView", TableViewComponent)

MopupMainView.ClickType = {
	Time = 1,
	Auto = 2
}

function MopupMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "ScrollView"
	}
end

function MopupMainView:ctor()
	MopupMainView.super.ctor(self)

	self.condition = ""
	self.oneMopupCost = 10
	self.maxMopupTime = 5
	self.rewadList = nil
	self.autoData = nil
	self.leftTime = false
	self._curViewDatas = {}
end

function MopupMainView:bindEvents()
	self.btnOne:AddClickListener(self.onClickOne, self)
	self.btnMul:AddClickListener(self.onClickMul, self)
	self.btnAuto:AddClickListener(self.onClickAutoBtn, self)
	self.btnClose:AddClickListener(self.onClickClose, self)
	self.btnPower:AddClickListener(self.onClickAddPower, self)
	self.addResPlotTimeBtn:AddClickListener(self.onClickAddResPlotTime, self)
	self._item2BtnAdd:AddClickListener(self._onClickAddItem2, self)
end

function MopupMainView:unbindEvents()
	self.btnOne:RemoveClickListener()
	self.btnMul:RemoveClickListener()
	self.btnAuto:RemoveClickListener()
	self.btnClose:RemoveClickListener()
	self.btnPower:RemoveClickListener()
	self.addResPlotTimeBtn:RemoveClickListener()
	self._item2BtnAdd:RemoveClickListener()
end

function MopupMainView:buildUI()
	MopupMainView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
	self.txtCondition1 = goutil.findChildTextComponent(self.mainGO, "txtRemainCount")
	self.txtCondition2 = goutil.findChildTextComponent(self.mainGO, "txtLegendCount")
	self.btnOne = self:getBtn("btnOneSweep")
	self.btnMul = self:getBtn("btnMulSweep")
	self.btnAuto = self:getBtn("btnAutoSweep")
	self.addResPlotTimeBtn = self:getBtn("addResPlotTimeBtn")
	self.scrollViewTr = self:getGo("ScrollView").transform
	self.txtBtnOneCost = goutil.findChildTextComponent(self.mainGO, "costOneSweepPower")
	self.txtBtnMulCost = goutil.findChildTextComponent(self.mainGO, "costMulSweepPower")
	self.txtBtnMul = goutil.findChildTextComponent(self.mainGO, "btnMulSweep/Text")
	self.txtBtnOne = goutil.findChildTextComponent(self.mainGO, "btnOneSweep/Text")
	self.raycastGo = self:getGo("raycastGo")
	self.goCube = self:getGo("bg/cube")
	self.goSweepOver = self:getGo("sweepOver")
	self.gocostOneSweepPower = self:getGo("costOneSweepPower")
	self.gocostMulSweepPower = self:getGo("costMulSweepPower")
	self.goGet = self:getGo("Get")
	self.autoItemCon = self:getGo("Get/cell")
	self.txtGetTip = goutil.findChildTextComponent(self.goGet, "txtGetTip")
	self.goPower = self:getGo("power")
	self.txtPower = goutil.findChildTextComponent(self.goPower, "txtPower")
	self.btnPower = self:getBtn("power/brnAdd")
	self.enterShowGo = self:getGo("enterShowGo")
	self._icon1Item1 = self:getGo("power/iconPower")
	self._icon2Item1 = self:getGo("costOneSweepPower/icon")
	self._icon3Item1 = self:getGo("costMulSweepPower/icon")
	self._item2Go = self:getGo("item2")
	self._item2Icon = self:getGo("item2/icon")
	self._item2BtnAdd = self:getBtn("item2/btnAdd")
	self._item2TxtNum = self:getGo("item2/txtNum"):GetComponent(goutil.Type_UIText)
	self._oneKeySweepGetGo = self:getGo("oneKeySweepGet")

	local itemTableview = self:getGo("oneKeySweepGet/tableview")
	local itemCell = self:getGo("oneKeySweepGet/itemcell")

	self._oneKeySweepTableView = ScrollerList.create(itemTableview, itemCell, GameUtil.handler(self._updateOneKeyCell, self), GameUtil.handler(self._clearOneCell, self))

	self._oneKeySweepTableView:setCenterMode(true)
	self:SetActive(self.goGet, false)
	self:SetActive(self.goSweepOver, false)

	self._togItemCost = self:getToggle("togItemCost")
	self._txtToggle = self:getTxt("togItemCost/Label")
	self._imgToggle = self:getGo("togItemCost/Label/icon")
	self._txtResplotDoubleLeftTime = goutil.findChildTextComponent(self.mainGO, "resPlotDouble/txtResplotDoubleLeftTime")
	self._txtResplotDouleTip = goutil.findChildTextComponent(self.mainGO, "resPlotDouble/txtResplotDouleTip")
	self._txtResplotDouleTip.text = "掉落翻倍"
	self._resPlotDoubleGo = self:getGo("resPlotDouble")
	self._resGDPlotDoubleGo = self:getGo("resGDPlotDouble")
	self._txtresGDplotDoubleLeftTime = goutil.findChildTextComponent(self._resGDPlotDoubleGo, "txtResplotDoubleLeftTime")
end

function MopupMainView:destroyUI()
	return
end

function MopupMainView:onEnter()
	MopupMainView.super.onEnter(self)

	self._isCanDoCallback = true

	self:_initOneKeyVariable()
	self:addGlobalListener()

	local param = self:getOpenParam()

	self.clickStarCallBack = param[1]
	self.getChallengeCallBack = param[2]
	self.getOneCostCallBack = param[3]
	self.getConditionCallBack = param[4]
	self.getRewardCallBack = param[5]
	self.getAutoDataCallBack = param[6]
	self.getChallengeLeftTimeCallBack = param[7]
	self.openPlayRewardList = param[8]
	self._resPlotId = param[9]
	self._secondItemParam = param[10]
	self._firstItemParam = param[11]
	self._curViewDatas = {}

	self:reloadData()
	self:refreshView()

	local pos = self.autoData and Vector2.New(0, 64) or Vector2.New(0, 42)
	local scale = self.autoData and 0.9 or 1

	GameUtil.setLocalScale(self.enterShowGo, scale)
	GameUtil.setLocalPos(self.enterShowGo, pos.x, pos.y)
	self:SetActive(self.enterShowGo, not self.openPlayRewardList)
	self:_initItem1()
	self:_initItem2()
	self:_initSweepTicketCost()
	self:_checkShowResplot()
	self:_sendUpdateDouble()
	self:_checkShowGDResplot()
end

function MopupMainView:addGlobalListener()
	GlobalDispatcher:addListener(GlobalNotify.RefreshSweepView, self.updatePower, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self.updatePower, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataEnergyCount, self.updatePower, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_BuyChallengeTimesRes, self.updataCondition, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateItem2, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeTimesInfoRes, self.updatePower, self)
	GlobalDispatcher:addListener(GlobalNotify.CopySweepAutoResError, self._initOneKeyVariable, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._setGoldenDiamondCardDoubleTime, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_NotifyBaseMultiplyTimesChangeRes, self._checkShowResplot, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._checkShowResplot, self)
	GlobalDispatcher:addListener(GlobalNotify.GetRewardMultiplyTimesReq, self._checkShowResplot, self)
end

function MopupMainView:removeGlobalListener()
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self.updatePower, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshSweepView, self.updatePower, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataEnergyCount, self.updatePower, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_BuyChallengeTimesRes, self.updataCondition, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateItem2, self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeTimesInfoRes, self.updatePower, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopySweepAutoResError, self._initOneKeyVariable, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self._setGoldenDiamondCardDoubleTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_NotifyBaseMultiplyTimesChangeRes, self._checkShowResplot, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._checkShowResplot, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetRewardMultiplyTimesReq, self._checkShowResplot, self)
end

function MopupMainView:onEnterFinished()
	if self.openPlayRewardList then
		self:playGoodsGet(self.openPlayRewardList)

		self.openPlayRewardList = nil
	end
end

function MopupMainView:onExit()
	MopupMainView.super.onExit(self)

	self._isCanDoCallback = false

	self:removeGlobalListener()
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._showPlotDoubleTime, self)
	coroutine.stop(self.co)
	removetimer(self.hideRaycast, self)
	self:hideRaycast()

	self.rewadList = nil
	self.rewadAddList = nil

	self:_resetItem1()
	self:_resetItem2()
	self:_resetOneKey()
	self:_resetSweepTicketCost()
	MopupModel.instance:setSweepType(GameEnum.SweepType.Default)
	MopupModel.instance:setSweepSetting(self:_isUseSweepTicket())
end

function MopupMainView:_cellSize(view, idx)
	local list = self._curViewDatas[idx + 1].list
	local line = math.ceil(#list / 4)

	return 630, 112 * line + 45
end

function MopupMainView:_updateCell(view, cell, data)
	local component = MopupItem.AddOnce(cell)

	component:setData(data, cell.data)
end

function MopupMainView:_clearTableview(cell)
	local component = MopupItem.AddOnce(cell)

	component:onExit()
end

function MopupMainView:onClickOne()
	if self:_isOneKeyType() then
		if not self._isStartAuto then
			self:onClickMopup(false)
		end
	else
		self:onClickMopup(false)
	end
end

function MopupMainView:onClickMul()
	self:onClickMopup(true)
end

function MopupMainView:_sendUpdateDouble()
	if self._resPlotId == 0 then
		PlotCopyController.instance:sendPCLG_GetRewardMultiplyTimesReq()
	elseif self._resPlotId and self._resPlotId > 0 then
		MaterialChallengeController.instance:sendMCLG_GetRewardMultiplyTimesReq()
	end
end

function MopupMainView:onClickAutoBtn()
	if self:_isOneKeyType() then
		if not self._isStartAuto then
			self._isStartAuto = true

			self:onClickAuto()
		end
	else
		self:onClickAuto()
	end
end

function MopupMainView:onClickAuto()
	if self:_isExistTogItemCost() and self:_isUseSweepTicket() then
		-- block empty
	else
		local has_num = self:_getFirstItemNum()

		if has_num < self.oneMopupCost then
			self:_notEnoughFirstItem()

			self._isStartAuto = false

			return
		end
	end

	if self.clickStarCallBack then
		local function func(list)
			GlobalDispatcher:dispatch(GlobalNotify.SweepUpdate)

			if not self._isCanDoCallback then
				return
			end

			self:playGoodsGet(list)
		end

		local param = {
			func = func
		}
		local arr = self:_isOneKeyType() and string.split(self.autoData.curRewardStr, ":") or string.split(self.autoData, ":")
		local matType = arr[1]
		local matId = arr[2]
		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)
		local baseNum = checknumber(arr[#arr])

		param.matType = checknumber(matType)
		param.matId = checknumber(matId)
		param.targetNum = baseNum - has_num

		if self:_isExistTogItemCost() then
			param.useTicket = self:_isUseSweepTicket()
		end

		self.clickStarCallBack(MopupMainView.ClickType.Auto, param)
	else
		self._isStartAuto = false
	end
end

function MopupMainView:onClickMopup(isMul)
	if self:_isExistTogItemCost() and self:_isUseSweepTicket() then
		-- block empty
	else
		local has_num = self:_getFirstItemNum()

		if isMul then
			if has_num < (self.oneMopupCost * self.maxMopupTime or self.oneMopupCost) then
				self:_notEnoughFirstItem()

				return
			end
		end
	end

	if isMul then
		if not self.maxMopupTime then
			local time = 1

			local function func(list)
				self:_sendUpdateDouble()
				GlobalDispatcher:dispatch(GlobalNotify.SweepUpdate)

				if not self._isCanDoCallback then
					return
				end

				self:playGoodsGet(list)
			end

			if self.clickStarCallBack then
				local param = {
					times = time,
					func = func
				}

				if self:_isExistTogItemCost() then
					param.useTicket = self:_isUseSweepTicket()
					param.isTicketEnough = self:_isMulTimeEnough(time)
				end

				self.clickStarCallBack(MopupMainView.ClickType.Time, param)
			end
		end
	end
end

function MopupMainView:onClickClose()
	self:close()
end

function MopupMainView:onClickAddPower()
	if self._firstItemParam == nil then
		FuncOpenController.instance:openFunc(57)
	elseif self._firstItemParam.addCallBack then
		self._firstItemParam.addCallBack()
	end
end

function MopupMainView:onClickAddResPlotTime()
	MaterialChallengeController.instance:onCountUseUp(self._resPlotId, function()
		self:onClickClose()
		ViewMgr.instance:close(ViewName.ResStageView)
	end)
end

function MopupMainView:refreshView()
	self:initData()
	self:updataAutoMopup()
	self:updateCost()
	self:updataCondition()
	self:updateRewad()
	self:updatePowerTxt()
end

function MopupMainView:initData()
	if self.getAutoDataCallBack then
		self.autoData = self.getAutoDataCallBack()

		self:_initOneKeySweep()
	end

	if self.getOneCostCallBack then
		self.oneMopupCost = self.getOneCostCallBack()
	end

	if self.getConditionCallBack then
		self.condition = self.getConditionCallBack()
	end

	if self.getChallengeCallBack then
		self.challengeId, self.stageId = self.getChallengeCallBack()
	end

	self.leftTime = false

	if self.getChallengeLeftTimeCallBack then
		self.leftTime = self.getChallengeLeftTimeCallBack()
	end
end

function MopupMainView:updataAutoMopup()
	self.proxy = nil
	self.autoMatType = nil
	self.autoMatId = nil
	self.showAutoBtn = self.autoData

	self:SetActive(self._oneKeySweepGetGo, false)
	self:SetActive(self.goGet, false)

	if self.autoData then
		if self:_isOneKeyType() then
			self:SetActive(self._oneKeySweepGetGo, true)

			self.scrollViewTr.sizeDelta = Vector2.New(537, 328)

			self:_updateOneKeySweep()
		else
			local arr = string.split(self.autoData, ":")
			local matType = tonumber(arr[1])
			local matId = tonumber(arr[2])
			local baseNum = checknumber(arr[#arr])
			local has_num = MaterialFacade.instance:getMatNumber(matType, matId)
			local enough = has_num > 0 and baseNum <= has_num

			if has_num < baseNum then
				if not ("<color=red>" .. has_num .. "/" .. baseNum .. "</color>") then
					local str = has_num .. "/" .. baseNum

					self.proxy = MaterialMgr.setCellByCfg(self.autoData, self.autoItemCon)

					self.proxy.binder:setNumStr(str)

					if enough then
						self.showAutoBtn = false
					end

					self:SetActive(self.goGet, true)

					self.scrollViewTr.sizeDelta = Vector2.New(537, 328)

					local cfg = MaterialMgr.getMatCfg(matType, matId)

					if cfg then
						if not cfg.name then
							local matName = ""

							if enough then
								self.txtGetTip.text = matName .. "已满足" or "已获得" .. matName .. has_num .. "个，还差" .. baseNum - has_num .. "个"
							end
						end
					end
				end
			end
		end
	else
		self:SetActive(self.goGet, false)

		self.scrollViewTr.sizeDelta = Vector2.New(537, 385)

		MaterialMgr.resetAll(self.autoItemCon)
		self:SetActive(self._oneKeySweepGetGo, false)
		self:_resetOneKey()
	end

	self:SetActive(self.btnAuto, self.showAutoBtn)
	self:SetActive(self.btnMul, not self.showAutoBtn)
	self:SetActive(self.gocostMulSweepPower, not self.showAutoBtn and self.oneMopupCost > 0)

	if self.leftTime and self.leftTime <= 1 then
		self:SetActive(self.gocostMulSweepPower, false)
		self:SetActive(self.btnMul, false)
		GameUtil.setLocalPos(self.btnOne.gameObject, 5, -275, 0)
		GameUtil.setLocalPos(self.gocostOneSweepPower, 25, -225, 0)
	else
		GameUtil.setLocalPos(self.btnOne.gameObject, -179, -275, 0)
		GameUtil.setLocalPos(self.gocostOneSweepPower, -159, -225, 0)
	end

	self.maxMopupTime = self.leftTime or 5
end

function MopupMainView:updateCost()
	local totalTili = MaterialFacade.instance:getMatNumber(MatType.Strength, 1)

	self.txtBtnOneCost.text = self.oneMopupCost
	self.txtBtnMulCost.text = self.maxMopupTime * self.oneMopupCost

	local sweepType = MopupModel.instance:getSweepType()

	self.txtBtnMul.text = sweepType == GameEnum.SweepType.Arena and "一键扫荡" or "扫荡" .. self.maxMopupTime .. "次"
	self.txtBtnOne.text = "扫荡1次"

	self:SetActive(self.gocostOneSweepPower, self.oneMopupCost > 0)
end

function MopupMainView:SetActive(go, bool)
	GameUtil.SetActive(go, bool)
end

function MopupMainView:updataCondition()
	if self.getChallengeLeftTimeCallBack then
		self.leftTime = self.getChallengeLeftTimeCallBack()
	end

	local condition1 = ""
	local condition2 = ""

	if self.getConditionCallBack then
		condition1, condition2 = self.getConditionCallBack()
	end

	local list = {}
	local conditionNew = false

	if condition1 ~= "" then
		conditionNew = condition1

		table.insert(list, condition1)
	end

	if condition2 ~= "" then
		conditionNew = conditionNew or condition2

		table.insert(list, condition2)
	end

	self:SetActive(self.goCube, conditionNew and conditionNew ~= "")

	if not list[2] then
		local str2 = ""

		if not list[1] then
			self.txtCondition1.text = ""
		end

		self.txtCondition2.text = str2

		self:SetActive(self.goPower, not str2 or str2 == "")
		self:SetActive(self.addResPlotTimeBtn, false)
	end
end

function MopupMainView:updateRewad()
	if self.rewadList then
		local count = 0
		local finalCount = 0

		GameUtil.SetActive(self.raycastGo, true)

		local function checkSweepOver()
			count = count + 1

			if count >= finalCount then
				if #self._curViewDatas > 0 and self._curViewDatas[1].isInit then
					GameUtil.SetActive(self.raycastGo, false)
				else
					self:SetActive(self.goSweepOver, true)
					settimer(1, self.hideRaycast, self)
				end
			end
		end

		if not self.rewadAddList then
			local list = self.rewadList

			self.rewadAddList = nil
			finalCount = #list

			local step = 1 / #list

			self.co = coroutine.start(function()
				for i, v in ipairs(list) do
					table.insert(self._curViewDatas, v)
					self:reloadData()
					checkSweepOver()
					coroutine.wait(step)
				end
			end)

			if #self._curViewDatas <= 0 then
				GameUtil.SetActive(self.raycastGo, false)
			end
		end
	end
end

function MopupMainView:hideRaycast()
	removetimer(self.hideRaycast, self)
	self:SetActive(self.goSweepOver, false)
	self:SetActive(self.raycastGo, false)
end

function MopupMainView:_onReloadFinish()
	if #self._curViewDatas > 1 then
		self._tableview:SetOffset(self._tableview:GetMaxOffset(), true)
	else
		self._tableview:SetOffset(self._tableview:GetMinOffset(), true)
	end

	self:updataAutoMopup()
	self:updateCost()
end

function MopupMainView:playGoodsGet(list)
	self:SetActive(self.enterShowGo, false)

	self.rewadList = self.rewadList or {}
	self.rewadAddList = false

	table.sort(list, function(a, b)
		return a.times < b.times
	end)

	if self._curViewDatas and #self._curViewDatas > 0 and self._curViewDatas[1].isInit then
		self.rewadList = list
		self._curViewDatas = {}
	else
		self.rewadAddList = {}

		for i, v in ipairs(list) do
			table.insert(self.rewadAddList, v)

			v.times = #self.rewadList + i
		end
	end

	self:refreshView()
end

function MopupMainView:updatePower()
	self:initData()
	self:updataAutoMopup()
	self:updateCost()
	self:updataCondition()
	self:updatePowerTxt()
end

function MopupMainView:updatePowerTxt()
	if self._firstItemParam == nil then
		self.txtPower.text = MaterialFacade.instance:getMatNumber(MatType.Strength, 1) .. "/" .. SupplyConfig.instance:getCommonValue("STRENGTH_LIMIT")
	elseif self._firstItemParam.txtCallBack then
		self.txtPower.text = self._firstItemParam.txtCallBack()
	end
end

function MopupMainView:_getFirstItemNum()
	if self._firstItemParam == nil then
		return MaterialFacade.instance:getMatNumber(MatType.Strength, 1)
	else
		return self._firstItemParam.numCallBack()
	end
end

function MopupMainView:_notEnoughFirstItem()
	self:onClickAddPower()

	if self._firstItemParam == nil then
		FloatWordMgr.instance:show("体力不足")
	else
		local matStr = self._firstItemParam.matStr
		local matCfg = MaterialMgr.getMatCfgByStr(matStr)

		FloatWordMgr.instance:show(langPara("%s不足", matCfg.name))
	end
end

function MopupMainView:_initItem1()
	local matStr
	local matCfg = MaterialMgr.getMatCfgByStr(self._firstItemParam == nil and MatType.Strength .. ":" .. 1 or self._firstItemParam.matStr)

	if matCfg then
		uGuiUtil.setSpriteToImage(self._icon1Item1, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
		uGuiUtil.setSpriteToImage(self._icon2Item1, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
		uGuiUtil.setSpriteToImage(self._icon3Item1, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
	end

	if self._firstItemParam ~= nil then
		local isHaveCallBack = self._firstItemParam.addCallBack ~= nil

		GameUtil.SetActive(self.btnPower.gameObject, isHaveCallBack)
	end
end

function MopupMainView:_resetItem1()
	uGuiUtil.clearImage(self._icon1Item1)
	uGuiUtil.clearImage(self._icon2Item1)
	uGuiUtil.clearImage(self._icon3Item1)
end

function MopupMainView:_onClickAddItem2()
	if self:_isExistItem2() then
		local matType = self._secondItemParam.matType
		local matId = self._secondItemParam.matId

		TipsFacade.instance:openItemSourceView(MaterialMgr.createSerName(matType, matId))
	end
end

function MopupMainView:_isExistItem2()
	return self._secondItemParam and (self._secondItemParam.sweepType == MopupModel.Legend or self._secondItemParam.sweepType == MopupModel.ResPlot or self._secondItemParam.sweepType == MopupModel.MainPlot)
end

function MopupMainView:_initItem2()
	if self:_isExistItem2() then
		goutil.setActive(self._item2Go, true)

		local matType = self._secondItemParam.matType
		local matId = self._secondItemParam.matId

		self._item2TxtNum.text = self:_getItem2TxtNum(matType, matId)

		local cfg = ItemConfig.instance:getCfgById(matId)

		if matType == MatType.Item and cfg then
			uGuiUtil.setSpriteToImage(self._item2Icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
		end
	else
		goutil.setActive(self._item2Go, false)
	end
end

function MopupMainView:_updateItem2()
	self:_checkSweepTicketCost()

	if self:_isExistItem2() then
		local matType = self._secondItemParam.matType
		local matId = self._secondItemParam.matId

		self._item2TxtNum.text = self:_getItem2TxtNum(matType, matId)

		self:updatePower()
	end
end

function MopupMainView:_getItem2TxtNum(matType, matId)
	local curCount = MaterialFacade.instance:getMatNumber(matType, matId)

	return string.format("<color=#%s>%d</color>", (self:_isExistTogItemCost() and not self:_isOneTimeEnough(curCount) or nil) and "eb4642", curCount)
end

function MopupMainView:_resetItem2()
	goutil.setActive(self._item2Go, false)

	self._item2TxtNum.text = ""

	local img = Framework.ImageBigBG.Get(self._item2Icon)

	if img then
		img:ClearImage()
	end
end

function MopupMainView:_isOneKeyType()
	return self.autoData and self.autoData.type and self.autoData.type == "onekeysweep"
end

function MopupMainView:_initOneKeySweep()
	if self:_isOneKeyType() then
		local rewardList = self.autoData.rewardList

		for i, v in ipairs(rewardList) do
			local arr = string.split(v, ":")
			local matType = tonumber(arr[1])
			local matId = tonumber(arr[2])
			local baseNum = checknumber(arr[#arr])
			local has_num = MaterialFacade.instance:getMatNumber(matType, matId)
			local enough = has_num > 0 and baseNum <= has_num

			if not enough then
				local isExist, chapterId, stageId = PlotCopyModel.instance:isOneWaySweepExistAtLeast(matType, matId)

				self.autoData.curChallengeId = chapterId
				self.autoData.curstageId = stageId
				self.autoData.curRewardStr = v

				break
			end
		end
	end
end

function MopupMainView:_updateOneKeySweep()
	if self:_isOneKeyType() then
		local rewardList = self.autoData.rewardList
		local allEnough = true

		self._oneKeySweepTableView:reloadData(rewardList)

		for i, v in ipairs(rewardList) do
			local arr = string.split(v, ":")
			local matType = tonumber(arr[1])
			local matId = tonumber(arr[2])
			local baseNum = checknumber(arr[#arr])
			local has_num = MaterialFacade.instance:getMatNumber(matType, matId)
			local enough = has_num > 0 and baseNum <= has_num

			if not enough then
				allEnough = false
			end
		end

		if allEnough then
			self._isStartAuto = false
			self.showAutoBtn = false

			if self._oneKeyTween then
				self._oneKeyTween:Kill()

				self._oneKeyTween = nil
			end
		end

		if self._isStartAuto and self.showAutoBtn and not self._oneKeyTween then
			self._oneKeyTween = TweenUtil.DoDelay(0.2, function()
				self:onClickAuto()

				self._oneKeyTween = nil
			end)
		end
	end
end

function MopupMainView:_initOneKeyVariable()
	self._isStartAuto = false
end

function MopupMainView:_resetOneKey()
	self._oneKeySweepTableView:dispose()

	self._isStartAuto = false

	if self._oneKeyTween then
		self._oneKeyTween:Kill()

		self._oneKeyTween = nil
	end
end

function MopupMainView:_isExistTogItemCost()
	return self._secondItemParam and (self._secondItemParam.sweepType == MopupModel.ResPlot or self._secondItemParam.sweepType == MopupModel.MainPlot)
end

function MopupMainView:_initSweepTicketCost()
	self._togItemCost.gameObject:SetActive(self:_isExistTogItemCost())

	if self:_isExistTogItemCost() then
		if MaterialModel.instance:IsEnough(self._secondItemParam.matType, self._secondItemParam.matId, self._secondItemParam.unitCost) then
			if MopupModel.instance:getSweepSetting(true) then
				MopupModel.instance:setSweepSetting(true)

				self._togItemCost.isOn = true
			else
				self._togItemCost.isOn = MopupModel.instance:getSweepSetting(true)
			end
		else
			MopupModel.instance:setSweepSetting(false)

			self._togItemCost.isOn = false
		end

		self._txtToggle.text = string.format("每次使用 <color=#cf7800>%d</color>张", self._secondItemParam.unitCost)

		local cfg = ItemConfig.instance:getCfgById(self._secondItemParam.matId)

		if self._secondItemParam.matType == MatType.Item and cfg then
			uGuiUtil.setSpriteToImage(self._imgToggle, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
		end
	else
		self._togItemCost.isOn = false
	end
end

function MopupMainView:_checkSweepTicketCost()
	self._togItemCost.gameObject:SetActive(self:_isExistTogItemCost())

	if self:_isExistTogItemCost() then
		if not MaterialModel.instance:IsEnough(self._secondItemParam.matType, self._secondItemParam.matId, self._secondItemParam.unitCost) and self:_isUseSweepTicket() then
			MopupModel.instance:setSweepSetting(false)

			self._togItemCost.isOn = false
		else
			MopupModel.instance:setSweepSetting(self:_isUseSweepTicket())
		end

		self._txtToggle.text = string.format("每次使用 <color=#cf7800>%d</color>张", self._secondItemParam.unitCost)

		local cfg = ItemConfig.instance:getCfgById(self._secondItemParam.matId)

		if self._secondItemParam.matType == MatType.Item and cfg then
			uGuiUtil.setSpriteToImage(self._imgToggle, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))
		end
	else
		self._togItemCost.isOn = false
	end
end

function MopupMainView:_resetSweepTicketCost()
	self._togItemCost.gameObject:SetActive(false)

	local img = Framework.ImageBigBG.Get(self._imgToggle)

	if img then
		img:ClearImage()
	end
end

function MopupMainView:_isUseSweepTicket()
	return self._togItemCost.isOn
end

function MopupMainView:_isOneTimeEnough(curCount)
	return self._secondItemParam and (self._secondItemParam.sweepType == MopupModel.ResPlot or self._secondItemParam.sweepType == MopupModel.MainPlot) and curCount >= self._secondItemParam.unitCost
end

function MopupMainView:_isMulTimeEnough(times)
	if self._secondItemParam and (self._secondItemParam.sweepType == MopupModel.ResPlot or self._secondItemParam.sweepType == MopupModel.sweepType == MopupModel.MainPlot) then
		local matType = self._secondItemParam.matType
		local matId = self._secondItemParam.matId
		local curCount = MaterialFacade.instance:getMatNumber(matType, matId)

		return curCount >= self._secondItemParam.unitCost * times
	else
		return false
	end
end

function MopupMainView:_checkShowResplot()
	self:_showPlotDoubleTime()

	if self._resPlotId then
		GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._showPlotDoubleTime, self)
	end
end

function MopupMainView:_showPlotDoubleTime()
	if self._resPlotId == nil then
		goutil.setActive(self._resPlotDoubleGo, false)

		return
	end

	if self._resPlotId > 0 then
		goutil.setActive(self._resPlotDoubleGo, true)
		self:_setResplotDoubleTime()

		return
	end

	if self._resPlotId == 0 then
		self:_setMainplotDoubleTime()

		return
	end

	goutil.setActive(self._resPlotDoubleGo, false)
end

function MopupMainView:_setResplotDoubleTime()
	local leftTime = MaterialChallengeModel.instance:getMaterialDoubleTimesWithChapterId(self._resPlotId)
	local curUseCount = MaterialChallengeModel.instance:getBaseUseTimesById()
	local maxUseCount = MaterialChallengeConfig.instance:getDailyDoubleTimes()
	local freeCount = maxUseCount - curUseCount

	freeCount = freeCount >= 0 and freeCount or 0

	local desc = "今日剩余次数\n"

	desc = leftTime < 0 and desc .. "不限次数" or desc .. "<color=#20B376FF>" .. leftTime + freeCount .. "</color>次"
	self._txtResplotDoubleLeftTime.text = desc
end

function MopupMainView:_setMainplotDoubleTime()
	local leftTime = MaterialChallengeModel.instance:getMainPlotDoubleTimes()

	if leftTime == 0 then
		goutil.setActive(self._resPlotDoubleGo, false)

		return
	end

	goutil.setActive(self._resPlotDoubleGo, true)

	local desc = "今日剩余次数\n"

	desc = leftTime < 0 and desc .. "不限次数" or desc .. "<color=#20B376FF>" .. leftTime .. "</color>次"
	self._txtResplotDoubleLeftTime.text = desc
end

function MopupMainView:_checkShowGDResplot()
	local isShowDouble = false

	isShowDouble = GoldenDiamondCardModel.instance.isUser and self._secondItemParam and (self._secondItemParam.sweepType == MopupModel.ResPlot or self._secondItemParam.sweepType == MopupModel.MainPlot)

	goutil.setActive(self._resGDPlotDoubleGo, isShowDouble)

	if isShowDouble then
		self:_setGoldenDiamondCardDoubleTime()
	end
end

function MopupMainView:_setGoldenDiamondCardDoubleTime()
	if self._secondItemParam then
		local type = not (self._secondItemParam.sweepType ~= MopupModel.ResPlot and self._secondItemParam.sweepType ~= MopupModel.MainPlot)

		if not type then
			return
		end

		local leftTime = 0

		leftTime = self._secondItemParam.sweepType == MopupModel.ResPlot and GoldenDiamondCardModel.instance:getLeftTimeOfPrivilege(GoldenDiamondCardModel.PrivilegeType.ResCopySweepDouble) or GoldenDiamondCardModel.instance:getLeftTimeOfPrivilege(GoldenDiamondCardModel.PrivilegeType.MainCopySweepDouble)

		local desc = "今日剩余次数\n"

		if leftTime >= 0 then
			desc = desc .. "<color=#20B376FF>" .. leftTime .. "</color>次"
		end

		self._txtresGDplotDoubleLeftTime.text = desc
	end
end

function MopupMainView:_updateOneKeyCell(view, cell, data)
	local itemPos = goutil.findChild(cell, "item")
	local matType, matId, matNum = MaterialMgr.getMatParams(data)
	local proxy = MaterialMgr.setCell(matType, matId, itemPos)
	local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

	if has_num < matNum then
		if not ("<color=red>" .. has_num .. "</color>" .. "/" .. matNum) then
			local numStr = has_num .. "/" .. matNum

			if proxy then
				proxy.binder:setNumStr(numStr)
			end
		end
	end
end

function MopupMainView:_clearOneCell(cell)
	local itemPos = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(itemPos)
end

return MopupMainView
