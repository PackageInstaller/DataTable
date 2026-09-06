-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgDailyBuffView.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgDailyBuffView", package.seeall)

local DivineMiyaClgDailyBuffView = class("DivineMiyaClgDailyBuffView", ViewComponent)

function DivineMiyaClgDailyBuffView:ctor()
	DivineMiyaClgDailyBuffView.super.ctor(self)
end

function DivineMiyaClgDailyBuffView:unbindEvents()
	DivineMiyaClgDailyBuffView.super.unbindEvents(self)
end

function DivineMiyaClgDailyBuffView:bindEvents()
	DivineMiyaClgDailyBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineMiyaClgDailyBuffView:buildUI()
	DivineMiyaClgDailyBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._tableList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = self:getTxt("txtTip")
end

function DivineMiyaClgDailyBuffView:onExit()
	DivineMiyaClgDailyBuffView.super.onExit(self)
end

function DivineMiyaClgDailyBuffView:onEnter()
	DivineMiyaClgDailyBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local activityCfg = DivineMiyaClgConfig.instance:getActivityCfg(self._activityId)

	self._txtTip.text = activityCfg.dailyBuffDesc

	local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId) or {}

	self._tableList:reloadData(cfgs)
end

function DivineMiyaClgDailyBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "imgEffect")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(go, "txtLv")

	txtDesc.text = data.des
	txtLevel.text = langPara("Lv.%d", data.buffLevel)

	if string.nilorempty(data.icon) then
		uGuiUtil.clearImage(iconGo)
	else
		uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getIconUrl(data.icon))
	end
end

function DivineMiyaClgDailyBuffView:_clearCell(cell)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "imgEffect")

	uGuiUtil.clearImage(iconGo)
end

return DivineMiyaClgDailyBuffView
