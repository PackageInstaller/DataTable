-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortGoodsView.lua

module("logic.extensions.escort.view.EscortGoodsView", package.seeall)

local EscortGoodsView = class("EscortGoodsView", ViewComponent)

function EscortGoodsView:ctor()
	EscortGoodsView.super.ctor(self)

	self.escortInfo = nil
	self.mapInfoList = nil
	self.clickTimer = 0
	self.coolTimer = 0.3
end

function EscortGoodsView:bindEvents()
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.battleBtn:AddClickListener(function()
		self:close()
		UIStateManager.instance:push(ViewName.EscortBattle)
	end, self)
	self.findWayBtn:AddClickListener(function()
		self:close()
		EscortModel.instance:StartFindGotoNPC()
	end, self)
	self.oneKeyBtn:AddClickListener(self.onClickOnkey, self)
	self.upgradeBtn:AddClickListener(self.OnClickupgradeBtn, self)
	self.kshsClickBtn:AddClickListener(self.OnClickKshsClickBtn, self)
end

function EscortGoodsView:unbindEvents()
	self.viewCloseBtn:RemoveClickListener()
	self.battleBtn:RemoveClickListener()
	self.findWayBtn:RemoveClickListener()
	self.upgradeBtn:RemoveClickListener()
	self.kshsClickBtn:RemoveClickListener()
	self.oneKeyBtn:RemoveClickListener()
	self.scaleTwn:RemoveListener()
end

function EscortGoodsView:buildUI()
	self.viewCloseBtn = self:getBtn("viewBgIma/viewCloseBtn")

	local viewBgGo = self:getGo("viewBgIma")

	self.surplusTimeTxt = goutil.findChildTextComponent(viewBgGo, "surplusTimeTxt")
	self.wuziIconIma = goutil.findChildComponent(viewBgGo, "wuziIconIma", "UIImageSpriteChange")
	self.wuziNameTxt = goutil.findChildTextComponent(viewBgGo, "wuziNameTxt")
	self.huowuPos = goutil.findChild(viewBgGo, "huowuPos")
	self.rewardPos = goutil.findChild(viewBgGo, "rewardPos")
	self.consumeGo = goutil.findChild(viewBgGo, "consumeGo")
	self.rewardGoods1 = goutil.findChild(self.rewardPos, "rewardGoods_1")
	self.rewardGoods2 = goutil.findChild(self.rewardPos, "rewardGoods_2")
	self.rewardGoods3 = goutil.findChild(self.rewardPos, "rewardGoods_3")
	self.multipleGo = goutil.findChild(self.rewardPos, "multipleGo")
	self.battleBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "battleBtn")
	self.redPointGo = goutil.findChild(viewBgGo, "battleBtn/redPointGo")
	self.findWayBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "findWayBtn")
	self.upgradeIma = goutil.findChild(self.consumeGo, "upgradeIma"):GetComponent("Image")
	self.upgradeTxt = goutil.findChildTextComponent(self.consumeGo, "upgradeTxt")
	self.upgradeBtn = Framework.ButtonAdapter.GetFrom(self.consumeGo, "upgradeBtn")
	self.upgradeBtnIma = goutil.findChild(self.consumeGo, "upgradeBtn"):GetComponent("Image")
	self.useJuanTog = goutil.findChild(self.consumeGo, "useJuanTog"):GetComponent("Toggle")
	self.juanIconIma = goutil.findChild(self.consumeGo, "juanIconIma"):GetComponent("Image")
	self.juanCountTxt = goutil.findChildTextComponent(self.consumeGo, "juanCountTxt")
	self.kshsClickBtn = Framework.ButtonAdapter.GetFrom(self.consumeGo, "kshsClickBtn")
	self.oneKeyBtn = Framework.ButtonAdapter.GetFrom(self.consumeGo, "oneKeyBtn")

	GameUtil.SetActive(self.multipleGo, false)

	self.surplusCountTxt = goutil.findChildTextComponent(self.consumeGo, "surplusCountTxt")

	self.redPointGo:SetActive(false)

	self.surplusTimeTxt.text = ""
	self.processTran = goutil.findChild(viewBgGo, "processTran").transform
	self.processGo = goutil.findChild(viewBgGo, "processGo")
	self.processBarSli = goutil.findChildComponent(viewBgGo, "processBarSli", "Slider")

	self.processGo:SetActive(false)

	self.processBarSli.value = 0
	self.levelupGo = self:getGo("levelupGo")
	self.boxIma = goutil.findChildComponent(self.levelupGo, "boxIma", "UIImageSpriteChange")
	self.nameTxt = goutil.findChildTextComponent(self.levelupGo, "nameTxt")

	self.levelupGo:SetActive(false)
end

function EscortGoodsView:onExit()
	removetimer(self.CalculationSurplusTime, self)
	GlobalDispatcher:removeListener("UpdataEscortBaseInfo", self.UpdataWuzhiInfo, self)
	GlobalDispatcher:removeListener("UpdataTipsShow", self.UpdataTipsShow, self)
	GlobalDispatcher:removeListener("EscortTimeOver", self.InitStartInfo, self)
	GlobalDispatcher:removeListener("UpdataEscortPoint", self.UpdataEscortPoint, self)

	if self.scaleTwn then
		self.scaleTwn:Stop()
	end

	self.levelupGo:SetActive(false)
end

function EscortGoodsView:destroyUI()
	if self.eff then
		UIEffectManager.instance:stopEffect(self.eff)

		self.eff = nil
	end

	self.escortInfo = nil

	for _, item in pairs(self.mapInfoList or {}) do
		if item then
			local bigBg = item.subIconGo:GetComponent("ImageBigBG")

			if bigBg then
				bigBg:ClearImage()
			end

			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.mapInfoList = nil
end

function EscortGoodsView:onEnter()
	self.scaleTwn = UnityTweens.TweenScale.Create(self.levelupGo, Vector3.New(1, 1, 1), Vector3.New(0, 0, 0), 0.5, UnityTweens.EaseType.easeInSine, 1)

	self.scaleTwn:AddListener(function()
		self.levelupGo:SetActive(false)
	end)
	self:InitStartInfo()

	local isRedPoint = EscortModel.instance:GetEscortRedPoint("escortgoods")

	self:UpdataEscortPoint("escortgoods", isRedPoint)
	GlobalDispatcher:addListener("UpdataEscortBaseInfo", self.UpdataWuzhiInfo, self)
	GlobalDispatcher:addListener("UpdataTipsShow", self.UpdataTipsShow, self)
	GlobalDispatcher:addListener("EscortTimeOver", self.InitStartInfo, self)
	GlobalDispatcher:addListener("UpdataEscortPoint", self.UpdataEscortPoint, self)
end

function EscortGoodsView:InitStartInfo()
	self.isPickup = EscortModel.instance:IsPickupEscort()

	if self.isPickup then
		self.consumeGo:SetActive(false)
		self.battleBtn.gameObject:SetActive(true)
		self.findWayBtn.gameObject:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self.huowuPos.transform, 108, 55, 0)
		Framework.TransformUtil.SetLocalPos(self.rewardPos.transform, 308, 55, 0)
	else
		self.battleBtn.gameObject:SetActive(false)
		self.findWayBtn.gameObject:SetActive(false)
		self.consumeGo:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self.huowuPos.transform, 108, 88, 0)
		Framework.TransformUtil.SetLocalPos(self.rewardPos.transform, 308, 88, 0)
	end

	local allUpdataCfg = EscortConfig.instance:GetBoxWuziInfo()

	if allUpdataCfg then
		self.allWuziCount = #allUpdataCfg or 0
	end

	self:UpdataWuzhiInfo()
	self:InitOtherInfo()
end

function EscortGoodsView:UpdataTipsShow(isUpgrade, des)
	if self.eff then
		UIEffectManager.instance:stopEffect(self.eff)

		self.eff = nil
	end

	if isUpgrade then
		local tempInfo = EscortModel.instance:GetEscortBaseInfo()

		if tempInfo == nil then
			return
		end

		Framework.TransformUtil.SetLocalScale(self.levelupGo.transform, 1, 1, 1)
		self.levelupGo:SetActive(true)
		self.scaleTwn:Stop()

		local wuziCfg = EscortConfig.instance:GetBoxWuziInfo(tempInfo.curGoodsId)

		self.boxIma:SetState(tempInfo.curGoodsId - 1)

		if wuziCfg then
			self.nameTxt.text = wuziCfg.boxName or "箱子"
		end

		self.scaleTwn:Begin()

		local effPath = "fx_ui_assignmentview/fx_ui_assignmentview_treasurechesteffects.prefab"
		local num = UGUIToolHelper.GetNodeCanvansSortingOrder(self.boxIma.gameObject) + 1

		self.eff = UIEffectManager.instance:playHUDEffect(effPath, self.boxIma.gameObject, false, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, num)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)
	elseif not string.nilorempty(des) then
		FloatWordMgr.instance:show(des)
	end
end

function EscortGoodsView:UpdataWuzhiInfo()
	removetimer(self.CalculationSurplusTime, self)
	MaterialMgr.resetAll(self.rewardGoods1)
	MaterialMgr.resetAll(self.rewardGoods2)
	MaterialMgr.resetAll(self.rewardGoods3)
	GameUtil.SetActive(self.multipleGo, false)

	self.escortInfo = EscortModel.instance:GetEscortBaseInfo()

	if self.escortInfo == nil then
		error("sr_护送  EscortGoodsView:UpdataWuzhiInfo()  护送基础数据空！")

		return
	end

	local wuziCfg = EscortConfig.instance:GetBoxWuziInfo(self.escortInfo.curGoodsId)

	self.wuziIconIma:SetState(self.escortInfo.curGoodsId - 1)

	if wuziCfg then
		self.wuziNameTxt.text = wuziCfg.boxName or "箱子"
	end

	local hwGoodsInfo = EscortModel.instance:GetHuowuGoodsInfo()
	local goodsType = hwGoodsInfo[1] and tonumber(hwGoodsInfo[1]) or 4
	local goodsId = hwGoodsInfo[2] and tonumber(hwGoodsInfo[2]) or 700
	local hwLua = MaterialMgr.setCell(goodsType, goodsId, self.huowuPos)

	GameUtil.setLocalScale(hwLua.view, 0.77, 0.77, 0.77)
	Framework.TransformUtil.SetLocalPos(hwLua.view.transform, 0, -13, 0)
	hwLua.binder:setNum(self.escortInfo.daibiCount)

	local now = ServerTime.nowDateServerLook()

	self:CalculationSurplusTime()
	settimer(1, self.CalculationSurplusTime, self, true)

	if wuziCfg and not string.nilorempty(wuziCfg.rewardPreview) then
		local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.familyEscortPrize)
		local mul = 1

		if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
			mul = checknumber(cfg.featureParam)
		end

		local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

		mul = mul + newhandDoubleValue

		GameUtil.SetActive(self.multipleGo, mul > 1)

		local jlGoodsInfo = string.split(wuziCfg.rewardPreview, "#")

		for i = 1, #jlGoodsInfo do
			if self["rewardGoods" .. i] then
				local proxy = MaterialMgr.setCellByCfg(jlGoodsInfo[i], self["rewardGoods" .. i])

				proxy.binder:setNum(0)
			end
		end
	end

	if self.isPickup then
		return
	end

	local supCount = self.escortInfo.freeUpdataCount - self.escortInfo.useUpdataCount

	if supCount > 0 then
		self.upgradeIma.gameObject:SetActive(false)

		self.upgradeTxt.text = string.format("免费升级次数：%s次", supCount)
	else
		self.upgradeIma.gameObject:SetActive(true)

		local needInfo = EscortConfig.instance:GetBoxUpdataInfo(self.escortInfo.useUpdataCount + 1)

		if needInfo == nil then
			self.upgradeTxt.text = string.format("升级消耗：     100")

			error("sr_护送 EscortGoodsView:UpdataWuzhiInfo()   升级物资消耗获取为空 = ", self.escortInfo.useUpdataCount + 1)

			return
		end

		local goodsType = tonumber(needInfo[1])
		local goodsId = tonumber(needInfo[2])
		local goodsCount = needInfo[3] and tonumber(needInfo[3]) or 100

		if goodsType == MatType.Diamond_Consume then
			goodsType = 104
			goodsId = 2
		end

		MaterialMgr.setIcon(self.upgradeIma, goodsType, goodsId)

		self.upgradeTxt.text = string.format("升级消耗：     %s", goodsCount)
	end

	if self.escortInfo.curGoodsId >= self.allWuziCount then
		uGuiUtil.setImageAlpha(self.upgradeBtnIma, 0.5)
	else
		uGuiUtil.setImageAlpha(self.upgradeBtnIma, 1)
	end
end

function EscortGoodsView:CalculationSurplusTime()
	local isOpen, allEndTime = EscortModel.instance:IsOpenEscortView()

	if not isOpen or allEndTime <= 0 then
		if EscortModel.instance:IsPickupEscort() then
			self.surplusTimeTxt.text = string.format("距离活动结束时间 0分0秒")

			return
		end

		self:close()
		FloatWordMgr.instance:show("护送活动结束！")

		return
	end

	local supTime = allEndTime - ServerTime.now()
	local hour = math.floor(supTime / 3600)
	local min = math.floor((supTime - hour * 3600) / 60)
	local sec = supTime - hour * 3600 - min * 60

	self.surplusTimeTxt.text = hour > 0 and string.format("距离活动结束时间 %s小时%s分%s秒", hour, min, sec) or string.format("距离活动结束时间 %s分%s秒", min, sec)
end

function EscortGoodsView:InitOtherInfo()
	local npcList = EscortModel.instance:GetRouteNpcInfoList()

	if npcList then
		if not #npcList then
			local npcCount = 0
			local passCount = 0

			if npcCount > 0 then
				if npcCount > 1 then
					if not (500 / (npcCount - 1)) then
						do
							local oneSize = 500

							self.mapInfoList = self.mapInfoList or {}

							for i = 1, npcCount do
								if self.mapInfoList[i] == nil then
									local go = UnityEngine.GameObject.Instantiate(self.processGo, self.processTran)

									go.name = "processItem_" .. i
									self.mapInfoList[i] = {
										itemGo = go,
										itemIma = go:GetComponent("UIImageSpriteChange"),
										subIconGo = goutil.findChild(go, "processIcon")
									}
								end

								self.mapInfoList[i].itemGo:SetActive(true)
								Framework.TransformUtil.SetLocalPos(self.mapInfoList[i].itemGo.transform, (i - 1) * oneSize, 0, 0)

								if npcList[i] and npcList[i].isPass then
									passCount = passCount + 1

									self.mapInfoList[i].itemIma:SetState(1)
								else
									self.mapInfoList[i].itemIma:SetState(0)
								end

								if npcList[i] and not string.nilorempty(npcList[i].mapIcon) then
									uGuiUtil.setSpriteToImage(self.mapInfoList[i].subIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl(npcList[i].mapIcon))
								else
									uGuiUtil.setSpriteToImage(self.mapInfoList[i].subIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getSceneIconUrl("aoqicheng.png"))
								end
							end

							self.processBarSli.value = passCount / npcCount
						end

						if self.isPickup then
							return
						end
					end
				end
			end

			self.useJuanTog.isOn = false

			local goodsType, goodsId = EscortModel.instance:GetHusongJuanInfo()
			local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

			MaterialMgr.setIcon(self.juanIconIma, goodsType, goodsId)

			local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)

			if info then
				if not info.num then
					local count = 0

					self.juanCountTxt.text = string.format("消耗护送券：      %s/1", count)
					self.surplusCountTxt.text = string.format("今日剩余：%s/%s", self.escortInfo.supEscortCount, self.escortInfo.freeEscortCount)
				end
			end
		end
	end
end

function EscortGoodsView:onClickOnkey()
	if not EscortModel.instance:IsOpenEscortView() and not EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送活动未开始！")

		return
	end

	if GoldenDiamondCardModel.instance.isUser then
		local function startFunc()
			local goodsType, goodsId = EscortModel.instance:GetHusongJuanInfo()
			local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
			local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)

			if info then
				if not info.num then
					local count = 0

					if count <= 0 then
						FloatWordMgr.instance:show(string.format("%s不足！", cfg.name))
					else
						self:close()
						ConvoyAgent.instance:sendPM_ConvoyOneKeyFinishReq(true)
					end
				end
			end
		end

		if self.useJuanTog.isOn then
			TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否使用1张护送券开始护送？"), startFunc, nil, "确定", "取消")
		else
			if self.escortInfo.supEscortCount <= 0 then
				FloatWordMgr.instance:show("免费次数不足！")

				return
			end

			self:close()
			ConvoyAgent.instance:sendPM_ConvoyOneKeyFinishReq(false)
		end
	else
		TipsFacade.instance:openPopupWindow("提示", "您还不是金钻特权用户，是否前往购买？", function()
			self:close()
			PayShopController.instance:openView(GameEnum.PayShopEasyJump.GoldenDiamondCard)
		end, nil, "确定", "取消")
	end
end

function EscortGoodsView:OnClickKshsClickBtn()
	if not EscortModel.instance:IsOpenEscortView() and not EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送活动未开始！")

		return
	end

	local npcInfo = EscortModel.instance:GetEscortNpcInfo()

	if npcInfo == nil then
		error("sr_护送  EscortGoodsView:OnClickKshsClickBtn()     获取npc信息空！")

		return
	end

	local num = EscortModel.instance:GetNumByEscortNpcId(npcInfo.npcId)

	local function startFunc()
		local goodsType, goodsId = EscortModel.instance:GetHusongJuanInfo()
		local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
		local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)

		if info then
			if not info.num then
				local count = 0

				if count <= 0 then
					FloatWordMgr.instance:show(string.format("%s不足！", cfg.name))
				else
					self:close()

					if num == 1 then
						EscortController.instance:CSAcceptConvoyReq(true)
						EscortModel.instance:OnTalkFinishToNPC(npcInfo.npcId)
					else
						EscortModel.instance:StartFindGotoNPC()
					end
				end
			end
		end
	end

	local function sureFunc()
		if self.useJuanTog.isOn then
			TipsFacade.instance:openPopupWindow("提示", "是否使用1张护送券开始护送？", startFunc, nil, "确定", "取消")
		else
			if self.escortInfo.supEscortCount <= 0 then
				FloatWordMgr.instance:show("免费次数不足！")

				return
			end

			self:close()

			if num == 1 then
				EscortController.instance:CSAcceptConvoyReq(false)
				EscortModel.instance:OnTalkFinishToNPC(npcInfo.npcId)
			else
				EscortModel.instance:StartFindGotoNPC()
			end
		end
	end

	if self.escortInfo.curGoodsId < self.allWuziCount then
		TipsFacade.instance:openPopupWindow("提示", "当前货箱还未达到钻石品质，确定不再刷新要开始护送了吗？", sureFunc, nil, "确定", "取消")

		return
	end

	sureFunc()
end

function EscortGoodsView:OnClickupgradeBtn()
	if not self:PreventTooFastClick() then
		return
	end

	if self.eff then
		UIEffectManager.instance:stopEffect(self.eff)

		self.eff = nil
	end

	if not EscortModel.instance:IsOpenEscortView() and not EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送活动未开始！")

		return
	end

	if self.escortInfo.curGoodsId >= self.allWuziCount then
		FloatWordMgr.instance:show("已是最高品质箱！")

		return
	end

	local supCount = self.escortInfo.freeUpdataCount - self.escortInfo.useUpdataCount

	if supCount <= 0 then
		local needInfo = EscortConfig.instance:GetBoxUpdataInfo(self.escortInfo.useUpdataCount + 1)

		if needInfo then
			local goodsType = tonumber(needInfo[1])
			local goodsId = tonumber(needInfo[2])

			if goodsType == MatType.Diamond_Consume then
				goodsType = 104
				goodsId = 2
			end

			local info = MaterialModel.instance:getMaterialMo(goodsType, goodsId)
			local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

			if cfg then
				if not cfg.name then
					local nameStr = ""

					if info then
						if not info.num then
							local have = 0
							local need = needInfo[3] and tonumber(needInfo[3]) or 100
							local str = string.format("升级货箱需要消耗%s%s，是否升级？", need, nameStr)

							local function clickFunc()
								if need > have then
									FloatWordMgr.instance:show(string.format("升级货箱所需%s不足！", nameStr))

									return
								end

								EscortController.instance:CSConvoyUpgradeBoxReq(self.escortInfo.useUpdataCount)
							end

							if goodsType == MatType.Diamond then
								local timeStr = UnityEngine.PlayerPrefs.GetString("EscortGoodsUpgrade")
								local now = ServerTime.nowDateServerLook()
								local formatStr = string.format("%sY%sM%sD", now.year, now.month, now.day)

								if timeStr == formatStr then
									clickFunc()
								else
									TipsFacade.instance:openPopupCostDiamondView(need, str, clickFunc, function(isCancel)
										if not isCancel then
											UnityEngine.PlayerPrefs.SetString("EscortGoodsUpgrade", formatStr)
										end
									end)
								end
							else
								clickFunc()
							end

							return
						end
					end
				end
			end
		end
	end

	EscortController.instance:CSConvoyUpgradeBoxReq(self.escortInfo.useUpdataCount)
end

function EscortGoodsView:PreventTooFastClick()
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < self.coolTimer then
			return
		end

		self.clickTimer = now
	end

	return true
end

function EscortGoodsView:UpdataEscortPoint(viewName, isShow)
	if viewName == "escortgoods" or viewName == "all" then
		self.redPointGo:SetActive(isShow)
	end
end

return EscortGoodsView
