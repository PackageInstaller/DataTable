-- chunkname: @modules/logic/gm/view/GMFastAddHeroHadHeroItem.lua

module("modules.logic.gm.view.GMFastAddHeroHadHeroItem", package.seeall)

local GMFastAddHeroHadHeroItem = class("GMFastAddHeroHadHeroItem", ListScrollCell)

GMFastAddHeroHadHeroItem.SelectBgColor = GameUtil.parseColor("#EA4F4F")
GMFastAddHeroHadHeroItem.NotSelectBgColor = GameUtil.parseColor("#B0B0B0")

function GMFastAddHeroHadHeroItem:init(go)
	self.goClick = gohelper.getClick(go)

	self.goClick:AddClickListener(self.onClickItem, self)

	self.bgImg = go:GetComponent(gohelper.Type_Image)
	self._txtName = gohelper.findChildText(go, "#txt_heroname")
	self._txtherolv = gohelper.findChildText(go, "#txt_herolv")
	self._txtherolabel = gohelper.findChildText(go, "#txt_herolv/label")
	self._txtranklv = gohelper.findChildText(go, "#txt_ranklv")
	self._txtranklabel = gohelper.findChildText(go, "#txt_ranklv/label")
	self._txttalentlv = gohelper.findChildText(go, "#txt_talentlv")
	self._txttalentlabel = gohelper.findChildText(go, "#txt_talentlv/label")
	self._txtexskilllv = gohelper.findChildText(go, "#txt_exskilllv")
	self._txtexskilllabel = gohelper.findChildText(go, "#txt_exskilllv/label")
	self.isSelect = false

	GMController.instance:registerCallback(GMController.Event.ChangeSelectHeroItem, self.refreshSelect, self)
end

function GMFastAddHeroHadHeroItem:onUpdateMO(mo)
	self.mo = mo

	local showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()

	if showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		local heroMo = mo

		self._txtName.text = heroMo.config.name .. "#" .. tostring(heroMo.config.id)
		self._txtherolv.text = heroMo.level
		self._txtranklabel.text = "洞悉:"
		self._txtranklv.text = heroMo.rank - 1
		self._txttalentlabel.text = "共鸣:"
		self._txttalentlv.text = heroMo.talent
		self._txtexskilllabel.text = "塑造:"
		self._txtexskilllv.text = heroMo.exSkillLevel
	else
		local equipMo = mo

		self._txtName.text = equipMo.config.name .. "#" .. tostring(equipMo.config.id)
		self._txtherolv.text = equipMo.level
		self._txtranklabel.text = "精炼:"
		self._txtranklv.text = equipMo.refineLv
		self._txttalentlabel.text = "突破:"
		self._txttalentlv.text = equipMo.breakLv
		self._txtexskilllabel.text = "uid:"
		self._txtexskilllv.text = equipMo.uid
	end

	self:refreshSelect()
end

function GMFastAddHeroHadHeroItem:onClickItem()
	self.isSelect = not self.isSelect

	if self.isSelect then
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(self.mo)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(self.mo)
	else
		GMFastAddHeroHadHeroItemModel.instance:changeSelectHeroItem(nil)
		GMFastAddHeroHadHeroItemModel.instance:setSelectMo(nil)
	end
end

function GMFastAddHeroHadHeroItem:refreshSelect()
	local selectMo = GMFastAddHeroHadHeroItemModel.instance:getSelectMo()

	self.isSelect = selectMo and self.mo.uid == selectMo.uid or false
	self.bgImg.color = self.isSelect and GMFastAddHeroHadHeroItem.SelectBgColor or GMFastAddHeroHadHeroItem.NotSelectBgColor
end

function GMFastAddHeroHadHeroItem:onDestroy()
	self.goClick:RemoveClickListener()
	GMController.instance:unregisterCallback(GMController.Event.ChangeSelectHeroItem, self.refreshSelect, self)
end

return GMFastAddHeroHadHeroItem
