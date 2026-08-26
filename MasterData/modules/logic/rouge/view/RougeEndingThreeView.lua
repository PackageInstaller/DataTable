-- chunkname: @modules/logic/rouge/view/RougeEndingThreeView.lua

module("modules.logic.rouge.view.RougeEndingThreeView", package.seeall)

local RougeEndingThreeView = class("RougeEndingThreeView", BaseView)

function RougeEndingThreeView:onInitView()
	self._btnnext = gohelper.findChildButton(self.viewGO, "Content/#btn_next")
	self._txtcontent = gohelper.findChildText(self.viewGO, "Content/#go_success/txt_success")
	self._txttitle = gohelper.findChildText(self.viewGO, "Content/Title/#txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeEndingThreeView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function RougeEndingThreeView:removeEvents()
	self._btnnext:RemoveClickListener()
end

function RougeEndingThreeView:_btnnextOnClick()
	self:closeThis()
	RougeController.instance:openRougeResultView()
end

function RougeEndingThreeView:_editableInitView()
	local titleConstCo = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeTitle]
	local contentConstCo = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeContent]

	self._txttitle.text = titleConstCo and titleConstCo.value2
	self._txtcontent.text = contentConstCo and contentConstCo.value2
end

function RougeEndingThreeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenEndingThreeView)
end

return RougeEndingThreeView
