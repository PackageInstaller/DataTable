-- chunkname: @modules/logic/handbook/view/HandbookSkinItem3_3.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinItem3_3", package.seeall)

local HandbookSkinItem3_3 = class("HandbookSkinItem3_3", LuaCompBase)

function HandbookSkinItem3_3:init(go)
	self.viewGO = go
	self._roleImage = gohelper.findChildSingleImage(self.viewGO, "item/unlock/#simage_card")
	self._roleImageLock = gohelper.findChildSingleImage(self.viewGO, "item/lock/#simage_card")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "item/unlock")
	self._btnlockclick = gohelper.findChildButtonWithAudio(self.viewGO, "item/lock")
	self._btnEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "item/empty")
	self._goEmpty = gohelper.findChild(self.viewGO, "item/empty")
	self._goUnlock = gohelper.findChild(self.viewGO, "item/unlock")
	self._goLock = gohelper.findChild(self.viewGO, "item/lock")
	self._goDestivalItemSelected = gohelper.findChild(self.viewGO, "LineItem/selected")
	self._goDestivalItemUnSelect = gohelper.findChild(self.viewGO, "LineItem/unselect")
	self._goLineItemImgDesc = gohelper.findChild(self.viewGO, "LineItem/unselect/image_dec2")
	self._goLineItemImgDesc2 = gohelper.findChild(self.viewGO, "LineItem/unselect/image_dec4")
	self._goDesTextUnSelect = gohelper.findChild(self._goDestivalItemUnSelect, "#txt_Descr")
	self._goDateTextUnSelect = gohelper.findChild(self._goDestivalItemUnSelect, "#txt_Date")
	self._desTextUnSelect = gohelper.findChildText(self._goDestivalItemUnSelect, "#txt_Descr")
	self._dateTextUnSelect = gohelper.findChildText(self._goDestivalItemUnSelect, "#txt_Date")
	self._goCardSelect = gohelper.findChild(self.viewGO, "item/unlock/#go_select")
	self._goItem = gohelper.findChild(self.viewGO, "item")
	self._itemAnimator = self._goItem:GetComponent(gohelper.Type_Animator)
	self._unlockVxLoader = nil
	self._goUnlockVx = nil
	self._unlockAnimator = nil
	self._animEvent = nil
end

function HandbookSkinItem3_3:setData(idx, suitId, scrollRect)
	self._cardIdx = idx
	self._suitId = suitId
	self._scrollRect = scrollRect
end

function HandbookSkinItem3_3:refreshItem(skinId)
	self._skinId = skinId

	if self._skinId == 0 then
		self:_refreshEmptySkin()

		return
	end

	self.skinCfg = SkinConfig.instance:getSkinCo(skinId)
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)

	local spineParams = self._skinSuitCfg.spineParams

	if string.nilorempty(spineParams) then
		-- block empty
	end

	local spineParamsList = string.split(spineParams, "#")

	self._roleImage:LoadImage(ResUrl.getSkinHandbookFestivalSkinImage(skinId), self._onLoadRoleImageDone, self)
	self._roleImageLock:LoadImage(ResUrl.getSkinHandbookFestivalSkinImage(skinId), self._onLoadRoleImageDone, self)

	self._width = self._roleImage.transform.parent.sizeDelta.x
	self._needRefreshUnlockVx = true

	self:tryRefreshUnlockVx()
end

function HandbookSkinItem3_3:refreshSelectedState(selected)
	self._itemAnimator:Play((selected or nil) and (UIAnimationName.Select or UIAnimationName.Idle), 0, 0)
	gohelper.setActive(self._goDestivalItemSelected, selected)
	gohelper.setActive(self._goCardSelect, selected)
end

function HandbookSkinItem3_3:_refreshEmptySkin()
	gohelper.setActive(self._goEmpty, true)
	gohelper.setActive(self._goUnlock, false)
	gohelper.setActive(self._goLock, false)
end

function HandbookSkinItem3_3:_onLoadRoleImageDone()
	ZProj.UGUIHelper.SetImageSize(self._roleImage.gameObject)
end

function HandbookSkinItem3_3:resetRes()
	if self._roleImage then
		self._roleImage:UnLoadImage()
	end
end

function HandbookSkinItem3_3:refreshDestivalData(destivalDataStr)
	local destivalDataParams = string.split(destivalDataStr, ",")

	self._desTextUnSelect.text = destivalDataStr ~= "0" and luaLang(destivalDataParams[1]) or ""

	if destivalDataStr ~= "0" then
		self._dateTextUnSelect.text = destivalDataParams[2] or ""
	end

	gohelper.setActive(self._goLineItemImgDesc, self._dateTextUnSelect.text ~= "")
end

function HandbookSkinItem3_3:addEventListeners()
	self._btnClick:AddClickListener(self._btnclickOnClick, self)

	if self._btnlockclick then
		self._btnlockclick:AddClickListener(self._btnclickOnClick, self)
	end

	self._btnEmpty:AddClickListener(self._btnclickOnClick, self)
end

function HandbookSkinItem3_3:removeEventListeners()
	self._btnClick:RemoveClickListener()

	if self._btnlockclick then
		self._btnlockclick:RemoveClickListener()
	end

	self._btnEmpty:RemoveClickListener()

	if self._animEvent then
		self._animEvent:RemoveEventListener("unlock")

		self._animEvent = nil
	end
end

function HandbookSkinItem3_3:_btnclickOnClick()
	HandbookController.instance:dispatchEvent(HandbookEvent.OnClickFestivalSkinCard, self._cardIdx, self._skinId)
end

function HandbookSkinItem3_3:getSkinId()
	return self._skinId
end

function HandbookSkinItem3_3:_refreshUnlockVx()
	local parentGo = self._roleImage.gameObject

	self._unlockVxLoader = PrefabInstantiate.Create(parentGo)

	local unlockSpinePath = HandbookEnum.SkinUnlockVxPath.Static

	self._unlockVxLoader:startLoad(unlockSpinePath, self._onLoadUnlockVx, self)
end

function HandbookSkinItem3_3:tryRefreshUnlockVx()
	if not self._needRefreshUnlockVx then
		return
	end

	if self:_isVisibleInScroll() then
		self._needRefreshUnlockVx = false

		self:_refreshUnlockVx()
	end
end

local VisibleRatioThreshold = 0.5

function HandbookSkinItem3_3:_isVisibleInScroll()
	if not self._scrollRect then
		return true
	end

	if not self._scrollRect.horizontal then
		return true
	end

	local viewport = self._scrollRect.viewport

	if not viewport then
		return true
	end

	if self._goItem then
		if not self._goItem.transform then
			local itemTrans = self.viewGO.transform
			local itemLocalPos = viewport:InverseTransformPoint(itemTrans.position)
			local itemLocalX = itemLocalPos.x
			local itemWidth = recthelper.getWidth(itemTrans)
			local itemPivot = itemTrans.pivot
			local viewportWidth = recthelper.getWidth(viewport)
			local viewportPivot = viewport.pivot
			local itemLeft = itemLocalX - itemWidth * itemPivot.x
			local itemRight = itemLocalX + itemWidth * (1 - itemPivot.x)
			local viewportLeft = -viewportWidth * viewportPivot.x
			local viewportRight = viewportWidth * (1 - viewportPivot.x)

			if itemWidth <= 0 then
				return false
			end

			local overlapWidth = math.min(itemRight, viewportRight) - math.max(itemLeft, viewportLeft)

			if overlapWidth <= 0 then
				return false
			end

			return overlapWidth / itemWidth >= VisibleRatioThreshold
		end
	end
end

function HandbookSkinItem3_3:_onLoadUnlockVx()
	if self._unlockVxLoader then
		local go = self._unlockVxLoader:getInstGO()

		if not gohelper.isNil(go) then
			self._goUnlockVx = go
			self._unlockAnimator = gohelper.findChildComponent(go, "", gohelper.Type_Animator)

			gohelper.setAsFirstSibling(go)
			gohelper.onceAddComponent(self._roleImage.gameObject, typeof(UnityEngine.UI.Mask))
			self:refreshUnlockVxState()
		end
	end
end

function HandbookSkinItem3_3:refreshUnlockVxState()
	local skinId = self._skinId
	local haveSkin = HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(self._goUnlockVx, haveSkin)

	if haveSkin then
		local showUnlockAnim = HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId)

		if showUnlockAnim then
			if not HandbookEnum.SkinUnlockAnimName.Open then
				local animName = HandbookEnum.SkinUnlockAnimName.Idle

				if showUnlockAnim then
					local audioId = HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather

					AudioMgr.instance:trigger(audioId)
					HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)
					gohelper.setActive(self._goUnlock, false)
					gohelper.setActive(self._goLock, true)
					gohelper.setActive(self._goEmpty, false)

					self._animEvent = self._goUnlockVx:GetComponent(gohelper.Type_AnimationEventWrap)

					self._animEvent:AddEventListener("unlock", self._refreshUnlockGray, self)
					TaskDispatcher.runDelay(self._delayPlayAnim, self, 0.8)
				else
					self._unlockAnimator:Play(animName, 0, 0)
					self:_refreshUnlockGray()
				end
			end
		end
	else
		self:_refreshUnlockGray()
	end
end

function HandbookSkinItem3_3:_delayPlayAnim()
	logNormal(string.format("[Handbook] _delayPlayAnim(解锁动画播放) time: %.3f, skinId: %s", Time.realtimeSinceStartup, tostring(self._skinId)))
	gohelper.setActive(self._goUnlock, true)
	gohelper.setActive(self._goLock, false)
	gohelper.setActive(self._goEmpty, false)
	self._unlockAnimator:Play(HandbookEnum.SkinUnlockAnimName.Open, 0, 0)
end

function HandbookSkinItem3_3:_refreshUnlockGray()
	local haveSkin = HeroModel.instance:checkHasSkin(self._skinId)

	self:_setUnlockGray(haveSkin)
end

function HandbookSkinItem3_3:_setUnlockGray(has)
	gohelper.setActive(self._goUnlock, has)
	gohelper.setActive(self._goLock, not has)
	gohelper.setActive(self._goEmpty, false)
end

function HandbookSkinItem3_3:onDestroy()
	self:resetRes()
	self:removeEventListeners()
	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
end

return HandbookSkinItem3_3
