-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorTipsView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorTipsView", package.seeall)

local IgorTipsView = class("IgorTipsView", BaseView)

function IgorTipsView:onInitView()
	self.goclose = gohelper.findChild(self.viewGO, "#go_close")
	self.goscrolltip = gohelper.findChild(self.viewGO, "#scroll_tip")
	self.gocontent = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content")
	self.gotipitem = gohelper.findChild(self.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")
end

function IgorTipsView:addEvents()
	self.closeClick = gohelper.getClickWithDefaultAudio(self.goclose)

	self.closeClick:AddClickListener(self.closeThis, self)
end

function IgorTipsView:removeEvents()
	self.closeClick:RemoveClickListener()

	self.closeClick = nil
end

function IgorTipsView:onOpen()
	self.rectTrScrollTip = self.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = self.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.gotipitem, false)

	self.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(self.goscrolltip)

	if not self.viewParam.offsetX then
		local offsetX = 0

		if not self.viewParam.offsetY then
			local offsetY = 0

			if not self.viewParam.screenPos then
				local screenPos = GamepadController.instance:getMousePosition()

				if not self.viewParam.pivot then
					local pivot = Vector2()

					self.rectTrScrollTip.pivot = pivot

					local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(screenPos, self.rectTrViewGo)

					anchorPosX = pivot.x > 0 and anchorPosX - CommonBuffTipEnum.DefaultInterval or anchorPosX + CommonBuffTipEnum.DefaultInterval
					anchorPosY = pivot.y > 0 and anchorPosY - CommonBuffTipEnum.DefaultInterval or anchorPosY + CommonBuffTipEnum.DefaultInterval

					recthelper.setAnchor(self.rectTrScrollTip, anchorPosX + offsetX, anchorPosY + offsetY)

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
		end
	end
end

function IgorTipsView:_onCreateItem(obj, data, index)
	local txtName = gohelper.findChildText(obj, "title/txt_name")
	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local goTag = gohelper.findChild(obj, "title/txt_name/go_tag")

	txtName.text = data.title
	txtDesc.text = data.desc

	gohelper.setActive(goTag, false)
end

return IgorTipsView
