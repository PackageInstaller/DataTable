-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdibuffView.lua

module("logic.extensions.nvdi.view.NvdibuffView", package.seeall)

local NvdibuffView = class("NvdibuffView", ViewComponent)

function NvdibuffView:ctor()
	NvdibuffView.super.ctor(self)
end

function NvdibuffView:unbindEvents()
	NvdibuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NvdibuffView:bindEvents()
	NvdibuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NvdibuffView:buildUI()
	NvdibuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function NvdibuffView:onExit()
	NvdibuffView.super.onExit(self)
	self._scrollList:dispose()
end

function NvdibuffView:onEnter()
	NvdibuffView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshUI()
end

function NvdibuffView:_refreshUI()
	local info = NvdiChallengeModel.instance:getInfo(self._activityId) or {}
	local buffList = NvdiChallengeConfig.instance:getBuffCfgList(self._activityId) or {}

	self.usingBuffMap = {}

	for i, v in ipairs(info.extremeClgStageInfo or {}) do
		self.usingBuffMap[v.buffIdUsed] = v.stageId
	end

	self._scrollList:reloadData(buffList)
end

function NvdibuffView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local notuse = goutil.findChild(cell, "notuse")
	local hasUse = goutil.findChild(cell, "hasUse")
	local txtStage = goutil.findChildTextComponent(cell, "hasUse/txtStage")
	local cfg = NvdiChallengeConfig.instance:getBuffCfgById(self._activityId, data.buffId) or {}

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))

	txtName.text = tostring(cfg.name)
	txtDesc.text = tostring(cfg.desc)

	local stageId = self.usingBuffMap[data.buffId]

	GameUtil.SetActive(hasUse, stageId ~= nil)
	GameUtil.SetActive(notuse, stageId == nil)

	if stageId then
		local cfg = NvdiChallengeConfig.instance:getStageCfgById(self._activityId, stageId)

		txtStage.text = cfg.name
	end
end

function NvdibuffView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

return NvdibuffView
