-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberResultView.lua

module("logic.extensions.numberbomb.view.NumberResultView", package.seeall)

local NumberResultView = class("NumberResultView", ViewComponent)

function NumberResultView:ctor()
	NumberResultView.super.ctor(self)
end

function NumberResultView:bindEvents()
	NumberResultView.super.bindEvents(self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
end

function NumberResultView:unbindEvents()
	NumberResultView.super.unbindEvents(self)
	self._sureBtn:RemoveClickListener()
end

function NumberResultView:onExit()
	NumberResultView.super.onExit(self)
end

function NumberResultView:destroyUI()
	NumberResultView.super.destroyUI(self)
end

function NumberResultView:buildUI()
	NumberResultView.super.buildUI(self)

	local viewInfoGo = self:getGo("viewInfoGo")

	self._sureBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "sureBtn")
	self._deseTxt = goutil.findChildTextComponent(viewInfoGo, "deseTxt")
	self._scoreTxt = goutil.findChildTextComponent(viewInfoGo, "scoreTxt")
	self._daibiTxt = goutil.findChildTextComponent(viewInfoGo, "daibiTxt")
	self._deseTxt.text = ""
	self._scoreTxt.text = ""
	self._daibiTxt.text = ""
end

function NumberResultView:onEnter()
	NumberResultView.super.onEnter(self)

	self._callBack = NumberGameModel.instance:getFinishCallBack(NumberGameModel.CallBackTypes_GameEnd)
	self._overInfo = NumberGameModel.instance:getAndSetGameOverData(true)

	local endRank = self._overInfo and checknumber(self._overInfo.endRank) or 4
	local endScore = self._overInfo and checknumber(self._overInfo.endScore) or 0
	local endDaibi = self._overInfo and checknumber(self._overInfo.endDaibi) or 0

	self._deseTxt.text = string.format("本局游戏，你排名第<color=#eb4642>%s</color>，结算如下：", endRank)
	self._scoreTxt.text = "本局积分：" .. endScore

	if endDaibi <= 0 then
		self._daibiTxt.text = ""

		return
	end

	local actiId = NumberGameConfig.instance:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		local commonCfgInfo = NumberGameConfig.instance:getCommonInfo()

		actiId = commonCfgInfo and commonCfgInfo.lastActiId or 0
	end

	if checknumber(actiId) <= 0 then
		self._daibiTxt.text = "本局炸弹币：" .. endDaibi

		return
	end

	local cfg = NumberGameConfig.instance:getActivityCfg(actiId)

	if cfg == nil or string.nilorempty(cfg.coinItem) then
		self._daibiTxt.text = "本局炸弹币：" .. endDaibi

		return
	end

	local matCfg = MaterialMgr.getMatCfgByStr(cfg.coinItem)

	if matCfg == nil or string.nilorempty(matCfg.name) then
		self._daibiTxt.text = "本局炸弹币：" .. endDaibi

		return
	end

	self._daibiTxt.text = string.format("本局%s：%s", matCfg.name, endDaibi)
end

function NumberResultView:_onClickSureBtn()
	self:close()

	if self._callBack then
		self._callBack()
	end

	self._callBack = nil

	if self._overInfo and self._overInfo.setId then
		MaterialController.instance:showChangeSetInTemp(self._overInfo.setId)
	end

	self._overInfo = nil

	GlobalDispatcher:dispatch(GlobalNotify.NumberGameViewClose)
end

return NumberResultView
