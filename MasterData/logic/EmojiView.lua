-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emoji/view/EmojiView.lua

module("logic.extensions.emoji.view.EmojiView", package.seeall)

local EmojiView = class("EmojiView", TableViewComponent)

function EmojiView:ctor()
	EmojiView.super.ctor(self)
end

function EmojiView:buildUI()
	self._ImgC_Mask = goutil.findChild(self.mainGO, "ImgC_Mask")

	local _Nego_Emoji = goutil.findChild(self.mainGO, "Nego_Emoji")
	local _Nego_Left = goutil.findChild(_Nego_Emoji, "Nego_Left")
	local _Nego_Right = goutil.findChild(_Nego_Emoji, "Nego_Right")

	self._tableview = goutil.findChild(_Nego_Right, "SrlC_Emoji"):GetComponent("UITableview")
	self._tableCell = self._viewPresentor:getPrefab(ItemEmojiLayout.ResPath)

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	local _Nego_Bottom = goutil.findChild(_Nego_Emoji, "Nego_Bottom")
end

function EmojiView:destroyUI()
	return
end

function EmojiView:bindEvents()
	self._onClickMaskHandler = PointerClickHandler.Get(self._ImgC_Mask):AddLuaHandler(function()
		self:_OnClickMask()
	end)
end

function EmojiView:unbindEvents()
	PointerClickHandler.Get(self._ImgC_Mask):RemoveLuaHandler(self._onClickMaskHandler)
end

function EmojiView:onEnter()
	EmojiView.super.onEnter(self)
	self._tableview:ReloadData()
end

function EmojiView:onEnterFinished()
	return
end

function EmojiView:onExit()
	return
end

function EmojiView:onExitFinished()
	return
end

function EmojiView:_numInView()
	local emojis = EmojiController.instance:GetEmojis()
	local t1, t2 = math.modf(#emojis)

	t1 = t1 + t2 > 0 and 1 or 0

	return t1
end

function EmojiView:_cellSize()
	return 436.8, 153.58
end

function EmojiView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local emojis = EmojiController.instance:GetEmojis()
	local _begin, _end = index * 30 + 1, (index + 1) * 30

	_end = _end > #emojis and #emojis or _end

	local _emojis = {}

	for i = _begin, _end do
		table.insert(_emojis, emojis[i])
	end

	local component = ItemEmojiLayout.AddOnce(cell.gameObject)

	component:SetContent(_emojis)

	return cell
end

function EmojiView:_OnClickMask()
	self:close()
end

return EmojiView
