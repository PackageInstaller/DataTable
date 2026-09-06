-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallShareView.lua

module("logic.extensions.recalltask.view.RecallShareView", package.seeall)

local RecallShareView = class("RecallShareView", ViewComponent)

function RecallShareView:ctor()
	RecallShareView.super.ctor(self)

	self._shareBtnsList = nil
end

function RecallShareView:bindEvents()
	RecallShareView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i = 1, #self._shareBtnsList do
		if self._shareBtnsList[i] then
			self._shareBtnsList[i]:AddClickListener(function()
				self:_onClickShareBtn(i)
			end, self)
		end
	end
end

function RecallShareView:unbindEvents()
	RecallShareView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i = 1, #self._shareBtnsList do
		if self._shareBtnsList[i] then
			self._shareBtnsList[i]:RemoveClickListener()
		end
	end
end

function RecallShareView:onExit()
	RecallShareView.super.onExit(self)
	SDKManager.unregisterShareListener()
end

function RecallShareView:destroyUI()
	RecallShareView.super.destroyUI(self)

	self._shareBtnsList = nil
end

function RecallShareView:buildUI()
	RecallShareView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._inputTxt = goutil.findChildTextComponent(self.mainGO, "codeInp/codeTxt")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "nameTxt")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descTxt")
	self._shareBtnsList = {
		self:getBtn("platformBtn/btn_1"),
		self:getBtn("platformBtn/btn_2"),
		self:getBtn("platformBtn/btn_3"),
		self:getBtn("platformBtn/btn_4"),
		self:getBtn("platformBtn/btn_5")
	}
	self._inputTxt.text = ""
	self._descTxt.text = ""
end

function RecallShareView:onEnter()
	RecallShareView.super.onEnter(self)

	local info = RecallTaskModel.instance:getRecallInfo()

	if info == nil or string.nilorempty(info.codes) then
		printError("sr---召回玩家    RecallShareView:onEnter()     没有码？？")
	end

	self._codeStr = info.codes
	self._descTxt.text = lang("text_recall_desc_29")
	self._inputTxt.text = self._codeStr

	SDKManager.registerShareListener(function(cade, desc)
		self:_onShareHander(cade, desc)
	end)
	ShareController.instance:checkOnlyShowQZone(self._shareBtnsList)
end

function RecallShareView:_onClickShareBtn(index)
	if (index == 2 or index == 3) and not ShareController.instance:isOpenShare() then
		FloatWordMgr.instance:show(lang("text_recall_desc_3"))

		return
	end

	SDKManager.share(SDKManager.SHARE_TEXT, langPara("text_recall_desc_27", self._codeStr), lang("text_recall_desc_4"), nil, nil, index - 1)
	self:close()
end

function RecallShareView:_onShareHander(cade, desc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if cade ~= SDKManager.SHARE_STATUS_CODE_SUCCESS and btplatformId ~= 2 and btplatformId ~= 10 then
		-- block empty
	end

	if cade == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		if btplatformId == 2 or btplatformId == 10 then
			TipsFacade.instance:openTipWindow(lang("text_share_name"), lang("text_recall_desc_5"))
		end
	elseif cade == SDKManager.SHARE_STATUS_CODE_FAIL then
		if SDKManager.isShowShareFailDesc() == true then
			TipsFacade.instance:openTipWindow("分享失败", desc)
		end
	elseif cade == SDKManager.SHARE_STATUS_CODE_CANCEL and (btplatformId == 2 or btplatformId == 10) then
		TipsFacade.instance:openTipWindow(lang("text_share_name"), desc)
	end
end

function RecallShareView:_onClickCopyBtn()
	NativeBridge.instance:invoke("com.baitian.wrap.ClipboardWrap", "copyclip", {
		content = langPara("text_recall_desc_27", self._codeStr)
	})
end

return RecallShareView
