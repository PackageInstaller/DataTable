-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/SevenSignView.lua

module("logic.extensions.sevendays.view.SevenSignView", package.seeall)

local SevenSignView = class("SevenSignView", ViewComponent)

function SevenSignView:ctor()
	SevenDaysView.super.ctor(self)

	self.allItemList = nil
	self.lotteryDayId = 0
	self.scoreEffList = nil
end

function SevenSignView:bindEvents()
	SevenDaysView.super.bindEvents(self)
	self.tipsClickBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "sevensign")
	end, self)
	self.spriteSkillBtn:AddClickListener(function()
		self:OnClickSkillExplainBtn(true)
	end, self)
	self.spriteInfoBtn:AddClickListener(self.OnClickSkillExplainBtn, self)
end

function SevenSignView:unbindEvents()
	SevenDaysView.super.unbindEvents(self)
	self.tipsClickBtn:RemoveClickListener()
	self.spriteSkillBtn:RemoveClickListener()
	self.spriteInfoBtn:RemoveClickListener()
end

function SevenSignView:buildUI()
	SevenSignView.super.buildUI(self)

	local libaoShowGo = self:getGo("libaoShowGo")

	self.libaoDesTxt2 = goutil.findChildTextComponent(libaoShowGo, "libaoDesTxt2")
	self.tipsClickBtn = Framework.ButtonAdapter.GetFrom(libaoShowGo, "tipsClickBtn")
	self.spriteNameTxt = goutil.findChildTextComponent(libaoShowGo, "imgNameBg/spriteNameTxt")
	self.spriteSkillBtn = Framework.ButtonAdapter.GetFrom(libaoShowGo, "spriteSkillBtn")
	self.spriteInfoBtn = Framework.ButtonAdapter.GetFrom(libaoShowGo, "spriteInfoBtn")
	self.spriteStarGo = goutil.findChild(libaoShowGo, "imgNameBg/spriteStarIma")

	local allItemTran = self:getGo("allItemTran").transform

	if self.allItemList == nil or #self.allItemList == 0 then
		self.allItemList = {}

		for i = 1, allItemTran.childCount do
			local go = allItemTran:GetChild(i - 1).gameObject
			local names = string.split(go.name, "_")

			self.allItemList[tonumber(names[2])] = {
				itemGo = go,
				itemGroup = go:GetComponent("UIChangeGroup"),
				daysTxt = goutil.findChildTextComponent(go, "daysTxt"),
				lockDesTxt = goutil.findChildTextComponent(go, "lockDesTxt"),
				receivedGo = goutil.findChild(go, "receivedGo"),
				redpointGo = goutil.findChild(go, "redpointGo"),
				clickBtnGo = goutil.findChild(go, "clickBtnGo")
			}
		end
	end
end

function SevenSignView:onExit()
	for _, eff in pairs(self.scoreEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.scoreEffList = nil
	self.lotteryDayId = 0

	GlobalDispatcher:removeListener("UpdataSevenSignInfo", self.InitAllItemInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self.ItemGetViewClosed, self)
	MaterialMgr.resetAll(self.spriteStarGo)
end

function SevenSignView:destroyUI()
	self.allItemList = nil
	self.scoreEffList = nil
end

function SevenSignView:onEnter()
	self.lotteryDayId = 0
	self.allGoodsList = SevenDaysModel.instance:GetActivitySignCfgs()

	self:InitAllItemInfo()
	self:InitShowSpriteInfo()
	GlobalDispatcher:addListener("UpdataSevenSignInfo", self.InitAllItemInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self.ItemGetViewClosed, self)
end

function SevenSignView:onEnterFinished()
	return
end

function SevenSignView:onExitFinished()
	return
end

function SevenSignView:ItemGetViewClosed()
	if checknumber(self.lotteryDayId) <= 0 then
		return
	end

	local count = 1

	if self.allGoodsList and self.allGoodsList[self.lotteryDayId] then
		count = self.allGoodsList[self.lotteryDayId].lotteryCount
	end

	TipsFacade.instance:openTipWindow("赠送提示", "恭喜你！获得【普通召唤】免费10连召唤\n仅当天有效！快前往使用吧！", function()
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(43)

		if not FuncOpenController.instance:getFuncIsOpenByCfg(cfg) then
			FloatWordMgr.instance:show(cfg.lockedTips)
		else
			LotteryModel.instance:GetLotteryPoolIdIndex(3, true)

			local parentView = self._viewPresentor.parentPresentor.viewName

			UIStateManager.instance:popByName(self._viewPresentor.viewName)
			UIStateManager.instance:popByName(parentView)
			UIStateManager.instance:push(ViewName.Lottery, 3)
		end
	end, "前往", UnityEngine.TextAnchor.MiddleCenter)

	self.lotteryDayId = 0
end

function SevenSignView:InitShowSpriteInfo()
	if self.allGoodsList == nil or #self.allGoodsList < #self.allItemList then
		print("sr_SevenSignView:InitShowSpriteInfo()      七日签到配置错误！！！")

		return
	end

	local cfg = self.allGoodsList[#self.allItemList]

	if cfg == nil or cfg.goodsInfo == nil or #cfg.goodsInfo < 2 then
		print("sr_SevenSignView:InitShowSpriteInfo()      七日签到最后一个奖励物品配置错误！！！")

		return
	end

	local petCfg = MaterialMgr.getMatCfg(checknumber(cfg.goodsInfo[1]), checknumber(cfg.goodsInfo[2]))

	if petCfg == nil then
		print("sr_SevenSignView:InitShowSpriteInfo()      七日签到精灵配置错误 = ", cfg.goodsInfo[1], cfg.goodsInfo[2])

		return
	end

	self.libaoDesTxt2.text = string.format("签到7天，领走【%s】", petCfg.name)
	self.spriteNameTxt.text = petCfg.name

	local proxy = MaterialMgr.setCell(MatType.Rare, cfg.goodsInfo[2], self.spriteStarGo)

	proxy.binder:setRare(CharacterConfig.instance:getInitRare(cfg.goodsInfo[2]))
end

function SevenSignView:OnClickSkillExplainBtn(isSkill)
	SevenDaysModel.instance.openBonusName = ViewName.SevenSign

	if self.allGoodsList == nil or #self.allGoodsList < #self.allItemList then
		print("sr_SevenSignView:OnClickSkillExplainBtn()      七日签到配置错误！！！")

		return
	end

	local cfg = self.allGoodsList[#self.allItemList]

	if cfg == nil or cfg.goodsInfo == nil or #cfg.goodsInfo < 2 then
		print("sr_SevenSignView:OnClickSkillExplainBtn()      七日签到最后一个奖励物品配置错误！！！")

		return
	end

	if isSkill then
		BattleFacade.instance:sendPreviewPetBattle(checknumber(cfg.goodsInfo[2]))
	else
		PetbookController.instance:openPetinfoView(checknumber(cfg.goodsInfo[2]))
	end
end

function SevenSignView:InitAllItemInfo(dayId)
	self.lotteryDayId = dayId or 0

	if checknumber(dayId) > 0 then
		local cfg = self.allGoodsList[dayId]

		if cfg == nil or cfg.goodsInfo == nil then
			self:ItemGetViewClosed()
		end
	end

	self.sevenSignInfo = SevenDaysModel.instance:GetSevenSignInfo()

	if self.allGoodsList then
		if not #self.allGoodsList then
			local count = 0

			if count ~= #self.allItemList then
				return
			end

			self.scoreEffList = self.scoreEffList or {}

			for i = 1, count do
				local num = i

				MaterialMgr.resetAll(self.allItemList[num].itemGo)
				GameUtil.asBtn(self.allItemList[num].clickBtnGo):RemoveClickListener()

				self.allItemList[num].daysTxt.text = tostring(num)

				if self.sevenSignInfo.prizedDays[num + 1] then
					if self.scoreEffList[num] then
						UIEffectManager.instance:stopEffect(self.scoreEffList[num])

						self.scoreEffList[num] = nil
					end

					self.allItemList[num].itemGroup:SetState(1)

					self.allItemList[num].lockDesTxt.text = ""

					self.allItemList[num].receivedGo:SetActive(true)
					self.allItemList[num].redpointGo:SetActive(false)
					self.allItemList[num].clickBtnGo:SetActive(false)
				else
					self.allItemList[num].itemGroup:SetState(0)
					self.allItemList[num].receivedGo:SetActive(false)

					if num <= self.sevenSignInfo.loginDays then
						self.allItemList[num].clickBtnGo:SetActive(true)
						self.allItemList[num].redpointGo:SetActive(true)

						self.allItemList[num].lockDesTxt.text = "可领取"

						if self.scoreEffList[num] == nil then
							local effPath = "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"

							self.scoreEffList[num] = UIEffectManager.instance:playEffect(self, effPath, self.allItemList[num].itemGo, 0, 0, true, nil, nil, nil, self)

							self.scoreEffList[num]:setParent(self.allItemList[num].itemGo.transform)
							self.scoreEffList[num]:setLocalPos(-0.8, 4.5, 0)

							if num == count then
								self.scoreEffList[num]:setScaleXYZ(1.1, 1.3, 1)
							else
								self.scoreEffList[num]:setScaleXYZ(0.93, 1, 1)
							end
						end

						GameUtil.asBtn(self.allItemList[num].clickBtnGo):AddClickListener(function()
							SevenDaysController.instance:CSRequestSignInGainPrize(num)
						end, self)
					else
						self.allItemList[num].clickBtnGo:SetActive(false)
						self.allItemList[num].redpointGo:SetActive(false)

						self.allItemList[num].lockDesTxt.text = "待领取"
					end
				end

				local cfg = self.allGoodsList[num]

				if cfg.goodsInfo and #cfg.goodsInfo > 2 then
					local matType = checknumber(cfg.goodsInfo[1])
					local matId = checknumber(cfg.goodsInfo[2])
					local matCount = checknumber(cfg.goodsInfo[3])
					local hwLua = MaterialMgr.setCell(matType, matId, self.allItemList[num].itemGo)

					GameUtil.setLocalScale(hwLua.view, 0.9, 0.9, 0.9)

					if num == count then
						Framework.TransformUtil.SetLocalPos(hwLua.view.transform, 0, 8, 0)
					else
						Framework.TransformUtil.SetLocalPos(hwLua.view.transform, 0, -15, 0)
					end

					hwLua.binder:setNum(matCount)

					if matType == MatType.Pet then
						hwLua.binder:setLvl(1)
					end

					if self.sevenSignInfo.prizedDays[num + 1] then
						hwLua.binder:setGray(true)
					end
				end
			end
		end
	end
end

function SevenSignView:CalculationSurplusTime()
	if not ViewMgr.instance:isOpen(ViewName.SevenDays) then
		return
	end

	local daysNum = SevenDaysController.instance:GetRegisteredTimeDay(true)
	local now = ServerTime.nowDateServerLook()
	local days = SevenDaysModel.instance.sevenDays - daysNum

	if days < 0 or self.spriteTimeTxt == nil then
		self:close()
		TipsFacade.instance:openTipWindow("活动提示", "当前活动已结束！", nil, "确定")

		return
	end

	local refreshTime = ClockMgr.instance._refreshTime
	local hour = refreshTime - now.hour
	local min = 0

	if refreshTime <= now.hour then
		hour = hour + 24
	end

	if now.min > 0 then
		hour = hour - 1
		min = 60 - now.min
	end

	if days > 0 then
		if min > 0 then
			hour = hour + 1
		end

		self.spriteTimeTxt.text = string.format("%s天%s小时", days, hour)
	elseif hour == 24 then
		self.spriteTimeTxt.text = "即将结束"
	else
		if hour <= 0 and min < 1 then
			self:close()
			TipsFacade.instance:openTipWindow("活动提示", "当前活动已结束！", nil, "确定")

			return
		end

		self.spriteTimeTxt.text = string.format("%s小时%s分", hour, min)
	end

	settimer(1, self.CalculationSurplusTime, self, false)
end

return SevenSignView
