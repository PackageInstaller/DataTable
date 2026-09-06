-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryCountView.lua

module("logic.extensions.lottery.view.LotteryCountView", package.seeall)

local LotteryCountView = class("LotteryCountView", TableViewComponent)

function LotteryCountView:ctor()
	LotteryCountView.super.ctor(self)

	self.rewardGoodsList = nil
end

function LotteryCountView:bindEvents()
	LotteryCountView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self._tableview:AddOnScrollValueChanged(self.OnCellUpdatePosition, self)
end

function LotteryCountView:unbindEvents()
	LotteryCountView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function LotteryCountView:destroyUI()
	LotteryCountView.super.destroyUI(self)

	local bgBig = self.viewBgIma.gameObject:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end

	for _, go in pairs(self.rewardGoodsList or {}) do
		if go then
			UnityEngine.GameObject.Destroy(go)
		end
	end

	self.rewardGoodsList = nil
	self.uiCamera = nil
end

function LotteryCountView:onExit()
	LotteryCountView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)

	for _, go in pairs(self.rewardGoodsList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	MaterialMgr.resetAll(self.spriteStageGo)

	self._curViewDatas = nil
end

function LotteryCountView:buildUI()
	LotteryCountView.super.buildUI(self)

	self.viewBgIma = self:getGo("viewBgIma"):GetComponent("Image")
	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self._timebg = self:getGo("timebg")
	self.supTimeTxt = self:getGo("supTimeTxt"):GetComponent("Text")
	self.countShowTxt = self:getGo("countShowTxt"):GetComponent("Text")
	self.supTimeTxt.text = ""
	self.countShowTxt.text = ""
	self.progBarGo = self:getGo("cellItemSR/Viewport/progBarGo/progBarSli")
	self.progBarSli = self.progBarGo:GetComponent("Slider")
	self.progBarSli.value = 0
end

function LotteryCountView:onEnter()
	LotteryCountView.super.onEnter(self)
	removetimer(self.CalculationSurplusTime, self)
	MaterialMgr.resetAll(self.spriteStageGo)

	local poolId = 0

	if self._viewPresentor._openParam and checknumber(self._viewPresentor._openParam[1]) > 0 then
		poolId = self._viewPresentor._openParam[1]
	end

	self.poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if self.poolCfg == nil then
		print("sr_召唤精灵    LotteryCountView:onEnter()  获取的池为空 poolId = ", poolId)

		return
	end

	local path = string.format("ui/bigbg/zhaohuan/%s", self.poolCfg.progBg)

	uGuiUtil.setSpriteToImage(self.viewBgIma.gameObject, uGuiUtil.SpriteType.BigBg, path, function()
		self.viewBgIma:SetNativeSize()
	end)

	local x, y = 0, 0

	if self.poolCfg.progPos then
		x = checknumber(self.poolCfg.progPos[1])
		y = checknumber(self.poolCfg.progPos[2])
	end

	Framework.TransformUtil.SetLocalPos(self.viewBgIma.gameObject.transform, x, y, 0)

	self.uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	self.rewardGoodsList = self.rewardGoodsList or {}

	local info = LotteryModel.instance:GetUseZhaohuanCount(self.poolCfg.poolId)

	if info then
		self.lotteryCount = info.useCount or 0
	end

	self._curViewDatas = LotteryConfig.instance:GetProgPrizeCfgs(self.poolCfg.poolId)
	self.countShowTxt.text = langPara("text_lottery_desc_14", self.lotteryCount)

	self._tableview:ReloadData()
	self:UpdateShowProgressBar()
	GameUtil.SetActive(self._timebg, false)

	self.supTimeTxt.text = ""

	if self.poolCfg.countdown then
		GameUtil.SetActive(self._timebg, true)

		local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(self.poolCfg)

		if not isOpen or endTime <= ServerTime.nowServerLook() then
			self.showTimeTxt.text = lang("text_lottery_desc_6")
		else
			self:CalculationSurplusTime()
		end
	end
end

function LotteryCountView:CalculationSurplusTime()
	local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(self.poolCfg)
	local supTime = isOpen and endTime - ServerTime.nowServerLook() or 0

	if supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

		self.supTimeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
	else
		self.supTimeTxt.text = lang("text_lottery_desc_6")

		if supTime < 0 then
			removetimer(self.CalculationSurplusTime, self)
			self:close()
		end
	end
end

function LotteryCountView:UpdateShowProgressBar()
	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 1

			GameUtil.setWidth(self.progBarGo, width)

			if count == 0 or self.lotteryCount <= 0 then
				self.progBarSli.value = 0

				return
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if self._curViewDatas[i] then
					if self._curViewDatas[i].times <= self.lotteryCount then
						value = value + once
					else
						local syc = 0

						if self._curViewDatas[i - 1] and self._curViewDatas[i - 1].times > 0 then
							syc = self._curViewDatas[i - 1].times
						end

						local temp = (self.lotteryCount - syc) * once / (self._curViewDatas[i].times - syc)

						value = value + temp

						break
					end
				end
			end

			self.progBarSli.value = value
		end
	end
end

function LotteryCountView:OnCellUpdatePosition(pos)
	local contentGo = self._tableview:GetContent()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 60

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self.progBarGo.transform, contentGo.transform.localPosition.x, -105, 0)
		end
	end
end

function LotteryCountView:_onReloadFinish()
	self:OnCellUpdatePosition()
end

function LotteryCountView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellItemSR"
	}
end

function LotteryCountView:_cellSize()
	return 120, 150
end

function LotteryCountView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local cellIconGo = goutil.findChild(cell, "cellIconGo")
	local cellCountTxt = goutil.findChildTextComponent(cell, "cellCountTxt")
	local cellStageIma = goutil.findChildComponent(cell, "cellStageIma", "UIChangeGroup")
	local lingquGo = goutil.findChild(cell, "lingquGo")

	MaterialMgr.resetAll(goodsGo)

	if not string.nilorempty(data.prize) then
		local goodsList = string.split(data.prize, ":")
		local matType = checknumber(goodsList[1])
		local proxy = MaterialMgr.setCell(matType, checknumber(goodsList[2]), goodsGo)

		proxy.binder:setNum(checknumber(goodsList[3]))

		if matType == MatType.Pet then
			proxy.binder:setLvl(checknumber(goodsList[4]))
		end
	end

	cellCountTxt.text = tostring(data.times)

	if self.lotteryCount >= data.times then
		cellStageIma:SetState(1)
		lingquGo:SetActive(true)
	else
		cellStageIma:SetState(0)
		lingquGo:SetActive(false)
	end

	if cell.data == #self._curViewDatas then
		Framework.TransformUtil.SetLocalPos(cellStageIma.gameObject.transform, 53.5, 45.6, 0)
	else
		Framework.TransformUtil.SetLocalPos(cellStageIma.gameObject.transform, 60, 45.6, 0)
	end
end

return LotteryCountView
