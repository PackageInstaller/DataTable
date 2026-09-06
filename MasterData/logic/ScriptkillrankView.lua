-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillrankView.lua

module("logic.extensions.scriptkill.view.ScriptkillrankView", package.seeall)

local ScriptkillrankView = class("ScriptkillrankView", ViewComponent)

function ScriptkillrankView:unbindEvents()
	ScriptkillrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose, self)
end

function ScriptkillrankView:bindEvents()
	ScriptkillrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function ScriptkillrankView:buildUI()
	ScriptkillrankView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.goEmpty = self:getGo("content/goEmpty")
	self.rankcell = self:getGo("content/rankcell")
	self.rankview = self:getGo("content/rankview")
	self._reward = self:getGo("reward")
	self.txtmyRank = self:getTxt("content/myRank/txtMyRank")
	self.txtTip = self:getTxt("content/myRank/txtTip")
	self.scrollList = ScrollerList.create(self.rankview, self.rankcell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ScriptkillrankView:onExit()
	ScriptkillrankView.super.onExit(self)
	self.scrollList:dispose()

	for i, v in pairs(self._scrollMap) do
		v:dispose()
	end

	self._scrollMap = nil
end

function ScriptkillrankView:onEnter()
	ScriptkillrankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._scrollMap = {}
	self._rankCfg = ScriptKillConfig.instance:getRankPrizeCfgById(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.ScriptKillRankInfoUpdate, self._refreshUI, self)
	ScriptKillController.instance:sendGetRankInfo(self._activityId)
end

function ScriptkillrankView:_refreshUI()
	local info = ScriptKillModel.instance:getRankInfo(self._activityId) or {}

	self.txtmyRank.text = checknumber(info.myRank) > 0 and info.myRank or lang("text_rank_notrank")
	self.txtTip.text = lang("txt_script_kill_rank_rule")

	if not info.rankInfos then
		local list = {}

		self.scrollList:reloadData(list)
		GameUtil.SetActive(self.goEmpty, #list == 0)
	end
end

function ScriptkillrankView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtWin = goutil.findChildTextComponent(cell, "txtWin")
	local txtRate = goutil.findChildTextComponent(cell, "txtRate")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._scrollMap[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._reward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

		rewardView:dragNotifyParent()

		self._scrollMap[cell] = rewardView
	end

	GameUtil.SetActive(imgRank, data.rank <= 3)

	if data.rank <= 3 then
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)

		txtRank.text = ""
	else
		txtRank.text = data.rank
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				FriendController.instance:showInfoView(data.headInfo.userId, imgHeadIcon)
			end
		end)
	end

	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName
	txtWin.text = GameUtil.FormatTimeWords(checknumber(data.value) / 1000)

	for i, v in pairs(self._rankCfg) do
		local arr = v.rankRange

		if data.rank >= checknumber(arr[1]) and data.rank <= checknumber(arr[2]) then
			local rewardData = string.split(v.prize, "#")

			rewardView:reloadData(rewardData)

			break
		end
	end
end

function ScriptkillrankView:clearCell(cell)
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)
end

function ScriptkillrankView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ScriptkillrankView:_clearCell(cell)
	local rewardView = self._scrollMap[cell]

	if rewardView then
		rewardView:dispose()
	end
end

return ScriptkillrankView
