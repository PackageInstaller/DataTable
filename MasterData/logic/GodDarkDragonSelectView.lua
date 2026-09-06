-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonSelectView.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonSelectView", package.seeall)

local GodDarkDragonSelectView = class("GodDarkDragonSelectView", ViewComponent)

function GodDarkDragonSelectView:ctor()
	GodDarkDragonSelectView.super.ctor(self)
end

function GodDarkDragonSelectView:unbindEvents()
	GodDarkDragonSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSelect)
end

function GodDarkDragonSelectView:bindEvents()
	GodDarkDragonSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSelect, self._onClickSure, self)
end

function GodDarkDragonSelectView:buildUI()
	GodDarkDragonSelectView.super.buildUI(self)

	self._btnSelect = self:getGo("btnSelect")
	self._btnClose = self:getGo("btnClose")
	self._myBuffTableView = self:getGo("myTableview")
	self._enemyBuffTableView = self:getGo("enemyTableview")
	self._buffCell = self:getGo("buffCell")
end

function GodDarkDragonSelectView:onExit()
	GodDarkDragonSelectView.super.onExit(self)
end

function GodDarkDragonSelectView:onEnter()
	GodDarkDragonSelectView.super.onEnter(self)

	self._myBuffTableList = ScrollerList.create(self._myBuffTableView, self._buffCell, GameUtil.handler(self._updateMyCell, self), GameUtil.handler(self._clearMyCell, self))
	self._enemyBuffTableList = ScrollerList.create(self._enemyBuffTableView, self._buffCell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))

	local params = self:getOpenParam()

	self._actId = params[1]
	self._stageId = params[2]
	self._myLimit = nil
	self._enemyLimit = nil

	self:_refreshView()
end

function GodDarkDragonSelectView:_refreshView()
	local myBuffMap = GodDarkDragonModel.instance:getMyBuffMap(self._actId)
	local emenyBuffMap = GodDarkDragonModel.instance:getEmenyBuffMap(self._actId)
	local myBuffList = table.values(myBuffMap)
	local myBuffList = {}

	for i, v in pairs(myBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			table.insert(myBuffList, v)
		end
	end

	table.sort(myBuffList, function(a, b)
		return b.limitNum < a.limitNum
	end)

	local emenyBuffList = {}

	for i, v in pairs(emenyBuffMap) do
		if v.num > 0 and v.limitNum > 0 and v.limitNum <= 9 then
			table.insert(emenyBuffList, v)
		end
	end

	table.sort(emenyBuffList, function(a, b)
		return a.limitNum < b.limitNum
	end)
	self._myBuffTableList:reloadData(myBuffList)
	self._enemyBuffTableList:reloadData(emenyBuffList)
end

function GodDarkDragonSelectView:_onClickSure()
	if self._myLimit and self._enemyLimit then
		local fmtMo = GodDarkDragonModel.instance:getMainFmtMo()

		fmtMo:initParams(self._actId, self._stageId, self._myLimit, self._enemyLimit)
		CustomFmtController.instance:showMissionView(fmtMo)
		self:close()
	else
		FloatWordMgr.instance:show(lang("请选择敌我祝福"))
	end
end

function GodDarkDragonSelectView:onClickMyBuff(limitNum)
	self._myLimit = limitNum

	self:_refreshView()
end

function GodDarkDragonSelectView:onClickEnemyBuff(limitNum)
	self._enemyLimit = limitNum

	self:_refreshView()
end

function GodDarkDragonSelectView:_updateMyCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtLimit = goutil.findChildTextComponent(go, "txtLimit")
	local btn = goutil.findChild(go, "btn")
	local selectGo = goutil.findChild(go, "selectGo")
	local icon = goutil.findChild(go, "buffCon")

	if data.type == 1 then
		uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getExpEventUrl("icon_xingyu_01"))
	else
		uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getExpEventUrl("icon_xingyu_02"))
	end

	GameUtil.SetActive(selectGo, data.limitNum == self._myLimit)
	GameUtil.addClickHandler(btn, function()
		self:onClickMyBuff(data.limitNum)
	end)

	txtDesc.text = langPara("我方上阵精灵%d只", data.limitNum)
	txtNum.text = data.num
	txtLimit.text = data.limitNum
end

function GodDarkDragonSelectView:_clearMyCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "buffCon")
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(icon)
end

function GodDarkDragonSelectView:_updateEnemyCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtLimit = goutil.findChildTextComponent(go, "txtLimit")
	local btn = goutil.findChild(go, "btn")
	local selectGo = goutil.findChild(go, "selectGo")
	local icon = goutil.findChild(go, "buffCon")

	if data.type == 1 then
		uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getExpEventUrl("icon_xingyu_01"))
	else
		uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getExpEventUrl("icon_xingyu_02"))
	end

	GameUtil.SetActive(selectGo, data.limitNum == self._enemyLimit)
	GameUtil.addClickHandler(btn, function()
		self:onClickEnemyBuff(data.limitNum)
	end)

	txtDesc.text = langPara("敌方上阵精灵%d只", data.limitNum)
	txtNum.text = data.num
	txtLimit.text = data.limitNum
end

function GodDarkDragonSelectView:_clearEnemyCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "buffCon")
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(icon)
end

return GodDarkDragonSelectView
