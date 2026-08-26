-- chunkname: @modules/logic/partygame/view/carddrop/player/CardDropCommonPlayerItem.lua

module("modules.logic.partygame.view.carddrop.player.CardDropCommonPlayerItem", package.seeall)

local CardDropCommonPlayerItem = class("CardDropCommonPlayerItem", UserDataDispose)

function CardDropCommonPlayerItem.Create(go)
	local item = CardDropCommonPlayerItem.New()

	item:init(go)

	return item
end

function CardDropCommonPlayerItem:init(go)
	self:__onInit()

	self.go = go

	self:onInitView()
end

function CardDropCommonPlayerItem:onInitView()
	self.animator = gohelper.findChildComponent(self.go, "#go_playeritem", gohelper.Type_Animator)
	self.goArrowSelf = gohelper.findChild(self.go, "#go_playeritem/#arrow_self")
	self.goImageLight = gohelper.findChild(self.go, "#go_playeritem/#image_light")
	self.goImageSelfLight = gohelper.findChild(self.go, "#go_playeritem/#image_selflight")
	self.txtPlayerName = gohelper.findChildText(self.go, "#go_playeritem/#txt_playername")
	self.goPlayerName = gohelper.findChild(self.go, "#go_playeritem/#txt_playername")
	self.goImagePaint = gohelper.findChild(self.go, "#go_playeritem/#image_paint")

	transformhelper.setLocalScale(self.goImagePaint.transform, 1, 1, 1)

	self.goImageWin = gohelper.findChild(self.go, "#go_playeritem/#image_win")
	self.goImageLose = gohelper.findChild(self.go, "#go_playeritem/#image_lose")

	self:setArrowActive(false)
	self:setImageLightActive(true)
	self:setImageSelfLightActive(true)
	self:setImagePaintActive(false)
	self:setImageWinActive(true)
	self:setImageLoseActive(true)
	self:setNameActive(true)

	self.txtPlayerName.text = ""
end

function CardDropCommonPlayerItem:setArrowActive(active)
	gohelper.setActive(self.goArrowSelf, active)
end

function CardDropCommonPlayerItem:setImageLightActive(active)
	gohelper.setActive(self.goImageLight, active)
end

function CardDropCommonPlayerItem:setImageSelfLightActive(active)
	gohelper.setActive(self.goImageSelfLight, active)
end

function CardDropCommonPlayerItem:setImagePaintActive(active)
	gohelper.setActive(self.goImagePaint, active)
end

function CardDropCommonPlayerItem:setImageWinActive(active)
	gohelper.setActive(self.goImageWin, active)
end

function CardDropCommonPlayerItem:setImageLoseActive(active)
	gohelper.setActive(self.goImageLose, active)
end

function CardDropCommonPlayerItem:setNameActive(active)
	gohelper.setActive(self.goPlayerName, active)
end

function CardDropCommonPlayerItem:setNameTextByPlayerMo(playerMo)
	if not playerMo then
		return self:setNameText("")
	end

	self:setNameText(playerMo:getColorName())
end

function CardDropCommonPlayerItem:setNameTextByUid(uid)
	local playerMo = PartyGameModel.instance:getPlayerMoByUid(uid)

	self:setNameTextByPlayerMo(playerMo)
end

function CardDropCommonPlayerItem:setNameText(name)
	self.txtPlayerName.text = name
end

function CardDropCommonPlayerItem:playAnimByWin(win)
	local animName = win and "win" or "lose"

	self:playAnim(animName)
end

function CardDropCommonPlayerItem:setLightByWin(win, isMain)
	if win then
		if isMain then
			self:setImageSelfLightActive(true)
			self:setImageLightActive(false)
		else
			self:setImageSelfLightActive(false)
			self:setImageLightActive(true)
		end
	else
		self:setImageSelfLightActive(false)
		self:setImageLightActive(false)
	end
end

function CardDropCommonPlayerItem:playAnim(animName)
	self.animator:Play(animName, 0, 0)
end

function CardDropCommonPlayerItem:onDestroy()
	self:__onDispose()
end

return CardDropCommonPlayerItem
