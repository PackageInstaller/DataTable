-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiScoreRankView.lua

module("logic.extensions.lailisi.view.LailisiScoreRankView", package.seeall)

local LailisiScoreRankView = class("LailisiScoreRankView", ViewComponent)

function LailisiScoreRankView:ctor()
	LailisiScoreRankView.super.ctor(self)
end

function LailisiScoreRankView:unbindEvents()
	LailisiScoreRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function LailisiScoreRankView:bindEvents()
	LailisiScoreRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function LailisiScoreRankView:onExit()
	LailisiScoreRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiRank, self._updateRank, self)
end

function LailisiScoreRankView:buildUI()
	LailisiScoreRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("Close")
	self._rankCell = self:getGo("right/rankCell")
	self._rankTable = self:getGo("right/rankListView")
	self._maRank = self:getTxt("right/myRank/txtMyRank")
	self._tipTxt = self:getTxt("right/myRank/txtTip")
	self._empty = self:getGo("right/goEmpty")
	self._rankList = ScrollerList.create(self._rankTable, self._rankCell, GameUtil.handler(self._updateRankInfo, self), GameUtil.handler(self._clearItemCell, self))
end

function LailisiScoreRankView:onEnter()
	LailisiScoreRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.LailisiRank, self._updateRank, self)
	LailisiController.instance:sendPM_ActorGainDamageRankReq(self._activityId)

	self._tipTxt.text = LailisiConfig.instance:getCommonCfg("challenge_rank")
end

function LailisiScoreRankView:_updateRank()
	local info = LailisiModel.instance:getRankInfo()

	self._maRank.text = info.myRank < 1 and "未上榜" or info.myRank

	GameUtil.SetActive(self._empty, #info.rankList <= 0)
	self._rankList:reloadData(info.rankList)
end

function LailisiScoreRankView:_updateRankInfo(view, cell, data)
	if data == nil then
		return
	end

	local rankTxt = goutil.findChildTextComponent(cell, "txtRank")
	local rankImg = goutil.findChild(cell, "txtRank/imgRank")
	local go = goutil.findChild(cell, "imgIcon")
	local nameTxt = goutil.findChildTextComponent(cell, "txtName")
	local scoreTxt = goutil.findChildTextComponent(cell, "txtScore")
	local areaTxt = goutil.findChildTextComponent(cell, "txtArea")

	goutil.setActive(goutil.findChild(cell, "imgFamilyIcon"), false)
	goutil.clearChildren(go)

	if data.headInfo ~= nil then
		local proxy = HeadItemController.instance:setHeadCellByInfo(go, data.headInfo)

		if proxy then
			proxy:setCallBack(function()
				if data.headInfo.userId then
					self:onHeadClick(data.headInfo.userId, go)
				end
			end)
		end

		nameTxt.text = data.headInfo.userName
	else
		printError("莱丽丝挑战排行榜没有头像信息哦")
	end

	if data.rank ~= nil and checknumber(data.rank) <= 3 and checknumber(data.rank) > 0 then
		goutil.setActive(rankImg, true)
		rankImg:GetComponent("UIImageSpriteChange"):SetState(checknumber(data.rank) - 1)
	else
		goutil.setActive(rankImg, false)
	end

	rankTxt.text = data.rank
	scoreTxt.text = data.totalDamage
	areaTxt.text = data.areaName
end

function LailisiScoreRankView:_clearItemCell()
	return
end

function LailisiScoreRankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

return LailisiScoreRankView
