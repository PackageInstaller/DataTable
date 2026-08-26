-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationRoleItem.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationRoleItem", package.seeall)

local VersionActivity2_3NewCultivationRoleItem = class("VersionActivity2_3NewCultivationRoleItem", RougeSimpleItemBase)

function VersionActivity2_3NewCultivationRoleItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goselect_sp = gohelper.findChild(self.viewGO, "#go_select_sp")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationRoleItem:addEvents()
	return
end

function VersionActivity2_3NewCultivationRoleItem:removeEvents()
	return
end

function VersionActivity2_3NewCultivationRoleItem:ctor(ctorParam)
	VersionActivity2_3NewCultivationRoleItem.super.ctor(self, ctorParam)
end

function VersionActivity2_3NewCultivationRoleItem:_onLongClickItem()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = self:heroId()
	})
end

function VersionActivity2_3NewCultivationRoleItem:_onClickSelf()
	if self._callBack and self._callBackObj then
		self._callBack(self._callBackObj, self:heroId())
	end
end

function VersionActivity2_3NewCultivationRoleItem:_editableInitView()
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "heroicon")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "heroicon")
	self._imagerare = gohelper.findChildImage(self.viewGO, "rare")
end

function VersionActivity2_3NewCultivationRoleItem:addEventListeners()
	VersionActivity2_3NewCultivationRoleItem.super.addEventListeners(self)
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function VersionActivity2_3NewCultivationRoleItem:removeEventListeners()
	self._btnClick:RemoveClickListener()

	self._callBack = nil
	self._callBackObj = nil

	VersionActivity2_3NewCultivationRoleItem.super.removeEventListeners(self)
end

function VersionActivity2_3NewCultivationRoleItem:setClickCallBack(callBack, callBackObj)
	self._callBack = callBack
	self._callBackObj = callBackObj
end

function VersionActivity2_3NewCultivationRoleItem:heroId()
	return self._mo.heroId
end

function VersionActivity2_3NewCultivationRoleItem:isSp()
	if self._isSp == nil then
		self._isSp = self:baseViewContainer():isHeroWithSpecialDestiny(self:heroId())
	end

	return self._isSp
end

function VersionActivity2_3NewCultivationRoleItem:setData(mo)
	VersionActivity2_3NewCultivationRoleItem.super.setData(self, mo)
	self:_refreshUI()
end

function VersionActivity2_3NewCultivationRoleItem:_refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self:heroId())

	self:_refreshBaseInfo(heroCo)
end

function VersionActivity2_3NewCultivationRoleItem:_refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))
end

function VersionActivity2_3NewCultivationRoleItem:refreshSelect(roleId)
	local isSelect = self:heroId() == roleId

	self:_refresh_goselected(isSelect, self:isSp())

	return isSelect
end

function VersionActivity2_3NewCultivationRoleItem:_refresh_goselected(isActive, isSp)
	if not isActive then
		gohelper.setActive(self._goselect, false)
		gohelper.setActive(self._goselect_sp, false)

		return
	end

	gohelper.setActive(self._goselect, not isSp)
	gohelper.setActive(self._goselect_sp, isSp)
end

return VersionActivity2_3NewCultivationRoleItem
