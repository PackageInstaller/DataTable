-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardMainView.lua

module("logic.extensions.yearcard.view.YearCardMainView", package.seeall)

local YearCardMainView = class("YearCardMainView", TableViewComponent)

function YearCardMainView:ctor()
	YearCardMainView.super.ctor(self)
end

function YearCardMainView:buildUI()
	YearCardMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._curPage = self:getGo("curPage")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("txtTime")
	self._effectGo = self:getGo("effect")
end

function YearCardMainView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function YearCardMainView:bindEvents()
	YearCardMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function YearCardMainView:unbindEvents()
	YearCardMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function YearCardMainView:onEnter()
	YearCardMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityGainMonthPrize, self._onGainMonthPrize, self)
	YearCardController.instance:getUserAnnuityInfo()
	self:_resetCountdown()
	settimer(1, self._onSecond, self)
	self:_loadEffect()
end

function YearCardMainView:onEnterFinished()
	YearCardMainView.super.onEnterFinished(self)
	self:_openTipAutomatically()
end

function YearCardMainView:onExit()
	YearCardMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityGainMonthPrize, self._onGainMonthPrize, self)
	removetimer(self._onSecond, self)
	self:_removeEffect()
end

function YearCardMainView:_onClickClose()
	self:close()
end

function YearCardMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "yearcardRule")
end

function YearCardMainView:_onSecond()
	if self._isCountdown then
		self:_updateCountdown()
	end
end

function YearCardMainView:_updateCell(view, cell, data)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local imgPoint = goutil.findChild(cell, "imgPoint")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local colorChange = txtName.gameObject:GetComponent(typeof(UITextColorChange))
	local btnClick = Framework.ButtonAdapter.Get(cell.gameObject)
	local notice = goutil.findChild(cell, "notice")

	btnClick:RemoveClickListener()
	btnClick:AddClickListener(function()
		self:_selectPage(data.index)
	end)

	txtName.text = data.textName

	imgSelected:SetActive(data.isSelect)
	colorChange:SetState(data.isSelect and 1 or 0)

	txtName.fontSize = data.isSelect and 32 or 26

	if data.isSelect and self._isShowSubView then
		self:showTabAt(self._curPage, "")
		self:showTabAt(self._curPage, data.viewName, data.cfg, data.isCurMonth)
	end

	if data.viewName == ViewName.YearCardPerMonthView then
		imgPoint:SetActive(self:_isShowMonthPrizeRedPoint(data.cfg, data.isCurMonth))
	else
		imgPoint:SetActive(self:_isShowBeYearRedPoint())
	end

	notice:SetActive(data.isNotice)
end

function YearCardMainView:_clearTableview(cell)
	local btnClick = Framework.ButtonAdapter.Get(cell.gameObject)

	btnClick:RemoveClickListener()
end

function YearCardMainView:_initView()
	self._isShowSubView = true

	local showList = YearCardController.instance:getShowList(YearCardModel.instance:getCurAnnuityId())

	self:updateListData(showList)
end

function YearCardMainView:_selectPage(index)
	self._isShowSubView = true

	for i, v in ipairs(self._curViewDatas) do
		if v.isSelect and v.index == index then
			return
		end

		v.isSelect = v.index == index
	end

	self:reloadData()
end

function YearCardMainView:_openTipAutomatically()
	local isOpened = GameUtil.getUserData(ViewName.YearCardMainView)

	if not isOpened then
		GameUtil.saveUserData(ViewName.YearCardMainView, true)
		self:_onClickTip()
	end
end

function YearCardMainView:_refresh()
	self._curViewActId = 8001

	YearCardModel.instance:setCurAnnuityId(self._curViewActId)
	self:_initView()
	self:_initCountdown()
end

function YearCardMainView:_initCountdown()
	self._isCountdown = true

	local activityId = YearCardModel.instance:getCurAnnuityId()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FirstCharge, activityId)

	self._endTimestamp = endTimestamp
	self._realEndTimestamp = YearCardModel.instance:getEndTime(activityId)

	self:_updateCountdown()
end

function YearCardMainView:_resetCountdown()
	self._isCountdown = false
	self._txtTime.text = ""
	self._endTimestamp = nil
end

function YearCardMainView:_updateCountdown()
	local timestamp = YearCardModel.instance:isActiveAnnuity(YearCardModel.instance:getCurAnnuityId()) and self._realEndTimestamp or self._endTimestamp

	if timestamp and timestamp > 0 then
		local leftTime = timestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("距离次元龙离开剩余：%s", GameUtil.FormatTimeSymbol(leftTime))

		if leftTime == 0 then
			self._txtTime.text = ""
		end
	end
end

function YearCardMainView:_loadEffect()
	local path = "fx_ui_nianfeilong/fx_ui_nianfeilong.prefab"

	self._uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectGo.transform, 0, 0, true, false)

	self._uiEffect:setScale(1)
	self._uiEffect:setParent(self._effectGo.transform)
end

function YearCardMainView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function YearCardMainView:_isShowMonthPrizeRedPoint(cfg, isCurMonth)
	local activityId = YearCardModel.instance:getCurAnnuityId()
	local active = YearCardModel.instance:isActiveAnnuity(activityId)

	if isCurMonth and active and not YearCardModel.instance:getHasGainWeeklyPrize(activityId) then
		return true
	end

	local annuityInfo = YearCardModel.instance:getAnnuityInfo(activityId)

	if annuityInfo and annuityInfo.active then
		local isCanGet = YearCardController.instance:isCanGet(activityId, cfg)

		if cfg and isCanGet then
			if not YearCardModel.instance:getIsGainMonthPrize(activityId, cfg.prizeId) then
				return true
			else
				return false
			end
		end
	end

	return false
end

function YearCardMainView:_onGainMonthPrize()
	self._isShowSubView = false

	self:reloadData()
end

function YearCardMainView:_isShowBeYearRedPoint()
	local activityId = YearCardModel.instance:getCurAnnuityId()
	local data = YearCardModel.instance:getAnnuityInfo(activityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(activityId)

	if data and cfg and not data.active and data.money >= cfg.price then
		return true
	end

	if data and data.active and not YearCardModel.instance:getHasGainWeeklyPrize(activityId) then
		return true
	end

	return false
end

return YearCardMainView
