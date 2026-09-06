-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestBuffPreView.lua

module("logic.extensions.magiccontest.view.MagicContestBuffPreView", package.seeall)

local MagicContestBuffPreView = class("MagicContestBuffPreView", ViewComponent)

function MagicContestBuffPreView:ctor()
	MagicContestBuffPreView.super.ctor(self)
end

function MagicContestBuffPreView:buildUI()
	MagicContestBuffPreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local buffScrCell = self:getGo("buffCol/scrCell")
	local buffScrView = self:getGo("buffCol/scrView")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function MagicContestBuffPreView:bindEvents()
	MagicContestBuffPreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MagicContestBuffPreView:unbindEvents()
	MagicContestBuffPreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicContestBuffPreView:onEnter()
	MagicContestBuffPreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self._myCampId = self._subMo:getCampId()

	self:_onUpdate()
end

function MagicContestBuffPreView:onExit()
	MagicContestBuffPreView.super.onExit(self)
	self:_onClearBuffCol()
end

function MagicContestBuffPreView:_onUpdate()
	self:_onUpdateBuffColUI()
end

function MagicContestBuffPreView:_onUpdateBuffColUI()
	local cfg = MagicSchoolConfig.instance:getBuffCfgsByCampId(self._activityId, self._myCampId) or {}

	self._buffScrollerList:reloadData(cfg)
end

function MagicContestBuffPreView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function MagicContestBuffPreView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "desc/viewport/content")

	txtName.text = data.name
	txtDesc.text = data.desc

	local iconUrl = string.format("ui/icon/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)
end

function MagicContestBuffPreView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
end

function MagicContestBuffPreView:_onClickClose()
	self:close()
end

return MagicContestBuffPreView
