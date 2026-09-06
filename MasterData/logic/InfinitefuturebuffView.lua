-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefuturebuffView.lua

module("logic.extensions.infinitefuture.view.InfinitefuturebuffView", package.seeall)

local InfinitefuturebuffView = class("InfinitefuturebuffView", ViewComponent)

function InfinitefuturebuffView:ctor()
	InfinitefuturebuffView.super.ctor(self)
end

function InfinitefuturebuffView:unbindEvents()
	InfinitefuturebuffView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._selectBtn:RemoveClickListener()
end

function InfinitefuturebuffView:bindEvents()
	InfinitefuturebuffView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "fireDimensionDragonChapter_buff")
	end, self)
	self._selectBtn:AddClickListener(self._clickSelect, self)
end

function InfinitefuturebuffView:buildUI()
	InfinitefuturebuffView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._scrollObj = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._tipBtn = self:getBtn("btnTip")
	self._selectBtn = self:getBtn("btnChange")
	self._btnText = self:getTxt("btnChange/Text")
	self._skillCell = self:getGo("skill")
end

function InfinitefuturebuffView:onExit()
	InfinitefuturebuffView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._setSkillCell, self)
end

function InfinitefuturebuffView:onEnter()
	InfinitefuturebuffView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._setSkillCell, self)

	self.activityId = self:getFirstParam()
	self.cfgs = InfinitefutureConfig.instance:getOpenBuffCfgs(self.activityId, InfinitefutureModel.instance.curStageId)

	self:_onRefreshUI(InfinitefutureModel.instance.curBuffId)
	self:_setSkillCell()
	InfinitefutureModel.instance:setBuffNew(self.activityId)
end

function InfinitefuturebuffView:_onRefreshUI(selectId)
	self.selectBuffId = selectId

	self._tableview:reloadData(self.cfgs)
	self._tableview:refresh()
end

function InfinitefuturebuffView:_clickSelect()
	if InfinitefutureModel.instance.curBuffId == self.selectBuffId then
		return
	end

	local function okFunc()
		InfinitefutureController.instance:sendSelectBuffReq(self.activityId, self.selectBuffId)
		self:close()
	end

	if InfinitefutureModel.instance.curBuffId == 0 then
		okFunc()

		return
	end

	local tipsContent = "切换buff会导致本层内所有战斗均重置为待挑战状态，是否确认切换？"

	TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, okFunc)
end

function InfinitefuturebuffView:_updateCell(view, cell, data)
	local isOpen = InfinitefutureModel.instance.curStageId >= data.stageId
	local showName = string.format("第%d层解锁", data.stageId)
	local iconPath = GameUrl.getExpEventUrl(data.icon)
	local isSelect = self.selectBuffId == data.buffId
	local icon = goutil.findChild(cell, "skillIcon")
	local select = goutil.findChild(cell, "select")

	goutil.findChildTextComponent(cell, "txtName").text = tostring(data.name)
	goutil.findChildTextComponent(cell, "txtDesc").text = data.desc
	goutil.findChildTextComponent(cell, "tag/txt").text = showName

	goutil.findChild(cell, "tag"):SetActive(data.stageId > 1)
	select:SetActive(isSelect)
	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconPath)

	local btn = GameUtil.asBtn(cell)

	btn:AddClickListener(function()
		if not isOpen then
			return
		end

		if isSelect then
			return
		end

		self:_onRefreshUI(data.buffId)
	end, self)
end

function InfinitefuturebuffView:_setSkillCell()
	local isSelect = self.selectBuffId > 0
	local cell = self._skillCell

	cell:SetActive(isSelect)

	self._btnText.text = isSelect and "切换buff" or "确定"

	if not isSelect then
		return
	end

	local data = InfinitefutureConfig.instance:getSelectBuffCfg(self.activityId, self.selectBuffId)
	local iconPath = GameUrl.getExpEventUrl(data.icon)
	local icon = goutil.findChild(cell, "skillIcon")

	goutil.findChildTextComponent(cell, "txtName").text = tostring(data.name)
	goutil.findChildTextComponent(cell, "txtDesc").text = data.desc

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconPath)
end

function InfinitefuturebuffView:_clearTableview(cell)
	uGuiUtil.clearImage(goutil.findChild(cell, "skillIcon"))
	GameUtil.rmClickHandler(cell)
end

return InfinitefuturebuffView
