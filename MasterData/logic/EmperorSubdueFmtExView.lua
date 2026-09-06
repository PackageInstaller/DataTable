-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueFmtExView.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueFmtExView", package.seeall)

local EmperorSubdueFmtExView = class("EmperorSubdueFmtExView", ViewComponent)

function EmperorSubdueFmtExView:ctor()
	EmperorSubdueFmtExView.super.ctor(self)
end

function EmperorSubdueFmtExView:unbindEvents()
	EmperorSubdueFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnChange)
end

function EmperorSubdueFmtExView:bindEvents()
	EmperorSubdueFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
end

function EmperorSubdueFmtExView:buildUI()
	EmperorSubdueFmtExView.super.buildUI(self)

	self._showCon = self:getGo("showCon")
	self._btnSure = self:getGo("showCon/btnSure")
	self._btnChange = self:getGo("btnChange")

	local goTablecell = self:getGo("showCon/tablecell")
	local goTableview = self:getGo("showCon/tableview")

	self._tableview = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function EmperorSubdueFmtExView:onExit()
	EmperorSubdueFmtExView.super.onExit(self)
	self._tableview:dispose()
end

function EmperorSubdueFmtExView:onEnter()
	EmperorSubdueFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._curSelectBuffId = self._customFmtMo.curSelectBuffId

	local activityId = self._customFmtMo.activityId

	self._curShowBuffCfgs = {}

	local cfgMap = {}
	local stageCfgs = EmperorSubdueConfig.instance:getStageCfgs(activityId) or {}

	for _, cfg in ipairs(stageCfgs) do
		local buffId = cfg.buffId
		local buffCfg = EmperorSubdueConfig.instance:getBuffCfgById(activityId, buffId)

		if buffCfg then
			cfgMap[buffId] = buffCfg
		end
	end

	for _, buffCfg in pairs(cfgMap) do
		table.insert(self._curShowBuffCfgs, buffCfg)
	end

	self:_onClickChange()
end

function EmperorSubdueFmtExView:_setBuffConShow(isShow)
	GameUtil.SetActive(self._showCon, isShow)
end

function EmperorSubdueFmtExView:_onClickSure()
	if self._curSelectBuffId == 0 then
		FloatWordMgr.instance:show("先选择Buff")

		return
	end

	self._customFmtMo.curSelectBuffId = self._curSelectBuffId

	self:_setBuffConShow(false)
end

function EmperorSubdueFmtExView:_onClickChange()
	self._tableview:reloadData(self._curShowBuffCfgs)
	self._tableview:setCenterMode(true)
	GameUtil.SetGray(self._btnSure, self._curSelectBuffId == 0)
	self:_setBuffConShow(true)
end

function EmperorSubdueFmtExView:_updateCell(view, cell, data)
	local go = cell.gameObject

	GameUtil.addClickHandler(go, function()
		self._curSelectBuffId = data.buffId or 1

		self:_onClickChange()
	end, self)

	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local select = goutil.findChild(go, "select")

	txtName.text = data.buffName or ""
	txtDesc.text = data.buffDesc or ""

	goutil.setActive(select, self._curSelectBuffId == data.buffId)

	local goBuffIcon = goutil.findChild(go, "buffIcon")
	local spriteName = GameUrl.getExpEventUrl(data.buffIcon)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
end

function EmperorSubdueFmtExView:_clearCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)

	local goBuffIcon = goutil.findChild(go, "buffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

return EmperorSubdueFmtExView
