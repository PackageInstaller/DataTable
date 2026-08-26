-- chunkname: @modules/logic/character/view/destiny/CharacterDestinyUnlockStoneComp.lua

module("modules.logic.character.view.destiny.CharacterDestinyUnlockStoneComp", package.seeall)

local CharacterDestinyUnlockStoneComp = class("CharacterDestinyUnlockStoneComp", LuaCompBase)

function CharacterDestinyUnlockStoneComp:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtdragtip = gohelper.findChildText(self.viewGO, "txt_dragtip")
	self._gostone = gohelper.findChild(self.viewGO, "#go_stone")
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "#go_stone/#simage_stone")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinyUnlockStoneComp:addEvents()
	return
end

function CharacterDestinyUnlockStoneComp:removeEvents()
	return
end

function CharacterDestinyUnlockStoneComp:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterDestinyUnlockStoneComp:addEventListeners()
	self:addEvents()
end

function CharacterDestinyUnlockStoneComp:removeEventListeners()
	self:removeEvents()
end

function CharacterDestinyUnlockStoneComp:_editableInitView()
	self._goeffect = gohelper.findChild(self.viewGO, "effectItem")
	self._effectItems = self:getUserDataTb_()

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:getEffectItem(i)
		local x, y = recthelper.getAnchor(item.go.transform)

		item.orignAnchor = {
			x = x,
			y = y
		}
	end

	self._imagestone = gohelper.findChildImage(self.viewGO, "#go_stone/#simage_stone")
	self._imagestone.color = Color(0.5, 0.5, 0.5, 1)

	local goLine = gohelper.findChild(self.viewGO, "#go_line")

	self._linempc = goLine:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self._effectmpc = self._goeffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function CharacterDestinyUnlockStoneComp:_onDragBegin(param, pointerEventData)
	if not param then
		return
	end

	if self._isSuccessUnlock[param] then
		return
	end

	local item = self._effectItems[param]

	if not item or not item.isCanDrag then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_resonate_property_click)
end

function CharacterDestinyUnlockStoneComp:_onDrag(param, pointerEventData)
	if not param then
		return
	end

	if self._isSuccessUnlock[param] then
		return
	end

	local item = self._effectItems[param]

	if not item or not item.isCanDrag then
		return
	end

	local _dragPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self.viewGO.transform)

	recthelper.setAnchor(item.go.transform, _dragPos.x, _dragPos.y)
end

function CharacterDestinyUnlockStoneComp:_onDragEnd(param, pointerEventData)
	if not param then
		return
	end

	local index = param

	if self._isSuccessUnlock[index] then
		return
	end

	local item = self._effectItems[index]

	if not item or not item.isCanDrag then
		return
	end

	local dis = Vector2.Distance(item.go.transform.anchoredPosition, Vector2.zero)

	if dis < 300 then
		self:_finishDrag(index)
	else
		self:_returnOrginPos(index)
	end
end

function CharacterDestinyUnlockStoneComp:_returnOrginPos(index)
	local item = self._effectItems[index]
	local nowAnchor = item.go.transform.anchoredPosition
	local anchor = item.orignAnchor
	local time = Vector2.Distance(nowAnchor, Vector2(anchor.x, anchor.y)) * 0.001

	time = Mathf.Clamp(time, 0.5, 1)
	item.tweenId = ZProj.TweenHelper.DOAnchorPos(item.go.transform, anchor.x, anchor.y, time)
end

function CharacterDestinyUnlockStoneComp:_finishDrag(index)
	local item = self._effectItems[index]

	item.anim:Play(CharacterDestinyEnum.StoneViewAnim.Close, 0, 0)
	gohelper.setActive(item.glow, true)

	self._isSuccessUnlock[index] = true

	TaskDispatcher.runDelay(self._checkAllFinish, self, 0.9)

	item.isCanDrag = false

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_runes_put)
end

function CharacterDestinyUnlockStoneComp:_checkAllFinish()
	if self:_checkAllDragFinish() then
		if self._stoneView then
			AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_lifestone_unlock)
			self._stoneView:playUnlockstoneAnim(CharacterDestinyEnum.StoneViewAnim.LevelUp, self._onUnlockStone, self)
			self._stoneView:onUnlockStone()
		else
			self:_onUnlockStone()
		end
	end
end

function CharacterDestinyUnlockStoneComp:_onUnlockStone()
	CharacterDestinyController.instance:onUnlockStone(self.heroId, self.stoneId)
end

function CharacterDestinyUnlockStoneComp:_checkAllDragFinish()
	for i = 1, CharacterDestinyEnum.EffectItemCount do
		if not self._isSuccessUnlock[i] then
			return false
		end
	end

	return true
end

function CharacterDestinyUnlockStoneComp:onUpdateParam()
	return
end

function CharacterDestinyUnlockStoneComp:onUpdateMo(heroId, stoneId)
	self._isSuccessUnlock = {}
	self.heroId = heroId
	self.stoneId = stoneId

	local co = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(stoneId)

	self._simagestone:LoadImage(ResUrl.getDestinyIcon(co.icon))

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:getEffectItem(i)

		item.isCanDrag = true

		item.anim:Play(CharacterDestinyEnum.StoneViewAnim.Idle, 0, 0)

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end

		if item.orignAnchor then
			recthelper.setAnchor(item.go.transform, item.orignAnchor.x, item.orignAnchor.y)
		end

		local tenp = CharacterDestinyEnum.SlotTend[co.tend]
		local color = tenp.RuneColor

		if self._linempc.color_01 ~= color then
			self._linempc.color_01 = color

			self._linempc:SetProps()
		end

		if self._effectmpc.color_01 ~= color then
			self._effectmpc.color_01 = color

			self._effectmpc:SetProps()
		end

		gohelper.setActive(item.glow, false)
	end

	TaskDispatcher.cancelTask(self._checkAllFinish, self)
end

function CharacterDestinyUnlockStoneComp:setStoneView(view)
	self._stoneView = view
end

function CharacterDestinyUnlockStoneComp:getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		local go = gohelper.findChild(self._goeffect, index)
		local txt = gohelper.findChild(go, "txt")

		item = self:getUserDataTb_()
		item.go = go
		item.txt = txt
		item.txtglow = gohelper.findChildImage(go, "#txt_glow")
		item.drag = SLFramework.UGUI.UIDragListener.Get(txt.gameObject)

		item.drag:AddDragBeginListener(self._onDragBegin, self, index)
		item.drag:AddDragListener(self._onDrag, self, index)
		item.drag:AddDragEndListener(self._onDragEnd, self, index)

		item.anim = go:GetComponent(typeof(UnityEngine.Animator))

		local goglow = gohelper.findChild(self.viewGO, "#go_line/#mesh0" .. index)

		item.glow = gohelper.findChild(goglow, "#glow")
		item.isCanDrag = true
		self._effectItems[index] = item
	end

	return item
end

function CharacterDestinyUnlockStoneComp:onClose()
	return
end

function CharacterDestinyUnlockStoneComp:onDestroy()
	for _, item in pairs(self._effectItems) do
		item.drag:RemoveDragBeginListener()
		item.drag:RemoveDragListener()
		item.drag:RemoveDragEndListener()

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end
	end

	self._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(self._checkAllFinish, self)
end

return CharacterDestinyUnlockStoneComp
