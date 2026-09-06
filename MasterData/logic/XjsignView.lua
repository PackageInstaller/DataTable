-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjsignView.lua

module("logic.extensions.xingjiang.view.XjsignView", package.seeall)

local XjsignView = class("XjsignView", ViewComponent)

function XjsignView:ctor()
	XjsignView.super.ctor(self)
end

function XjsignView:unbindEvents()
	XjsignView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function XjsignView:bindEvents()
	XjsignView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function XjsignView:buildUI()
	XjsignView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self.level = self:getTxt("desc/txtLevel")
end

function XjsignView:onExit()
	XjsignView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)
end

function XjsignView:onEnter()
	XjsignView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)

	self.activityId = XingJiangModel.instance.curActId

	local params = self:getOpenParam()

	self.level.gameObject:SetActive(not self.isSign)

	self.level.text = string.format("当前关卡：%d/%d", XingJiangModel.instance.curStageId, XingJiangConfig.instance:getStageCount(self.activityId))

	self:_onRefreshUI()
end

function XjsignView:_onRefreshUI()
	local cfgs

	self._tableview:reloadData((XingJiangConfig.instance:getSignCfgs(self.activityId)))
	self._tableview:refresh()
end

function XjsignView:_updateCell(view, cell, data)
	if self.isSign then
		if not data.level then
			local index = data.stageId
			local showName = "第%d天"
			local todayIndex = XingJiangModel.instance.curDailySignId + 1
			local canGet = todayIndex == index and not XingJiangModel.instance.isSignToday
			local haveGet = index <= XingJiangModel.instance.curDailySignId
			local btnObj = goutil.findChild(cell, "btnAchieve")
			local getObj = goutil.findChild(cell, "receive")
			local btn = GameUtil.asBtn(btnObj)

			goutil.findChildTextComponent(cell, "txtDay").text = string.format(showName, index)

			getObj:SetActive(self.isSign and haveGet)
			btnObj:SetActive(self.isSign and canGet)
			btn:AddClickListener(function()
				XingJiangController.instance:sendSignInReq(self.activityId)
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

function XjsignView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnAchieve"))

	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

return XjsignView
