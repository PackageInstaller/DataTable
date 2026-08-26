-- chunkname: @modules/logic/udimo/view/UdimoInfoHeadItem.lua

module("modules.logic.udimo.view.UdimoInfoHeadItem", package.seeall)

local UdimoInfoHeadItem = class("UdimoInfoHeadItem", ListScrollCellExtend)

function UdimoInfoHeadItem:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._simageIcon1 = gohelper.findChildSingleImage(self.viewGO, "#go_Locked/Mask/#simage_Icon")
	self._goUnLocked = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._goUnSelectedBG = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_UnSelectedBG")
	self._goSelectedBG = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_SelectedBG")
	self._simageIcon2 = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/Mask/#simage_Icon")
	self._goshowing = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Icon")
	self._goSelectedFrame = gohelper.findChild(self.viewGO, "#go_SelectedFrame")
	self._goNew = gohelper.findChild(self.viewGO, "#go_New")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function UdimoInfoHeadItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._animEventWrap:AddEventListener("playAudio", self._onPlayAudio, self)
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
end

function UdimoInfoHeadItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
end

function UdimoInfoHeadItem:_btnclickOnClick()
	if not self._udimoId then
		return
	end

	UdimoController.instance:selectInfoViewHeadItem(self._index)
	self:refreshNew()
end

function UdimoInfoHeadItem:_onPlayAudio()
	AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_shua)
end

function UdimoInfoHeadItem:_onChangeUdimoShow()
	self:refresh()
end

function UdimoInfoHeadItem:_editableInitView()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self.transicon1 = self._simageIcon1.transform
	self.transicon2 = self._simageIcon2.transform
end

function UdimoInfoHeadItem:onUpdateMO(mo)
	self._mo = mo
	self._udimoId = self._mo and self._mo.id

	local heroId = UdimoConfig.instance:getUdimoHeroId(self._udimoId)
	local heroCo = HeroConfig.instance:getHeroCO(heroId)
	local iconPath = ResUrl.getHandbookheroIcon(heroCo and heroCo.skinId)

	self._simageIcon1:LoadImage(iconPath)
	self._simageIcon2:LoadImage(iconPath)

	local imgParam = UdimoConfig.instance:getUdimoImgParam(self._udimoId)

	if imgParam then
		if not imgParam[1] then
			local x = 0

			if imgParam then
				if not imgParam[2] then
					local y = 0

					if imgParam then
						if not imgParam[3] then
							local scale = 1

							transformhelper.setLocalPosXY(self.transicon1, x, y)
							transformhelper.setLocalPosXY(self.transicon2, x, y)
							transformhelper.setLocalScale(self.transicon1, scale, scale, 1)
							transformhelper.setLocalScale(self.transicon2, scale, scale, 1)
							self:refresh()
						end
					end
				end
			end
		end
	end
end

function UdimoInfoHeadItem:refresh()
	self:refreshUnlock()
	self:refreshNew()
	self:refreshShowing()
end

function UdimoInfoHeadItem:refreshUnlock()
	local isUnlock = UdimoModel.instance:isUnlockUdimo(self._udimoId)
	local cacheKey = UdimoHelper.getPlayerCacheDataKey(UdimoEnum.PlayerCacheDataKey.UdimoHasPlayedUnlockAnim, self._udimoId)
	local needPlayUnlockAnim = false

	if isUnlock and needPlayUnlockAnim then
		gohelper.setActive(self._goUnLocked, true)
		gohelper.setActive(self._goLocked, true)
		self.animatorPlayer:Play("unlock", self.setUnlockGOActive, self)
		UdimoController.instance:setCacheData(cacheKey, true)
	else
		self:setUnlockGOActive()
	end
end

function UdimoInfoHeadItem:setUnlockGOActive()
	self.animatorPlayer:Play("idle")

	local hasUnlock = UdimoModel.instance:isUnlockUdimo(self._udimoId)

	gohelper.setActive(self._goUnLocked, hasUnlock)
	gohelper.setActive(self._goLocked, not hasUnlock)
end

function UdimoInfoHeadItem:refreshNew()
	local isNew = false
	local hasUnlock = UdimoModel.instance:isUnlockUdimo(self._udimoId)

	if hasUnlock then
		local cacheKey = UdimoHelper.getPlayerCacheDataKey(UdimoEnum.PlayerCacheDataKey.UdimoHasClicked, self._udimoId)

		isNew = not UdimoModel.instance:getCacheKeyData(cacheKey)
	end

	gohelper.setActive(self._goNew, isNew)
end

function UdimoInfoHeadItem:refreshShowing()
	local hasUnlock = UdimoModel.instance:isUnlockUdimo(self._udimoId)

	gohelper.setActive(self._goshowing, (hasUnlock or nil) and UdimoModel.instance:isUseUdimo(self._udimoId))
end

function UdimoInfoHeadItem:onSelect(isSelect)
	gohelper.setActive(self._goSelectedFrame, isSelect)
	gohelper.setActive(self._goSelectedBG, isSelect)
	gohelper.setActive(self._goUnSelectedBG, not isSelect)
end

function UdimoInfoHeadItem:onDestroyView()
	self._simageIcon1:UnLoadImage()
	self._simageIcon2:UnLoadImage()
end

return UdimoInfoHeadItem
