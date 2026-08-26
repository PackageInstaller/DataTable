-- chunkname: @modules/logic/survival/view/map/SurvivalCommonTipsView.lua

module("modules.logic.survival.view.map.SurvivalCommonTipsView", package.seeall)

local SurvivalCommonTipsView = class("SurvivalCommonTipsView", BaseView)

function SurvivalCommonTipsView:onInitView()
	self.goclose = gohelper.findChild(self.viewGO, "#go_close")
	self.goscrolltip = gohelper.findChild(self.viewGO, "#scroll_tip")
	self.gocontent = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content")
	self.gotipitem = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")
end

function SurvivalCommonTipsView:addEvents()
	self.closeClick = gohelper.getClickWithDefaultAudio(self.goclose)

	self.closeClick:AddClickListener(self.closeThis, self)
end

function SurvivalCommonTipsView:removeEvents()
	self.closeClick:RemoveClickListener()

	self.closeClick = nil
end

function SurvivalCommonTipsView:onOpen()
	self.rectTrScrollTip = self.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = self.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.gotipitem, false)

	self.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(self.goscrolltip)
	self.clickPosition = GamepadController.instance:getMousePosition()

	if not self.viewParam.pivot then
		local pivot = Vector2()

		self.rectTrScrollTip.pivot = pivot

		local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self.clickPosition, self.rectTrViewGo)

		anchorPosX = pivot.x > 0 and anchorPosX - CommonBuffTipEnum.DefaultInterval or anchorPosX + CommonBuffTipEnum.DefaultInterval
		anchorPosY = pivot.y > 0 and anchorPosY - CommonBuffTipEnum.DefaultInterval or anchorPosY + CommonBuffTipEnum.DefaultInterval

		recthelper.setAnchor(self.rectTrScrollTip, anchorPosX, anchorPosY)

		local viewHeight = recthelper.getHeight(self.rectTrViewGo)
		local anchorY = recthelper.getAnchorY(self.rectTrScrollTip)

		anchorY = math.abs(anchorY)
		self.maxHeight = viewHeight / 2 + anchorY - CommonBuffTipEnum.BottomMargin

		gohelper.CreateObjList(self, self._onCreateItem, self.viewParam.list, nil, self.gotipitem)
		ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

		local height = recthelper.getHeight(self.rectTrContent)

		height = math.min(self.maxHeight, height)

		recthelper.setHeight(self.rectTrScrollTip, height)

		self.scrollTip.verticalNormalizedPosition = 0
	end
end

function SurvivalCommonTipsView:_onCreateItem(obj, data, index)
	local txtName = gohelper.findChildText(obj, "title/txt_name")
	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local goTag = gohelper.findChild(obj, "title/txt_name/go_tag")

	txtName.text = data.title
	txtDesc.text = data.desc

	gohelper.setActive(goTag, false)
end

return SurvivalCommonTipsView
