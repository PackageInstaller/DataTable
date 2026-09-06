-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhendescView.lua

module("logic.extensions.breakformation.view.PozhendescView", package.seeall)

local PozhendescView = class("PozhendescView", ViewComponent)

function PozhendescView:ctor()
	PozhendescView.super.ctor(self)
end

function PozhendescView:buildUI()
	PozhendescView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.txtTitle = self:getTxt("title/txt2")
end

function PozhendescView:bindEvents()
	PozhendescView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function PozhendescView:unbindEvents()
	PozhendescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function PozhendescView:destroyUI()
	PozhendescView.super.destroyUI(self)
end

function PozhendescView:onEnter()
	PozhendescView.super.onEnter(self)

	local periodId = BreakFormationModel.instance.periodId
	local cfg = BreakFormationConfig.instance:getTeamCfg(periodId)
	local scoreCfg = BreakFormationConfig.instance:getScoreCfg(cfg.scoreProcessor)
	local param = BreakFormationConfig.instance:getBreakParmCfg(cfg.scoreProcessor)

	if scoreCfg and param then
		self.txtTitle.text = param.desc

		local arr = {}

		for k, v in pairs(scoreCfg) do
			table.insert(arr, v)
		end

		ArraySort.sortOn(arr, "point", ArraySort.DESCENDING)

		for i = 1, 5 do
			local txt = self:getTxt("desc/cell" .. i .. "/txt1")
			local txt2 = self:getTxt("desc/cell" .. i .. "/txt2")

			txt.text = ""
			txt2.text = ""

			if arr[i] then
				txt.text = arr[i].desc
				txt2.text = arr[i].point
			end
		end
	end
end

function PozhendescView:onEnterFinished()
	PozhendescView.super.onEnterFinished(self)
end

function PozhendescView:onExit()
	PozhendescView.super.onExit(self)
end

function PozhendescView:onExitFinished()
	PozhendescView.super.onExitFinished(self)
end

return PozhendescView
