-- chunkname: @modules/logic/player/view/PlayerChangeBgItem.lua

module("modules.logic.player.view.PlayerChangeBgItem", package.seeall)

local PlayerChangeBgItem = class("PlayerChangeBgItem", LuaCompBase)

function PlayerChangeBgItem:init(go)
	self._bgSelect = gohelper.findChild(go, "#go_select")
	self._bgCur = gohelper.findChild(go, "#go_cur")
	self._bgLock = gohelper.findChild(go, "#go_lock")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._simagebg = gohelper.findChildSingleImage(go, "#simg_bg")
	self._txtname = gohelper.findChildTextMesh(go, "#txt_name")
	self._goreddot = gohelper.findChild(go, "#go_reddot")
end

function PlayerChangeBgItem:addEventListeners()
	self._btnClick:AddClickListener(self._onSelect, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangeBgTab, self.onBgSelect, self)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, self._updateStatus, self)
end

function PlayerChangeBgItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangeBgTab, self.onBgSelect, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self._updateStatus, self)
end

function PlayerChangeBgItem:initMo(mo, index, nowSelect)
	self._mo = mo
	self._index = index

	self._simagebg:LoadImage(string.format("singlebg/playerinfo/bg/%s.png", mo.bg))

	self._txtname.text = mo.name

	self:onBgSelect(nowSelect)
	self:_updateStatus()

	if mo.item > 0 then
		RedDotController.instance:addMultiRedDot(self._goreddot, {
			{
				id = RedDotEnum.DotNode.PlayerChangeBgItemNew,
				uid = mo.item
			}
		})
	end
end

function PlayerChangeBgItem:_updateStatus()
	local isUnlock = true
	local info = PlayerModel.instance:getPlayinfo()

	if self._mo.item ~= 0 then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, self._mo.item)

		isUnlock = quantity > 0
	end

	gohelper.setActive(self._bgLock, not isUnlock)
	gohelper.setActive(self._bgCur, info.bg == self._mo.item)
end

function PlayerChangeBgItem:_onSelect()
	local id = self._mo.item

	if id > 0 and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PlayerChangeBgItemNew, id) then
		ItemRpc.instance:sendMarkReadSubType21Request(id)
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.ChangeBgTab, self._index)
end

function PlayerChangeBgItem:onBgSelect(index)
	gohelper.setActive(self._bgSelect, index == self._index)
end

function PlayerChangeBgItem:onDestroy()
	self._simagebg:UnLoadImage()
end

return PlayerChangeBgItem
