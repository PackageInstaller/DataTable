-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookNpcItem.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookNpcItem", package.seeall)

local SurvivalHandbookNpcItem = class("SurvivalHandbookNpcItem", LuaCompBase)

function SurvivalHandbookNpcItem:ctor()
	return
end

function SurvivalHandbookNpcItem:init(go)
	self.go = go
	self.animGo = gohelper.findComponentAnim(go)
	self.empty = gohelper.findChild(go, "#empty")
	self.normal = gohelper.findChild(go, "#normal")
	self.image_quality = gohelper.findChildImage(go, "#normal/#image_quality")
	self.image_Chess = gohelper.findChildSingleImage(go, "#normal/#image_Chess")
	self.txt_PartnerName = gohelper.findChildTextMesh(go, "#txt_PartnerName")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "#btnClick")
	self.go_rewardinherit = gohelper.findChild(go, "#normal/#go_rewardinherit")
	self.go_Selected = gohelper.findChild(self.go_rewardinherit, "#go_Selected")
	self.go_Mark = gohelper.findChild(go, "#go_Mark")
	self.go_score = gohelper.findChild(go, "#normal/#go_score")
	self.txt_score = gohelper.findChildTextMesh(self.go_score, "#txt_score")
end

function SurvivalHandbookNpcItem:onStart()
	return
end

function SurvivalHandbookNpcItem:updateMo(mo)
	if mo == nil then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self.mo = mo
	self.itemMo = mo:getSurvivalBagItemMo()

	gohelper.setActive(self.empty, not self.mo.isUnlock)
	gohelper.setActive(self.normal, self.mo.isUnlock)

	if not self.mo.isUnlock then
		gohelper.setActive(self.txt_PartnerName, false)

		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self.image_quality, string.format("survival_bag_itemquality2_%s", self.itemMo.npcCo.rare))
	SurvivalUnitIconHelper.instance:setNpcIcon(self.image_Chess, self.itemMo.npcCo.headIcon)
	self:refreshName()
end

function SurvivalHandbookNpcItem:showExtendCost()
	gohelper.setActive(self.go_score, true)

	self.txt_score.text = self.itemMo:getExtendCost()
end

function SurvivalHandbookNpcItem:refreshName()
	local offset = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self.txt_PartnerName, "...") + 0.1
	local str = GameUtil.getBriefNameByWidth(self.itemMo.npcCo.name, self.txt_PartnerName, offset, "...")

	gohelper.setActive(self.txt_PartnerName, true)

	self.txt_PartnerName.text = str
end

function SurvivalHandbookNpcItem:addEventListeners()
	self.btnClick:AddClickListener(self._onItemClick, self)
end

function SurvivalHandbookNpcItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function SurvivalHandbookNpcItem:onDestroy()
	return
end

function SurvivalHandbookNpcItem:setClickCallback(callBack, callObj)
	self._callBack = callBack
	self._callObj = callObj
end

function SurvivalHandbookNpcItem:_onItemClick()
	if self._callBack then
		self._callBack(self._callObj, self)
	end
end

function SurvivalHandbookNpcItem:setRewardInherit(isSelect)
	gohelper.setActive(self.go_rewardinherit, true)
	gohelper.setActive(self.go_Selected, isSelect)
end

function SurvivalHandbookNpcItem:setSelect(value)
	gohelper.setActive(self.go_Mark, value)
end

return SurvivalHandbookNpcItem
