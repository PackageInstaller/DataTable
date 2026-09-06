-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgSkillBuffView.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgSkillBuffView", package.seeall)

local DivineMiyaClgSkillBuffView = class("DivineMiyaClgSkillBuffView", ViewComponent)

function DivineMiyaClgSkillBuffView:ctor()
	DivineMiyaClgSkillBuffView.super.ctor(self)
end

function DivineMiyaClgSkillBuffView:unbindEvents()
	DivineMiyaClgSkillBuffView.super.unbindEvents(self)
end

function DivineMiyaClgSkillBuffView:bindEvents()
	DivineMiyaClgSkillBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineMiyaClgSkillBuffView:buildUI()
	DivineMiyaClgSkillBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._tableList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = self:getTxt("txtTip")
end

function DivineMiyaClgSkillBuffView:onExit()
	DivineMiyaClgSkillBuffView.super.onExit(self)
end

function DivineMiyaClgSkillBuffView:onEnter()
	DivineMiyaClgSkillBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local activityCfg = DivineMiyaClgConfig.instance:getActivityCfg(self._activityId)

	self._txtTip.text = activityCfg.skillBuffDesc

	self._tableList:reloadData(DivineMiyaClgConfig.instance:getSkillBuffs(self._activityId))
end

function DivineMiyaClgSkillBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "imgEffect")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(go, "txtLv")

	txtDesc.text = data.buffDesc
	txtLevel.text = langPara("%d次", data.skillUsedCount)

	uGuiUtil.clearImage(iconGo)
	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.icon))
end

function DivineMiyaClgSkillBuffView:_clearCell(cell)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "imgEffect")

	uGuiUtil.clearImage(iconGo)
end

return DivineMiyaClgSkillBuffView
