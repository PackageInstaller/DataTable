-- chunkname: @modules/logic/sodache/view/inside/SodacheMapSelectTimeView.lua

module("modules.logic.sodache.view.inside.SodacheMapSelectTimeView", package.seeall)

local SodacheMapSelectTimeView = class("SodacheMapSelectTimeView", BaseView)

function SodacheMapSelectTimeView:onInitView()
	self._gotimeitem = gohelper.findChild(self.viewGO, "times/item")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ok")
end

function SodacheMapSelectTimeView:addEvents()
	self._btnok:AddClickListener(self._onClickOK, self)
end

function SodacheMapSelectTimeView:removeEvents()
	self._btnok:RemoveClickListener()
end

function SodacheMapSelectTimeView:onOpen()
	local insideMo = SodacheModel.instance:getInsideMo()
	local arr = string.splitToNumber(insideMo.copyCo.time, "#") or {}

	self._times = arr
	self._timeselects = self:getUserDataTb_()

	ZProj.UGUIHelper.SetGrayscale(self._btnok.gameObject, true)
	gohelper.CreateObjList(self, self._onCreateTimeItem, arr, nil, self._gotimeitem)
end

function SodacheMapSelectTimeView:_onCreateTimeItem(obj, data, index)
	local select = gohelper.findChild(obj, "#go_select")
	local click = gohelper.findChildButtonWithAudio(obj, "#btn_click")
	local cardGo = gohelper.findChild(obj, "#go_normal/#go_carditem/sodache_carditem")
	local name = gohelper.findChildTextMesh(obj, "bottom/#txt_name")
	local desc = gohelper.findChildTextMesh(obj, "bottom/txt_desc")
	local cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, SodacheCardItem)

	gohelper.setActive(select, false)

	self._timeselects[index] = select

	local cardMo = SodacheCardMo.Create(data)

	cardItem:updateMo(cardMo)

	name.text = cardMo.serverMo.itemCo.name
	desc.text = SodacheUtil.changeDescColor(cardMo.serverMo.itemCo.funcDesc)

	self.addClickCb(self, click, self._onTimeClick, self, index)
end

function SodacheMapSelectTimeView:_onTimeClick(index)
	for i, v in ipairs(self._timeselects) do
		gohelper.setActive(v, i == index)
	end

	self._curIndex = index

	ZProj.UGUIHelper.SetGrayscale(self._btnok.gameObject, false)
end

function SodacheMapSelectTimeView:_onClickOK()
	local selectItemId = self._times[self._curIndex]

	if not selectItemId then
		GameFacade.showToast(ToastEnum.SodacheToastId373002)

		return
	end

	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.SelectTime, tostring(selectItemId))
	self:closeThis()
end

return SodacheMapSelectTimeView
