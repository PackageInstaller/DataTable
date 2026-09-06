-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletNormalGameView.lua

module("logic.extensions.stickcouplet.view.StickCoupletNormalGameView", package.seeall)

local StickCoupletNormalGameView = class("StickCoupletNormalGameView", ViewComponent)

function StickCoupletNormalGameView:ctor()
	StickCoupletNormalGameView.super.ctor(self)
end

function StickCoupletNormalGameView:buildUI()
	StickCoupletNormalGameView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnSubmit = self:getGo("btnSubmit")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtScore = self:getTxt("score/txtScore")
	self._middleCouplet = self:getGo("middleCouplet")
	self._middleList = {}

	for i = 1, self._middleCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._middleCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")

		table.insert(self._middleList, cell)
	end

	self._leftCouplet = self:getGo("leftCouplet")
	self._leftList = {}

	for i = 1, self._leftCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._leftCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")
		cell.bgGo = goutil.findChild(cellGo, "bg")
		cell.txtAnswer = goutil.findChildTextComponent(cellGo, "txtAnswer")

		table.insert(self._leftList, cell)
	end

	self._rightCouplet = self:getGo("rightCouplet")
	self._rightList = {}

	for i = 1, self._rightCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._rightCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")
		cell.bgGo = goutil.findChild(cellGo, "bg")
		cell.txtAnswer = goutil.findChildTextComponent(cellGo, "txtAnswer")

		table.insert(self._rightList, cell)
	end

	self._selects = self:getGo("selects")
	self._selectGoList = {}

	for i = 1, 3 do
		local cell = {}
		local wordList = {}
		local cellGo = goutil.findChild(self._selects, "select_" .. i)
		local wordsGo = goutil.findChild(cellGo, "words")
		local imgChange = goutil.findChild(cellGo, "bg/check"):GetComponent(ComponentType.UIImageSpriteChange)

		for i = 1, wordsGo.transform.childCount do
			local word = goutil.findChild(wordsGo, "word_" .. i)
			local txtWord = goutil.findChildTextComponent(word, "Text")

			table.insert(wordList, txtWord)
		end

		cell.go = cellGo
		cell.wordList = wordList
		cell.imgChange = imgChange
		cell.imgSelect = goutil.findChild(cellGo, "imgSelect")

		table.insert(self._selectGoList, cell)
	end
end

function StickCoupletNormalGameView:bindEvents()
	StickCoupletNormalGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSubmit, self._onClickBtnSubmit, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for idx, selectGo in ipairs(self._selectGoList) do
		GameUtil.addClickHandler(selectGo.go, GameUtil.handler(self._onClickSelectGo, self, idx))
	end
end

function StickCoupletNormalGameView:unbindEvents()
	StickCoupletNormalGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSubmit)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, selectGo in ipairs(self._selectGoList) do
		GameUtil.rmClickHandler(selectGo.go)
	end
end

function StickCoupletNormalGameView:onEnter()
	StickCoupletNormalGameView.super.onEnter(self)

	self._activityId = StickCoupletController.instance:getActivityId()
	self._actcfg = StickCoupletConfig.instance:getSCActData(self._activityId)
	self._normalCfg = StickCoupletConfig.instance:getSCNormalData() or {}
	self._normalAskNum = #self._normalCfg
	self._curSelectIdx = 0
	self._selectList = {}

	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._startGame, self)
	self:_onSetUI()
	self:_onInit()
end

function StickCoupletNormalGameView:onExit()
	StickCoupletNormalGameView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	removetimer(self._updateTime, self)
end

function StickCoupletNormalGameView:_onSetUI()
	local skinId = self._actcfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	self._txtScore.text = 0
end

function StickCoupletNormalGameView:_onInit()
	self:_initData()
	self:_initCoupletUI()
	self:_initSelectUI()
end

function StickCoupletNormalGameView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function StickCoupletNormalGameView:_initData()
	local curAskId = math.random(1, self._normalAskNum)
	local curAskCfg = self._normalCfg[curAskId]

	self._hasSelectList = {}
	self._curSelectIdx = 0
	self._stopSubmit = false
	self._selectList = {}

	if curAskCfg then
		local middleStr = curAskCfg.middleCouplet
		local askStr = curAskCfg.askCouplet

		self._askType = curAskCfg.coupletType
		self._middleStrArr = string.split(middleStr, "#")
		self._askStrArr = string.split(askStr, "#")
		self._correctId = curAskCfg.anserId

		for i = 1, #self._selectGoList do
			local selectArr = string.split(curAskCfg["select" .. i], "#")

			table.insert(self._selectList, selectArr)
			table.insert(self._hasSelectList, 0)
		end
	end
end

function StickCoupletNormalGameView:_initCoupletUI()
	local coupletLength = #self._leftList

	for i, cell in ipairs(self._middleList) do
		cell.txtWord.text = self._middleStrArr[i]
	end

	if self._askType == GameEnum.StickCoupletNormalType.Left then
		for i = 1, coupletLength do
			self._leftList[i].txtWord.text = ""
			self._leftList[i].txtAnswer.text = ""
			self._rightList[i].txtWord.text = self._askStrArr[i]
			self._rightList[i].txtAnswer.text = ""

			GameUtil.SetActive(self._leftList[i].bgGo, true)
			GameUtil.SetActive(self._rightList[i].bgGo, false)
		end
	else
		for i = 1, coupletLength do
			self._leftList[i].txtWord.text = self._askStrArr[i]
			self._leftList[i].txtAnswer.text = ""
			self._rightList[i].txtWord.text = ""
			self._rightList[i].txtAnswer.text = ""

			GameUtil.SetActive(self._leftList[i].bgGo, false)
			GameUtil.SetActive(self._rightList[i].bgGo, true)
		end
	end
end

function StickCoupletNormalGameView:_initSelectUI()
	for i, cell in ipairs(self._selectGoList) do
		if self._selectList[i] then
			for j, txtWord in ipairs(cell.wordList) do
				txtWord.text = self._selectList[i][j] or "1"
			end
		end

		cell.imgChange:SetState(GameEnum.StickCoupletSelectType.Empty)
		GameUtil.SetActive(cell.imgSelect, false)
	end
end

function StickCoupletNormalGameView:_updateData()
	if self._hasSelectList[self._curSelectIdx] then
		self._hasSelectList[self._curSelectIdx] = self._hasSelectList[self._curSelectIdx] + 1
	end
end

function StickCoupletNormalGameView:_updateUI()
	self:_updateCoupletUI()
	self:_updateSelectUI()
end

function StickCoupletNormalGameView:_updateCoupletUI()
	if self._curSelectIdx ~= 0 then
		if self._selectList then
			if self._askType == GameEnum.StickCoupletNormalType.Left then
				for idx, cell in ipairs(self._leftList) do
					cell.txtWord.text = self._selectList[idx]
					cell.txtAnswer.text = self._selectList[idx]
				end
			else
				for idx, cell in ipairs(self._rightList) do
					cell.txtWord.text = self._selectList[idx]
					cell.txtAnswer.text = self._selectList[idx]
				end
			end
		end
	end
end

function StickCoupletNormalGameView:_updateSelectUI()
	for idx, cell in ipairs(self._selectGoList) do
		if self._hasSelectList[self._curSelectIdx] <= 0 and idx == self._curSelectIdx then
			cell.imgChange:SetState(GameEnum.StickCoupletSelectType.Correct)
		elseif self._hasSelectList[idx] > 0 then
			cell.imgChange:SetState(GameEnum.StickCoupletSelectType.Fault)
		else
			cell.imgChange:SetState(GameEnum.StickCoupletSelectType.Empty)
		end

		GameUtil.SetActive(cell.imgSelect, idx == self._curSelectIdx)
	end
end

function StickCoupletNormalGameView:_startGame()
	self._time = 100
	self._curScore = 0
	self._winNum = 0

	settimer(1, self._updateTime, self)
end

function StickCoupletNormalGameView:_reStartGame()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self)
end

function StickCoupletNormalGameView:_updateTime()
	self._time = self._time - 1
	self._txtTime.text = self._time

	if self._time == 0 then
		local text = "本次累计答对" .. self._winNum .. "对对联"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			StickCoupletController.instance:sendPM_StickCoupletEndGameReq(self._activityId, self._curScore)
			self:close()
		end, "退出")
	end
end

function StickCoupletNormalGameView:_onClickSelectGo(idx)
	self._curSelectIdx = idx

	self:_updateUI()
end

function StickCoupletNormalGameView:_canSubmit()
	self._stopSubmit = false

	removetimer(self._canSubmit, self)
end

function StickCoupletNormalGameView:_onClickBtnSubmit()
	if self._curSelectIdx == 0 then
		FloatWordMgr.instance:show("请选择答案后提交")

		return
	end

	if self._stopSubmit then
		FloatWordMgr.instance:show("请2秒后作答")

		return
	end

	if self._curSelectIdx == self._correctId then
		self._curScore = self._curScore + self._actcfg.normalScore
		self._winNum = self._winNum + 1
		self._txtScore.text = self._winNum

		FloatWordMgr.instance:show("恭喜答对，进入下一题")
		self:_onInit()
	else
		self:_onUpdate()
		FloatWordMgr.instance:show("请再认真思考一下~")

		self._stopSubmit = true

		settimer(2, self._canSubmit, self)
	end
end

function StickCoupletNormalGameView:_onClickBtnClose()
	removetimer(self._updateTime, self)

	local text = "是否要退出游戏\n现阶段退出不累计当前所获得积分"

	local function okFunc()
		StickCoupletController.instance:sendPM_StickCoupletEndGameReq(self._activityId, 0)
		self:close()
	end

	local function cancelFunc()
		settimer(1, self._updateTime, self)
	end

	TipsFacade.instance:openPopupWindow("提示", text, okFunc, cancelFunc, "确定", "取消")
end

function StickCoupletNormalGameView:_onClickBtnTip()
	local key = self._actcfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return StickCoupletNormalGameView
