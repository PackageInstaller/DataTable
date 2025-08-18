-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleListDlg.lua

local strClassName = "CircleListDlg"
local CircleListDlg = Class(strClassName, UIControls.Window)

function CircleListDlg:ctor()
	self:initUI()
end

function CircleListDlg:initUI()
	self.cells = {}
	self.inputSearch = UIControls.Input(self, "MainInfoPanel/SearchPanel/InputText")

	self.inputSearch:addEventValueChanged(self.onInputChanged)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnSearch = UIControls.Button(self, "MainInfoPanel/SearchPanel/BtnSearch")

	self.btnSearch:addEventClick(self.onBtnSearchClick)

	self.btnDelTxt = UIControls.Button(self, "MainInfoPanel/SearchPanel/BtnDel")

	self.btnDelTxt:addEventClick(self.onBtnDelTxtClick)

	self.btnRefresh = UIControls.Button(self, "MainInfoPanel/SearchPanel/BtnChange")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.btnCreate = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnCreate")

	self.btnCreate:addEventClick(self.onBtnCreateClick)

	self.btnRanking = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnRanking")

	self.btnRanking:addEventClick(self.onBtnRankingClick)
	self.btnRanking:setVisible(Const.FORCE_OPEN_CIRCLE_BATTLE)

	self.btnInviteInfo = UIControls.Button(self, "BtnInviteInfo")

	self.btnInviteInfo:addEventClick(self.onBtnInviteInfoClick)
	self.btnInviteInfo:setVisible(not CurAvatar:isInCircle() and not RegionUtils.isJP())

	self.redCircleInvite = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnInviteInfo/IconNew")

	self.redCircleInvite:addHint({
		UIConst.RD_HINT_CIRCLE_INVITED
	})

	self.panelResultContent = UIControls.Panel(self, "MainInfoPanel/ResultContent")
	self.scrollCircle = UIControls.ScrollViewLoopV(self, "MainInfoPanel/CircleListPanel", 0, self._initItem)
	self.panelEmpty = UIControls.Panel(self, "MainInfoPanel/TextEmpty")
	self.txtEmpty = UIControls.Label(self, "MainInfoPanel/TextEmpty/Text")
	self.panelTipsActive = UIControls.Panel(self, "MainInfoPanel/TipsActivePanel")
	self.btnClosePanelTips = UIControls.Button(self, "MainInfoPanel/UIClickThrough")

	self.btnClosePanelTips:addEventClick(self.onBtnClosePanelTipsClick)

	CurAvatar.applyedCircleDic = {}
end

function CircleListDlg:openTipsActivePanel(circleCell)
	local cellPos = circleCell:getAbsPosition()

	self.panelTipsActive:setAbsPosition(cellPos.x, cellPos.y + 0.25)
	self.panelTipsActive:setVisible(true)
	self.btnClosePanelTips:setVisible(true)
end

function CircleListDlg:onBtnClosePanelTipsClick()
	self.btnClosePanelTips:setVisible(false)
	self.panelTipsActive:setVisible(false)
end

function CircleListDlg:onBtnTipsClick()
	return
end

function CircleListDlg:initCircleList()
	local circleList = CurAvatar:tryGetRecommendCircleList()

	if circleList then
		self:refreshCircleList(circleList)
	end
end

function CircleListDlg:refreshCircleList(circleList)
	self.circleList = circleList

	self.panelResultContent:setVisible(false)
	self.scrollCircle:setVisible(true)
	self.panelEmpty:setVisible(#self.circleList == 0)
	self.txtEmpty:setText(Lang.get(30192))
	self.scrollCircle:setTotalCount(#self.circleList)
end

function CircleListDlg:refreshSearchResult(circle)
	if circle then
		self.searchCircle = circle

		self.panelEmpty:setVisible(false)
		self.panelResultContent:setVisible(true)
		self.scrollCircle:setVisible(false)

		if not self.searchBtnCircle then
			self.searchBtnCircle = UIControls.BtnCircleCellChild(self, "MainInfoPanel/ResultContent", "System/Circle/BtnCircleCell", 0, 0, true)
		end

		self.searchBtnCircle:setCircleCellData(self.searchCircle, self.isShowMode)
	else
		if self.searchBtnCircle then
			self.searchBtnCircle:destroy()

			self.searchBtnCircle = nil
		end

		self.txtEmpty:setText(Lang.get(780))
		self.panelEmpty:setVisible(true)
		self.scrollCircle:setVisible(false)
	end
end

function CircleListDlg:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.BtnCircleCellLoop(sender, "System/Circle/BtnCircleCell", newIdx)

	if not self.circleList or #self.circleList == 0 then
		return
	end

	if self.circleList[newIdx] ~= nil then
		targetCell:setCircleCellData(self.circleList[newIdx], self.isShowMode)
	end

	self.cells[newIdx] = targetCell
end

function CircleListDlg:onInputChanged()
	local text = self.inputSearch:getText()

	self.btnDelTxt:setVisible(text ~= "")
end

function CircleListDlg:setOnlyShowMode()
	self.isShowMode = true

	self.btnCreate:setVisible(false)
	self:initCircleList()
end

function CircleListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleListDlg:onBtnSearchClick()
	local searchText = self.inputSearch:getText()

	if searchText == "" then
		MsgManager.clientNotice(230)

		return
	end

	local searchId = tonumber(searchText)

	if searchId == nil then
		local circle = CurAvatar:tryGetCircleDetailInfoByName(searchText)

		if circle then
			self:refreshSearchResult(circle)
		end
	else
		if searchId > 1000000000 then
			self:refreshSearchResult()

			return
		end

		local circle = CurAvatar:tryGetCircleDetailInfo(searchId, Const.CIRCLE_SEARCH_BYLIST)

		if circle then
			self:refreshSearchResult(circle)
		end
	end
end

function CircleListDlg:onBtnDelTxtClick()
	self.inputSearch:setText("")

	if not self.scrollCircle:getVisible() then
		self:refreshCircleList(self.circleList)
	end
end

function CircleListDlg:onBtnRefreshClick()
	CurAvatar:refreshRecommendCircle()
end

function CircleListDlg:onBtnRankingClick()
	if not CurAvatar:opActivityIsOpened(Const.ACT_TYPE_CIRCLE_BATTLE) then
		MsgManager.clientNotice(499)

		return
	end

	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg.isOpenedByHideMode = true

	rankMainDlg:initByRankType(Const.RANK_TYPE_CIRCLE_BATTLE_LAYER)
end

function CircleListDlg:onBtnInviteInfoClick()
	local circleInviteInfoDlg = UIManager.getUI("circleInviteInfoDlg", true)

	circleInviteInfoDlg:setInviteMsgData(CurAvatar:getInviterDataList())
end

function CircleListDlg:onBtnCreateClick()
	local createCircleDlg = UIManager.getUI("createCircleDlg", true)
end

function CircleListDlg:addApplyedCircle(circleGid)
	self.scrollCircle:setTotalCount(#self.circleList)
end

return CircleListDlg
