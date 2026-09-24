-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameMainBlockItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameMainBlockItem", package.seeall)

local MusicGameMainBlockItem = class("MusicGameMainBlockItem", LuaCompBase)

function MusicGameMainBlockItem:init(go)
	self.go = go
	self.goroot = gohelper.findChild(self.go, "root")
	self._imagenum = gohelper.findChildImage(self.go, "root/image_num")
	self._btnClick = gohelper.findChildButton(self.go, "root/image_num")
	self._gomainblock = gohelper.findChild(self.go, "go_mainblock")
	self._gobranchblock = gohelper.findChild(self.go, "go_branchblock")
	self._godistrubblock = gohelper.findChild(self.go, "go_distrubblock")
	self._gonodistrubblock = gohelper.findChild(self.go, "go_nodistrubblock")
	self._golinked = gohelper.findChild(self.go, "go_linked")
	self._gogrey = gohelper.findChild(self.go, "go_grey")
	self._goconnectitem = gohelper.findChild(self.go, "go_connectitem")
	self._longPress = SLFramework.UGUI.UILongPressListener.Get(self.go)

	self._longPress:SetLongPressTime({
		0.5,
		99999
	})

	self._btnclickitem = gohelper.getClick(self.go)

	self:_initItem()
end

function MusicGameMainBlockItem:_initItem()
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._golinked, false)
	gohelper.setActive(self._gogrey, false)

	self._connectItem = MusicGameMainConnectItem.New()

	self._connectItem:init(self._goconnectitem)
	self:_addEvents()
end

function MusicGameMainBlockItem:_onBlockItemConnect(id)
	if id ~= self._blockMo.id then
		return
	end

	self._itemAnim:Play("get", 0, 0)
end

function MusicGameMainBlockItem:_onLongPress()
	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if connects and #connects > 0 then
		return
	end

	local blockMo = MusicGameModel.instance:getBlockDataById(self._blockMo.id)

	MusicGameModel.instance:addSelectedBlockLines(self._blockMo.id)

	if not blockMo.config.audioId then
		AudioMgr.instance:trigger(blockMo.config.audioId)
		MusicGameController.instance:dispatchEvent(MusicGameEvent.BlockLongPress, self._blockMo)
	end
end

function MusicGameMainBlockItem:_onClickThisUp()
	local connects = MusicGameModel.instance:getSelectedBlockLines()

	if connects and #connects == 1 then
		MusicGameController.instance:dispatchEvent(MusicGameEvent.BlockPressEnd)
	end
end

function MusicGameMainBlockItem:_addEvents()
	self._longPress:AddLongPressListener(self._onLongPress, self)
	self._btnclickitem:AddClickUpListener(self._onClickThisUp, self)
	MusicGameController.instance:registerCallback(MusicGameEvent.BlockItemConnect, self._onBlockItemConnect, self)
end

function MusicGameMainBlockItem:_removeEvents()
	self._longPress:RemoveLongPressListener()
	self._btnclickitem:RemoveClickUpListener()
	MusicGameController.instance:unregisterCallback(MusicGameEvent.BlockItemConnect, self._onBlockItemConnect, self)
end

function MusicGameMainBlockItem:showLine(show)
	self._showline = show
end

function MusicGameMainBlockItem:getBlockMo()
	return self._blockMo
end

function MusicGameMainBlockItem:refresh(blockMo)
	self._blockMo = blockMo

	UISpriteSetMgr.instance:setV4a0ConcertSprite(self._imagenum, self._blockMo.config.icon)
	gohelper.setActive(self._gomainblock, self._showline and self._blockMo.type == MusicGameEnum.BlockType.Main)
	gohelper.setActive(self._gobranchblock, self._showline and self._blockMo.type == MusicGameEnum.BlockType.Branch)
	gohelper.setActive(self._godistrubblock, self._showline and self._blockMo.type == MusicGameEnum.BlockType.Disturb)
	gohelper.setActive(self._gonodistrubblock, self._showline and self._blockMo.type == MusicGameEnum.BlockType.NoDisturb)

	local connects = MusicGameModel.instance:getSelectedBlockLines()
	local hasConnect = connects and #connects > 0
	local isConnect = MusicGameModel.instance:isSelectedBlockLines(self._blockMo.id)
	local couldConnect = false

	if connects and #connects > 0 then
		local curBlockId = connects[#connects]
		local curBlockMo = MusicGameModel.instance:getBlockDataById(curBlockId)
		local isAdjacent = curBlockMo and math.abs(blockMo.x - curBlockMo.x) + math.abs(blockMo.y - curBlockMo.y) == 1

		if isAdjacent then
			couldConnect = curBlockMo.noteType <= blockMo.noteType
		end
	end

	if isConnect then
		self._itemAnim:Play("get")
	else
		local showTip = not hasConnect and self._blockMo.noteType == MusicGameEnum.BlockNoteType.Do

		if showTip then
			self._itemAnim:Play("tip")
		else
			self._itemAnim:Play("idle")
		end
	end

	gohelper.setActive(self._golinked, hasConnect and isConnect)
	gohelper.setActive(self._gogrey, hasConnect and not isConnect and not couldConnect)
	self._connectItem:refresh(self._blockMo.id)
end

function MusicGameMainBlockItem:showSelect()
	gohelper.setActive(self._golinked, true)
end

function MusicGameMainBlockItem:showGrey()
	gohelper.setActive(self._gogrey, true)
end

function MusicGameMainBlockItem:destroy()
	self._connectItem:destroy()
	self:_removeEvents()
end

return MusicGameMainBlockItem
