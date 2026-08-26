-- chunkname: @modules/logic/survival/view/SurvivalCurrencyTipView.lua

module("modules.logic.survival.view.SurvivalCurrencyTipView", package.seeall)

local SurvivalCurrencyTipView = class("SurvivalCurrencyTipView", BaseView)

function SurvivalCurrencyTipView:onInitView()
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._rootTrans = gohelper.findChild(self.viewGO, "root").transform
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#txt_dec")
end

function SurvivalCurrencyTipView:addEvents()
	self._click:AddClickListener(self.closeThis, self)
end

function SurvivalCurrencyTipView:removeEvents()
	self._click:RemoveClickListener()
end

function SurvivalCurrencyTipView:onOpen()
	self._rootTrans.pivot = self.viewParam.arrow == "BL" and Vector2(1, 1) or self.viewParam.arrow == "BR" and Vector2(0, 1) or Vector2(0, 0)

	local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform.parent)

	recthelper.setAnchor(self._rootTrans, anchorPos.x, anchorPos.y)

	if self.viewParam.txt then
		self._txtdesc.text = self.viewParam.txt
	else
		local id = self.viewParam.id
		local itemCo = lua_survival_item.configDict[id]

		if itemCo then
			self._txtdesc.text = itemCo.desc1 or ""
		end
	end
end

return SurvivalCurrencyTipView
