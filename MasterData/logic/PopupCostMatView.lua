-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatView.lua

module("logic.extensions.tips.view.PopupCostMatView", package.seeall)

local PopupCostMatView = class("PopupCostMatView", ViewComponent)

function PopupCostMatView:ctor()
	PopupCostMatView.super.ctor(self)
end

function PopupCostMatView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnToggle:AddClickListener(self._onClickToggle, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function PopupCostMatView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnToggle:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PopupCostMatView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._goToggle = self:getGo("main/toggle")
	self._btnToggle = self:getBtn("main/toggle/btnToggle")
	self._imgGou = goutil.findChild(self._btnToggle.btn.gameObject, "imgGou")
	self._txtToggle = goutil.findChildTextComponent(self._goToggle, "txtToggle")

	if self._txtToggle then
		self._strTxtToggle = self._txtToggle.text or ""
	end

	self._content = MaterialMgr.findGraphicText(self.mainGO, "main/content")
	self._curCount = goutil.findChildComponent(self.mainGO, "main/imgMyDiamond/txtNum", "Text")
	self._costCount = goutil.findChildComponent(self.mainGO, "main/imgCostDiamond/txtNum", "Text")
	self._imgIcon1 = goutil.findChild(self.mainGO, "main/imgCostDiamond/img")
	self._imgIcon2 = goutil.findChild(self.mainGO, "main/imgMyDiamond/img")
	self._imgIcon3 = goutil.findChild(self.mainGO, "main/imgIcon")
	self._btnSure = self:getBtn("main/btnSure")

	goutil.setActive(self._imgIcon3, false)
end

function PopupCostMatView:destroyUI()
	return
end

function PopupCostMatView:onEnter()
	local param = self._viewPresentor:getFirstParam()
	local matType = param.matType
	local matId = param.matId
	local matNum = param.matNum
	local content = param.content
	local alignment = param.alignment
	local togTxt = param.togTxt

	self.matType = checknumber(matType)
	self.matId = checknumber(matId)
	self.costNum = checknumber(matNum)
	self._content.text = content

	MaterialMgr.setIcon(self._imgIcon1.gameObject, matType, matId)
	MaterialMgr.setIcon(self._imgIcon2.gameObject, matType, matId)
	MaterialMgr.setIcon(self._imgIcon3.gameObject, matType, matId)

	self._myMatNums = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if matType == MatType.Diamond or matType == MatType.PayDiamond then
		self._myMatNums = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()
	end

	self._costNums = matNum
	self._curCount.text = self._myMatNums
	self._costCount.text = self._costNums

	if self._txtToggle then
		self._txtToggle.text = not string.nilorempty(togTxt) and togTxt or self._strTxtToggle
	end

	self._toggleCall = param.toggleFunc
	self._successCallBack = param.successCallBack
	self._otherCallBack = param.otherCallBack
	self._autoOpenSource = param.autoOpenSource ~= false

	goutil.setActive(self._goToggle, self._toggleCall ~= nil)
	goutil.setActive(self._imgGou, false)

	if alignment then
		self._content.alignment = alignment
	else
		local height = self._content.preferredHeight

		if height > 40 then
			self._content.alignment = UnityEngine.TextAnchor.MiddleLeft or UnityEngine.TextAnchor.MiddleCenter
		end
	end
end

function PopupCostMatView:onEnterFinished()
	return
end

function PopupCostMatView:onExit()
	self._toggleCall = nil

	MaterialMgr.clearIcon(self._imgIcon1.gameObject)
	MaterialMgr.clearIcon(self._imgIcon2.gameObject)
	MaterialMgr.clearIcon(self._imgIcon3.gameObject)
end

function PopupCostMatView:onExitFinished()
	return
end

function PopupCostMatView:_onClickClose()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_CANCEL)
	self:close()
end

function PopupCostMatView:_onClickSure()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_OK)

	if self.matType == MatType.GodGem and PasswordLockController.instance:checkNeedOpenVerifyView() then
		self:close()

		return
	end

	if not MaterialFacade.instance:checkMatEnough(self.matType, self.matId, self.costNum, nil, self._autoOpenSource) then
		self:close()
		GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_FAIL)

		return
	end

	self:close()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_SUCCESS)
	GameUtil.callBack(self._successCallBack)
end

function PopupCostMatView:_onClickToggle()
	goutil.setActive(self._imgGou, not self._imgGou.activeSelf)

	if self._toggleCall then
		self._toggleCall(not self._imgGou.activeSelf)
	end
end

return PopupCostMatView
