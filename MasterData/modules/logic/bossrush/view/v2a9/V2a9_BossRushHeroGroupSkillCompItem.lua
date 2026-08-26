-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushHeroGroupSkillCompItem.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupSkillCompItem", package.seeall)

local V2a9_BossRushHeroGroupSkillCompItem = class("V2a9_BossRushHeroGroupSkillCompItem", LuaCompBase)

function V2a9_BossRushHeroGroupSkillCompItem:init(go)
	self.viewGO = go
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._txtnum = gohelper.findChildText(self.viewGO, "num/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushHeroGroupSkillCompItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a9_BossRushHeroGroupSkillCompItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function V2a9_BossRushHeroGroupSkillCompItem:_btnclickOnClick()
	if self._mo:isLock() then
		return
	end

	BossRushController.instance:openV2a9BossRushSkillBackpackView(self._mo:getItemType())
end

function V2a9_BossRushHeroGroupSkillCompItem:_editableInitView()
	gohelper.setActive(self._goselect, false)

	self._gonum = gohelper.findChild(self.viewGO, "num")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V2a9_BossRushHeroGroupSkillCompItem:onUpdateMO(mo)
	self._mo = mo

	local itemType = mo:getItemType()
	local isLock = mo:isLock()
	local isEquip = mo:isEquip()

	if isEquip then
		local assassinMo = V2a9BossRushSkillBackpackListModel.instance:getMObyItemType(itemType)

		if assassinMo then
			self._txtnum.text = assassinMo:getCount() or 0

			AssassinHelper.setAssassinItemIcon(assassinMo:getId(), self._imageicon)
		end
	end

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._goadd, not isLock and not isEquip)
	gohelper.setActive(self._gonum, not isLock and isEquip)
	gohelper.setActive(self._imageicon.gameObject, not isLock and isEquip)
end

function V2a9_BossRushHeroGroupSkillCompItem:playAnim(aniName)
	self._anim:Play(aniName, 0, 0)
end

return V2a9_BossRushHeroGroupSkillCompItem
