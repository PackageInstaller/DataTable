-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/view/YearcardSignInBuyView.lua

module("logic.extensions.yearcardsignin.view.YearcardSignInBuyView", package.seeall)

local YearcardSignInBuyView = class("YearcardSignInBuyView", ViewComponent)

function YearcardSignInBuyView:buildUI()
	YearcardSignInBuyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._slider = self:getSlider("progress/Slider")
	self._txtProgress = self:getTxt("progress/Text")
	self._cellList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("cellList/cell_" .. i)
		cell.btn = goutil.findChild(cell.go, "btnBuy")
		cell.txtTip = goutil.findChildTextComponent(cell.go, "txtTip")
		cell.txtPrice = goutil.findChildTextComponent(cell.btn, "txt")
		cell.itemPrice = goutil.findChild(cell.btn, "item")
		cell.txtNub = goutil.findChildTextComponent(cell.go, "txtNub")
		cell.tag = goutil.findChild(cell.go, "tag")
		cell.txtTag = goutil.findChildTextComponent(cell.tag, "Text")
		cell.showprice = goutil.findChild(cell.go, "showprice")
		cell.txtShowPrice = goutil.findChildTextComponent(cell.go, "showprice/Text")
		cell.imgChange = goutil.findChild(cell.go, "img"):GetComponent(ComponentType.UIImageSpriteChange)
		cell.info = nil
		self._cellList[i] = cell
	end

	self._goldBar = self:getGo("goldbar")
end

function YearcardSignInBuyView:bindEvents()
	YearcardSignInBuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._cellList[i].btn, GameUtil.handler(self._onClickBuyGift, self, i))
	end
end

function YearcardSignInBuyView:unbindEvents()
	YearcardSignInBuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._cellList[i].btn)
	end
end

function YearcardSignInBuyView:onEnter()
	YearcardSignInBuyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardSignInInfoUpdate, self._refreshView, self)

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	self._actId = YearCardModel.instance:getCurAnnuityId()

	self:_refreshView()
	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btnList)
end

function YearcardSignInBuyView:onExit()
	YearcardSignInBuyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardSignInInfoUpdate, self._refreshView, self)

	for i = 1, 3 do
		MaterialMgr.clearIcon(self._cellList[i].itemPrice)
	end
end

function YearcardSignInBuyView:_refreshView()
	for i = 1, 3 do
		local cell = self._cellList[i]

		cell.info = YearCardSignInModel.instance:getGiftInfo(i)

		if cell.info then
			if string.nilorempty(cell.info.cfg.showTag) then
				goutil.setActive(cell.tag, false)
			else
				goutil.setActive(cell.tag, true)

				cell.txtTag.text = lang(cell.info.cfg.showTag)
			end

			cell.txtNub.text = "X" .. cell.info.cfg.gainDays
			cell.txtTip.text = langPara("限购次数：<color=#20b376>%s</color>/%s", cell.info.hasBuyTime, cell.info.cfg.times)

			local showType, showId, showNum = MaterialMgr.getMatParams(cell.info.cfg.showCost)

			cell.txtShowPrice.text = langPara("原价：%s", checknumber(showNum))

			local costType, costId, costNum = MaterialMgr.getMatParams(cell.info.cfg.cost)

			GameUtil.SetActive(cell.showprice, checknumber(showNum) > 0 and checknumber(showNum) ~= costNum)

			local costName = MaterialMgr.getMaterialsName(costType, costId)

			cell.txtPrice.text = costNum

			MaterialMgr.setIcon(cell.itemPrice, costType, costId)

			local iconName = cell.info.cfg.iconName

			cell.imgChange:ChangeSprite(iconName)
		end
	end

	local totalProgress = table.nums(YearCardSignInConfig.instance:getPrizeCfgs(self._actId))
	local curProgress = math.min(YearCardSignInModel.instance.signInDays, totalProgress)

	self._isCurFullProgress = totalProgress <= curProgress

	self._slider:SetValue(curProgress / checknumber(totalProgress))

	self._txtProgress.text = langPara("我的签到天数：<color=#20b376>%s</color>/%s", curProgress, totalProgress)
end

function YearcardSignInBuyView:_onClickBuyGift(id)
	if self._isCurFullProgress then
		FloatWordMgr.instance:show(lang("签到进度已满"))

		return
	end

	local info = self._cellList[id].info

	if info then
		local cost = info.cfg.cost

		if info.hasBuyTime >= info.cfg.times then
			FloatWordMgr.instance:show(lang("次数已达到购买上限"))

			return
		end

		local dayGain = info.cfg.gainDays
		local matType, matId, num = MaterialMgr.getMatParams(cost)
		local costName = MaterialMgr.getMaterialsName(matType, matId)
		local content = langPara("确定花费%s%s购买%s天签到礼包吗？", num, costName, dayGain)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, num, content, function()
			YearCardSignInController.instance:sendBuyGiftReq(self._actId, id)
		end)
	end
end

return YearcardSignInBuyView
