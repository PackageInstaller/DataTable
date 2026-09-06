-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgBuffView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgBuffView", package.seeall)

local DivinexjClgBuffView = class("DivinexjClgBuffView", ViewComponent)

function DivinexjClgBuffView:ctor()
	DivinexjClgBuffView.super.ctor(self)
end

function DivinexjClgBuffView:buildUI()
	DivinexjClgBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtDesc = self:getTxt("txtDesc")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function DivinexjClgBuffView:bindEvents()
	DivinexjClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivinexjClgBuffView:unbindEvents()
	DivinexjClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivinexjClgBuffView:onEnter()
	DivinexjClgBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgBuffList = DivineXingJiangClgConfig.instance:getBuffList(self._activityId)
	self._curProgress = DivineXingJiangClgModel.instance:getBuffProgress(self._activityId)
	self._curCfgBuff = self:_getCurCfg()

	self:_initProgress()
	self:_initBuffList()
end

function DivinexjClgBuffView:onExit()
	DivinexjClgBuffView.super.onExit(self)
	self._scrollList:dispose()
end

function DivinexjClgBuffView:_updateCell(view, cell, data, tag)
	local bgGo = goutil.findChild(cell, "bg")
	local selectGo = goutil.findChild(cell, "select")
	local tipGo = goutil.findChild(cell, "tip")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtTip = goutil.findChildTextComponent(cell, "tip/txt")

	txtName.text = data.name
	txtDesc.text = data.buffDesc
	txtTip.text = string.format("收集数%d解锁", data.progress)

	GameUtil.SetActive(bgGo, cell.index % 2 == 0)
	GameUtil.SetActive(selectGo, self._curCfgBuff == data)

	if self._curCfgBuff then
		GameUtil.SetActive(tipGo, self._curCfgBuff.progress < data.progress)
	else
		GameUtil.SetActive(tipGo, true)
	end
end

function DivinexjClgBuffView:clearCell(cell)
	return
end

function DivinexjClgBuffView:_getCurCfg()
	local count = #self._cfgBuffList

	for i = count, 1, -1 do
		if self._curProgress >= self._cfgBuffList[i].progress then
			return self._cfgBuffList[i]
		end
	end

	return nil
end

function DivinexjClgBuffView:_initProgress()
	local maxProgress = self._cfgBuffList[#self._cfgBuffList].progress

	self._txtDesc.text = string.format("当前星座收集数量：%d/%d", self._curProgress, maxProgress)
end

function DivinexjClgBuffView:_initBuffList()
	self._scrollList:reloadData(self._cfgBuffList)
end

return DivinexjClgBuffView
