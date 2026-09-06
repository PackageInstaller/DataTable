-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonpopView.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonpopView", package.seeall)

local KingspacedragonpopView = class("KingspacedragonpopView", ViewComponent)

function KingspacedragonpopView:ctor()
	KingspacedragonpopView.super.ctor(self)
end

function KingspacedragonpopView:unbindEvents()
	KingspacedragonpopView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function KingspacedragonpopView:bindEvents()
	KingspacedragonpopView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function KingspacedragonpopView:buildUI()
	KingspacedragonpopView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self.title = self:getTxt("title/txtTitle")
	self.level = self:getTxt("desc/txtLevel")
end

function KingspacedragonpopView:onExit()
	KingspacedragonpopView.super.onExit(self)
	self._tableview:dispose()
end

function KingspacedragonpopView:onEnter()
	KingspacedragonpopView.super.onEnter(self)

	local params = self:getOpenParam()

	self.activityId = params[1]
	self._curStageId = KingspacedragonModel.instance:getPassedStageId(self.activityId)
	self._stageCfgs = KingspacedragonConfig.instance:getStageCfgs(self.activityId)

	local maxStage = math.min(self._curStageId, #self._stageCfgs)

	self.level.text = string.format("当前关卡：%d/%d", maxStage, #self._stageCfgs)

	self:_onRefreshUI()
end

function KingspacedragonpopView:_onRefreshUI()
	self._tableview:reloadData(self._stageCfgs)
	self._tableview:refresh()
end

function KingspacedragonpopView:_updateCell(view, cell, data)
	local index = data.stageId
	local showName = "第%d层"
	local haveGet = self._curStageId >= data.stageId
	local getObj = goutil.findChild(cell, "receive")

	goutil.findChildTextComponent(cell, "txtDay").text = string.format(showName, index)

	getObj:SetActive(haveGet)

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

function KingspacedragonpopView:_clearTableview(cell)
	local transform = goutil.findChild(cell, "reward").transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end
end

return KingspacedragonpopView
