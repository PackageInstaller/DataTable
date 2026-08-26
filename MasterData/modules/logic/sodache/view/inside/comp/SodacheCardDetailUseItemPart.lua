-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCardDetailUseItemPart.lua

module("modules.logic.sodache.view.inside.comp.SodacheCardDetailUseItemPart", package.seeall)

local SodacheCardDetailUseItemPart = class("SodacheCardDetailUseItemPart", BaseView)

function SodacheCardDetailUseItemPart:onInitView()
	self._gobottom = gohelper.findChild(self.viewGO, "Right/#go_Bottom")
	self._gocount = gohelper.findChild(self.viewGO, "Right/#go_Bottom/#go_Count")
	self._gocost = gohelper.findChild(self.viewGO, "Right/#go_Bottom/cost")
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Bottom/#btn_Upgrade")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "Right/#go_Bottom/#btn_Upgrade/Text")
end

function SodacheCardDetailUseItemPart:addEvents()
	self._btn:AddClickListener(self._onClickBtn, self)
end

function SodacheCardDetailUseItemPart:removeEvents()
	self._btn:RemoveClickListener()
end

function SodacheCardDetailUseItemPart:onOpen()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._gocount, false)
	gohelper.setActive(self._gocost, false)

	self._txtdesc.text = luaLang("sodache_carddetailview_btnuse")
end

function SodacheCardDetailUseItemPart:_onClickBtn()
	if SodacheMapUtil.instance:isInFlow() then
		return
	end

	local cardMo = self.viewParam.cardMo

	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.UseCard, tostring(cardMo.serverMo.configId))
	self:closeThis()
end

return SodacheCardDetailUseItemPart
