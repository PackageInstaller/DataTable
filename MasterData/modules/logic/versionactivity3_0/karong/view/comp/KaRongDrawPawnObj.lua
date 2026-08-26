-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawPawnObj.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawPawnObj", package.seeall)

local KaRongDrawPawnObj = class("KaRongDrawPawnObj", UserDataDispose)

function KaRongDrawPawnObj:ctor(go, isAvatar)
	self:__onInit()

	self.go = go
	self.image = gohelper.findChildImage(self.go, "#go_ctrl/#image_content")
	self.imageTf = self.image.transform
	self.goCtrl = gohelper.findChild(self.go, "#go_ctrl")
	self.tf = self.go.transform
	self.anim = self.image.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self.animEvent = self.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.animEvent:AddEventListener(KaRongDrawEnum.AnimEvent_OnJump, self.onPawnJump, self)

	self.isAvatar = isAvatar

	if isAvatar then
		self.dir = KaRongDrawEnum.dir.left or KaRongDrawEnum.dir.right
	end

	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, self._onUsingSkill, self)
end

function KaRongDrawPawnObj:_onUsingSkill(using)
	gohelper.setActive(self.go, not using)
end

function KaRongDrawPawnObj:onInit(x, y)
	self.anim:Play("open")

	local iconUrl = KaRongDrawModel.instance:getPawnIconUrl(self.isAvatar)

	if not string.nilorempty(iconUrl) then
		UISpriteSetMgr.instance:setV3a0KaRongSprite(self.image, iconUrl, true)
	end

	recthelper.setAnchor(self.goCtrl.transform, KaRongDrawEnum.MazeMonsterIconOffset.x, KaRongDrawEnum.MazeMonsterIconOffset.y)
	self:setPos(x, y)
	gohelper.setAsLastSibling(self.go)
end

function KaRongDrawPawnObj:onBeginDrag()
	self.anim:Play("image_content_drag")
end

function KaRongDrawPawnObj:onDraging(x, y)
	self:setPos(x, y)
end

function KaRongDrawPawnObj:onEndDrag(x, y)
	self:setPos(x, y)
	self.anim:Play("open")
end

function KaRongDrawPawnObj:setPos(x, y)
	self.x = x or 0
	self.y = y or 0

	recthelper.setAnchor(self.tf, x, y)
end

function KaRongDrawPawnObj:setDir(dir)
	if self.isAvatar then
		self.dir = -dir or dir
	end

	if math.abs(dir) == 1 then
		transformhelper.setLocalRotation(self.tf, 0, self.dir == KaRongDrawEnum.dir.right and 180 or 0, 0)
	end
end

function KaRongDrawPawnObj:onPawnJump()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function KaRongDrawPawnObj:destroy()
	self.animEvent:RemoveEventListener(KaRongDrawEnum.AnimEvent_OnJump)
	self:__onDispose()
end

return KaRongDrawPawnObj
