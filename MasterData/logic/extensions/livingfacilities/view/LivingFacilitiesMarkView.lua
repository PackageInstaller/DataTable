-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesMarkView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesMarkView", package.seeall)

local M = class("LivingFacilitiesMarkView")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._genderMarkCO = nil
	self._campMarkCO = nil
	self._showHint = false

	self:_buildUI()
	self:_createBlocker()
	self:_bindEvents()
end

function M:_buildUI()
	self._goGenderMark = goutil.findChild(self._mainGO, "imgSexSign")
	self._goCampMark = goutil.findChild(self._mainGO, "imgCampSign")
	self._imgGenderMark = goutil.findChildImageComponent(self._mainGO, "imgSexSign")
	self._imgCampMark = goutil.findChildImageComponent(self._mainGO, "imgCampSign")
	self._goHintTips = goutil.findChild(self._mainGO, "sex_camp_hint_tips")
	self._textHintTitle = goutil.findChildTextComponent(self._goHintTips, "txtTitle")
	self._textHintDesc = goutil.findChildTextComponent(self._goHintTips, "txtDesc")
	self._btnGender = UIComponentType.ButtonAdapter(self._goGenderMark)
	self._btnCamp = UIComponentType.ButtonAdapter(self._goCampMark)
end

function M:_bindEvents()
	self._btnGender:AddClickListener(self._clickGenderBtn, self)
	self._btnCamp:AddClickListener(self._clickCampBtn, self)

	if self._blockerBtn then
		self._blockerBtn:AddClickListener(self._clickBlockerBtn, self)
	end
end

function M:_unbindEvents()
	self._btnGender:RemoveClickListener()
	self._btnCamp:RemoveClickListener()

	if self._blockerBtn then
		self._blockerBtn:RemoveClickListener()
	end
end

function M:OnDestroy()
	self:_unbindEvents()
	self:_destroyUI()
end

function M:_destroyUI()
	self._mainGO = nil
	self._genderMarkCO = nil
	self._campMarkCO = nil

	goutil.destroy(self._blocker)
end

function M:_createBlocker()
	local blocker = goutil.create("markViewBlock")
	local root = ViewMgr.instance:getRoot(ViewRootType.PopupTop)

	goutil.addChildToParent(blocker, root)
	goutil.addComponentOnce(blocker, UIComponentType.EmptyRaycast)

	local rect = blocker:GetComponent(UIComponentType.RectTransform)

	rect.anchorMin = Vector3.zero
	rect.anchorMax = Vector3.one
	rect.sizeDelta = Vector2.zero

	goutil.setActive(blocker, false)

	self._blockerBtn = UIComponentType.ButtonAdapter(blocker)
	self._blocker = blocker
end

function M:_destroyBlocker()
	if self._blocker then
		goutil.destroy(self._blocker)
	end
end

function M:_clickBlockerBtn()
	self._showHint = false

	goutil.setActive(self._blocker, false)
	goutil.setActive(self._goHintTips, false)
end

function M:updateData(genderMarkCO, campMarkCO)
	self._genderMarkCO = genderMarkCO
	self._campMarkCO = campMarkCO

	self:setVisiable(genderMarkCO or campMarkCO)
	goutil.setActive(self._goMarktips, false)
	goutil.setActive(self._goHintTips, false)
	goutil.setActive(self._goGenderMark, genderMarkCO)
	goutil.setActive(self._goCampMark, campMarkCO)

	if genderMarkCO then
		IconLoader.setSprite(self._imgGenderMark, IconType.DynSpriteAtlas_Room, genderMarkCO.icon)
	end

	if campMarkCO then
		IconLoader.setSprite(self._imgCampMark, IconType.BigCamp, campMarkCO.icon)
	end
end

function M:setVisiable(visiable)
	goutil.setActive(self._mainGO, visiable)
end

function M:_clickGenderBtn()
	self._showHint = not self._showHint
	self._textHintTitle.text = self._genderMarkCO.name
	self._textHintDesc.text = self._genderMarkCO.desc

	goutil.setActive(self._goHintTips, self._showHint)
	goutil.setActive(self._blocker, true)
end

function M:_clickCampBtn()
	self._showHint = not self._showHint
	self._textHintTitle.text = self._campMarkCO.name
	self._textHintDesc.text = self._campMarkCO.desc

	goutil.setActive(self._goHintTips, self._showHint)
	goutil.setActive(self._blocker, true)
end

return M
