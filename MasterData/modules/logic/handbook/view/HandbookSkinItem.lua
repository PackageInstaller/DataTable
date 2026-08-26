-- chunkname: @modules/logic/handbook/view/HandbookSkinItem.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinItem", package.seeall)

local HandbookSkinItem = class("HandbookSkinItem", LuaCompBase)
local spineDefaultSize = {
	500,
	780
}
local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection
local SLFramework_UGUI_GuiHelper = SLFramework.UGUI.GuiHelper
local spineGray = 0.63

function HandbookSkinItem:init(go)
	self.viewGO = go
	self._goUniqueSkin = gohelper.findChild(self.viewGO, "#go_UniqueSkin")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "#simage_icon")
	self._uniqueImageicon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self._goUniqueImageicon2 = gohelper.findChild(self.viewGO, "#simage_icon2")
	self._roleImage = gohelper.findChildSingleImage(self.viewGO, "root/#image")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root")
	self._btnframeclick = gohelper.findChildButtonWithAudio(self.viewGO, "image_Frame")
	self._uiEffectComp = ZProj_UIEffectsCollection.Get(self.viewGO)
	self._roleImageGraphic = gohelper.findChildImage(self.viewGO, "root/#image")
	self._roleImageFrame = gohelper.findChildImage(self.viewGO, "image_Frame")
	self._goimageL2DRole = gohelper.findChildImage(self.viewGO, "image_L2DRole")
	self._rootGo = gohelper.findChild(self.viewGO, "root")
	self.image_bg = gohelper.findChildImage(self.viewGO, "image_bg")
	self.img_bg = gohelper.findChildImage(self.viewGO, "img_bg")
	self.image_l2dbg = gohelper.findChildImage(self.viewGO, "image_L2DBG")

	local trans = self.viewGO.transform

	while trans do
		local scrollRect = trans:GetComponent(gohelper.Type_ScrollRect)

		if scrollRect then
			self._scrollRect = scrollRect

			break
		end

		trans = trans.parent
	end

	self:_addEvents()

	self._unlockVxLoader = nil
	self._goUnlockVx = nil
	self._unlockAnimator = nil
	self._animEvent = nil
end

function HandbookSkinItem:setData(suitId)
	self._suitId = suitId
end

function HandbookSkinItem:refreshItem(skinId)
	self._skinId = skinId
	self.skinCfg = SkinConfig.instance:getSkinCo(skinId)
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)

	local spineParams = self._skinSuitCfg.spineParams

	if string.nilorempty(spineParams) then
		-- block empty
	end

	local spineParamsList = string.split(spineParams, "#")
	local curSkinSpineParam

	if spineParamsList then
		for _, spineParamStr in ipairs(spineParamsList) do
			local spineParam = string.split(spineParamStr, "|")
			local spineSkinId = tonumber(spineParam[1])

			if spineSkinId == skinId then
				curSkinSpineParam = spineParam
			end
		end
	end

	local isUniqueSkin = curSkinSpineParam ~= nil

	self.isUniqueSkin = isUniqueSkin

	if isUniqueSkin then
		gohelper.setActive(self._goUniqueSkinsImage, false)
		gohelper.setActive(self._goUniqueImageicon2, false)
		gohelper.setActive(self._roleImage.gameObject, false)
		gohelper.setActive(self._goimageL2DRole, false)

		local spinePrefabPath = curSkinSpineParam[2]
		local pos = #curSkinSpineParam > 2 and string.splitToNumber(curSkinSpineParam[3], ",") or {
			0,
			0
		}
		local uniScale = #curSkinSpineParam > 3 and tonumber(curSkinSpineParam[4]) or 1

		if self._skinSpine then
			self._skinSpine:setResPath(spinePrefabPath, self._onSkinSpineLoaded, self, true)
		else
			gohelper.setActive(self._goUniqueSkinsImage, true)

			self._skinSpineGO = self._skinSpineGO or gohelper.create2d(self._goUniqueSkinsImage, "uniqueSkinSpine")

			local spineRootRect = self._skinSpineGO.transform

			recthelper.setWidth(spineRootRect, spineDefaultSize[1])
			transformhelper.setLocalPos(spineRootRect, pos[1], pos[2], 0)
			transformhelper.setLocalScale(spineRootRect, uniScale, uniScale, uniScale)

			self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)

			self._skinSpine:setResPath(spinePrefabPath, self._onSkinSpineLoaded, self, true)
		end
	else
		gohelper.setActive(self._goUniqueSkinsImage, false)
		gohelper.setActive(self._goUniqueImageicon2, false)
		self._roleImage:LoadImage(ResUrl.getHeadIconImg(skinId), self._onLoadRoleImageDone, self)

		self._width = self._roleImage.transform.parent.sizeDelta.x
		self._needRefreshUnlockVx = true

		self:tryRefreshUnlockVx()
	end

	self:_refreshUnlockGray()
end

function HandbookSkinItem:_setUnlockGray(has)
	if self._lastHasSkin ~= has then
		self._lastHasSkin = has
	end

	if has then
		self._uiEffectComp:SetGray(false)
	else
		self._uiEffectComp:SetGray(true)
	end

	if has then
		if not HandbookEnum.Color.Unlock then
			local color = HandbookEnum.Color.Lock

			SLFramework_UGUI_GuiHelper.SetColor(self._roleImageGraphic, color)

			if self.image_bg then
				SLFramework_UGUI_GuiHelper.SetColor(self.image_bg, color)
			end

			if self.img_bg then
				SLFramework_UGUI_GuiHelper.SetColor(self.img_bg, color)
			end

			if self.image_l2dbg then
				SLFramework_UGUI_GuiHelper.SetColor(self.image_l2dbg, color)
			end

			local isFrameAsIcon = self._btnframeclick ~= nil

			if isFrameAsIcon then
				SLFramework_UGUI_GuiHelper.SetColor(self._roleImageFrame, color)
			end

			if self._skinSpine then
				local spineGraphic = self._skinSpine:getSkeletonGraphic()

				if spineGraphic then
					spineGraphic.raycastTarget = self._raycastTarget

					local gray = has and 0 or spineGray
					local mat = spineGraphic.runtimeMaterial

					mat:SetFloat(ShaderPropertyId.LumFactor, gray)

					spineGraphic.color = SLFramework.UGUI.GuiHelper.ParseColor(color)
				end
			end
		end
	end
end

function HandbookSkinItem:_refreshUnlockVx()
	local parentGo

	self._unlockVxLoader = self._unlockVxLoader or PrefabInstantiate.Create(self.isUniqueSkin and self.viewGO or HandbookEnum.HideRootSuit[self._suitId] and self._roleImageFrame.gameObject or self._roleImage.gameObject)

	if self.isUniqueSkin then
		if not HandbookEnum.SkinUnlockVxPath.Spine then
			local unlockSpinePath = HandbookEnum.SkinUnlockVxPath.Static

			self._unlockVxLoader:startLoad(unlockSpinePath, self._onLoadUnlockVx, self)
		end
	end
end

function HandbookSkinItem:tryRefreshUnlockVx()
	if not self._needRefreshUnlockVx then
		return
	end

	if self:_isVisibleInScroll() then
		self._needRefreshUnlockVx = false

		self:_refreshUnlockVx()
	end
end

local VisibleRatioThreshold = 0.5

function HandbookSkinItem:_isVisibleInScroll()
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

	if self._rootGo then
		if not self._rootGo.transform then
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

function HandbookSkinItem:_onLoadUnlockVx()
	if self._unlockVxLoader then
		local go = self._unlockVxLoader:getInstGO()

		if not gohelper.isNil(go) then
			self._goUnlockVx = go
			self._unlockAnimator = gohelper.findChildComponent(go, "", gohelper.Type_Animator)

			gohelper.setAsLastSibling(go)
			self:refreshUnlockVxState()

			if self.isUniqueSkin == false then
				if HandbookEnum.HideRootSuit[self._suitId] then
					gohelper.onceAddComponent(self._roleImageFrame.gameObject, typeof(UnityEngine.UI.Mask))
				else
					gohelper.onceAddComponent(self._roleImage.gameObject, typeof(UnityEngine.UI.Mask))
				end
			end
		end
	end
end

function HandbookSkinItem:refreshUnlockVxState()
	local skinId = self._skinId
	local haveSkin = HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(self._goUnlockVx, haveSkin)

	if haveSkin then
		local showUnlockAnim = HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId)

		if showUnlockAnim then
			if not HandbookEnum.SkinUnlockAnimName.Open then
				local animName = HandbookEnum.SkinUnlockAnimName.Idle

				if showUnlockAnim then
					HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)

					if self.isUniqueSkin then
						if not HandbookEnum.Audio.play_ui_tujianskin_special_unlock then
							local audioId = HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather

							AudioMgr.instance:trigger(audioId)

							self._animEvent = self._goUnlockVx:GetComponent(gohelper.Type_AnimationEventWrap)

							self:_setUnlockGray(false)
							self._animEvent:AddEventListener("unlock", self._refreshUnlockGray, self)
							TaskDispatcher.runDelay(self._delayPlayAnim, self, 0.3)
						end
					end
				else
					self._unlockAnimator:Play(animName, 0, 0)
				end
			end
		end
	else
		self:_refreshUnlockGray()
	end
end

function HandbookSkinItem:_delayPlayAnim()
	logNormal(string.format("[Handbook] _delayPlayAnim(解锁动画播放) time: %.3f, skinId: %s", Time.realtimeSinceStartup, tostring(self._skinId)))
	self._unlockAnimator:Play(HandbookEnum.SkinUnlockAnimName.Open, 0, 0)
end

function HandbookSkinItem:_refreshUnlockGray()
	local haveSkin = HeroModel.instance:checkHasSkin(self._skinId)

	self:_setUnlockGray(haveSkin)
end

function HandbookSkinItem:_onLoadRoleImageDone()
	ZProj.UGUIHelper.SetImageSize(self._roleImage.gameObject)
	self:_refreshUnlockGray()
end

function HandbookSkinItem:resetRes()
	if self._roleImage then
		self._roleImage:UnLoadImage()
	end
end

function HandbookSkinItem:_onSkinSpineLoaded()
	local spineTr = self._skinSpine:getSpineTr()
	local rootTrans = spineTr.parent

	recthelper.setWidth(spineTr, recthelper.getWidth(rootTrans))
	recthelper.setHeight(spineTr, recthelper.getHeight(rootTrans))
	self:setSpineRaycastTarget(self._raycastTarget)

	self._needRefreshUnlockVx = true

	self:_refreshUnlockGray()
	self:tryRefreshUnlockVx()
end

function HandbookSkinItem:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end

		local has = HeroModel.instance:checkHasSkin(self._skinId)

		if has then
			if not HandbookEnum.Color.Unlock then
				local color = HandbookEnum.Color.Lock

				if not has then
					local mat = spineGraphic.runtimeMaterial

					mat:SetFloat(ShaderPropertyId.LumFactor, spineGray)

					spineGraphic.color = SLFramework.UGUI.GuiHelper.ParseColor(color)
				end
			end
		end
	end
end

function HandbookSkinItem:refreshTitle()
	return
end

function HandbookSkinItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)

	if self._btnframeclick then
		self._btnframeclick:AddClickListener(self._btnclickOnClick, self)
	end
end

function HandbookSkinItem:removeEventListeners()
	self._btnclick:RemoveClickListener()

	if self._btnframeclick then
		self._btnframeclick:RemoveClickListener()
	end
end

function HandbookSkinItem:_btnclickOnClick()
	local heroId = self.skinCfg.characterId
	local skinId = self.skinCfg.id
	local skinViewParams = {
		handbook = true,
		storyMode = true,
		heroId = heroId,
		skin = skinId,
		skinSuitId = self._suitId
	}

	CharacterController.instance:openCharacterSkinView(skinViewParams)
end

function HandbookSkinItem:_addEvents()
	return
end

function HandbookSkinItem:_removeEvents()
	return
end

function HandbookSkinItem:onDestroy()
	self:resetRes()
	self:_removeEvents()
	self:removeEventListeners()

	if self._unlockVxLoader then
		self._unlockVxLoader:dispose()

		self._unlockVxLoader = nil
	end

	if self._animEvent then
		self._animEvent:RemoveEventListener("unlock")

		self._animEvent = nil
	end

	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
end

return HandbookSkinItem
