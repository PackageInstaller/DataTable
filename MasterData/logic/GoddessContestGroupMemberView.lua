-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupMemberView.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupMemberView", package.seeall)

local GoddessContestGroupMemberView = class("GoddessContestGroupMemberView", ViewComponent)

function GoddessContestGroupMemberView:buildUI()
	GoddessContestGroupMemberView.super.buildUI(self)

	self._iconGroup = self:getGo("group/icon"):GetComponent("UIImageSpriteChange")
	self._txtTitleGroup = self:getTxt("group/txtTitle")
	self._txtGroup = self:getTxt("group/txtGroup")
	self._txtMemberNum = self:getTxt("memberNum/txt")
	self._txtDeclaration = self:getTxt("declaration/txt")
	self._inputDeclaration = self:getInput("declaration/input")
	self._campaign = self:getGo("campaign")
	self._goTableViewCampaign = goutil.findChild(self._campaign, "listCom/tableview")
	self._goCellCampaign = goutil.findChild(self._campaign, "listCom/cell")
	self._tableviewCampaign = ScrollerList.create(self._goTableViewCampaign, self._goCellCampaign, GameUtil.handler(self._updateCellCampaign, self), GameUtil.handler(self._clearCellCampaign, self))
	self._btnLeftCampaign = goutil.findChild(self._campaign, "btnLeft")
	self._btnRightCampaign = goutil.findChild(self._campaign, "btnRight")
	self._txtPageCampaign = goutil.findChildTextComponent(self._campaign, "txtPage")
	self._btnCampaign = goutil.findChild(self._campaign, "btnCampaign")
	self._inputSearch = self:getInput("campaign/listCom/inputSearch")
	self._btnSearch = goutil.findChild(self._inputSearch.gameObject, "btnSearch")
	self._btnClear = goutil.findChild(self._inputSearch.gameObject, "btnClear")
	self._member = self:getGo("member")
	self._txtName = goutil.findChildTextComponent(self._member, "leader/txtName")
	self._txtArea = goutil.findChildTextComponent(self._member, "leader/area/txt")
	self._headLeader = goutil.findChild(self._member, "leader/head")
	self._goTableViewMember = goutil.findChild(self._member, "listCom/tableview")
	self._goCellMember = goutil.findChild(self._member, "listCom/cell")
	self._tableviewMember = ScrollerList.create(self._goTableViewMember, self._goCellMember, GameUtil.handler(self._updateCellMember, self), GameUtil.handler(self._clearCellMember, self))
	self._cellPlayer = self:_clearCellMember(goutil.findChild(self._member, "listCom/cellPlayer"))
	self._btnLeftMember = goutil.findChild(self._member, "btnLeft")
	self._btnRightMember = goutil.findChild(self._member, "btnRight")
	self._txtPageMember = goutil.findChildTextComponent(self._member, "txtPage")
end

function GoddessContestGroupMemberView:bindEvents()
	GoddessContestGroupMemberView.super.bindEvents(self)
	self._inputDeclaration:AddOnEndEdit(self._onEndEdit, self)
	GameUtil.addClickHandler(self._btnLeftMember, self._onClickbtnLeftMember, self)
	GameUtil.addClickHandler(self._btnRightMember, self._onClickbtnRightMember, self)
	GameUtil.addClickHandler(self._btnLeftCampaign, self._onClickbtnLeftCampaign, self)
	GameUtil.addClickHandler(self._btnRightCampaign, self._onClickbtnRightCampaign, self)
	GameUtil.addClickHandler(self._btnCampaign, self._onClickbtnCampaign, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickBtnSearch, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickBtnClear, self)
end

function GoddessContestGroupMemberView:unbindEvents()
	GoddessContestGroupMemberView.super.unbindEvents(self)
	self._inputDeclaration:RemoveOnEndEdit()
	GameUtil.rmClickHandler(self._btnLeftMember)
	GameUtil.rmClickHandler(self._btnRightMember)
	GameUtil.rmClickHandler(self._btnLeftCampaign)
	GameUtil.rmClickHandler(self._btnRightCampaign)
	GameUtil.rmClickHandler(self._btnCampaign)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnClear)
end

function GoddessContestGroupMemberView:onEnter()
	GoddessContestGroupMemberView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetGroupInfo, self._refreshByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestReviseDeclaration, self._refreshDeclaration, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestJoinCampaign, self._onJoinCampaign, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestUpdateLeaderList, self._refreshCampaignInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestVoteToLeader, self._onVoteToLeader, self)
	self:_refreshView()
end

function GoddessContestGroupMemberView:onExit()
	GoddessContestGroupMemberView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetGroupInfo, self._refreshByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestReviseDeclaration, self._refreshDeclaration, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestJoinCampaign, self._onJoinCampaign, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestUpdateLeaderList, self._refreshCampaignInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestVoteToLeader, self._onVoteToLeader, self)
	self._tableviewCampaign:dispose()
	self._tableviewMember:dispose()
	HeadItemController.instance:resetHeadCell(self._headLeader)
	HeadItemController.instance:resetHeadCell(self._cellPlayer.head)
end

function GoddessContestGroupMemberView:_refreshView()
	self._curActId = GoddessContestModel.instance:getCurActId()
	self._actCfg = GoddessContestConfig.instance:getActCfgByActId(self._curActId)
	self._groupCfg = GoddessContestConfig.instance:getFanGroupCfgsByActIdAndGroupId(self._curActId, GoddessContestModel.instance:getCurGroupId())
	self._showCellNum = checkint(GoddessContestConfig.instance:getCommondValueByKey("CAMPAIGN_SHOW_NUMS"))

	self:_refreshByCfg()
	self:_refreshByInfo()
end

function GoddessContestGroupMemberView:_refreshByCfg()
	self._iconGroup:SetState(self._groupCfg.fansGroupId - 1)

	self._txtTitleGroup.text = self._groupCfg.fansGroupName
	self._txtGroup.text = self._groupCfg.fansGroupName
end

function GoddessContestGroupMemberView:_refreshByInfo()
	local info = GoddessContestModel.instance:getCurFansGroupInfo()

	if info then
		self._txtMemberNum.text = info.numMembers or 0
	end

	if GoddessContestModel.instance:getCurLeaderInfo() then
		self:_refreshMember()
	else
		self:_refreshCampaigh()
	end

	self._curGrade = GoddessContestModel.instance:getCurGrade()
	self._curGradeCfg = GoddessContestConfig.instance:getGradeCfg(self._curGrade)

	goutil.setActive(self._txtDeclaration.gameObject, not self._curGradeCfg.reviseDeclaration)
	goutil.setActive(self._inputDeclaration.gameObject, self._curGradeCfg.reviseDeclaration)
	self:_refreshDeclaration()
	HeadItemController.instance:setMyHeadCell(self._cellPlayer.head)

	self._cellPlayer.txtArea.text = RoleModel.instance:getAreaName()
	self._cellPlayer.txtName.text = RoleModel.instance:getUserName()
	self._cellPlayer.txtTitle.text = self._curGradeCfg.name

	self._cellPlayer.title:SetState(self._curGrade - 1)

	self._cellPlayer.txtNum.text = GoddessContestModel.instance:getVotePower()
end

function GoddessContestGroupMemberView:_refreshDeclaration()
	local info = GoddessContestModel.instance:getCurFansGroupInfo()
	local showStr = self._groupCfg.fansGroupDeclaration

	if info and info.declaration and not string.nilorempty(info.declaration) then
		showStr = info.declaration
	end

	self._txtDeclaration.text = showStr

	self._inputDeclaration:SetText(showStr)
end

function GoddessContestGroupMemberView:_onEndEdit(str)
	if str ~= self._txtDeclaration.text and self:_checkInputValid(str) then
		GoddessContestController.instance:reviseDeclaration(str)
	end

	self._inputDeclaration:SetText(self._txtDeclaration.text)
end

function GoddessContestGroupMemberView:_checkInputValid(content)
	if string.nilorempty(content) then
		content = self._inputDeclaration:GetText()
	end

	local result = StringUtil.utf8split(content)
	local realLen = #result
	local inputLenLimit = checkint(GoddessContestConfig.instance:getCommondValueByKey("DECLARATION_MAX_LENGTH"))
	local isValid = false

	if string.len(content) == 0 then
		FloatWordMgr.instance:show("新宣言不可为空！")
	elseif inputLenLimit < realLen then
		FloatWordMgr.instance:show("新宣言超过字数限制30")
	else
		isValid = true
	end

	return isValid
end

function GoddessContestGroupMemberView:_refreshMember()
	goutil.setActive(self._campaign, false)
	goutil.setActive(self._member, true)

	local leaderInfo = GoddessContestModel.instance:getCurLeaderInfo()

	if leaderInfo then
		HeadItemController.instance:setHeadCellByInfo(self._headLeader, leaderInfo.headInfo)

		self._txtArea.text = leaderInfo.headInfo.areaName
		self._txtName.text = leaderInfo.headInfo.userName
	end

	self._curGroupMemberInfos = GoddessContestModel.instance:getCurGroupMemberInfos()
	self._curMemberPageId = -1
	self._memberPageNum = math.ceil(checknumber(#self._curGroupMemberInfos) / checknumber(self._showCellNum))

	if self._memberPageNum < 1 then
		self._memberPageNum = 1
	end

	self:_refreshMemberList(1)
end

function GoddessContestGroupMemberView:_onClickbtnLeftMember()
	local id = self._curMemberPageId - 1

	if id < 1 then
		id = 1
	end

	self:_refreshMemberList(id)
end

function GoddessContestGroupMemberView:_onClickbtnRightMember()
	local id = self._curMemberPageId + 1

	if id > self._memberPageNum then
		id = self._memberPageNum
	end

	self:_refreshMemberList(id)
end

function GoddessContestGroupMemberView:_refreshMemberList(id)
	if id ~= self._curMemberPageId then
		self._curMemberPageId = id
		self._txtPageMember.text = langPara("%s/%s", self._curMemberPageId, self._memberPageNum)

		local dataList = {}

		for i = (self._curMemberPageId - 1) * self._showCellNum + 1, self._curMemberPageId * self._showCellNum do
			local data = self._curGroupMemberInfos[i]

			if data then
				table.insert(dataList, data)
			end
		end

		self._tableviewMember:reloadData(dataList)
	end
end

function GoddessContestGroupMemberView:_onClickPrompt(data)
	if not GoddessContestModel.instance:getIsTime("GODDESS_VOTE_TIME") then
		FloatWordMgr.instance:show(lang("投票已结束，不可以催投票啦"))

		return
	end

	local timeLimit = checkint(GoddessContestConfig.instance:getCommondValueByKey("CHAT_CD"))

	if ServerTime.now() > data.lastChatTime + timeLimit then
		local userId = checkint(data.headInfo.userId)

		if checkint(RoleModel.instance:getUserId()) == userId then
			FloatWordMgr.instance:show("不可以给自己催票")
		else
			GoddessContestController.instance:prompt(userId)
		end
	else
		FloatWordMgr.instance:show(langPara("每%s秒才可以进行一次催票，不可以过于频繁地催票", timeLimit))
	end
end

function GoddessContestGroupMemberView:_updateCellMember(view, goCell, data)
	local cell = self:_clearCellMember(goCell)
	local headInfo = data.headInfo

	if headInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo)

		cell.txtArea.text = headInfo.areaName
		cell.txtName.text = headInfo.userName
	end

	cell.title:SetState(data.grade - 1)

	local gradeCfg = GoddessContestConfig.instance:getGradeCfg(data.grade)

	cell.txtTitle.text = gradeCfg.name
	cell.txtNum.text = data.popularityValue

	GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickPrompt, self, data))
	GameUtil.addClickHandler(cell.btnHead, GameUtil.handler(self._onClickHead, self, data.headInfo.userId, cell.btnHead))
	goutil.setActive(cell.btnVote, self._curGradeCfg.pressVote)
end

function GoddessContestGroupMemberView:_clearCellMember(goCell)
	local cell = {}

	cell.go = goCell
	cell.head = goutil.findChild(cell.go, "head")
	cell.btnHead = goutil.findChild(cell.go, "btnHead")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "area/txt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.title = goutil.findChildComponent(cell.go, "title", "UIImageSpriteChange")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txtTitle")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnVote = goutil.findChild(cell.go, "btnVote")

	GameUtil.rmClickHandler(cell.btnVote)
	GameUtil.rmClickHandler(cell.btnHead)
	HeadItemController.instance:resetHeadCell(cell.head)

	return cell
end

function GoddessContestGroupMemberView:_refreshCampaigh()
	goutil.setActive(self._campaign, true)
	goutil.setActive(self._member, false)
	goutil.setActive(self._btnCampaign, not GoddessContestModel.instance:getIsCampaign())
	GoddessContestController.instance:getCampaighList()
end

function GoddessContestGroupMemberView:_updateCellCampaign(view, goCell, data)
	local cell = self:_clearCellCampaign(goCell)
	local headInfo = data.headInfo

	if headInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo)

		cell.txtArea.text = headInfo.areaName
		cell.txtName.text = headInfo.userName
	end

	cell.txtNum.text = data.popularityValue
	cell.txtVoteNum.text = data.voteNums

	local isVoteTime = GoddessContestModel.instance:getIsTime("CAMPAIGN_VOTE_TIME")

	if not isVoteTime then
		local date = GoddessContestModel.instance:getStarTimeDate("CAMPAIGN_VOTE_TIME")

		cell.txtTip.text = string.format("%s月%s日\n开始投票", date.month, date.day)
	end

	goutil.setActive(cell.btnVote, isVoteTime)
	goutil.setActive(cell.txtTip.gameObject, not isVoteTime)
	GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickVote, self, data))
	GameUtil.addClickHandler(cell.btnHead, GameUtil.handler(self._onClickHead, self, data.headInfo.userId, cell.btnHead))
end

function GoddessContestGroupMemberView:_clearCellCampaign(goCell)
	local cell = {}

	cell.go = goCell
	cell.head = goutil.findChild(cell.go, "head")
	cell.btnHead = goutil.findChild(cell.go, "btnHead")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "area/txt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.txtVoteNum = goutil.findChildTextComponent(cell.go, "txtVoteNum")
	cell.btnVote = goutil.findChild(cell.go, "btnVote")
	cell.txtTip = goutil.findChildTextComponent(cell.go, "txtTip")

	GameUtil.rmClickHandler(cell.btnVote)
	GameUtil.rmClickHandler(cell.btnHead)
	HeadItemController.instance:resetHeadCell(cell.head)

	return cell
end

function GoddessContestGroupMemberView:_onClickVote(data)
	if GoddessContestModel.instance:getIsTime("CAMPAIGN_VOTE_TIME") then
		local costParms = string.splitToNumber(self._actCfg.directorVoteItemId, ":")
		local costType = costParms[1]
		local costId = costParms[2]
		local costNum = MaterialModel.instance:getMaterialsNumber(costType, costId)
		local content = langPara("每消耗1个%s可进行1次投票，请选择投票数量", MaterialMgr.getMaterialsName(costType, costId))

		TipsFacade.instance:openPopupCostAdjustView(costType, costId, costNum, content, function(num)
			GoddessContestController.instance:voteToDirector(data.headInfo.userId, num)

			self._curAddVoteNum = num
		end)
	else
		FloatWordMgr.instance:show("投票活动未开始或已结束")
	end
end

function GoddessContestGroupMemberView:_onClickHead(userId, go)
	FriendController.instance:showInfoView(userId, go)
end

function GoddessContestGroupMemberView:_onClickbtnLeftCampaign()
	local id = self._curCampaighPageId - 1

	if id < 1 then
		id = 1
	end

	self:_refreshCampaignList(id)
end

function GoddessContestGroupMemberView:_onClickbtnRightCampaign()
	local id = self._curCampaighPageId + 1

	if id > self._campaignNum then
		id = self._campaignNum
	end

	self:_refreshCampaignList(id)
end

function GoddessContestGroupMemberView:_refreshCampaignInfo()
	self._leaderListPageId = GoddessContestModel.instance:getLeaderListPageId()
	self._leaderInfoList = GoddessContestModel.instance:getLeaderInfoList()
	self._leaderNum = GoddessContestModel.instance:getLeaderCampaignListNum()
	self._campaignNum = math.ceil(checknumber(self._leaderNum) / checknumber(self._showCellNum))

	if self._campaignNum < 1 then
		self._campaignNum = 1
	end

	local newPageId = 1

	if self._curCampaighPageId and self._curCampaighPageId > 0 then
		newPageId = self._curCampaighPageId % 10

		if self._curCampaighPageId % 10 == 0 then
			newPageId = 10
		end
	end

	self._curCampaighPageId = -1

	self:_refreshCampaignList(newPageId + (self._leaderListPageId - 1) * 50 / self._showCellNum)
end

function GoddessContestGroupMemberView:_onVoteToLeader()
	self._leaderListPageId = GoddessContestModel.instance:getLeaderListPageId()
	self._leaderInfoList = GoddessContestModel.instance:getLeaderInfoList()
	self._leaderNum = GoddessContestModel.instance:getLeaderCampaignListNum()
	self._campaignNum = math.ceil(checknumber(self._leaderNum) / checknumber(self._showCellNum))

	if self._campaignNum < 1 then
		self._campaignNum = 1
	end

	self._curCampaighPageId = -1

	local curSubId = GoddessContestModel.instance:getCurVoteUserGroupSubId()

	self:_refreshCampaignList(math.ceil(curSubId / self._showCellNum) + (self._leaderListPageId - 1) * 50 / self._showCellNum)
	FloatWordMgr.instance:show(langPara("投票成功，给支持的团长竞选人增加了%s票！", self._curAddVoteNum))
end

function GoddessContestGroupMemberView:_refreshCampaignList(id)
	if id ~= self._curCampaighPageId then
		self._curCampaighPageId = id
		self._txtPageCampaign.text = langPara("%s/%s", self._curCampaighPageId, self._campaignNum)

		local curGroupPageId = math.ceil(checknumber(self._curCampaighPageId * self._showCellNum) / 50)
		local addPageId = (curGroupPageId - 1) * (50 / self._showCellNum)

		if curGroupPageId == self._leaderListPageId then
			local dataList = {}

			for i = (self._curCampaighPageId - 1 - addPageId) * self._showCellNum + 1, self._curCampaighPageId * self._showCellNum do
				local data = self._leaderInfoList[i]

				if data then
					table.insert(dataList, data)
				end
			end

			self._tableviewCampaign:reloadData(dataList)
		else
			GoddessContestController.instance:getCampaighList(curGroupPageId)
		end
	end
end

function GoddessContestGroupMemberView:_onClickbtnCampaign()
	if GoddessContestModel.instance:getIsTime("CAMPAIGN_APPLY_TIME") then
		local votePowerLimit = checkint(GoddessContestConfig.instance:getCommondValueByKey("CAMPAIGN_POPULARITY_VALUE_LIMIT"))
		local powerLimit = checkint(GoddessContestConfig.instance:getCommondValueByKey("CAMPAIGN_ZDL_LIMIT"))

		if powerLimit > RoleModel.instance:getMaxPower() or votePowerLimit > GoddessContestModel.instance:getVotePower() then
			FloatWordMgr.instance:show(langPara("达到%s战力且贡献人气值达到%s可参与竞选", powerLimit, votePowerLimit))

			return
		end

		local costMat = GoddessContestConfig.instance:getCommondValueByKey("CAMPAIGN_COST")
		local costType, costId, costNum = MaterialMgr.getMatParams(costMat)
		local content = langPara("确认花费%s%s参与团长竞选吗？", costNum, MaterialMgr.getMaterialsName(costType, costId))

		TipsFacade.instance:openPopupCostMatViewNew(costType, costId, costNum, content, function()
			GoddessContestController.instance:joinCampaign()
		end)
	else
		FloatWordMgr.instance:show("团长竞选时间未开始或已结束")
	end
end

function GoddessContestGroupMemberView:_onJoinCampaign()
	GoddessContestController.instance:getCampaighList(GoddessContestModel.instance:getLeaderListPageId())
	goutil.setActive(self._btnCampaign, false)
end

function GoddessContestGroupMemberView:_onClickBtnSearch()
	if not string.nilorempty(self._inputSearch:GetText()) then
		GoddessContestController.instance:searchCampaign(self._inputSearch:GetText())
	end
end

function GoddessContestGroupMemberView:_onClickBtnClear()
	if not string.nilorempty(self._inputSearch:GetText()) then
		self._inputSearch:SetText("")
		GoddessContestController.instance:getCampaighList()
	end
end

return GoddessContestGroupMemberView
