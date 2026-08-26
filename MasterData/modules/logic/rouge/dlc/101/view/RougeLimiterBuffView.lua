-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterBuffView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffView", package.seeall)

local RougeLimiterBuffView = class("RougeLimiterBuffView", BaseView)

function RougeLimiterBuffView:onInitView()
	self._gochoosebuff = gohelper.findChild(self.viewGO, "#go_choosebuff")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_choosebuff/#btn_close")
	self._gosmallbuffitem = gohelper.findChild(self.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	self._gobuffdec = gohelper.findChild(self.viewGO, "#go_buffdec")
	self._gobuff = gohelper.findChild(self.viewGO, "#go_buff")
	self._txtchoosebuff = gohelper.findChildText(self.viewGO, "#go_choosebuff/txt_choosebuff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterBuffView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeLimiterBuffView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RougeLimiterBuffView:_btncloseOnClick()
	self:closeThis()
end

function RougeLimiterBuffView:_editableInitView()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.OnSelectBuff, self._onSelectBuff, self)
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.CloseBuffDescTips, self._onCloseBuffDescTips, self)
end

function RougeLimiterBuffView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterBuffView)
	self:init()
end

function RougeLimiterBuffView:onUpdateParam()
	self:init()
end

function RougeLimiterBuffView:init()
	self._buffType = self.viewParam and self.viewParam.buffType

	RougeLimiterBuffListModel.instance:onInit(self._buffType)
	self:initBuffEntry()
	self:refreshTitle()
end

function RougeLimiterBuffView:refreshTitle()
	local buffTypeRoman = GameUtil.getRomanNums(self._buffType)

	self._txtchoosebuff.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougelimiterbuffoverview_txt_buff"), buffTypeRoman)
end

function RougeLimiterBuffView:initBuffEntry()
	if not self._buffEntry then
		local resUrl = self.viewContainer:getSetting().otherRes.LimiterItem

		self._gobufficon = self:getResInst(resUrl, self._gobuff, "#go_bufficon")
		self._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobufficon, RougeLimiterBuffEntry)

		self._buffEntry:refreshUI()
	end

	self._buffEntry:selectBuffEntry(self._buffType)
end

function RougeLimiterBuffView:_onSelectBuff(buffId, isSelect)
	self._buffTips = self._buffTips or MonoHelper.addNoUpdateLuaComOnceToGo(self._gobuffdec, RougeLimiterBuffTips)

	self._buffTips:onUpdateMO(buffId, isSelect)
	gohelper.setActive(self._btnclose.gameObject, not isSelect)
end

function RougeLimiterBuffView:_onCloseBuffDescTips()
	gohelper.setActive(self._btnclose.gameObject, true)
end

function RougeLimiterBuffView:onClose()
	return
end

function RougeLimiterBuffView:onDestroyView()
	return
end

return RougeLimiterBuffView
