-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/view/FeedbackCell.lua

module("logic.extensions.feedback.view.FeedbackCell", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local FeedbackCell = class("FeedbackCell")

function FeedbackCell.AddOnce(go)
	local component = FeedbackCell.Get(go)

	component = component or LuaComponentContainer.Add(go, FeedbackCell)

	return component
end

function FeedbackCell.Remove(go)
	LuaComponentContainer.Remove(go, FeedbackCell)
end

function FeedbackCell.Get(go)
	return (LuaComponentContainer.Get(go, FeedbackCell))
end

function FeedbackCell:ctor(go)
	self._go = go

	self:buildUI()

	self._procFunc = {
		[GameEnum.ChatItemType.ItemMy] = function(data)
			self._mainTxts[data.msgType].text = data.content

			local width = self._mainTxts[data.msgType].preferredWidth
			local height = self._mainTxts[data.msgType].preferredHeight

			printInfo("test 我输入的文本 =", width, height, data.content, ">>", self._mainTxts[data.msgType].text)

			width = math.min(572, width)
			self._mainTxts[data.msgType].alignment = height < 25 and UnityEngine.TextAnchor.UpperRight or UnityEngine.TextAnchor.UpperLeft
			self._rectTrans[data.msgType].sizeDelta = Vector2.New(width + 125, height + 40)

			local go = self._items[GameEnum.ChatItemType.ItemMy]
			local com = goutil.findChild(go, "Nego_Icon/ImgC_Icon")

			HeadItemController.instance:setMyHeadCell(com)
		end,
		[GameEnum.ChatItemType.ItemOther] = function(data)
			self._mainTxts[data.msgType].text = data.content

			local width = self._mainTxts[data.msgType].preferredWidth
			local height = self._mainTxts[data.msgType].preferredHeight

			self._rectTrans[data.msgType].sizeDelta = Vector2.New(width + 125, height + 40)
		end,
		[GameEnum.ChatItemType.ItemTime] = function(data)
			self._mainTxts[data.msgType].text = GameUtil.formatTimeStamp("-  %Y/%m/%d  %H:%M:%S  -", data.sendTime)
		end
	}
end

function FeedbackCell:buildUI()
	self._items = {}
	self._items[GameEnum.ChatItemType.ItemMy] = goutil.findChild(self._go, "item_my")
	self._items[GameEnum.ChatItemType.ItemOther] = goutil.findChild(self._go, "item_other")
	self._items[GameEnum.ChatItemType.ItemTime] = goutil.findChild(self._go, "item_time")
	self._mainTxts = {}
	self._mainTxts[GameEnum.ChatItemType.ItemMy] = goutil.findChildTextComponent(self._go, "item_my/TxtContent")
	self._mainTxts[GameEnum.ChatItemType.ItemOther] = goutil.findChildComponent(self._go, "item_other/TxtContent", "UIGraphicText")
	self._mainTxts[GameEnum.ChatItemType.ItemTime] = goutil.findChildTextComponent(self._go, "item_time")
	self._rectTrans = {}
	self._rectTrans[GameEnum.ChatItemType.ItemMy] = goutil.findChildRectTransformComponent(self._go, "item_my/ImgBg")
	self._rectTrans[GameEnum.ChatItemType.ItemOther] = goutil.findChildRectTransformComponent(self._go, "item_other/ImgBg")
	self._otherTextRect = goutil.findChildRectTransformComponent(self._go, "item_other/TxtContent")

	self._mainTxts[GameEnum.ChatItemType.ItemOther]:AddClickListener(self._onClickHerf, self)
end

function FeedbackCell:OnDestroy()
	self._mainTxts[GameEnum.ChatItemType.ItemOther]:RemoveClickListener()
end

function FeedbackCell:updateData(data)
	self._items[GameEnum.ChatItemType.ItemMy]:SetActive(data.msgType == GameEnum.ChatItemType.ItemMy)
	self._items[GameEnum.ChatItemType.ItemOther]:SetActive(data.msgType == GameEnum.ChatItemType.ItemOther)
	self._items[GameEnum.ChatItemType.ItemTime]:SetActive(data.msgType == GameEnum.ChatItemType.ItemTime)
	self._procFunc[data.msgType](data)

	self._msgType = data.msgType
end

function FeedbackCell:_onClickHerf(param)
	FeedbackController.instance:onClickQuestion(checknumber(param))
end

return FeedbackCell
