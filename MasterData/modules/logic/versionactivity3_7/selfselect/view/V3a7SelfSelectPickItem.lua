-- chunkname: @modules/logic/versionactivity3_7/selfselect/view/V3a7SelfSelectPickItem.lua

module("modules.logic.versionactivity3_7.selfselect.view.V3a7SelfSelectPickItem", package.seeall)

local V3a7SelfSelectPickItem = class("V3a7SelfSelectPickItem", LuaCompBase)
local exSkillFillAmount = {
	[0] = 0,
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function V3a7SelfSelectPickItem:init(go)
	self.viewGO = go
	self._goexskill = gohelper.findChild(self.viewGO, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7SelfSelectPickItem:addEventListeners()
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function V3a7SelfSelectPickItem:removeEventListeners()
	self._btnLongPress:RemoveLongPressListener()
end

function V3a7SelfSelectPickItem:_onLongClickItem()
	if not self._heroId then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self._heroId
	})
end

function V3a7SelfSelectPickItem:_editableInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "role/career")
	self._txtname = gohelper.findChildText(self.viewGO, "role/name")
	self._goexskill = gohelper.findChild(self.viewGO, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "role/#go_exskill/#image_exskill")
	self._goRankBg = gohelper.findChild(self.viewGO, "role/Rank")
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(self.viewGO, "role/Rank/rank" .. i)
	end

	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function V3a7SelfSelectPickItem:onUpdateMO(heroId)
	self._heroId = heroId

	local heroCo = HeroConfig.instance:getHeroCO(heroId)

	if not heroCo then
		return
	end

	self:_refreshInfo(heroCo)
end

function V3a7SelfSelectPickItem:_refreshInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("V2a7_SelfSelectSix_PickChoiceHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name

	local heroMo = HeroModel.instance:getByHeroId(self._heroId)
	local isShowRanIcon = false

	if heroMo then
		local rank = heroMo.rank
		local rankIconIndex = rank - 1

		for i = 1, 3 do
			local isCurRanIcon = i == rankIconIndex

			gohelper.setActive(self._goranks[i], isCurRanIcon)

			isShowRanIcon = isShowRanIcon or isCurRanIcon
		end

		local exSkillLevel = heroMo.exSkillLevel

		self._imageexskill.fillAmount = exSkillFillAmount[exSkillLevel] or 1
	else
		gohelper.setActive(self._goexskill, false)
	end

	gohelper.setActive(self._goRankBg, isShowRanIcon)
end

function V3a7SelfSelectPickItem:onDestroy()
	return
end

return V3a7SelfSelectPickItem
