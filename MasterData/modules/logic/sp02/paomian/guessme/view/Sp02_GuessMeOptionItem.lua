-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeOptionItem.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeOptionItem", package.seeall)

local Sp02_GuessMeOptionItem = class("Sp02_GuessMeOptionItem", LuaCompBase)

function Sp02_GuessMeOptionItem:init(go)
	self.go = go
	self._btnClick = gohelper.findChildButton(self.go, "btn_Click")

	self:initTypeUITab()
end

function Sp02_GuessMeOptionItem:initTypeUITab()
	self._typeTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goRoot = gohelper.findChild(self.go, "btn" .. i)

		if gohelper.isNil(goRoot) then
			break
		end

		local subTypeTab = self:getUserDataTb_()

		subTypeTab.goRoot = goRoot
		subTypeTab.goNormal = gohelper.findChild(goRoot, "#nomal")
		subTypeTab.txtNormalContent = gohelper.findChildText(goRoot, "#nomal/txt_Content")
		subTypeTab.goRight = gohelper.findChild(goRoot, "#right")
		subTypeTab.txtRightContent = gohelper.findChildText(goRoot, "#right/txt_Content")
		subTypeTab.rightAnim = gohelper.onceAddComponent(subTypeTab.goRight, gohelper.Type_Animator)
		subTypeTab.goError = gohelper.findChild(goRoot, "#error")
		subTypeTab.txtErrorContent = gohelper.findChildText(goRoot, "#error/txt_Content")
		subTypeTab.errorAnim = gohelper.onceAddComponent(subTypeTab.goError, gohelper.Type_Animator)
		self._typeTab[i] = subTypeTab
	end

	self._typeNum = tabletool.len(self._typeTab)
end

function Sp02_GuessMeOptionItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnSelectGuessMeOption, self._onSelectOption, self)
end

function Sp02_GuessMeOptionItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_GuessMeOptionItem:_btnClickOnClick()
	if self._status >= Sp02_GuessMeEnum.TaskStatus.CanGet or self._isEdit then
		return
	end

	self._isEdit = true

	Sp02_PaoMianController.instance:dispatchEvent(Sp02_GuessMeEvent.OnSelectGuessMeOption, self._index)

	if self._isRight then
		GameUtil.setActiveUIBlock("Sp02_GuessMeOptionItem", true, false)
		TaskDispatcher.runDelay(self._sendAnswerRpc, self, 0.2)
		self:playTypeTabAnim("rightAnim", "open")
		AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.GuessMeSelectRight)
	else
		self:playTypeTabAnim("errorAnim", "open")
		AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.GuessMeSelectError)
	end
end

function Sp02_GuessMeOptionItem:_sendAnswerRpc()
	GameUtil.setActiveUIBlock("Sp02_GuessMeOptionItem", false, true)
	Activity238Rpc.instance:sendAct238AnswerRequest(self._activityId, self._taskId)
end

function Sp02_GuessMeOptionItem:onUpdateMO(index, optionInfo, taskCo, signMo)
	self._index = index
	self._optionInfo = optionInfo
	self._taskCo = taskCo
	self._signMo = signMo
	self._activityId = self._taskCo and self._taskCo.activityId
	self._taskId = self._taskCo and self._taskCo.id
	self._status = self._signMo and self._signMo:getStatus() or Sp02_GuessMeEnum.TaskStatus.Lock
	self._correctOption = self._taskCo and self._taskCo.correctOption
	self._isRight = self._correctOption == index
	self._isSelect = false
	self._isEdit = false

	self:refreshUI()
end

function Sp02_GuessMeOptionItem:refreshUI()
	TaskDispatcher.cancelTask(self._sendAnswerRpc, self)
	GameUtil.setActiveUIBlock("Sp02_GuessMeOptionItem", false, true)

	local typeTab = self:getAndShowTypeTab(self._index)

	if not typeTab then
		return
	end

	gohelper.setActive(typeTab.goNormal, false)
	gohelper.setActive(typeTab.goRight, false)
	gohelper.setActive(typeTab.goError, false)

	typeTab.txtNormalContent.text = self._optionInfo
	typeTab.txtRightContent.text = self._optionInfo
	typeTab.txtErrorContent.text = self._optionInfo

	local isUnlock = self._status == Sp02_GuessMeEnum.TaskStatus.UnLock
	local isFinish = self._status >= Sp02_GuessMeEnum.TaskStatus.CanGet

	gohelper.setActive(typeTab.goNormal, isUnlock and not self._isEdit)
	gohelper.setActive(typeTab.goRight, (not isFinish or nil) and self._isEdit and self._isRight)
	gohelper.setActive(typeTab.goError, (not isFinish or nil) and self._isEdit and not self._isRight)
end

function Sp02_GuessMeOptionItem:getAndShowTypeTab(index)
	if not self._typeTab then
		return
	end

	index = index % self._typeNum
	index = index ~= 0 and index or self._typeNum

	for i, typeTab in pairs(self._typeTab) do
		if typeTab and typeTab.goRoot then
			gohelper.setActive(typeTab.goRoot, i == index)
		end
	end

	return self._typeTab and self._typeTab[index]
end

function Sp02_GuessMeOptionItem:playTypeTabAnim(animCompName, animName)
	if self._typeTab then
		local typeTab = self._typeTab[self._index]
		local animInst = typeTab and typeTab[animCompName]

		if animInst then
			animInst:Play(animName, 0, 0)
		end
	end
end

function Sp02_GuessMeOptionItem:onDestroy()
	TaskDispatcher.cancelTask(self._sendAnswerRpc, self)
	GameUtil.setActiveUIBlock("Sp02_GuessMeOptionItem", false, true)
end

function Sp02_GuessMeOptionItem:_onSelectOption(index)
	local isSelect = index == self._index

	if isSelect == self._isSelect then
		return
	end

	self._isSelect = isSelect

	self:refreshUI()
end

return Sp02_GuessMeOptionItem
