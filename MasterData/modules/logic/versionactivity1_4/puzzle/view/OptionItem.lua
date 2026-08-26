-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/OptionItem.lua

module("modules.logic.versionactivity1_4.puzzle.view.OptionItem", package.seeall)

local OptionItem = class("OptionItem", LuaCompBase)
local posY = {
	-45,
	-37,
	-27,
	-17,
	-5,
	13,
	21
}

function OptionItem:init(go)
	self.go = go
	self.transform = go.transform
	self.transParent = go.transform.parent
	self.imageIcon = gohelper.findChildImage(go, "img_ItemIcon")
	self._uiclick = SLFramework.UGUI.UIClickListener.Get(self.go)

	self._uiclick:AddClickListener(self._btnclickOnClick, self)

	self._uidrag = SLFramework.UGUI.UIDragListener.Get(self.go)

	self._uidrag:AddDragBeginListener(self._onDragBegin, self)
	self._uidrag:AddDragListener(self._onDrag, self)
	self._uidrag:AddDragEndListener(self._onDragEnd, self)

	self.anim = go:GetComponent(typeof(UnityEngine.Animator))
	self.imageyy = gohelper.findChildImage(self.go, "img_ItemIcon_yy")
	self.goWrong = gohelper.findChild(go, "go_Wrong")
	self.txtNum = gohelper.findChildText(go, "txt_Num")
	self.isDrag = false
	self.operList = Role37PuzzleModel.instance:getOperList()
	self.maxOper = Role37PuzzleModel.instance:getMaxOper()
end

function OptionItem:onDestroy()
	self._uiclick:RemoveClickListener()
	self._uidrag:RemoveDragBeginListener()
	self._uidrag:RemoveDragListener()
	self._uidrag:RemoveDragEndListener()
end

function OptionItem:initParam(index, frameItemList, viewGO, isFinal)
	self.isFinal = isFinal
	self.viewRootGO = viewGO
	self.viewRootTrans = viewGO.transform
	self.frameItemList = frameItemList

	self:updateIndex(index)
	self:refreshSprite()
	self:calculateDefalutPos()
	self:_setDefalutPos(false)

	self.frameWidth = recthelper.getWidth(frameItemList[1].go.transform)
	self.frameHeight = recthelper.getHeight(frameItemList[1].go.transform)

	gohelper.setActive(self.txtNum, true)
end

function OptionItem:refreshSprite()
	local operType = self.operList[self._index]

	UISpriteSetMgr.instance:setV1a4Role37Sprite(self.imageIcon, Role37PuzzleModel.instance:getShapeImage(operType))
	UISpriteSetMgr.instance:setV1a4Role37Sprite(self.imageyy, Role37PuzzleModel.instance:getShapeImage(operType) .. "_yy")

	if self.isFinal then
		local y = posY[operType]

		recthelper.setAnchorY(self.imageIcon.transform, y)
		recthelper.setAnchorY(self.imageyy.transform, y)
	end
end

function OptionItem:updateIndex(index)
	self._index = index
end

function OptionItem:calculateDefalutPos()
	local frameGo = self.frameItemList[self._index].go

	self.defalutPos = recthelper.rectToRelativeAnchorPos(frameGo.transform.position, self.transParent)
end

function OptionItem:_btnclickOnClick()
	if self._isDrag then
		return
	end

	Role37PuzzleModel.instance:removeOption(self._index)
end

function OptionItem:_onDragBegin(param, pointerEventData)
	self._isDrag = true

	self.anim:Play("in", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)
	gohelper.addChildPosStay(self.viewRootGO, self.go)
end

function OptionItem:_onDrag(param, pointerEventData)
	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewRootTrans)

	recthelper.setAnchor(self.transform, pos.x, pos.y)
end

function OptionItem:_onDragEnd(param, pointerEventData)
	self._isDrag = false

	self.anim:Play("put", 0, 0)
	ZProj.TweenHelper.KillByObj(self.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewRootTrans)

	for i = 1, self.maxOper do
		local frameGo = self.frameItemList[i].go
		local uiPos = recthelper.rectToRelativeAnchorPos(frameGo.transform.position, self.viewRootTrans)
		local deltaX = math.abs(uiPos.x - anchorPos.x)
		local deltaY = math.abs(uiPos.y - anchorPos.y)

		if deltaX < self.frameWidth / 2 and deltaY < self.frameHeight / 2 then
			gohelper.addChildPosStay(self.transParent.gameObject, self.go)

			if i == self._index then
				self:_setDefalutPos(true)
			else
				Role37PuzzleModel.instance:exchangeOption(self._index, i)
			end

			self:_playEndAduio()

			return
		end
	end

	Role37PuzzleModel.instance:removeOption(self._index)
end

function OptionItem:_setDefalutPos(isTween)
	if isTween then
		ZProj.TweenHelper.DOAnchorPos(self.transform, self.defalutPos.x, self.defalutPos.y, 0.2)
	else
		recthelper.setAnchor(self.transform, self.defalutPos.x, self.defalutPos.y)
	end
end

function OptionItem:setError(isShow)
	if self.goWrong then
		gohelper.setActive(self.goWrong, isShow)
	end
end

function OptionItem:setNum(num)
	if self.txtNum then
		if num < 10 then
			self.txtNum.text = "0" .. num or num
		end
	end
end

function OptionItem:_playEndAduio()
	local curLevelId = Activity130Model.instance:getCurEpisodeId()

	if curLevelId == 7 then
		local audioId = Role37PuzzleModel.instance:getOperAudioId(self.operList[self._index])

		AudioEffectMgr.instance:playAudio(audioId)
	else
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return OptionItem
