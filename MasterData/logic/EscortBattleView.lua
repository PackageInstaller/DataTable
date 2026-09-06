-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortBattleView.lua

module("logic.extensions.escort.view.EscortBattleView", package.seeall)

local EscortBattleView = class("EscortBattleView", TableViewComponent)

function EscortBattleView:ctor()
	EscortBattleView.super.ctor(self)

	self.escortInfo = nil
	self.isCooling = false
	self.clickTimer = 0
	self.tipsTimer = 0
	self.coolTimer = 0.2
end

function EscortBattleView:bindEvents()
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.zhanbaoBtn:AddClickListener(function()
		ViewMgr.instance:open(ViewName.EscortReport)
	end, self)
	self.kshsClickBtn:AddClickListener(function()
		if not EscortModel.instance:IsPickupEscort() then
			FloatWordMgr.instance:show("本次护送任务已结束！")

			return
		end

		self:close()
		EscortModel.instance:StartFindGotoNPC()
	end, self)
	self.useJuanTog:AddOnValueChanged(function(go, isOn)
		if isOn and checknumber(self.escortInfo.supFreeChall) > 0 then
			self.useJuanTog.isOn = false

			FloatWordMgr.instance:show("当前还有免费次数，无法使用挑战券！")

			return
		end

		self.useJuanTog.isOn = isOn
	end)
end

function EscortBattleView:unbindEvents()
	self.viewCloseBtn:RemoveClickListener()
	self.zhanbaoBtn:RemoveClickListener()
	self.kshsClickBtn:RemoveClickListener()
	self.useJuanTog:RemoveOnValueChanged()
end

function EscortBattleView:buildUI()
	EscortBattleView.super.buildUI(self)

	local viewInfoGo = self:getGo("viewInfoGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "viewCloseBtn")
	self.supTimeTxt = goutil.findChildTextComponent(viewInfoGo, "supTimeTxt")
	self.noListGo = goutil.findChild(viewInfoGo, "noListGo")
	self.zhanbaoBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "zhanbaoBtn")
	self.redPointGo = goutil.findChild(viewInfoGo, "zhanbaoBtn/redPointGo")

	self.noListGo:SetActive(false)
	self.redPointGo:SetActive(false)

	self.supTimeTxt.text = ""
	self.surplusCountTxt = goutil.findChildTextComponent(viewInfoGo, "surplusCountTxt")
	self.juanCountTxt = goutil.findChildTextComponent(viewInfoGo, "juanCountTxt")
	self.useJuanTog = Framework.ToggleAdapter.GetFrom(viewInfoGo, "useJuanTog")
	self.juanIconIma = goutil.findChild(viewInfoGo, "juanIconIma"):GetComponent("Image")
	self.kshsClickBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "kshsClickBtn")
end

function EscortBattleView:onEnterFinished()
	EscortBattleView.super.onEnterFinished(self)
	self._tableview:ReloadData()
end

function EscortBattleView:onExitFinished()
	return
end

function EscortBattleView:onExit()
	removetimer(self.CalculationSurplusTime, self)

	self._curViewDatas = nil

	GlobalDispatcher:removeListener("UpdataEscortBattleList", self.UpdataBattlePlayerList, self)
	GlobalDispatcher:removeListener("EscortTimeOver", self.InitShowSpriteInfo, self)
	GlobalDispatcher:removeListener("UpdataEscortPoint", self.UpdataEscortPoint, self)
end

function EscortBattleView:destroyUI()
	self.escortInfo = nil
	self.isCooling = false
	self.clickTimer = 0
	self.coolTimer = 0.2
end

function EscortBattleView:onEnter()
	EscortBattleView.super.onEnter(self)
	EscortController.instance:CSGetConvoyListReq(true)

	local wuziInfo = EscortModel.instance:GetHuowuGoodsInfo()

	self.wuziType = wuziInfo[1] and tonumber(wuziInfo[1]) or 4
	self.wuziId = wuziInfo[2] and tonumber(wuziInfo[2]) or 700

	self:InitShowSpriteInfo()
	self:UpdataBattlePlayerList()

	local isRedPoint = EscortModel.instance:GetEscortRedPoint("escortbattle")

	self:UpdataEscortPoint("escortbattle", isRedPoint)
	self._tableview:RegisterOnUpdatePositionCallback(function(self, srView)
		self:OnCellUpdatePosition(srView)
	end)
	GlobalDispatcher:addListener("UpdataEscortBattleList", self.UpdataBattlePlayerList, self)
	GlobalDispatcher:addListener("EscortTimeOver", self.InitShowSpriteInfo, self)
	GlobalDispatcher:addListener("UpdataEscortPoint", self.UpdataEscortPoint, self)
end

function EscortBattleView:InitShowSpriteInfo()
	removetimer(self.CalculationSurplusTime, self)

	self.escortInfo = EscortModel.instance:GetEscortBaseInfo()
	self.useJuanTog.isOn = false

	local goodsType, goodsId = EscortModel.instance:GetTiaoZhanJuanInfo()

	MaterialMgr.setIcon(self.juanIconIma, goodsType, goodsId)

	local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)

	if info then
		if not info.num then
			local count = 0

			if self.escortInfo.supFreeChall > 0 then
				uGuiUtil.setImageGrayStateRecursive(self.useJuanTog.gameObject, true)
				uGuiUtil.setImageGrayState(self.juanIconIma.gameObject, true)

				self.juanCountTxt.text = string.format("<color=#9A9D9EFF>消耗挑战券：    %s/1</color>", count)
				self.surplusCountTxt.text = string.format("<color=#273544FF>剩余挑战次数：</color><color=#20B376FF>%s</color><color=#273544FF>/%s</color>", self.escortInfo.supFreeChall, self.escortInfo.freeChallCount)
			else
				uGuiUtil.setImageGrayStateRecursive(self.useJuanTog.gameObject, false)
				uGuiUtil.setImageGrayState(self.juanIconIma.gameObject, false)

				self.juanCountTxt.text = string.format("<color=#273544FF>消耗挑战券：    %s/1</color>", count)
				self.surplusCountTxt.text = string.format("<color=#9A9D9EFF>剩余挑战次数：0/%s</color>", self.escortInfo.freeChallCount)
			end

			self:CalculationSurplusTime()
			settimer(1, self.CalculationSurplusTime, self, true)
		end
	end
end

function EscortBattleView:CalculationSurplusTime()
	local isPick, onceEndTime = EscortModel.instance:IsPickupEscort()

	if not isPick or onceEndTime <= 0 then
		self.supTimeTxt.text = "护送时间已结束"

		return
	end

	local supTime = onceEndTime - ServerTime.now()
	local hour = math.floor(supTime / 3600)
	local min = math.floor((supTime - hour * 3600) / 60)
	local sec = supTime - hour * 3600 - min * 60

	self.supTimeTxt.text = hour > 0 and string.format("护送剩余时间 %s小时%s分%s秒", hour, min, sec) or string.format("护送剩余时间 %s分%s秒", min, sec)
end

function EscortBattleView:UpdataBattlePlayerList()
	self._curViewDatas = EscortModel.instance:GetBattlePlayerList()

	self._tableview:ReloadData()

	if self._curViewDatas and #self._curViewDatas > 0 then
		self.noListGo:SetActive(false)
		self._tableview:SetOffset(0, false)
	else
		self.noListGo:SetActive(true)
	end

	self.isCooling = false
end

function EscortBattleView:SetCoolTimer()
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
		self.tipsTimer = ServerTime.now()
	end

	local now = ServerTime.now()

	if now - self.clickTimer < self.coolTimer then
		if ServerTime.now() - self.tipsTimer > 2 then
			self.tipsTimer = ServerTime.now()

			FloatWordMgr.instance:show("护送-还在挑战列表刷新CD中，无法获取新的信息，请稍后再尝试。")
		end

		return
	end

	self.clickTimer = now
	self.tipsTimer = now

	return true
end

function EscortBattleView:OnCellUpdatePosition(srView)
	if self.isCooling then
		return
	end

	if srView:GetOffset() >= srView:GetMaxOffset() then
		if not self:SetCoolTimer() then
			return
		end

		self.clickTimer = 0
		self.coolTimer = 10
		self.isCooling = true

		EscortController.instance:CSGetConvoyListReq(true)
	end
end

function EscortBattleView:_getPath()
	return {
		cellPath = "viewInfoGo/itemGo",
		viewPath = "viewInfoGo/itemListSR"
	}
end

function EscortBattleView:_cellSize()
	return 1100, 100
end

function EscortBattleView:_updateCell(view, cell, data)
	local enemyIconGo = goutil.findChild(cell, "enemyIconGo")
	local playerIconIma = goutil.findChild(cell, "playerIconIma")
	local playerLevelTxt = goutil.findChildTextComponent(cell, "playerLevelIma/playerLevelTxt")
	local playerNameTxt = goutil.findChildTextComponent(cell, "playerNameTxt")
	local powerCountTxt = goutil.findChildTextComponent(cell, "powerCountTxt")
	local tiaozhanBtnGo = goutil.findChild(cell, "tiaozhanBtn")
	local tiaozhanTxt = goutil.findChildTextComponent(cell, "tiaozhanBtn/tiaozhanTxt")

	enemyIconGo:SetActive(data.isEnemy)
	HeadItemController.instance:setHeadCellByInfo(playerIconIma, data.headInfo)

	playerLevelTxt.text = tostring(data.userLevel)
	playerNameTxt.text = data.userName

	local wuziCfg = EscortConfig.instance:GetBoxWuziInfo(data.userBoxId)

	if wuziCfg then
		if not wuziCfg.eachRobNum then
			local goodsCount = 30
			local wzLua = MaterialMgr.setCell(self.wuziType, self.wuziId, cell)

			GameUtil.setLocalScale(wzLua.view, 0.9, 0.9, 0.9)
			Framework.TransformUtil.SetLocalPos(wzLua.view.transform, -80, 0, 0)
			wzLua.binder:setNum(goodsCount)

			powerCountTxt.text = tostring(data.maxPower)
			tiaozhanTxt.text = string.format("挑战（%s/%s）", data.supBeChalNum, self.escortInfo.freeBeChallCount)

			GameUtil.asBtn(tiaozhanBtnGo):AddClickListener(function()
				self:OnClickTiaozhanBtn(data)
			end, self)
		end
	end
end

function EscortBattleView:OnClickTiaozhanBtn(data)
	if data == nil then
		return
	end

	if not EscortModel.instance:IsOpenEscortView() and not EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送活动未开始！")

		return
	end

	if not EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("本次护送任务已结束！")

		return
	end

	local function sendFunc()
		self:close()
		EscortModel.instance:SetBattlePlayer(data, self.useJuanTog.isOn)

		if tonumber(data.userId) <= 0 then
			UIStateManager.instance:push(ViewName.EscortMission)
		else
			EscortController.instance:CSGetOtherConvoyDetailReq(tonumber(data.userId))
		end
	end

	local function startFunc()
		local goodsType, goodsId = EscortModel.instance:GetTiaoZhanJuanInfo()
		local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)

		if info then
			if not info.num then
				local count = 0
				local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

				if count <= 0 then
					FloatWordMgr.instance:show(string.format("%s不足！", cfg.name))

					return
				end

				sendFunc()
			end
		end
	end

	if self.useJuanTog.isOn then
		TipsFacade.instance:openPopupWindow("提示", "是否使用1张挑战券开始挑战？", startFunc, nil, "确定", "取消")
	else
		if self.escortInfo.supFreeChall <= 0 then
			FloatWordMgr.instance:show("免费次数不足！")

			return
		end

		sendFunc()
	end
end

function EscortBattleView:UpdataEscortPoint(viewName, isShow)
	if viewName == "escortbattle" or viewName == "all" then
		self.redPointGo:SetActive(isShow)
	end
end

return EscortBattleView
