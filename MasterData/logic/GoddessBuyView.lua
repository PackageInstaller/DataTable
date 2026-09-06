-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/view/GoddessBuyView.lua

module("logic.extensions.goddessvote.view.GoddessBuyView", package.seeall)

local GoddessBuyView = class("GoddessBuyView", ViewComponent)

function GoddessBuyView:ctor()
	GoddessBuyView.super.ctor(self)
end

function GoddessBuyView:bindEvents()
	GoddessBuyView.super.bindEvents(self)
	self._reduceBtn:AddClickListener(function()
		self:_onClickChangeNum(-1)
	end)
	self._addBtn:AddClickListener(function()
		self:_onClickChangeNum(1)
	end)
	self._sureBtn:AddClickListener(function()
		self:_onClickAgree()
	end)
	self._cancelBtn:AddClickListener(self.close, self)
	self._strItemIpt:AddOnValueChanged(self._onValueChanged, self)
end

function GoddessBuyView:unbindEvents()
	GoddessBuyView.super.unbindEvents(self)
	self._reduceBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._strItemIpt:RemoveOnValueChanged()
end

function GoddessBuyView:destroyUI()
	GoddessBuyView.super.destroyUI(self)
	uGuiUtil.clearImage(self._haveImaGo)
end

function GoddessBuyView:buildUI()
	GoddessBuyView.super.buildUI(self)

	self._strItemIpt = self:getInput("viewInfoGo/strItemIpt")
	self._reduceBtn = self:getBtn("viewInfoGo/reduceBtn")
	self._addBtn = self:getBtn("viewInfoGo/addBtn")
	self._sureBtn = self:getBtn("viewInfoGo/sureBtn")
	self._cancelBtn = self:getBtn("viewInfoGo/cancelBtn")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "viewInfoGo/descTxt")
	self._limitTxt = goutil.findChildTextComponent(self.mainGO, "viewInfoGo/limitTxt")
	self._haveTxt = goutil.findChildTextComponent(self.mainGO, "viewInfoGo/haveTxt")
	self._haveImaGo = self:getGo("viewInfoGo/haveTxt/haveIma")
	self._descTxt.text = ""
	self._limitTxt.text = ""
	self._haveTxt.text = ""
end

function GoddessBuyView:onEnter()
	GoddessBuyView.super.onEnter(self)

	local actId = self:getFirstParam()

	if checknumber(actId) <= 0 then
		printError("sr---超神龙召唤   GoddessBuyView:onEnter()      未传参数！！！")

		return
	end

	self._actCfg = GoddessVoteConfig.instance:getGoddessActivityCfg(actId)

	GameUtil.SetActive(self._haveTxt, true)

	self._setNumber = 0

	local haveCount = MaterialMgr.getMatCount(self._actCfg.voteItem)

	self._haveTxt.text = langPara("text_goddess_desc_7", haveCount)

	local goddessInfo = GoddessVoteModel.instance:getGoddessInfo()

	self._supCount = self._actCfg.voteItemDailyBuyLimit

	if goddessInfo and checknumber(goddessInfo.buyCount) > 0 then
		self._supCount = self._supCount - goddessInfo.buyCount
	end

	self._limitTxt.text = langPara("text_goddess_desc_8", self._supCount, self._actCfg.voteItemDailyBuyLimit)

	MaterialMgr.updateItemByStr(self._haveImaGo, self._actCfg.voteItem)
	self:_setChargeNum()
end

function GoddessBuyView:_setChargeNum()
	self._strItemIpt:SetText(tostring(self._setNumber))

	if self._setNumber > 0 then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.voteItemPrice)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local tempName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.voteItem)

		self._descTxt.text = langPara("text_goddess_desc_9", matNum * self._setNumber, matName, tempName, self._setNumber)
	else
		self._descTxt.text = lang("text_goddess_desc_11")
	end
end

function GoddessBuyView:_onClickChangeNum(num)
	if checknumber(self._supCount) <= 0 then
		FloatWordMgr.instance:show(lang("text_goddess_desc_10"))

		return
	end

	self._setNumber = self._setNumber + num
	self._setNumber = Mathf.Clamp(self._setNumber, 0, self._supCount)

	self:_setChargeNum()
end

function GoddessBuyView:_onValueChanged(strNum)
	self._setNumber = checkint(strNum)
	self._setNumber = Mathf.Clamp(self._setNumber, 0, self._supCount)

	self:_setChargeNum()
end

function GoddessBuyView:_onClickAgree()
	self._setNumber = checknumber(self._setNumber)

	if self._setNumber <= 0 then
		FloatWordMgr.instance:show(lang("text_goddess_desc_11"))

		return
	end

	if self._setNumber > self._supCount then
		FloatWordMgr.instance:show(lang("text_goddess_desc_12"))

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.voteItemPrice)
	local haveCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if haveCount < matNum * self._setNumber then
		local name = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(langPara("text_goddess_desc_13", name))

		return
	end

	GoddessVoteController.instance:csRequestGVBuyVoteItemReq(self._actCfg.activityId, self._setNumber)
	self:close()
end

return GoddessBuyView
