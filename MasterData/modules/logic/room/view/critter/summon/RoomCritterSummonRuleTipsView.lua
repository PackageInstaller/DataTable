-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonRuleTipsView.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsView", package.seeall)

local RoomCritterSummonRuleTipsView = class("RoomCritterSummonRuleTipsView", BaseView)

function RoomCritterSummonRuleTipsView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonRuleTipsView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function RoomCritterSummonRuleTipsView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function RoomCritterSummonRuleTipsView:_btnclose1OnClick()
	self:closeThis()
end

function RoomCritterSummonRuleTipsView:_btnclose2OnClick()
	self:closeThis()
end

function RoomCritterSummonRuleTipsView:_editableInitView()
	self._txttilte = gohelper.findChildText(self.viewGO, "title/titlecn")
	self._txttilteEn = gohelper.findChildText(self.viewGO, "title/titlecn/titleen")
end

function RoomCritterSummonRuleTipsView:onUpdateParam()
	return
end

function RoomCritterSummonRuleTipsView:onOpen()
	local type = self.viewParam.type
	local typedesc = RoomSummonEnum.SummonMode[type].RuleTipDesc
	local langTxt = luaLang(typedesc.desc)
	local strs = string.split(langTxt, "|")

	for i = 1, #strs, 2 do
		local item = gohelper.cloneInPlace(self._goinfoitem, "infoitem")

		gohelper.setActive(item, true)

		gohelper.findChildTextMesh(item, "txt_title").text = strs[i]
		gohelper.findChildTextMesh(item, "txt_desc").text = strs[i + 1]
	end

	self._txttilte.text = luaLang(typedesc.titlecn)
	self._txttilteEn.text = luaLang(typedesc.titleen)
end

function RoomCritterSummonRuleTipsView:onClose()
	return
end

function RoomCritterSummonRuleTipsView:onDestroyView()
	return
end

return RoomCritterSummonRuleTipsView
