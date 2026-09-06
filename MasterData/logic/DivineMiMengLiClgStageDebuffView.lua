-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageDebuffView.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageDebuffView", package.seeall)

local DivineMiMengLiClgStageDebuffView = class("DivineMiMengLiClgStageDebuffView", ViewComponent)

function DivineMiMengLiClgStageDebuffView:buildUI()
	DivineMiMengLiClgStageDebuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local buffScrView = goutil.findChild(self.mainGO, "scrView")
	local buffScrCell = goutil.findChild(self.mainGO, "scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function DivineMiMengLiClgStageDebuffView:bindEvents()
	DivineMiMengLiClgStageDebuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineMiMengLiClgStageDebuffView:unbindEvents()
	DivineMiMengLiClgStageDebuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineMiMengLiClgStageDebuffView:onEnter()
	DivineMiMengLiClgStageDebuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	self:_onUpdate()
end

function DivineMiMengLiClgStageDebuffView:onExit()
	DivineMiMengLiClgStageDebuffView.super.onExit(self)
	self._buffScrollerList:dispose()
end

function DivineMiMengLiClgStageDebuffView:_onUpdate()
	local cfg = DivineMiMengLiClgConfig.instance:getBuffCfg(self._activityId, self._stageId) or {}

	self._buffScrollerList:reloadData(cfg)
end

function DivineMiMengLiClgStageDebuffView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtCount.text = data.signBuffCount
	txtDesc.text = data.desc
end

function DivineMiMengLiClgStageDebuffView:_clearBuffCell(cell)
	return
end

return DivineMiMengLiClgStageDebuffView
