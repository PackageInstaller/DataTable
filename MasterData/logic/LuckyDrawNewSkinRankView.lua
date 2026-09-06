-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinRankView.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinRankView", package.seeall)

local LuckyDrawNewSkinRankView = class("LuckyDrawNewSkinRankView", ViewComponent)

function LuckyDrawNewSkinRankView:ctor()
	LuckyDrawNewSkinRankView.super.ctor(self)
end

function LuckyDrawNewSkinRankView:unbindEvents()
	LuckyDrawNewSkinRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function LuckyDrawNewSkinRankView:bindEvents()
	LuckyDrawNewSkinRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function LuckyDrawNewSkinRankView:buildUI()
	LuckyDrawNewSkinRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("Close")
	self._rankCell = self:getGo("right/rankCell")
	self._rankTable = self:getGo("right/rankListView")
	self._maRank = self:getTxt("right/myRank/txtMyRank")
	self._tipTxt = self:getTxt("right/myRank/txtTip")
	self._rankList = ScrollerList.create(self._rankTable, self._rankCell, GameUtil.handler(self._updateRankInfo, self), GameUtil.handler(self._clearItemCell, self))
end

function LuckyDrawNewSkinRankView:onEnter()
	LuckyDrawNewSkinRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SkinLotteryRankInfo, self._updateRank, self)

	self._activityId = tonumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = LuckyDrawNewSkinModel.instance:getActId()
	end

	SkinLotteryAgent.instance:sendPM_SkinLotteryRankReq(self._activityId)
	SkinLotteryAgent.instance:sendPM_SkinLotteryFreeChargeRankReq(self._activityId)
end

function LuckyDrawNewSkinRankView:onExit()
	LuckyDrawNewSkinRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SkinLotteryRankInfo, self._updateRank, self)
end

function LuckyDrawNewSkinRankView:_updateRank(activityId)
	if activityId == self._activityId then
		local info = LuckyDrawNewSkinModel.instance:getMoOrCreate(self._activityId):getRankInfo()

		self._maRank.text = info.myRank < 1 and "未上榜" or info.myRank

		self._rankList:reloadData(info.ranks)
	end
end

function LuckyDrawNewSkinRankView:_updateRankInfo(view, cell, data)
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
		printError("新皮肤抽奖战排行榜没有头像信息哦")
	end

	if data.rank ~= nil and checknumber(data.rank) <= 3 and checknumber(data.rank) > 0 then
		goutil.setActive(rankImg, true)
		rankImg:GetComponent("UIImageSpriteChange"):SetState(checknumber(data.rank) - 1)
	else
		goutil.setActive(rankImg, false)
	end

	rankTxt.text = data.rank
	areaTxt.text = data.areaName

	local time = GameUtil.time2date(checknumber(data.time / 1000))

	scoreTxt.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
end

function LuckyDrawNewSkinRankView:_clearItemCell()
	return
end

function LuckyDrawNewSkinRankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

return LuckyDrawNewSkinRankView
