-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumelotterymainView.lua

module("logic.extensions.consumelottery.view.ConsumelotterymainView", package.seeall)

local ConsumelotterymainView = class("ConsumelotterymainView", ViewComponent)

function ConsumelotterymainView:ctor()
	ConsumelotterymainView.super.ctor(self)
end

function ConsumelotterymainView:buildUI()
	ConsumelotterymainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipBtn = self:getBtn("tipBtn")
	self._drawBtn = self:getBtn("drawBtn")
	self._cellGo = self:getGo("itemcon/cell")
	self._itemconGo = self:getGo("itemcon")
	self._norRewardGroup = ItemGroup.New(self._itemconGo, self._cellGo, nil, nil, true)
	self._bigrewardcon1Go = self:getGo("bigrewardcon1/mask/icon")
	self._bigrewardcon2Go = self:getGo("bigrewardcon2/mask/icon")
	self._bigrewardcon3Go = self:getGo("bigrewardcon3/mask/icon")
	self._bigrewardYhdGo1 = self:getGo("bigrewardcon1/yhd")
	self._bigrewardYhdGo2 = self:getGo("bigrewardcon2/yhd")
	self._bigrewardYhdGo3 = self:getGo("bigrewardcon3/yhd")
	self._rewardText3 = goutil.findChildTextComponent(self.mainGO, "bigrewardcon3/text")
	self._rewardText2 = goutil.findChildTextComponent(self.mainGO, "bigrewardcon2/text")
	self._rewardText1 = goutil.findChildTextComponent(self.mainGO, "bigrewardcon1/text")
	self._yinshiLeftText = goutil.findChildTextComponent(self.mainGO, "bigrewardcon1/leftText")
	self._imgJewelryGo = self:getGo("bigrewardcon1/imgJewelry")
	self._timeText = goutil.findChildTextComponent(self.mainGO, "timeText")
	self._numText = goutil.findChildTextComponent(self.mainGO, "numText")
	self._changeTicketText = goutil.findChildTextComponent(self.mainGO, "changeTicketText")
	self._drawBtnText = goutil.findChildTextComponent(self.mainGO, "drawBtn/text")
	self._imgNum = self:getGo("imgNum"):GetComponent(ComponentType.UIImgNumeralText)
end

function ConsumelotterymainView:bindEvents()
	ConsumelotterymainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._tipBtn:AddClickListener(self._onClicktipBtn, self)
	self._drawBtn:AddClickListener(self._onClickdrawBtn, self)
end

function ConsumelotterymainView:unbindEvents()
	ConsumelotterymainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._drawBtn:RemoveClickListener()
end

function ConsumelotterymainView:destroyUI()
	ConsumelotterymainView.super.destroyUI(self)
end

function ConsumelotterymainView:onEnter()
	ConsumelotterymainView.super.onEnter(self)

	self._actId = self:getFirstParam()

	GlobalDispatcher:addListener(ConsumelotteryController.PM_ConsumeLotteryGetInfoRes, self._PM_ConsumeLotteryGetInfoRes, self)
	GlobalDispatcher:addListener(ConsumelotteryController.PM_ConsumeLotteryDrawRes, self._PM_ConsumeLotteryDrawRes, self)
	ConsumelotteryModel.instance:setActId(self._actId)
	ConsumeLotteryAgent.instance:sendPM_ConsumeLotteryGetInfoReq(self._actId)
	self:_updateView()
end

function ConsumelotterymainView:onEnterFinished()
	ConsumelotterymainView.super.onEnterFinished(self)
end

function ConsumelotterymainView:onExit()
	ConsumelotterymainView.super.onExit(self)
	removetimer(self._updateActLeftTime, self)
	GlobalDispatcher:removeListener(ConsumelotteryController.PM_ConsumeLotteryGetInfoRes, self._PM_ConsumeLotteryGetInfoRes, self)
	GlobalDispatcher:removeListener(ConsumelotteryController.PM_ConsumeLotteryDrawRes, self._PM_ConsumeLotteryDrawRes, self)
	uGuiUtil.clearImage(self._bigrewardcon1Go)
	uGuiUtil.clearImage(self._bigrewardcon2Go)
	uGuiUtil.clearImage(self._bigrewardcon3Go)
	self._norRewardGroup:dispose(function(item)
		MaterialMgr.resetAll(item.mainGO)
	end)
end

function ConsumelotterymainView:onExitFinished()
	ConsumelotterymainView.super.onExitFinished(self)
end

function ConsumelotterymainView:_onClickcloseBtn()
	self:close()
end

function ConsumelotterymainView:_onClicktipBtn()
	TipsFacade.instance:openRulesView("consumelottery")
end

function ConsumelotterymainView:_onClickdrawBtn()
	local useFree = ConsumelotteryModel.instance:hasMonthDailyTicket()

	if not useFree and ConsumelotteryModel.instance:getLeftTicket() <= 0 then
		FloatWordMgr.instance:show("抽奖券不足")

		return
	end

	local curRound = ConsumelotteryModel.instance:getCurrRound(self._actId)

	UIStateManager.instance:push(ViewName.ConsumelotterydrawView, self._actId, useFree)
end

function ConsumelotterymainView:_updateView()
	self:_updateReward()
	self:_setLotteryData()
	self:_setActTime()
end

function ConsumelotterymainView:_updateReward()
	local cfg = ConsumelotteryConfig.instance:getActCfg(self._actId)
	local planCfgs = ConsumelotteryConfig.instance:getLotteryPrizeCfg(cfg.prizePlanId)
	local round = ConsumelotteryModel.instance:getCurrRound(self._actId)
	local list = planCfgs[round]

	if not list then
		return
	end

	local bigRewardList = {}
	local norRewardList = {}

	for i, v in ipairs(list) do
		if i <= 3 then
			table.insert(bigRewardList, v)
		else
			table.insert(norRewardList, v)
		end
	end

	self:_updataBigReward(bigRewardList)
	self:_updataNorReward(norRewardList)
end

function ConsumelotterymainView:_updataBigReward(list)
	self._yinshiLeftText.text = ""

	goutil.setActive(self._imgJewelryGo, false)

	for i = 1, 3 do
		local cfg = list[i]

		if cfg then
			local name = MaterialModel.instance:getMaterialsNameByStr(cfg.prize)
			local arr = string.split(cfg.prize, ":")
			local matType = checknumber(arr[1])
			local matId = checknumber(arr[2])

			self["_rewardText" .. i].text = name

			local bigIcon = self["_bigrewardcon" .. i .. "Go"]

			bigIcon.transform.sizeDelta = Vector2.New(cfg.size[1], cfg.size[2])

			if cfg.type == 1 then
				self._yinshiLeftText.text = "剩余：" .. ConsumelotteryModel.instance:getYInshiLeftNum()

				goutil.setActive(self._imgJewelryGo, true)
			elseif matType == MatType.Pet then
				uGuiUtil.setSpriteToImage(bigIcon, nil, GameUrl.getPetImgUrl(cfg.icon))
			else
				local cfg = MaterialMgr.getMatCfg(matType, matId)

				uGuiUtil.setSpriteToImage(bigIcon, nil, GameUrl.getItemIconUrl(cfg.icon))
			end

			local active = ConsumelotteryModel.instance:checkRewardIsGet(cfg.id)

			goutil.setActive(self["_bigrewardYhdGo" .. i], active)
		end
	end
end

function ConsumelotterymainView:_updataNorReward(list)
	self._norRewardGroup:updateWithMoArray(list, function(item, cfg)
		MaterialMgr.setCellByCfg(cfg.prize, item.mainGO)
	end)
end

function ConsumelotterymainView:_setLotteryData()
	local hitNum = ConsumelotteryConfig.instance:getMustHitNum(self._actId)
	local needLotteryTime = hitNum - ConsumelotteryModel.instance:getUseTicket() % hitNum

	self._imgNum:SetText(tostring(needLotteryTime))

	self._changeTicketText.text = string.format("每充值%s元可获得一张抽奖券，已激活月卡的奥奇，每天登陆可获得1次免费抽奖券", ConsumelotteryConfig.instance:getRecharMoneyToTicket(self._actId) * PayModel.RMB_UNIT)
	self._drawBtnText.text = ConsumelotteryModel.instance:hasMonthDailyTicket() and "免费" or "抽奖"
	self._numText.text = ConsumelotteryModel.instance:getLeftTicket()
end

function ConsumelotterymainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.ConsumeLottery, self._actId)
	local leftTime = etime - stime

	if leftTime > 0 then
		self._leftTime = leftTime

		settimer(1, self._updateActLeftTime, self, true)
		self:_updateActLeftTime()
	else
		removetimer(self._updateActLeftTime, self)

		self._timeText.text = "活动已结束"
	end
end

function ConsumelotterymainView:_updateActLeftTime()
	self._leftTime = self._leftTime - 1

	if self._leftTime <= 0 then
		removetimer(self._updateActLeftTime, self)

		self._timeText.text = "活动已结束"

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

	self._timeText.text = day > 0 and string.format("%s天%s时%s分", day, hour, min) or string.format("%s时%s分%s秒", hour, min, sec)
end

function ConsumelotterymainView:_PM_ConsumeLotteryGetInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function ConsumelotterymainView:_PM_ConsumeLotteryDrawRes(status)
	self:_updateView()
end

return ConsumelotterymainView
