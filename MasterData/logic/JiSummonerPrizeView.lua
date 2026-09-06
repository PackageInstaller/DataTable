-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerPrizeView.lua

module("logic.extensions.jisummoner.view.JiSummonerPrizeView", package.seeall)

local JiSummonerPrizeView = class("JiSummonerPrizeView", TableViewComponent)

function JiSummonerPrizeView:ctor()
	JiSummonerPrizeView.super.ctor(self)
end

function JiSummonerPrizeView:bindEvents()
	JiSummonerPrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tableview:AddOnScrollValueChanged(self._onCellUpdatePosition, self)
end

function JiSummonerPrizeView:unbindEvents()
	JiSummonerPrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function JiSummonerPrizeView:onExit()
	JiSummonerPrizeView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)

	self._curViewDatas = nil
	self._haveCount = nil
	self._supTime = nil
end

function JiSummonerPrizeView:destroyUI()
	JiSummonerPrizeView.super.destroyUI(self)

	local bgBig = self._viewBgGo.gameObject:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end
end

function JiSummonerPrizeView:buildUI()
	JiSummonerPrizeView.super.buildUI(self)

	self._viewBgGo = self:getGo("viewBgGo")
	self._closeBtn = self:getBtn("viewCloseBtn")
	self._timeBgGo = self:getGo("timeBgGo")
	self._timeTxt = goutil.findChildTextComponent(self._timeBgGo, "timeTxt")
	self._countShowTxt = self:getGo("countShowTxt"):GetComponent("Text")
	self._progBarGo = self:getGo("cellItemSR/Viewport/progBarGo/progBarSli")
	self._progBarSli = self._progBarGo:GetComponent("Slider")
	self._timeTxt.text = ""
	self._countShowTxt.text = ""
	self._progBarSli.value = 0
end

function JiSummonerPrizeView:onEnter()
	JiSummonerPrizeView.super.onEnter(self)
	removetimer(self._calculationSurplusTime, self)

	local params = self:getFirstParam()

	if params == nil or params.itemList == nil then
		printError("sr---JiSummonerPrizeView:onEnter()   请传入参数！")

		return
	end

	uGuiUtil.setSpriteToImage(self._viewBgGo, uGuiUtil.SpriteType.BigBg, (not string.nilorempty(params.bgPath) or nil) and params.bgPath, function()
		self._viewBgGo:GetComponent("Image"):SetNativeSize()
	end)

	self._haveCount = checknumber(params.progressCount)
	self._curViewDatas = params.itemList
	self._supTime = checknumber(params.showEndTime)

	self:_showProgressBar()
end

function JiSummonerPrizeView:_showProgressBar()
	self._countShowTxt.text = langPara("text_lottery_desc_14", self._haveCount)

	self._tableview:ReloadData()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 1

			GameUtil.setWidth(self._progBarGo, width)

			if count == 0 or self._haveCount <= 0 then
				self._progBarSli.value = 0

				return
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if self._curViewDatas[i] then
					if self._curViewDatas[i].times <= self._haveCount then
						value = value + once
					else
						local syc = 0

						if self._curViewDatas[i - 1] and self._curViewDatas[i - 1].times > 0 then
							syc = self._curViewDatas[i - 1].times
						end

						local temp = (self._haveCount - syc) * once / (self._curViewDatas[i].times - syc)

						value = value + temp

						break
					end
				end
			end

			self._progBarSli.value = value

			if self._supTime > 0 then
				settimer(1, self._calculationSurplusTime, self, true)
			else
				removetimer(self._calculationSurplusTime, self)
			end
		end
	end
end

function JiSummonerPrizeView:_calculationSurplusTime()
	self._supTime = self._supTime - ServerTime.now()

	if self._supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

		self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
	else
		self._timeTxt.text = lang("text_lottery_desc_6")

		if self._supTime < 0 then
			removetimer(self._calculationSurplusTime, self)
			self:close()
		end
	end
end

function JiSummonerPrizeView:_onCellUpdatePosition(pos)
	local contentGo = self._tableview:GetContent()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 60

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self._progBarGo.transform, contentGo.transform.localPosition.x, -105, 0)
		end
	end
end

function JiSummonerPrizeView:_onReloadFinish()
	self:_onCellUpdatePosition()
end

function JiSummonerPrizeView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellItemSR"
	}
end

function JiSummonerPrizeView:_cellSize()
	return 120, 150
end

function JiSummonerPrizeView:_updateCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local countTxt = goutil.findChildTextComponent(cell, "cellCountTxt")
	local stageIma = goutil.findChildComponent(cell, "cellStageIma", "UIChangeGroup")
	local lingquGo = goutil.findChild(cell, "lingquGo")

	MaterialMgr.resetAll(goodsGo)
	MaterialMgr.setCellByCfg(data.prize, goodsGo)

	countTxt.text = tostring(data.times)

	if self._haveCount >= data.times then
		stageIma:SetState(1)
		lingquGo:SetActive(true)
	else
		stageIma:SetState(0)
		lingquGo:SetActive(false)
	end

	if cell.data == #self._curViewDatas then
		Framework.TransformUtil.SetLocalPos(stageIma.gameObject.transform, 53.5, 45.6, 0)
	else
		Framework.TransformUtil.SetLocalPos(stageIma.gameObject.transform, 60, 45.6, 0)
	end
end

return JiSummonerPrizeView
