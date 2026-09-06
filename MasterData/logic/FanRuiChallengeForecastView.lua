-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeForecastView.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeForecastView", package.seeall)

local FanRuiChallengeForecastView = class("FanRuiChallengeForecastView", ViewComponent)

function FanRuiChallengeForecastView:ctor()
	FanRuiChallengeForecastView.super.ctor(self)
end

function FanRuiChallengeForecastView:buildUI()
	FanRuiChallengeForecastView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FanRuiChallengeForecastView:bindEvents()
	FanRuiChallengeForecastView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FanRuiChallengeForecastView:unbindEvents()
	FanRuiChallengeForecastView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FanRuiChallengeForecastView:onEnter()
	FanRuiChallengeForecastView.super.onEnter(self)

	self._creepsMasterId = self:getFirstParam()

	self:_updateList()
end

function FanRuiChallengeForecastView:onExit()
	FanRuiChallengeForecastView.super.onExit(self)
end

function FanRuiChallengeForecastView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtDesc.text = data.buffDesc

	MaterialMgr.setCell(MatType.Pet, data.raceId, con)
end

function FanRuiChallengeForecastView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function FanRuiChallengeForecastView:_updateList()
	local cfgCreeps = FanRuiChallengeConfig.instance:getCreepsCfgs(self._creepsMasterId)
	local list = {}

	for i, v in ipairs(cfgCreeps) do
		if not string.nilorempty(v.buffDesc) then
			table.insert(list, v)
		end
	end

	self._scrollList:reloadData(list)
end

return FanRuiChallengeForecastView
