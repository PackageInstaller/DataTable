-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/item/ChannelItemChatNormal.lua

module("logic.extensions.chat.view.item.ChannelItemChatNormal", package.seeall)

local ChannelItemChatNormal = class("ChannelItemChatNormal", ItemChatNormal)

function ChannelItemChatNormal:_buildTextContent()
	self._btnMsgGo = goutil.findChild(self._target, "container/ImgC_ContentBg")
	self._txtEffect = goutil.findChild(self._target, "container/effect")

	if self._btnMsgGo then
		GameUtil.addClickHandler(self._btnMsgGo, self._onClickMsg, self)

		self._TxtC_Content = goutil.findChildTextComponent(self._btnMsgGo, "TxtC_Content")
		self._graphic = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.Graphic))
		self._uiChangeGroup = self._btnMsgGo:GetComponent(typeof(UIChangeGroup))
		self._contentSizeFitter = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
		self._rectTrans = self._btnMsgGo:GetComponent(typeof(UnityEngine.RectTransform))
		self._layoutGroup = self._btnMsgGo:GetComponent(typeof(UnityEngine.UI.LayoutGroup))

		local padding = self._layoutGroup.padding

		if self._layoutGroup then
			self._horizontalOffset = padding.left + padding.right or 0
		end
	else
		printError("取到self._btnMsgGo为空")
	end

	self._image00 = goutil.findChild(self._target, "container/ImgC_ContentBg/image00")
	self._image01 = goutil.findChild(self._target, "container/ImgC_ContentBg/image01")
	self._image10 = goutil.findChild(self._target, "container/ImgC_ContentBg/image10")
	self._image11 = goutil.findChild(self._target, "container/ImgC_ContentBg/image11")
	self._imageEffect00 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect00")
	self._imageEffect01 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect01")
	self._imageEffect10 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect10")
	self._imageEffect11 = goutil.findChild(self._target, "container/ImgC_ContentBg/imageEffect11")
	self._bubbleGo = goutil.findChild(self._target, "bubble")

	if self._bubbleGo then
		self._btnCopy = Framework.ButtonAdapter.GetFrom(self._target, "bubble/btnCopy")

		self._btnCopy:AddClickListener(self._onClickBtnCopy, self)

		self._customInput = UICustomInput.Get(self._bubbleGo)

		self._customInput:AddListener(self._onCustomInputCallback, self)

		self._longPress = goutil.findChild(self._target, "container/ImgC_ContentBg"):GetComponent(ComponentType.UILongPressed)

		self._longPress:AddListener(self._onLongPressCopy, self)
	end
end

return ChannelItemChatNormal
