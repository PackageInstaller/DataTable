-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefuturepopView.lua

module("logic.extensions.infinitefuture.view.InfinitefuturepopView", package.seeall)

local InfinitefuturepopView = class("InfinitefuturepopView", ViewComponent)

function InfinitefuturepopView:ctor()
	InfinitefuturepopView.super.ctor(self)
end

function InfinitefuturepopView:unbindEvents()
	InfinitefuturepopView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function InfinitefuturepopView:bindEvents()
	InfinitefuturepopView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function InfinitefuturepopView:buildUI()
	InfinitefuturepopView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableview:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self.title = self:getTxt("title/txtTitle")
	self.level = self:getTxt("desc/txtLevel")
end

function InfinitefuturepopView:onExit()
	InfinitefuturepopView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)
end

function InfinitefuturepopView:onEnter()
	InfinitefuturepopView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)

	local params = self:getOpenParam()

	self.isSign = params[1] == 1
	self.activityId = InfinitefutureModel.instance.curActId

	if checknumber(params[2]) then
		self.activityId = checknumber(params[2])
	end

	local title = params[3]

	self.title.text = title or self.isSign and "每日签到" or "未来奖励"

	self.level.gameObject:SetActive(not self.isSign)

	self.level.text = string.format("当前关卡：%d/%d", InfinitefutureModel.instance.curStageId, InfinitefutureConfig.instance:getStageCount(self.activityId))

	self:_onRefreshUI()
end

function InfinitefuturepopView:_onRefreshUI()
	local cfgs

	self._tableview:reloadData(self.isSign and InfinitefutureConfig.instance:getSignCfgs(self.activityId) or InfinitefutureConfig.instance:getStageCfgs(self.activityId))
	self._tableview:refresh()
end

function InfinitefuturepopView:_updateCell(view, cell, data)
	if self.isSign then
		if not data.level then
			local index = data.stageId
			local showName = self.isSign and "第%d天" or "第%d关"
			local todayIndex = InfinitefutureModel.instance.curDailySignId + 1
			local canGet = todayIndex == index and not InfinitefutureModel.instance.isSignToday
			local btnObj = goutil.findChild(cell, "btnAchieve")
			local getObj = goutil.findChild(cell, "receive")
			local btn = GameUtil.asBtn(btnObj)

			goutil.findChildTextComponent(cell, "txtDay").text = string.format(showName, index)

			self:checkHaveGet(getObj, index)
			btnObj:SetActive(self.isSign and canGet)
			btn:AddClickListener(function()
				InfinitefutureController.instance:sendSignInReq(self.activityId)
			end, self)

			local awards = string.split(data.prize, "#")
			local itemNum = #awards
			local transform = goutil.findChild(cell, "reward").transform
			local childCount = transform.childCount

			while childCount < itemNum do
				UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

				childCount = childCount + 1
			end

			for i = 1, itemNum do
				local go = transform:GetChild(i - 1).gameObject

				MaterialMgr.resetAll(go)
				MaterialMgr.setCellByCfg(awards[i], go)
				go:SetActive(true)
			end

			for i = itemNum + 1, childCount do
				transform:GetChild(i - 1).gameObject:SetActive(false)
			end
		end
	end
end

function InfinitefuturepopView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnAchieve"))

	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

function InfinitefuturepopView:checkHaveGet(getObj, index)
	local haveGet = index <= InfinitefutureModel.instance.curDailySignId

	getObj:SetActive(self.isSign and haveGet)
end

function InfinitefuturepopView:_reloadFinish()
	return
end

return InfinitefuturepopView
