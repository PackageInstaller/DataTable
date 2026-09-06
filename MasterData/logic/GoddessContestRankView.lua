-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestRankView.lua

module("logic.extensions.goddesscontest.view.GoddessContestRankView", package.seeall)

local GoddessContestRankView = class("GoddessContestRankView", ViewComponent)
local TabType = {
	Devote = 2,
	RedPack = 1
}

function GoddessContestRankView:ctor()
	GoddessContestRankView.super.ctor(self)
end

function GoddessContestRankView:unbindEvents()
	GoddessContestRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessContestRankView:bindEvents()
	GoddessContestRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GoddessContestRankView:buildUI()
	GoddessContestRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goEmpty = self:getGo("rightInfoGo/emptyGo")
	self._txtRank = self:getTxt("rightInfoGo/myRankGo/myRankTxt")
	self._txtTopNum = self:getTxt("rightInfoGo/rankTitleGo/numTxt")
	self._txtRankDesc = self:getTxt("rightInfoGo/myRankGo/rankDescTxt")
	self._tabTableView = self:getGo("tableview")
	self._rootCell = self:getGo("rootCell")
	self._leafCell = self:getGo("leafCell")
	self._tabScrollList = ScrollerList.create(self._tabTableView, {
		self._rootCell,
		self._leafCell
	}, GameUtil.handler(self._upateCell, self))

	self._tabScrollList:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))
	self._tabScrollList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._tableview = self:getGo("rightInfoGo/rankListSR")
	self._tablecell = self:getGo("rightInfoGo/rankItem")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._dropLineRectTrans = self:getGo("tableview/Nego_Viewport/Nego_Content/dropLine"):GetComponent(goutil.Type_RectTransform)
	self._taskRewardTabList = {}
end

function GoddessContestRankView:onExit()
	GoddessContestRankView.super.onExit(self)
	self._scrollList:dispose()
	self._tabScrollList:dispose()

	for k, v in pairs(self._taskRewardTabList) do
		if v then
			v:dispose()
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetRankInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGetRankInfo, self._refreshView, self)
end

function GoddessContestRankView:onEnter()
	GoddessContestRankView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GROUP_RED_PACK)

	if actCfg then
		self._redpackActivityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()
	end

	local goddessActCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Goddess_Contest)

	if goddessActCfg then
		self._goddessActivityId = goddessActCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()
	end

	self:_initTabList()

	self._rootIdx = 1
	self._leafIdx = 1
	self._rankPrizeCfgs = {}
	self._redpackRankPrizeCfgs = GroupRedpackConfig.instance:getRankCfgsByActId(self._redpackActivityId)
	self._goddessRankPrizeCfgs = GoddessContestConfig.instance:getRankCfgsByActId(self._goddessActivityId)

	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetRankInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGetRankInfo, self._refreshView, self)
	self:_updateTabList()
end

function GoddessContestRankView:_initTabList()
	self._tabList = {
		{
			{
				leaf = 0,
				idx = 1,
				name = "红包榜"
			}
		},
		{
			{
				leaf = 0,
				idx = 2,
				name = "贡献榜"
			}
		}
	}

	local groupCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._goddessActivityId)

	for i, v in ipairs(groupCfgs) do
		table.insert(self._tabList[1], {
			idx = 1,
			leaf = i,
			name = v.fansGroupName
		})
		table.insert(self._tabList[2], {
			idx = 2,
			leaf = i,
			name = v.fansGroupName
		})
	end
end

function GoddessContestRankView:_getTagByData(data, idx)
	return data.tag
end

function GoddessContestRankView:_getCellSize(view, idx)
	local list = self._tabScrollList:getData()
	local data = list[idx + 1]

	if data.tag == 1 then
		return 192, 70
	else
		return 192, 50
	end
end

function GoddessContestRankView:_upateCell(view, cell, data, tag)
	if data.tag == 1 then
		self:_updateRootCell(view, cell, data, tag)
	else
		self:_updateLeafCell(view, cell, data, tag)
	end
end

function GoddessContestRankView:_updateRootCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.setUIImageSpriteIdx(cell, (data.idx == self._rootIdx or nil) and 1)

	txtName.text = data.name

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onRootClick, self, data))
end

function GoddessContestRankView:_updateLeafCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelected = goutil.findChild(cell, "imgSelected")

	txtName.text = data.name

	local isSelect = data.leaf == self._leafIdx

	GameUtil.setUITextColorIdx(txtName, isSelect and 0 or 1)
	GameUtil.SetActive(imgSelected, isSelect)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onLeafClick, self, data))
end

function GoddessContestRankView:_onRootClick(data)
	if data.idx == self._rootIdx and self._leafIdx > 0 then
		self._leafIdx = 0
	else
		self._rootIdx = data.idx
		self._leafIdx = 1

		self:_updateTabList()
	end
end

function GoddessContestRankView:_onLeafClick(data)
	self._leafIdx = data.leaf

	self._tabScrollList:refresh()
	self:_sendGetList()
end

function GoddessContestRankView:_updateTabList()
	local rootIdx = self._rootIdx
	local leafIdx = self._leafIdx
	local list = {}

	for i, v in ipairs(self._tabList) do
		local rootNode = v[1]

		rootNode.tag = 1

		table.insert(list, rootNode)

		if rootIdx == rootNode.idx and leafIdx > 0 then
			for j = 2, #v do
				local leafNode = v[j]

				leafNode.tag = 2

				table.insert(list, leafNode)
			end
		end
	end

	self._tabScrollList:reloadData(list)
	self:_sendGetList()
	self:_updateScrollBg()
end

function GoddessContestRankView:_updateScrollBg()
	local posY = -self._rootIdx * 60 - (self._rootIdx - 1) * 10
	local height = 200
	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dropLineRectTrans, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._dropLineRectTrans, x, posY)
	goutil.setHeight(self._dropLineRectTrans, height)
end

function GoddessContestRankView:_sendGetList()
	local root = self._rootIdx
	local leaf = self._leafIdx

	if root == TabType.RedPack then
		GroupRedpackController.instance:sendGroupRedPackGetRankInfoReq(self._redpackActivityId, leaf)
	else
		GoddessContestController.instance:sendGetRankInfo(self._goddessActivityId, leaf)
	end
end

function GoddessContestRankView:_refreshView()
	self._txtTopNum.text = self._rootIdx == TabType.RedPack and "发送红包总额" or "总投票贡献"

	local root = self._rootIdx
	local leaf = self._leafIdx

	if root == TabType.RedPack then
		local var_18_0 = GroupRedpackModel.instance:getRankInfoById(leaf)

		if not var_18_0 then
			var_18_0 = GoddessContestModel.instance:getRankInfoById(leaf)

			local rankInfo = var_18_0

			if self._rootIdx == TabType.RedPack then
				self._rankPrizeCfgs = self._redpackRankPrizeCfgs or self._goddessRankPrizeCfgs
			end

			self._txtRank.text = checknumber(rankInfo.myRank) <= 0 and "未上榜" or tostring(rankInfo.myRank)
			self._txtRankDesc.text = self._rootIdx == TabType.RedPack and "本榜单按照活动期间内，发放的红包总额进行排名（1W以上即可上榜），前100名玩家可领取奖励，每10分钟刷新1次，榜单将于女神大赛结束时结算，通过邮件发奖" or "本榜单按照活动期间内每周增加的人气值进行排名（50以上即可上榜），前100名玩家可领取奖励，每10分钟刷新1次，每周5凌晨5点结算，通过邮件发奖"

			GameUtil.SetActive(self._goEmpty, #rankInfo.rankInfos == 0)
			self._scrollList:reloadData(rankInfo.rankInfos)
		end
	end
end

function GoddessContestRankView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local proxy = HeadItemController.instance:setHeadCellByInfo(cell.goHead, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:_onClickHead(data.headInfo.userId, headGo)
			end
		end)
	end

	cell.txtName.text = data.headInfo.userName

	GameUtil.SetActive(cell.itemCon, self._rootIdx == TabType.RedPack)

	if self._rootIdx == TabType.RedPack then
		cell.txtSend.text = data.totalAmount or data.nums
	end

	local isTop3 = data.rank > 0 and data.rank <= 3

	GameUtil.SetActive(cell.imgRankChange, isTop3)

	if not isTop3 then
		cell.txtRank.text = tostring(data.rank)
	else
		cell.imgRankChange:SetState(data.rank - 1)

		cell.txtRank.text = ""
	end

	local prizeCfgs = self:_getPrizeByRank(self._rankPrizeCfgs, data.rank)
	local prizeList = string.split(prizeCfgs, "#")

	self._taskRewardTabList[goCell] = self._taskRewardTabList[goCell] or ScrollerList.create(cell.rewardTableView, cell.rewardTableCell, GameUtil.handler(self._updateRewardList, self), GameUtil.handler(self._clearRewardCell, self))

	self._taskRewardTabList[goCell]:reloadData(prizeList)
end

function GoddessContestRankView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtRank = goutil.findChildTextComponent(goCell, "rankTxt")
	cell.txtName = goutil.findChildTextComponent(goCell, "nameTxt")
	cell.txtSend = goutil.findChildTextComponent(goCell, "txtSend")
	cell.itemCon = goutil.findChild(goCell, "txtSend/icon")
	cell.goHead = goutil.findChild(goCell, "headGo")
	cell.imgRankChange = goutil.findChild(goCell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	cell.rewardTableView = goutil.findChild(goCell, "tableview")
	cell.rewardTableCell = goutil.findChild(goCell, "cell")

	HeadItemController.resetHeadCell(cell.goHead)

	return cell
end

function GoddessContestRankView:_updateRewardList(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GoddessContestRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GoddessContestRankView:_getPrizeByRank(cfg, rank)
	if rank <= 0 then
		return ""
	end

	for i, v in ipairs(cfg) do
		local left, right = v.rankRange[1], v.rankRange[2]

		if rank <= right then
			return v.prize
		end
	end

	return ""
end

function GoddessContestRankView:_onClickClose()
	self:close()
end

function GoddessContestRankView:_onClickHead(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GoddessContestRankView
