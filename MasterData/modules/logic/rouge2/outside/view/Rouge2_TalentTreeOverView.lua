-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeOverView.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeOverView", package.seeall)

local Rouge2_TalentTreeOverView = class("Rouge2_TalentTreeOverView", BaseView)

function Rouge2_TalentTreeOverView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._goattribute = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/base/#go_attribute")
	self._gotalentitem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_TalentTreeOverView:addEvents()
	return
end

function Rouge2_TalentTreeOverView:removeEvents()
	return
end

function Rouge2_TalentTreeOverView:_btnarrowOnClick()
	return
end

function Rouge2_TalentTreeOverView:_editableInitView()
	self._attributeItemList = {}
	self._talentItemList = {}
	self._attributeItemGo = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/base/#go_attribute/attribute")
	self._talentParentGo = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/talent")

	gohelper.setActive(self._attributeItemGo, false)
	gohelper.setActive(self._gotalentitem, false)
end

function Rouge2_TalentTreeOverView:onUpdateParam()
	return
end

function Rouge2_TalentTreeOverView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentOverView)

	self._attributeMo, self._showMo = Rouge2_TalentModel.instance:calculateTalent()

	if not self._showMo and not self._attributeMo then
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self._scrolldesc.gameObject, false)

		return
	else
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._scrolldesc.gameObject, true)
	end

	if next(self._showMo) then
		gohelper.CreateObjList(self, self.onDescItemShow, self._showMo, self._talentParentGo, self._gotalentitem, Rouge2_TalentOverviewDescItem)
	end

	if #self._attributeMo > 0 then
		for index, co in ipairs(self._attributeMo) do
			local item = self._attributeItemList[index]

			if not item then
				item = self:getUserDataTb_()

				local go = gohelper.cloneInPlace(self._attributeItemGo, index)
				local icon = gohelper.findChildImage(go, "icon")
				local rate = gohelper.findChildTextMesh(go, "txt_attribute")
				local name = gohelper.findChildTextMesh(go, "name")
				local bg = gohelper.findChild(go, "bg")

				item.go = go
				item.rate = rate
				item.name = name
				item.icon = icon

				local layout = math.ceil(index / 2)
				local showbg = layout % 2 ~= 0

				gohelper.setActive(go, true)
				gohelper.setActive(bg, showbg)
				table.insert(self._attributeItemList, item)
			end

			if co.ismul then
				local attributevalue = "+" .. co.rate * 0.1 .. "%"
				local rougevalue = "+" .. co.rate .. "%"

				item.rate.text = co.isattribute and attributevalue or rougevalue
			else
				item.rate.text = "+" .. co.rate
			end

			if co.isattribute then
				if co.id == 215 or co.id == 216 then
					UISpriteSetMgr.instance:setCommonSprite(item.icon, co.icon)
				end

				UISpriteSetMgr.instance:setCommonSprite(item.icon, co.icon)
			else
				UISpriteSetMgr.instance:setRougeSprite(item.icon, co.icon)
			end

			item.name.text = co.name
		end
	end
end

function Rouge2_TalentTreeOverView:onDescItemShow(item, talentId, index)
	item:setInfo(talentId)
end

function Rouge2_TalentTreeOverView:onClose()
	return
end

function Rouge2_TalentTreeOverView:onDestroyView()
	return
end

return Rouge2_TalentTreeOverView
