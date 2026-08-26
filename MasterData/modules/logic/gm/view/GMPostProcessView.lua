-- chunkname: @modules/logic/gm/view/GMPostProcessView.lua

module("modules.logic.gm.view.GMPostProcessView", package.seeall)

local GMPostProcessView = class("GMPostProcessView", BaseView)

GMPostProcessView.Pos = {
	Normal = {
		x = 0,
		y = 0
	},
	Hide = {
		x = -536,
		y = -571
	},
	Large = {
		x = 0,
		y = 451
	}
}
GMPostProcessView.SrcHeight = {
	Large = 1027,
	Hide = 568,
	Normal = 568
}
GMPostProcessView.State = {
	Large = "Large",
	Hide = "Hide",
	Normal = "Normal"
}

function GMPostProcessView:onInitView()
	self._state = GMPostProcessView.State.Normal
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Title/btnNormal")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Title/btnClose")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "Title/btnHide")
	self._btnLarge = gohelper.findChildButtonWithAudio(self.viewGO, "Title/btnLarge")
	self._scrollGO = gohelper.findChild(self.viewGO, "scroll")
end

function GMPostProcessView:addEvents()
	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnLarge:AddClickListener(self._onClickLarge, self)
end

function GMPostProcessView:removeEvents()
	self._btnNormal:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnLarge:RemoveClickListener()
end

function GMPostProcessView:onOpen()
	self:_updateUI()
end

function GMPostProcessView:onClose()
	return
end

function GMPostProcessView:_updateUI()
	gohelper.setActive(self._btnNormal.gameObject, self._state == GMPostProcessView.State.Large)
	gohelper.setActive(self._btnLarge.gameObject, self._state ~= GMPostProcessView.State.Large)

	local pos = GMPostProcessView.Pos[self._state]

	recthelper.setAnchor(self.viewGO.transform, pos.x, pos.y)

	local srcHeight = GMPostProcessView.SrcHeight[self._state]

	recthelper.setHeight(self._scrollGO.transform, srcHeight)
end

function GMPostProcessView:_onClickNormal()
	self._state = GMPostProcessView.State.Normal

	self:_updateUI()
end

function GMPostProcessView:_onClickHide()
	self._state = GMPostProcessView.State.Hide

	self:_updateUI()
end

function GMPostProcessView:_onClickLarge()
	self._state = GMPostProcessView.State.Large

	self:_updateUI()
end

return GMPostProcessView
