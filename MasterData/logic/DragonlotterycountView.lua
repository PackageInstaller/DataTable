-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonlotterycountView.lua

module("logic.extensions.lottery.view.DragonDragonlotterycountView", package.seeall)

local DragonlotterycountView = class("DragonlotterycountView", TableViewComponent)

function DragonlotterycountView:ctor()
	DragonlotterycountView.super.ctor(self)

	self.rewardGoodsList = nil
end

function DragonlotterycountView:bindEvents()
	DragonlotterycountView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self._tableview:AddOnScrollValueChanged(self.OnCellUpdatePosition, self)
end

function DragonlotterycountView:unbindEvents()
	DragonlotterycountView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function DragonlotterycountView:destroyUI()
	DragonlotterycountView.super.destroyUI(self)

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
end

function DragonlotterycountView:onExit()
	DragonlotterycountView.super.onExit(self)

	for _, go in pairs(self.rewardGoodsList or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	self._curViewDatas = nil
end

function DragonlotterycountView:buildUI()
	DragonlotterycountView.super.buildUI(self)

	self.viewBgIma = self:getGo("viewBgIma"):GetComponent("Image")
	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.supTimeTxt = self:getGo("supTimeTxt"):GetComponent("Text")
	self.countShowTxt = self:getGo("countShowTxt"):GetComponent("Text")
	self.progBarGo = self:getGo("cellItemSR/Viewport/progBarGo/progBarSli")
	self.progBarSli = self.progBarGo:GetComponent("Slider")
	self.progBarSli.value = 0
end

function DragonlotterycountView:onEnter()
	DragonlotterycountView.super.onEnter(self)

	local cfgs, poolCfg = DragonModel.instance:getDragonProgressCfgs(self:getOpenParam()[2])

	self.lotteryCount = self:getOpenParam()[1]
	self.rewardGoodsList = self.rewardGoodsList or {}
	self._curViewDatas = cfgs
	self.countShowTxt.text = langPara("text_lottery_desc_14", self.lotteryCount)

	self._tableview:ReloadData()

	if not poolCfg.rewardViewBg then
		local bgName = "zhaohuan/zhaohuan_jindu_28"
		local path = string.format("ui/bigbg/%s.png", bgName)

		uGuiUtil.setSpriteToImage(self.viewBgIma.gameObject, uGuiUtil.SpriteType.BigBg, path, function()
			self.viewBgIma:SetNativeSize()
		end)
		self:UpdateShowProgressBar()
	end
end

function DragonlotterycountView:UpdateShowProgressBar()
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

function DragonlotterycountView:OnCellUpdatePosition(pos)
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

function DragonlotterycountView:_onReloadFinish()
	self:OnCellUpdatePosition()
end

function DragonlotterycountView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "cellItemSR"
	}
end

function DragonlotterycountView:_cellSize()
	return 120, 150
end

function DragonlotterycountView:_updateCell(view, cell, data)
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

return DragonlotterycountView
