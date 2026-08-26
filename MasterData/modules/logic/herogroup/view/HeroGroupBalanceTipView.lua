-- chunkname: @modules/logic/herogroup/view/HeroGroupBalanceTipView.lua

module("modules.logic.herogroup.view.HeroGroupBalanceTipView", package.seeall)

local HeroGroupBalanceTipView = class("HeroGroupBalanceTipView", BaseView)

function HeroGroupBalanceTipView:onInitView()
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._txtroleLv = gohelper.findChildTextMesh(self.viewGO, "lv/#txt_roleLv")
	self._txtequipLv = gohelper.findChildTextMesh(self.viewGO, "equipLv/#txt_equipLv")
	self._txttalent = gohelper.findChildTextMesh(self.viewGO, "talent/#txt_talent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupBalanceTipView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function HeroGroupBalanceTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function HeroGroupBalanceTipView:_editableInitView()
	self._rankGo = gohelper.findChild(self.viewGO, "lv/rankobj")
	self._ranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._ranks[i] = gohelper.findChild(self._rankGo, "rank" .. i)
	end
end

function HeroGroupBalanceTipView:onOpen()
	local lv, talent, equipLv = HeroGroupBalanceHelper.getBalanceLv()
	local showLv, rank = HeroConfig.instance:getShowLevel(lv)

	for i = 1, 3 do
		gohelper.setActive(self._ranks[i], rank - 1 == i)
	end

	self._txtroleLv.text = "Lv.<size=38>" .. showLv
	self._txtequipLv.text = "Lv.<size=38>" .. equipLv
	self._txttalent.text = "Lv.<size=38>" .. talent

	if rank == 1 then
		self._txtroleLv.alignment = TMPro.TextAlignmentOptions.Center

		recthelper.setAnchorX(self._txtroleLv.transform, 0)
	end
end

return HeroGroupBalanceTipView
