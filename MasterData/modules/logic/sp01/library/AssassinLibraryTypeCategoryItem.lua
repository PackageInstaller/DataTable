-- chunkname: @modules/logic/sp01/library/AssassinLibraryTypeCategoryItem.lua

module("modules.logic.sp01.library.AssassinLibraryTypeCategoryItem", package.seeall)

local AssassinLibraryTypeCategoryItem = class("AssassinLibraryTypeCategoryItem", LuaCompBase)

function AssassinLibraryTypeCategoryItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(go, "go_select")
	self._gounselect = gohelper.findChild(go, "go_unselect")
	self._imageicon1 = gohelper.findChildImage(go, "go_select/image_Icon")
	self._imageicon2 = gohelper.findChildImage(go, "go_unselect/image_Icon")
	self._txttitle1 = gohelper.findChildText(go, "go_select/txt_title")
	self._txttitle2 = gohelper.findChildText(go, "go_unselect/txt_title")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")
	self._goreddot1 = gohelper.findChild(go, "go_select/go_reddot")
	self._goreddot2 = gohelper.findChild(go, "go_unselect/go_reddot")
	self._layoutElement = gohelper.onceAddComponent(go, typeof(UnityEngine.UI.LayoutElement))
	self._preferredHeight = self._layoutElement.preferredHeight
end

function AssassinLibraryTypeCategoryItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinLibraryTypeCategoryItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinLibraryTypeCategoryItem:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_glassclick)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnSelectLibLibType, self._actId, self._libType)
end

function AssassinLibraryTypeCategoryItem:setLibType(actId, libType)
	self._actId = actId
	self._libType = libType

	self:refreshUI()
end

function AssassinLibraryTypeCategoryItem:getLibType()
	return self._libType
end

function AssassinLibraryTypeCategoryItem:refreshUI()
	local langIdKey = AssassinHelper.multipleKeys2OneKey(self._actId, self._libType)
	local langId = AssassinEnum.LibraryType2LangId[langIdKey]
	local libTypeTitle = ""

	if langId then
		libTypeTitle = luaLang(langId)
	else
		logError(string.format("缺少资料库页签多语言id actId = %s, libType = %s, langIdKey = %s", self._actId, self._libType, langIdKey))
	end

	self._txttitle1.text = libTypeTitle
	self._txttitle2.text = libTypeTitle

	local iconNameKey = AssassinHelper.multipleKeys2OneKey(self._actId, self._libType)
	local iconName = iconNameKey and AssassinEnum.ActId2LibraryCategoryIconName[iconNameKey]

	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imageicon1, iconName)
	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imageicon2, iconName)
	self:setSelectUI(false)
	gohelper.setActive(self.go, true)
end

function AssassinLibraryTypeCategoryItem:onSelect(isSelect)
	self:setSelectUI(isSelect)
end

function AssassinLibraryTypeCategoryItem:setSelectUI(isSelect)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)
end

function AssassinLibraryTypeCategoryItem:refreshRedDot(isShow)
	self._isShowRedDot = isShow

	gohelper.setActive(self._goreddot1, self._isShowRedDot)
	gohelper.setActive(self._goreddot2, self._isShowRedDot)
end

function AssassinLibraryTypeCategoryItem:_redDotCheckFunc()
	return self._isShowRedDot
end

function AssassinLibraryTypeCategoryItem:buildFoldTweenWork(isFoldOut)
	local from = self._layoutElement.preferredHeight

	if isFoldOut then
		if not self._preferredHeight then
			local to = 0
			local t = AssassinEnum.LibrarySubItemTweenDuration
			local params = {
				type = "DOTweenFloat",
				from = from,
				to = to,
				t = t,
				frameCb = self._tweenFrameCallBack,
				cbObj = self
			}

			return (TweenWork.New(params))
		end
	end
end

function AssassinLibraryTypeCategoryItem:_tweenFrameCallBack(val)
	self._layoutElement.preferredHeight = val
end

function AssassinLibraryTypeCategoryItem:tryClickSelf(clickPosition, eventCamera)
	local isClickSelf = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._btnclick.transform, clickPosition, eventCamera)

	if isClickSelf then
		self:_btnclickOnClick()
	end

	return isClickSelf
end

function AssassinLibraryTypeCategoryItem:onDestroy()
	return
end

return AssassinLibraryTypeCategoryItem
