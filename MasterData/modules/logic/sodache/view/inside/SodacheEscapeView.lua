-- chunkname: @modules/logic/sodache/view/inside/SodacheEscapeView.lua

module("modules.logic.sodache.view.inside.SodacheEscapeView", package.seeall)

local SodacheEscapeView = class("SodacheEscapeView", BaseView)

function SodacheEscapeView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "root/content/title/#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/content/#txt_desc")
	self._goexit = gohelper.findChild(self.viewGO, "root/content/btn/#go_exit")
	self._btnCancel = gohelper.findChildButtonWithAudio(self._goexit, "#btn_cancel")
	self._btnRetreat = gohelper.findChildButtonWithAudio(self._goexit, "#btn_retreat")
	self._gocondition = gohelper.findChild(self.viewGO, "root/content/go_condition")
	self._txtcondition = gohelper.findChildTextMesh(self.viewGO, "root/content/go_condition/type1/#txt_desc")
end

function SodacheEscapeView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnCancel:AddClickListener(self.closeThis, self)
	self._btnRetreat:AddClickListener(self.triggerUnit, self)
end

function SodacheEscapeView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnRetreat:RemoveClickListener()
end

function SodacheEscapeView:onOpen()
	self._unitMo = self.viewParam.unitMo
	self._txttitle.text = self._unitMo.eventCo.name
	self._txtdesc.text = self._unitMo.eventCo.desc

	gohelper.setActive(self._goexit, true)

	local cardNum = tonumber(self._unitMo.eventCo.typeParam) or 0

	gohelper.setActive(self._gocondition, cardNum > 0)

	if cardNum > 0 then
		self._txtcondition.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_mapretreatview_count"), cardNum)
	end
end

function SodacheEscapeView:triggerUnit()
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Interaction, tostring(self._unitMo.uid))
	self:closeThis()
end

return SodacheEscapeView
