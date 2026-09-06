-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDeclareView.lua

module("logic.extensions.rankrace.view.RankRaceDeclareView", package.seeall)

local RankRaceDeclareView = class("RankRaceDeclareView", ViewComponent)

RankRaceDeclareView.DeclareCount = 5
RankRaceDeclareView.DeclareViewCount = 6

function RankRaceDeclareView:ctor()
	RankRaceDeclareView.super.ctor(self)
end

function RankRaceDeclareView:buildUI()
	RankRaceDeclareView.super.buildUI(self)

	self._main = self:getGo("main")
	self._btnTabWin = self:getBtn("main/btnTabWin")
	self._btnTabLose = self:getBtn("main/btnTabLose")
	self._tabWin = self:getGo("main/btnTabWin"):GetComponent("UIChangeGroup")
	self._tabLose = self:getGo("main/btnTabLose"):GetComponent("UIChangeGroup")
	self._btnClose = self:getBtn("main/btnClose")
	self._txtTitle = self:getGo("main/txtTitle"):GetComponent("Text")
	self._txtRemind = self:getGo("main/txtRemind"):GetComponent("Text")
	self._imgBg = {}
	self._txtDeclare = {}
	self._checkbk = {}
	self._checkbox = {}

	for i = 1, RankRaceDeclareView.DeclareCount do
		self._imgBg[i] = self:getGo("main/imgBgCon/imgBg_" .. i)
		self._txtDeclare[i] = self:getGo("main/imgBgCon/imgBg_" .. i .. "/txtDeclare"):GetComponent("Text")
		self._checkbk[i] = self:getBtn("main/imgBgCon/imgBg_" .. i .. "/checkbk")
		self._checkbox[i] = self:getGo("main/imgBgCon/imgBg_" .. i .. "/checkbk/checkbox")
	end

	if RankRaceDeclareView.DeclareViewCount > RankRaceDeclareView.DeclareCount then
		for i = RankRaceDeclareView.DeclareViewCount, RankRaceDeclareView.DeclareCount, -1 do
			if i ~= RankRaceDeclareView.DeclareCount then
				local img = self:getGo("main/imgBgCon/imgBg_" .. i)

				img.gameObject:SetActive(false)
			end
		end
	end
end

function RankRaceDeclareView:bindEvents()
	RankRaceDeclareView.super.bindEvents(self)
	self._btnTabWin:AddClickListener(function()
		self:_onClickBtnTab(RankRaceController.WinTab)
	end, self)
	self._btnTabLose:AddClickListener(function()
		self:_onClickBtnTab(RankRaceController.LoseTab)
	end, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)

	for i = 1, RankRaceDeclareView.DeclareCount do
		self._checkbk[i]:AddClickListener(function()
			self:_onClickCheckBk(i)
		end)
	end
end

function RankRaceDeclareView:unbindEvents()
	RankRaceDeclareView.super.unbindEvents(self)
	self._btnTabWin:RemoveClickListener()
	self._btnTabLose:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for i = 1, RankRaceDeclareView.DeclareCount do
		self._checkbk[i]:RemoveClickListener()
	end
end

function RankRaceDeclareView:destroyUI()
	RankRaceDeclareView.super.destroyUI(self)
end

function RankRaceDeclareView:onEnter()
	RankRaceDeclareView.super.onEnter(self)

	self._curTabIndex = RankRaceController.WinTab

	self:_updateBtnLight()
	self:_initDeclareConfig()

	self.checkData = RankRaceModel.instance:getCheckData(self._curTabIndex)

	if not self.checkData then
		RankingMatchAgent.instance:sendRM_GetMyDeclarationReq()
	else
		self:_updateTabView()
	end

	local remind_config = {
		RankRaceConfig.instance:getWord(12),
		(RankRaceConfig.instance:getWord(13))
	}

	self._txtRemind.text = remind_config[self._curTabIndex]
end

function RankRaceDeclareView:onEnterFinished()
	RankRaceDeclareView.super.onEnterFinished(self)
end

function RankRaceDeclareView:onExit()
	RankRaceDeclareView.super.onExit(self)
end

function RankRaceDeclareView:onExitFinished()
	RankRaceDeclareView.super.onExitFinished(self)
end

function RankRaceDeclareView:_initDeclareConfig()
	self._declareConfig = RankRaceController.instance:getDeclareConfig()
end

function RankRaceDeclareView:_onClickBtnTab(tabIndex)
	if self._curTabIndex == tabIndex then
		return
	end

	self._curTabIndex = tabIndex

	self:_updateBtnLight()
	self:_updateTabView()
end

function RankRaceDeclareView:_updateBtnLight()
	if not self._curTabIndex then
		return
	end

	if self._curTabIndex == RankRaceController.WinTab then
		self._tabWin:SetState(1)
		self._tabLose:SetState(0)
	else
		self._tabWin:SetState(0)
		self._tabLose:SetState(1)
	end
end

function RankRaceDeclareView:_updateTabView()
	if not self._curTabIndex then
		return
	end

	self.checkData = RankRaceModel.instance:getCheckData(self._curTabIndex)

	if not self.checkData then
		return
	end

	for i = 1, RankRaceDeclareView.DeclareCount do
		self._txtDeclare[i].text = self._declareConfig[self._curTabIndex][i]

		self._checkbox[i].gameObject:SetActive(self.checkData[i])

		self._txtRemind.text = RankRaceConfig.instance:getWord(11 + self._curTabIndex)
	end
end

function RankRaceDeclareView:_onClickCheckBk(check_index)
	if not check_index or not self.checkData then
		return
	end

	self.checkData[check_index] = not self.checkData[check_index]

	RankRaceModel.instance:changeCheckData(self._curTabIndex, check_index, self.checkData[check_index])
	self._checkbox[check_index].gameObject:SetActive(self.checkData[check_index])
end

function RankRaceDeclareView:_onClickBtnClose()
	self:_sendDeclareData()
	self:close()
end

function RankRaceDeclareView:_sendDeclareData()
	local _winBit
	local _declearDataWin = RankRaceModel.instance:getCheckData(RankRaceController.WinTab)

	if _declearDataWin then
		local _declearDataWinStr = ""

		for i = 1, #_declearDataWin do
			_declearDataWinStr = tostring(_declearDataWin[i] and 1 or 0) .. "-" .. _declearDataWinStr
		end

		_declearDataWinStr = _declearDataWinStr .. "0"
		_winBit = RankRaceModel.instance:_decimal2ToDecimal10(_declearDataWinStr)
	end

	local _loseBit
	local _declearDataLose = RankRaceModel.instance:getCheckData(RankRaceController.LoseTab)

	if _declearDataLose then
		local _declearDataLoseStr = ""

		for i = 1, #_declearDataLose do
			_declearDataLoseStr = tostring(_declearDataLose[i] and 1 or 0) .. "-" .. _declearDataLoseStr
		end

		_declearDataLoseStr = _declearDataLoseStr .. "0"
		_loseBit = RankRaceModel.instance:_decimal2ToDecimal10(_declearDataLoseStr)
	end

	if _winBit and _loseBit then
		RankingMatchAgent.instance:sendRM_SetMyDeclarationReq(_winBit, _loseBit)
	end
end

return RankRaceDeclareView
