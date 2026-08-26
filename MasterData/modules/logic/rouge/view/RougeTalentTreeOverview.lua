-- chunkname: @modules/logic/rouge/view/RougeTalentTreeOverview.lua

module("modules.logic.rouge.view.RougeTalentTreeOverview", package.seeall)

local RougeTalentTreeOverview = class("RougeTalentTreeOverview", BaseView)

function RougeTalentTreeOverview:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._goattribute = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/base/#go_attribute/attribute")
	self._gotalentitem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem")
	self._godetails = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem/#go_details")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._attributeItemList = {}
	self._talentItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeOverview:addEvents()
	return
end

function RougeTalentTreeOverview:removeEvents()
	for key, item in pairs(self._talentItemList) do
		if item and item.btn then
			item.btn:RemoveClickListener()
		end
	end
end

function RougeTalentTreeOverview:_editableInitView()
	return
end

function RougeTalentTreeOverview:onUpdateParam()
	return
end

function RougeTalentTreeOverview:onOpen()
	self._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentOverView)

	self._attributeMo, self._showMo = RougeTalentModel.instance:calculateTalent()

	if not self._showMo and not self._attributeMo then
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self._scrolldesc.gameObject, false)

		return
	else
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._scrolldesc.gameObject, true)
	end

	if next(self._showMo) then
		for talent, mo in pairs(self._showMo) do
			local item = self._talentItemList[talent]

			if not item then
				item = self:getUserDataTb_()

				local go = gohelper.cloneInPlace(self._gotalentitem, talent)
				local talentname = gohelper.findChildText(go, "info/img_titleline/#txt_talenname")
				local icon = gohelper.findChildImage(go, "info/img_titleline/#image_icon")
				local btn = gohelper.findChildButton(go, "info/#btn_arrow")
				local gobtnopen = gohelper.findChild(go, "info/#btn_arrow/open")
				local gobtnclose = gohelper.findChild(go, "info/#btn_arrow/close")

				item.go = go
				item.name = talentname
				item.icon = icon
				item.btn = btn
				item.gobtnopen = gobtnopen
				item.gobtnclose = gobtnclose
				item.isopen = false
				item.details = {}

				for _, talentid in pairs(mo) do
					local detail = self:getUserDataTb_()
					local detailGo = gohelper.clone(self._godetails, go, talentid)

					detail.go = detailGo

					gohelper.setActive(detailGo, false)

					detail.gotalentdesc = gohelper.findChild(detailGo, "#txt_unlockdec")
					detail.txttalentdesc = gohelper.findChildText(detailGo, "#txt_unlockdec")
					detail.goUnlockdesc = gohelper.findChild(detailGo, "#txt_talentdec")
					detail.txtUnlockdesc = gohelper.findChildText(detailGo, "#txt_talentdec")

					local co = RougeTalentConfig.instance:getBranchConfigByID(self._season, talentid)
					local isOrigin = co.isOrigin == 1

					gohelper.setActive(detail.gotalentdesc, not isOrigin)
					gohelper.setActive(detail.goUnlockdesc, isOrigin)

					detail.txttalentdesc.text = co.desc
					detail.txtUnlockdesc.text = co.desc
					item.details[talentid] = detail
				end

				local function click()
					item.isopen = not item.isopen

					if next(item.details) then
						for _, details in pairs(item.details) do
							local go = details.go

							gohelper.setActive(go, item.isopen)
						end
					end

					gohelper.setActive(gobtnopen, item.isopen)
					gohelper.setActive(gobtnclose, not item.isopen)
					AudioMgr.instance:trigger(AudioEnum.UI.ClickOverBranch)
				end

				gohelper.setActive(gobtnopen, false)
				gohelper.setActive(gobtnclose, true)
				item.btn:AddClickListener(click, self)
				gohelper.setActive(go, true)

				self._talentItemList[talent] = item
			end

			local talentco = RougeTalentConfig.instance:getConfigByTalent(self._season, talent)

			item.name.text = talentco.name

			UISpriteSetMgr.instance:setRougeSprite(item.icon, talentco.icon)
		end
	end

	if #self._attributeMo > 0 then
		for index, co in ipairs(self._attributeMo) do
			local item = self._attributeItemList[index]

			if not item then
				item = self:getUserDataTb_()

				local go = gohelper.cloneInPlace(self._goattribute, index)
				local icon = gohelper.findChildImage(go, "icon")
				local rate = gohelper.findChildText(go, "txt_attribute")
				local name = gohelper.findChildText(go, "name")
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

function RougeTalentTreeOverview:onClose()
	return
end

function RougeTalentTreeOverview:onDestroyView()
	return
end

return RougeTalentTreeOverview
