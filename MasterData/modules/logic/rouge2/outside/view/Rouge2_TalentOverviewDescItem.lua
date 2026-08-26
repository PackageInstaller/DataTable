-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentOverviewDescItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentOverviewDescItem", package.seeall)

local Rouge2_TalentOverviewDescItem = class("Rouge2_TalentOverviewDescItem", LuaCompBase)

function Rouge2_TalentOverviewDescItem:init(go)
	self.go = go
	self._txttalenname = gohelper.findChildText(self.go, "info/img_titleline/#txt_talenname")
	self._imageicon = gohelper.findChildImage(self.go, "info/img_titleline/#image_icon")
	self._golighted = gohelper.findChild(self.go, "info/img_titleline/#go_lighted")
	self._btnarrow = gohelper.findChildButtonWithAudio(self.go, "info/#btn_arrow")
	self._godetails = gohelper.findChild(self.go, "#go_details")
	self._txttalentdec = gohelper.findChildText(self.go, "#go_details/#txt_talentdec")
	self._txtunlockdec = gohelper.findChildText(self.go, "#go_details/#txt_unlockdec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_TalentOverviewDescItem:addEventListeners()
	self._btnarrow:AddClickListener(self._btnarrowOnClick, self)
end

function Rouge2_TalentOverviewDescItem:removeEventListeners()
	self._btnarrow:RemoveClickListener()
end

function Rouge2_TalentOverviewDescItem:_btnarrowOnClick()
	self:setDisplayState(not self.showDetail)
end

function Rouge2_TalentOverviewDescItem:_editableInitView()
	self._simageicon = gohelper.findChildSingleImage(self.go, "info/img_titleline/#image_icon")

	gohelper.setActive(self._txtunlockdec, false)
	gohelper.setActive(self._txttalentdec, false)

	self._goBtnClose = gohelper.findChild(self.go, "info/#btn_arrow/close")
	self._goBtnOpen = gohelper.findChild(self.go, "info/#btn_arrow/open")

	self:setDisplayState(false)
end

function Rouge2_TalentOverviewDescItem:setInfo(talentId)
	local config = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)

	self.config = config
	self._txttalenname.text = config.typeName

	Rouge2_IconHelper.setTalentIcon(config.id, self._simageicon)

	local isActive = Rouge2_TalentModel.instance:isTalentActive(config.id)

	gohelper.setActive(self._golighted, isActive)

	local descParamList = string.split(config.overviewText, "|")

	for index, desc in ipairs(descParamList) do
		local itemGo = gohelper.cloneInPlace(self._txttalentdec.gameObject, tostring(index))

		gohelper.setActive(itemGo, true)

		local text = gohelper.findChildTextMesh(itemGo, "")

		text.text = SkillHelper.buildDesc(desc)

		SkillHelper.addHyperLinkClick(text)
		Rouge2_ItemDescHelper.addFixTmpBreakLine(text)
	end
end

function Rouge2_TalentOverviewDescItem:setDisplayState(showDetail)
	self.showDetail = showDetail

	gohelper.setActive(self._godetails, showDetail)
	gohelper.setActive(self._goBtnClose, showDetail)
	gohelper.setActive(self._goBtnOpen, not showDetail)
end

function Rouge2_TalentOverviewDescItem:onDestroy()
	return
end

return Rouge2_TalentOverviewDescItem
