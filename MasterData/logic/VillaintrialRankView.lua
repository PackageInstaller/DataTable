-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialRankView.lua

module("logic.extensions.villaintrial.view.VillaintrialRankView", package.seeall)

local VillaintrialRankView = class("VillaintrialRankView", TableViewComponent)

function VillaintrialRankView:ctor()
	VillaintrialRankView.super.ctor(self)
end

function VillaintrialRankView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function VillaintrialRankView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function VillaintrialRankView:buildUI()
	VillaintrialRankView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._myRank = self:getTxt("right/myRank/txtMyRank")
	self._myTip = self:getTxt("right/myRank/txtTip")
	self._tabName = self:getTxt("tableview/Nego_Viewport/Nego_Content/tablecell/leafCell/txtName")
	self._goEmpty = self:getGo("right/goEmpty")
end

function VillaintrialRankView:destroyUI()
	return
end

function VillaintrialRankView:onEnter()
	VillaintrialRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.VillaintrialRank, self._updateRank, self)
	VillaintrialController.instance:sendPM_VillainPetTrialGetRankInfoReq()
	self:refreshRank()
end

function VillaintrialRankView:onEnterFinished()
	return
end

function VillaintrialRankView:onExit()
	VillaintrialRankView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	GlobalDispatcher:removeListener(GlobalNotify.VillaintrialRank, self._updateRank, self)
end

function VillaintrialRankView:onExitFinished()
	return
end

function VillaintrialRankView:refreshRank()
	local cfg = VillaintrialConfig.instance:getPlanIdInfo()

	self._myTip.text = cfg.des
	self._tabName.text = cfg.name
end

function VillaintrialRankView:_updateRank()
	local data = VillaintrialModel.instance:getVillaintrialRankInfo()

	if data.myRank ~= -1 and checknumber(data.myRank) > 0 then
		self._myRank.text = data.myRank or "未上榜"
	end

	self:updateListData(data.rankInfos)
	goutil.setActive(self._goEmpty, not self:isTableHaveValue(data.rankInfos))
end

function VillaintrialRankView:_getPath()
	return {
		cellPath = "right/rankCell",
		viewPath = "right/rankListView"
	}
end

function VillaintrialRankView:_cellSize()
	return 1084, 110
end

function VillaintrialRankView:_updateCell(view, cell, data)
	if data == nil then
		return
	end

	local rankTxt = goutil.findChildTextComponent(cell, "txtRank")
	local rankImg = goutil.findChild(cell, "txtRank/imgRank")
	local passTimeTxt = goutil.findChildTextComponent(cell, "passTime/txtPassTime")
	local go = goutil.findChild(cell, "imgIcon")
	local nameTxt = goutil.findChildTextComponent(cell, "txtName")
	local scoreTxt = goutil.findChildTextComponent(cell, "txtScore")
	local progressTxt = goutil.findChildTextComponent(cell, "txtProgress")
	local areaTxt = goutil.findChildTextComponent(cell, "txtArea")

	rankTxt.text = data.rank
	progressTxt.text = string.format("%s层", data.curStageId)
	scoreTxt.text = data.totalSocre or ""

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
		printError("反派精灵试炼排行榜没有头像信息哦")
	end

	if data.rank ~= nil and checknumber(data.rank) <= 3 and checknumber(data.rank) > 0 then
		goutil.setActive(rankImg, true)
		rankImg:GetComponent("UIImageSpriteChange"):SetState(checknumber(data.rank) - 1)
	else
		goutil.setActive(rankImg, false)
	end

	if checknumber(data.sumbitTimeSec) > 0 then
		local time = GameUtil.time2date(checknumber(data.sumbitTimeSec / 1000))

		passTimeTxt.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	else
		printError("反派精灵试炼排行榜上榜时间有问题哦")
	end
end

function VillaintrialRankView:_clearTableview(cell)
	local go = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(go)
end

function VillaintrialRankView:_onClickClose()
	self:close()
end

function VillaintrialRankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

function VillaintrialRankView:isTableHaveValue(list)
	if list and #list > 0 then
		return true
	end

	return false
end

return VillaintrialRankView
