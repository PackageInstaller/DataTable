-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Title.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Title", package.seeall)

local V3a7_Wmz_GameItem_Title = class("V3a7_Wmz_GameItem_Title", V3a7_Wmz_GameItemMiscBase)

function V3a7_Wmz_GameItem_Title:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Image_TargetBG/#txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Title:addEvents()
	return
end

function V3a7_Wmz_GameItem_Title:removeEvents()
	return
end

local kAnimName = "switch_name"

function V3a7_Wmz_GameItem_Title:ctor(...)
	V3a7_Wmz_GameItem_Title.super.ctor(self, ...)

	self._descIndex = 0
	self._descList = {}
end

function V3a7_Wmz_GameItem_Title:_editableInitView()
	V3a7_Wmz_GameItem_Title.super._editableInitView(self)

	self._Image_TargetBGGo = gohelper.findChild(self.viewGO, "Image_TargetBG")
	self._Image_TargetBG = gohelper.findChildImage(self._Image_TargetBGGo, "")
	self._loopGo = gohelper.findChild(self.viewGO, "#loop")
	self._loopAniGo = gohelper.findChild(self._loopGo, "ani")
	self._loopTxtTitle = gohelper.findChildText(self._loopAniGo, "#txt_Title")
	self._animEvent = gohelper.onceAddComponent(self._loopAniGo, gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener(kAnimName, self._onSwitchName, self)
	gohelper.setActive(self._goLight, false)

	self._txtTitle.text = luaLang("V3a7_Wmz_GameItem_Title_txtTitle")
	self._loopTxtTitle.text = luaLang("V3a7_Wmz_GameItem_Title_txtTitle")
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self:_setActive_loopGo(false)
end

function V3a7_Wmz_GameItem_Title:_setActive_loopGo(isActive)
	gohelper.setActive(self._loopGo, isActive)
	gohelper.setActive(self._Image_TargetBGGo, not isActive)
end

function V3a7_Wmz_GameItem_Title:onDestroyView()
	self._animEvent:RemoveAllEventListener()
	V3a7_Wmz_GameItem_Title.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Title:setData(mo)
	V3a7_Wmz_GameItem_Title.super.setData(self, mo)

	self._descList = string.split(mo.titleDesc, "|") or {}

	local posX = tonumber(self._mo.titlePosX) or -19999
	local posY = tonumber(self._mo.titlePosY) or -19999

	self:setAPos(posX, posY)

	if isDebugBuild then
		self:setName(string.format("%s: %s (%s)", self:index(), self:zoneId(), self._txtTitle.text))
	end
end

function V3a7_Wmz_GameItem_Title:zoneId()
	return self._mo.id
end

function V3a7_Wmz_GameItem_Title:onCompleteZone(bCompleted)
	if bCompleted then
		self:playAnimOpen()
	else
		self:playIdleAnim()
	end
end

function V3a7_Wmz_GameItem_Title:_bNeedLoop()
	if not self._descList then
		return false
	end

	return #self._descList > 1
end

function V3a7_Wmz_GameItem_Title:playAnimOpen()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	self:_setActive_loopGo(self:_bNeedLoop())

	self._txtTitle.text = self._descList[1] or ""
end

function V3a7_Wmz_GameItem_Title:_onSwitchName()
	self._descIndex = self._descIndex + 1

	if self._descIndex > #self._descList then
		self._descIndex = 1
	end

	self._loopTxtTitle.text = self._descList[self._descIndex] or ""
end

function V3a7_Wmz_GameItem_Title:playIdleAnim()
	self:_setActive_loopGo(false)

	self._txtTitle.text = luaLang("V3a7_Wmz_GameItem_Title_txtTitle")

	self._animator:Play(UIAnimationName.Idle, 0, 1)
end

local kWhite = Color.white

function V3a7_Wmz_GameItem_Title:setGrayScale(bSelected)
	if bSelected then
		self._Image_TargetBG.color = kWhite
		self._txtTitle.color = kWhite
		self._loopTxtTitle.color = kWhite
	else
		local hexColor = WmzConfig.instance:grayScaleHex()

		UIColorHelper.set(self._txtTitle, hexColor)
		UIColorHelper.set(self._loopTxtTitle, hexColor)
		UIColorHelper.set(self._Image_TargetBG, hexColor)
	end
end

return V3a7_Wmz_GameItem_Title
