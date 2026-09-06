-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/FmtcertificationresultView.lua

module("logic.extensions.recommendfmt.view.FmtcertificationresultView", package.seeall)

local FmtcertificationresultView = class("FmtcertificationresultView", ViewComponent)

function FmtcertificationresultView:ctor()
	FmtcertificationresultView.super.ctor(self)
end

function FmtcertificationresultView:unbindEvents()
	FmtcertificationresultView.super.unbindEvents(self)
end

function FmtcertificationresultView:bindEvents()
	FmtcertificationresultView.super.bindEvents(self)
end

function FmtcertificationresultView:buildUI()
	FmtcertificationresultView.super.buildUI(self)

	self.lastZdl = self:getTxt("bg/power/value1")
	self.curZdl = self:getTxt("bg/power/value2")
	self.lastRank = self:getTxt("bg/rank/value1")
	self.curRank = self:getTxt("bg/rank/value2")
end

function FmtcertificationresultView:onExit()
	FmtcertificationresultView.super.onExit(self)
	removetimer(self.close, self)
end

function FmtcertificationresultView:onEnter()
	FmtcertificationresultView.super.onEnter(self)

	local params = self:getOpenParam()
	local lastZdl = checknumber(params[1])
	local lastRank = checknumber(params[2])
	local curRank = RecommendFmtModel.instance.myRank

	self.lastZdl.text = lastZdl
	self.curZdl.text = RecommendFmtModel.instance.curMaxZdl
	self.lastRank.text = self:getRankTxt(lastRank)
	self.curRank.text = self:getRankTxt(curRank)

	settimer(1, self.close, self)
end

function FmtcertificationresultView:getRankTxt(rank)
	if rank > 0 then
		return rank
	else
		return lang("world_Boss_tip9")
	end
end

return FmtcertificationresultView
