-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongResultView.lua

module("logic.extensions.tongbattle.view.TongResultView", package.seeall)

local TongResultView = class("TongResultView", ViewComponent)

function TongResultView:ctor()
	TongResultView.super.ctor(self)
end

function TongResultView:bindEvents()
	TongResultView.super.bindEvents(self)
	self._leftBtn:AddClickListener(function()
		self:_onClickleftRightBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickleftRightBtn(false)
	end, self)
end

function TongResultView:unbindEvents()
	TongResultView.super.unbindEvents(self)
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
end

function TongResultView:onExit()
	TongResultView.super.onExit(self)
end

function TongResultView:destroyUI()
	TongResultView.super.destroyUI(self)
end

function TongResultView:buildUI()
	TongResultView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._descTxt = goutil.findChildTextComponent(viewBgGo, "descTxt")

	local allBtnsGo = goutil.findChild(viewBgGo, "allBtnsGo")

	self._leftBtnGo = goutil.findChild(allBtnsGo, "leftBtnGo")
	self._rightBtnGo = goutil.findChild(allBtnsGo, "rightBtnGo")
	self._leftBtn = Framework.ButtonAdapter.GetFrom(self._leftBtnGo, "leftBtn")
	self._rightBtn = Framework.ButtonAdapter.GetFrom(self._rightBtnGo, "rightBtn")
	self._leftTxt = goutil.findChildTextComponent(self._leftBtnGo, "leftTxt")
	self._btnTxt = goutil.findChildTextComponent(self._rightBtnGo, "rightBtn/btnTxt")
	self._rightTxt = goutil.findChildTextComponent(self._rightBtnGo, "rightTxt")
	self._descTxt.text = ""
	self._leftTxt.text = ""
	self._rightTxt.text = ""
end

function TongResultView:onEnter()
	TongResultView.super.onEnter(self)

	self._paramInfo = self:getFirstParam()

	if self._paramInfo == nil then
		printError("sr---桶挑战 TongResultView:onEnter()   传入参数错误！")

		return
	end

	self._descTxt.text = self._paramInfo.desc

	if self._paramInfo.isFirst then
		self._leftTxt.text = ""

		GameUtil.SetActive(self._leftBtnGo, false)

		self._rightTxt.text = langPara("text_tong_desc_22", self._paramInfo.newTurns, self._paramInfo.allTurns)
		self._btnTxt.text = lang("text_tong_know")
	else
		GameUtil.SetActive(self._leftBtnGo, true)

		self._leftTxt.text = langPara("text_tong_desc_22", self._paramInfo.oldTurns, self._paramInfo.allTurns)
		self._rightTxt.text = langPara("text_tong_desc_22", self._paramInfo.newTurns, self._paramInfo.allTurns)
		self._btnTxt.text = lang("text_equip_replace")
	end
end

function TongResultView:_onClickleftRightBtn(isLeft)
	TongBattleController.instance:csGetTongStageRoundsReq(not isLeft, self._paramInfo.newTurns - self._paramInfo.oldTurns)
	self:close()
end

return TongResultView
