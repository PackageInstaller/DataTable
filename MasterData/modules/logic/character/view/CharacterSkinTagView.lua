-- chunkname: @modules/logic/character/view/CharacterSkinTagView.lua

module("modules.logic.character.view.CharacterSkinTagView", package.seeall)

local CharacterSkinTagView = class("CharacterSkinTagView", BaseView)

CharacterSkinTagView.MAX_TAG_HEIGHT = 825

local StoryModeTagPosX = 608

function CharacterSkinTagView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "bg/#scroll_prop")
	self._btnplay = gohelper.findChildButton(self.viewGO, "bg/#go_btnRoot/#btn_play")
	self._gocontentroot = gohelper.findChild(self.viewGO, "bg/#scroll_prop/Viewport/Content")
	self._goviewport = gohelper.findChild(self.viewGO, "bg/#scroll_prop/Viewport")
	self._goitem = gohelper.findChild(self._gocontentroot, "item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinTagView:addEvents()
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function CharacterSkinTagView:removeEvents()
	self._btnplay:RemoveClickListener()
end

function CharacterSkinTagView:_editableInitView()
	self._itemList = {}
	self._bgLayoutElement = gohelper.onceAddComponent(self._gobg, typeof(UnityEngine.UI.LayoutElement))
end

function CharacterSkinTagView:onUpdateParam()
	return
end

function CharacterSkinTagView:onOpen()
	self._skinCo = self.viewParam.skinCo

	local arr = string.splitToNumber(self._skinCo.storeTag, "|")
	local h = math.min(#arr * 62 + 120, 400)
	local rectTrans = self._gobg.transform

	recthelper.setHeight(rectTrans, h)

	if self.viewParam then
		if self.viewParam then
			recthelper.setAnchorX(rectTrans, StoryModeTagPosX)
		end

		local isReview = VersionValidator.instance:isInReviewing()
		local showVideo = not isReview and self._skinCo.isSkinVideo

		gohelper.setActive(self._btnplay, showVideo)
		self:_refreshContent()
	end
end

function CharacterSkinTagView:_refreshContent()
	local moList = {}
	local config = self._skinCo
	local content = self._gocontentroot

	if string.nilorempty(config.storeTag) == false then
		local arr = string.splitToNumber(config.storeTag, "|")

		for i, v in ipairs(arr) do
			table.insert(moList, SkinConfig.instance:getSkinStoreTagConfig(v))
		end
	end

	local itemList = self._itemList
	local itemCount = #itemList
	local dataCount = #moList

	for i = 1, dataCount do
		local mo = moList[i]
		local item

		if i <= itemCount then
			item = itemList[i]
		else
			local instance = gohelper.clone(self._goitem, content)

			item = CharacterSkinTagItem.New()

			item:init(instance)
			table.insert(itemList, item)
		end

		gohelper.setActive(item.viewGO, true)
		item:onUpdateMO(mo)
	end

	if dataCount < itemCount then
		for i = dataCount + 1, itemCount do
			local item = itemList[i]

			gohelper.setActive(item.viewGO, false)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self._goviewport.transform)

	local height = recthelper.getHeight(content.transform)
	local finalHeight = math.min(height, self.MAX_TAG_HEIGHT)

	recthelper.setHeight(self._gocontentroot.transform, finalHeight)
	recthelper.setHeight(self._goviewport.transform, finalHeight)
	recthelper.setHeight(self._gobg.transform, finalHeight)
end

function CharacterSkinTagView:onClickModalMask()
	self:closeThis()
end

function CharacterSkinTagView:_btnplayOnClick()
	local skinId = self._skinCo.id
	local heroId = self._skinCo.characterId
	local videoUrl = WebViewController.instance:getVideoUrl(heroId, skinId)

	WebViewController.instance:openWebView(videoUrl, false, self.OnWebViewBack, self)
end

function CharacterSkinTagView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
end

function CharacterSkinTagView:OnWebViewBack(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb and msg == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. msg)
end

function CharacterSkinTagView:onDestroyView()
	return
end

return CharacterSkinTagView
