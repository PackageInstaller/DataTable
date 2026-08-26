-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazePawnObj.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazePawnObj", package.seeall)

local PuzzleMazePawnObj = class("PuzzleMazePawnObj", PuzzleMazeBasePawnObj)

function PuzzleMazePawnObj:ctor(go)
	PuzzleMazePawnObj.super.ctor(self, go)

	self.image = gohelper.findChildImage(self.go, "#go_ctrl/#image_content")
	self.imageTf = self.image.transform
	self.goCtrl = gohelper.findChild(self.go, "#go_ctrl")
	self.tf = self.go.transform
	self.dir = PuzzleEnum.dir.left
	self.anim = self.image.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self.animEvent = self.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.animEvent:AddEventListener(PuzzleEnum.AnimEvent_OnJump, self.onPawnJump, self)
end

function PuzzleMazePawnObj:onInit(x, y)
	self.anim:Play("open")

	local iconUrl = PuzzleMazeDrawModel.instance:pawnIconUrl()

	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(self.image, iconUrl, true)
	recthelper.setAnchor(self.goCtrl.transform, PuzzleEnum.MazeMonsterIconOffset.x, PuzzleEnum.MazeMonsterIconOffset.y)
	self:setPos(x, y)
	gohelper.setAsLastSibling(self.go)
end

function PuzzleMazePawnObj:onBeginDrag()
	self.anim:Play("image_content_drag")
end

function PuzzleMazePawnObj:onDraging(x, y)
	PuzzleMazePawnObj.super.onDraging(self, x, y)
end

function PuzzleMazePawnObj:onEndDrag(x, y)
	PuzzleMazePawnObj.super.onEndDrag(self, x, y)
	self.anim:Play("open")
end

function PuzzleMazePawnObj:setPos(x, y)
	PuzzleMazePawnObj.super.setPos(self, x, y)
	recthelper.setAnchor(self.tf, x, y)
end

function PuzzleMazePawnObj:setDir(dir)
	self.dir = dir

	transformhelper.setLocalRotation(self.tf, 0, dir == PuzzleEnum.dir.right and 180 or 0, 0)
end

function PuzzleMazePawnObj:onPawnJump()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function PuzzleMazePawnObj:destroy()
	self.animEvent:RemoveEventListener(PuzzleEnum.AnimEvent_OnJump)
	PuzzleMazePawnObj.super.destroy(self)
end

return PuzzleMazePawnObj
