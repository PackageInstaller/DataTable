-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhenglirewardView.lua

module("logic.extensions.chuangzhengli.view.ChuangzhenglirewardView", package.seeall)

local ChuangzhenglirewardView = class("ChuangzhenglirewardView", ViewComponent)

function ChuangzhenglirewardView:ctor()
	ChuangzhenglirewardView.super.ctor(self)
end

function ChuangzhenglirewardView:unbindEvents()
	ChuangzhenglirewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ChuangzhenglirewardView:bindEvents()
	ChuangzhenglirewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ChuangzhenglirewardView:buildUI()
	ChuangzhenglirewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self.title = self:getTxt("title/txtTitle")
	self.level = self:getTxt("desc/txtLevel")
end

function ChuangzhenglirewardView:onExit()
	ChuangzhenglirewardView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)
end

function ChuangzhenglirewardView:onEnter()
	ChuangzhenglirewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self._onRefreshUI, self)

	self._activityId = self:getFirstParam()
	self.title.text = "关卡奖励"
	self._info = ChuangzhengliModel.instance:getInfo(self._activityId)
	self._stageCfgs = ChuangzhengliConfig.instance:getStageCfgs(self._activityId)
	self.level.text = string.format("当前关卡：%d/%d", self._info.passStageId, #self._stageCfgs)

	self:_onRefreshUI()
end

function ChuangzhenglirewardView:_onRefreshUI()
	self._tableview:reloadData(self._stageCfgs)
	self._tableview:refresh()
end

function ChuangzhenglirewardView:_updateCell(view, cell, data)
	local haveGet = self._info.passStageId >= data.stageId
	local getObj = goutil.findChild(cell, "receive")

	goutil.findChildTextComponent(cell, "txtDay").text = string.format("第%d关", data.stageId)

	getObj:SetActive(haveGet)

	local awards = string.split(data.passPrize, "#")
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

function ChuangzhenglirewardView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnAchieve"))

	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

return ChuangzhenglirewardView
