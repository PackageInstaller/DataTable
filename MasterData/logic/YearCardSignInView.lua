-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/view/YearCardSignInView.lua

module("logic.extensions.yearcardsignin.view.YearCardSignInView", package.seeall)

local YearCardSignInView = class("YearCardSignInView", ViewComponent)

function YearCardSignInView:unbindEvents()
	YearCardSignInView.super.unbindEvents(self)
	self._btnOneKey:RemoveClickListener()
	self._btnForward:RemoveClickListener()
end

function YearCardSignInView:bindEvents()
	YearCardSignInView.super.bindEvents(self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnForward:AddClickListener(self._onClickForward, self)
end

function YearCardSignInView:buildUI()
	YearCardSignInView.super.buildUI(self)

	self._goCell = self:getGo("reward/cell")
	self._goTable = self:getGo("reward/tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("reward/txtTime")
	self._btnOneKey = self:getBtn("reward/btnOneKey")
	self._btnForward = self:getBtn("reward/btnForward")
	self._rectClip = goutil.findChild(self._goTable, "Viewport"):GetComponent(goutil.Type_RectTransform)
	self._effs = {}
end

function YearCardSignInView:onEnter()
	YearCardSignInView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YearCardSignInInfoUpdate, self._refreshView, self)

	self._actId = self:_getActId()
	self._curActive = YearCardModel.instance:isActiveAnnuity(self._actId)
	self._prizeCfgs = YearCardSignInConfig.instance:getPrizeCfgs(self._actId)

	self:_refreshView()

	if self._curActive then
		YearCardSignInController.instance:sendGetInfoReq(self._actId)
	end

	self._effs[self.mainGO] = UIEffectManager.instance:playEffect(self, "20211231/qiandao/fx_ui_qiandao.prefab", self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self.mainGO.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
end

function YearCardSignInView:onExit()
	YearCardSignInView.super.onExit(self)

	for _, v in pairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effs = {}
end

function YearCardSignInView:_getActId()
	return YearCardModel.instance:getCurAnnuityId()
end

function YearCardSignInView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	if data.isHasSignIn then
		goutil.setActive(cell.mark, true)
	end

	if data.isAbleToSignIn then
		GameUtil.addClickHandler(cell.btnSignIn, GameUtil.handler(self._onClickBtnSignIn, self, data))

		self._effs[goCell] = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.btnSignIn.transform, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(cell.btnSignIn.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, -8, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 0.74, 0.74, 0.74)
			eff:setClipping(self._rectClip)
		end)

		goutil.setActive(cell.btnSignIn, true)
	end

	cell.txtDay.text = data.id
end

function YearCardSignInView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(goCell, "item")
	cell.btnSignIn = goutil.findChild(goCell, "btnSignIn")
	cell.txtDay = goutil.findChildTextComponent(goCell, "txtday")
	cell.mark = goutil.findChild(goCell, "mark")

	goutil.setActive(cell.mark, false)
	GameUtil.rmClickHandler(cell.btnSignIn)
	goutil.setActive(cell.btnSignIn, false)
	MaterialMgr.resetAll(cell.item)

	if self._effs[goCell] then
		UIEffectManager.instance:stopEffect(self._effs[goCell])

		self._effs[goCell] = nil
	end

	return cell
end

function YearCardSignInView:_onClickBtnSignIn(data)
	if data.isAbleToSignIn then
		YearCardSignInController.instance:sendSignInReq(self._actId, data.id)
	end
end

function YearCardSignInView:_refreshView()
	local curDataList = {}

	for k, v in ipairs(self._prizeCfgs) do
		local data = {}

		data.prize = v.prize
		data.id = v.signInDay
		data.isHasSignIn = self._curActive and YearCardSignInModel.instance:isHasSignIn(data.id)
		data.isAbleToSignIn = self._curActive and YearCardSignInModel.instance.signInDays >= data.id and not data.isHasSignIn

		table.insert(curDataList, data)
	end

	self._tableView:reloadData(curDataList)

	if self._curActive then
		local timeEnd = YearCardSignInModel.instance.expirationTimes
		local startTime = timeEnd - 31449600

		self._txtTime.text = langPara("领取日期：%s-%s", GameUtil.formatTimeStamp("%Y.%m.%d 05:00", startTime), GameUtil.formatTimeStamp("%Y.%m.%d 05:00", timeEnd))
	else
		self._txtTime.text = "激活年费后开始计算领取日期"
	end
end

function YearCardSignInView:_onClickOneKey()
	if YearCardSignInModel.instance:isAbleToOneKey() then
		YearCardSignInController.instance:sendSignInOneKeyReq(self._actId)
	else
		FloatWordMgr.instance:show(lang("当前没有奖励可以领取噢"))
	end
end

function YearCardSignInView:_onClickForward()
	if self._curActive then
		UIStateManager.instance:push(ViewName.YearCardSignInBuyView)
	else
		FloatWordMgr.instance:show(lang("未激活该年费"))
	end
end

return YearCardSignInView
