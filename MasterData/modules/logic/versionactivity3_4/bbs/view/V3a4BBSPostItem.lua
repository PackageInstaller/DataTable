-- chunkname: @modules/logic/versionactivity3_4/bbs/view/V3a4BBSPostItem.lua

module("modules.logic.versionactivity3_4.bbs.view.V3a4BBSPostItem", package.seeall)

local V3a4BBSPostItem = class("V3a4BBSPostItem", ListScrollCellExtend)

function V3a4BBSPostItem:onInitView()
	self._txtsendername = gohelper.findChildText(self.viewGO, "top/#txt_sendername")
	self._txtsendstation = gohelper.findChildText(self.viewGO, "top/#txt_sendstation")
	self._txtsendtime = gohelper.findChildText(self.viewGO, "top/#txt_sendtime")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._txtquoteuser = gohelper.findChildText(self.viewGO, "#go_content/#txt_quoteuser")
	self._txtreply = gohelper.findChildText(self.viewGO, "#go_content/#txt_reply")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "#go_content/#simage_pic")
	self._imagepic = gohelper.findChildImage(self.viewGO, "#go_content/#simage_pic")
	self._txtip = gohelper.findChildText(self.viewGO, "#txt_ip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4BBSPostItem:addEvents()
	return
end

function V3a4BBSPostItem:removeEvents()
	return
end

function V3a4BBSPostItem:_editableInitView()
	return
end

function V3a4BBSPostItem:_editableAddEvents()
	return
end

function V3a4BBSPostItem:_editableRemoveEvents()
	return
end

function V3a4BBSPostItem:onUpdateMO(mo)
	self.mo = mo

	self:_refreshQuote()
	self:_refreshReply()
	self:_refreshSender()
end

function V3a4BBSPostItem:_refreshQuote()
	local quoteInfo = self.mo:getQuoteInfo()

	if quoteInfo then
		local mo = V3a4BBSModel.instance:getPostStepMo(quoteInfo[1], quoteInfo[2])

		if mo then
			local lang = luaLang("v3a4bbs_quoteuser")
			local quote = GameUtil.getSubPlaceholderLuaLangOneParam(lang, mo.co.name)

			self._txtquoteuser.text = string.format("%s\n%s", quote, mo.co.decs)
		end
	end

	gohelper.setActive(self._txtquoteuser.gameObject, quoteInfo ~= nil)
end

function V3a4BBSPostItem:_refreshReply()
	if self.mo.co then
		self._txtreply.text = self.mo.co.decs
		self._txtip.text = self.mo.co.ipAdress

		local icon = self.mo.co.image

		if string.nilorempty(icon) then
			gohelper.setActive(self._simagepic.gameObject, false)
		else
			gohelper.setActive(self._simagepic.gameObject, true)
			self._simagepic:LoadImage(ResUrl.getDungeonFragmentIcon(icon), function()
				self._imagepic:SetNativeSize()
			end)
		end
	end
end

function V3a4BBSPostItem:_refreshSender()
	local co = self.mo.co

	if co then
		self._txtsendername.text = co.name
		self._txtsendtime.text = co.date
		self._txtsendstation.text = co.bbsName
	end
end

function V3a4BBSPostItem:onDestroyView()
	self._simagepic:UnLoadImage()
end

return V3a4BBSPostItem
