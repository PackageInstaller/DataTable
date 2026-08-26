-- chunkname: @modules/logic/sodache/view/inside/SodacheRandomEventView.lua

module("modules.logic.sodache.view.inside.SodacheRandomEventView", package.seeall)

local SodacheRandomEventView = class("SodacheRandomEventView", BaseView)

function SodacheRandomEventView:onInitView()
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "root/#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#scroll_descview/Viewport/Content/#txt_desc")
	self._goresult = gohelper.findChild(self.viewGO, "root/#go_result")
	self._txtresult = gohelper.findChildTextMesh(self.viewGO, "root/#go_result/#scroll_descview/Viewport/Content/#txt_desc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._gotipclose = gohelper.findChild(self.viewGO, "root/#go_result/txt_close")
	self._gobtn = gohelper.findChild(self.viewGO, "root/#go_btn")
end

function SodacheRandomEventView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClosePanel, self._onPanelClose, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUpdatePanel, self._refreshOptions, self)
end

function SodacheRandomEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClosePanel, self._onPanelClose, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUpdatePanel, self._refreshOptions, self)
end

function SodacheRandomEventView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.randomevent_open)

	local panelMo = SodacheModel.instance:getInsideMo().panelBox.currPanel
	local unitMo = panelMo:getUnitMo()

	self._panelMo = panelMo
	self._unitMo = unitMo
	self._txttitle.text = unitMo.eventCo.name
	self._txtdesc.text = unitMo.eventCo.desc
	self._choiceComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobtn, SodacheEventChoiceItem)

	self:_refreshOptions()
end

local resultToDescKey = {
	[0] = "descLose",
	"descSuccess",
	"descBigSuccess"
}

function SodacheRandomEventView:_refreshOptions()
	local lastOption = self._panelMo.selectLinkIds[#self._panelMo.selectLinkIds]
	local resultTxt

	if lastOption then
		local optionCo = lua_sodache_choice.configDict[lastOption]

		resultTxt = optionCo[resultToDescKey[self._panelMo.optionId2result[lastOption] or 1]]
	end

	if string.nilorempty(resultTxt) then
		gohelper.setActive(self._goresult, false)
	else
		gohelper.setActive(self._goresult, true)

		self._txtresult.text = resultTxt

		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.randomevent_result)
	end

	self._choiceComp:initData(self._panelMo.options)
	gohelper.setActive(self._btnclose, #self._panelMo.options == 0)
	gohelper.setActive(self._gotipclose, #self._panelMo.options == 0)
end

function SodacheRandomEventView:_onPanelClose()
	self.isPanelClose = true
end

function SodacheRandomEventView:onClickModalMask()
	if self._btnclose.gameObject.activeSelf then
		self:closeThis()
	end
end

function SodacheRandomEventView:onClose()
	if not self.isPanelClose then
		-- block empty
	end
end

return SodacheRandomEventView
