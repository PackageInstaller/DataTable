-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/DarkdragonsigninView.lua

module("logic.extensions.operationsignin.view.DarkdragonsigninView", package.seeall)

local DarkdragonsigninView = class("DarkdragonsigninView", ViewComponent)

function DarkdragonsigninView:buildUI()
	DarkdragonsigninView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._rolePoint = self:getGo("con")
	self._bubble = self:getGo("bubble")
	self._bubbleTxt = self:getTxt("bubble/txtDesc")
	self._timeText = self:getTxt("time/Text")
	self._view = ScrollerList.create(self:getGo("tableview"), self:getGo("cell"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DarkdragonsigninView:bindEvents()
	DarkdragonsigninView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function DarkdragonsigninView:unbindEvents()
	DarkdragonsigninView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function DarkdragonsigninView:onEnter()
	DarkdragonsigninView.super.onEnter(self)

	self._pet = PetPhotoShow.Get(self._rolePoint)

	self._pet:showPetEffect(10345, true, 4.1)

	self._cellProxy = {}
	self._cellEff = {}
	self._signInCfgs = OperationSignInConfig.instance:getSignInCfgList(18013)

	GlobalDispatcher:addListener(GlobalNotify.OperationSignIn, self._operationSignIn, self)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._itemGetFoClosed, self)

	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn, 18013)

	local startT, endT = os.date("*t", self._startTime), os.date("*t", self._endTime)

	self._timeText.text = string.format("活动时间:%d月%d日 %02d:%02d-%d月%d日 %02d:%02d", startT.month, startT.day, startT.hour, startT.min, endT.month, endT.day, endT.hour, endT.min)

	OperationSignInModel.instance:setActivityId(18013)
	OperationSignInController.instance:getInfo()
	goutil.setActive(self._bubble, false)
end

function DarkdragonsigninView:onExit()
	DarkdragonsigninView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OperationSignIn, self._operationSignIn, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._itemGetFoClosed, self)

	for k, v in pairs(self._cellEff) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function DarkdragonsigninView:onExitFinished()
	DarkdragonsigninView.super.onExitFinished(self)
	self._pet:clear()

	self._pet = nil
end

function DarkdragonsigninView:_operationSignIn()
	self._onlineDay = OperationSignInModel.instance:getOnlineDay()
	self._daysList = OperationSignInModel.instance:getDaysList()

	table.sort(self._signInCfgs, function(a, b)
		return a.day < b.day
	end)
	self._view:reloadData(self._signInCfgs)
end

function DarkdragonsigninView:_itemGetFoClosed()
	goutil.setActive(self._bubble, true)

	self._bubbleTxt.text = self._tempTxt

	UIEffectManager.instance:stopEffect(self._cellEff[self._tempCell])

	local gainBtn = goutil.findChild(self._tempCell.gameObject, "gainBtn")

	goutil.setActive(gainBtn, false)
	goutil.setActive(goutil.findChild(self._tempCell.gameObject, "received"), true)

	self._cellEff[self._tempCell] = nil
end

function DarkdragonsigninView:_updateCell(view, cell, data)
	local arr = string.split(data.reward, ":")
	local matType = checknumber(arr[1])
	local defineId = checknumber(arr[2])

	if self._cellProxy[cell] then
		self._cellProxy[cell].binder:setCfgData(MaterialMgr.getMatCfg(matType, defineId))
		self._cellProxy[cell].binder:setNum(0)

		goutil.findChildTextComponent(cell.gameObject, "txtNum").text = "x" .. checknumber(arr[3])
	else
		local proxy = MaterialMgr.setCellByCfg(data.reward, goutil.findChild(cell.gameObject, "item"))

		goutil.findChildTextComponent(cell.gameObject, "txtNum").text = "x" .. checknumber(arr[3])

		proxy.binder:setNum(0)

		self._cellProxy[cell] = proxy
	end

	goutil.findChildTextComponent(cell.gameObject, "txtDay").text = data.day

	goutil.setActive(goutil.findChild(cell.gameObject, "received"), self._daysList[data.day])

	local effectGo = goutil.findChild(cell.gameObject, "effect")

	if not self._daysList[data.day] and self._onlineDay >= data.day then
		self._cellEff[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_longzun/fx_ui_longzun_kuang.prefab", effectGo, 0, 0, true, nil, nil, function(loadedHandler, eff)
			eff:setParent(effectGo.transform)
			eff:setLocalPos()
			eff:setScale(0.7)
		end)
	end

	local gainBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "gainBtn")

	goutil.setActive(gainBtn.gameObject, not self._daysList[data.day] and self._onlineDay >= data.day)
	gainBtn:AddClickListener(function()
		self._tempTxt = data.dayText
		self._tempCell = cell

		OperationSignInController.instance:gainPrize(data.day, function(msg)
			MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
		end)
	end)
end

function DarkdragonsigninView:_clearCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "item"))
end

return DarkdragonsigninView
