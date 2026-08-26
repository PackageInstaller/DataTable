-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameItem_StartEndImpl.lua

local ti = table.insert

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameItem_StartEndImpl", package.seeall)

local V3a4_Chg_GameItem_StartEndImpl = class("V3a4_Chg_GameItem_StartEndImpl", V3a4_Chg_GameItem_ObjBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a4_Chg_GameItem_StartEndImpl:ctor(...)
	V3a4_Chg_GameItem_StartEndImpl.super.ctor(self, ...)

	self._idleNumList = {}
	self._usingNumList = {}
end

function V3a4_Chg_GameItem_StartEndImpl:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_idleNumList")
	GameUtil.onDestroyViewMemberList(self, "_usingNumList")
	V3a4_Chg_GameItem_StartEndImpl.super.onDestroyView(self)
end

function V3a4_Chg_GameItem_StartEndImpl:_editableInitView()
	self._Image_Group = gohelper.findChild(self.viewGO, "Image_Group")
	self._Image_GroupTrans = self._Image_Group.transform
	self._Image_PropGo = self._Image_Prop.gameObject
	self._numGo = gohelper.findChild(self.viewGO, "Num")

	gohelper.setActive(self._numGo, false)

	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animator = self._animatorPlayer.animator

	V3a4_Chg_GameItem_StartEndImpl.super._editableInitView(self)
	ti(self._idleNumList, self:_create_V3a4_Chg_GameItem_DeltaNum())
end

function V3a4_Chg_GameItem_StartEndImpl:setNum(num)
	self._txtNum.text = num <= 0 and "-" or num
end

function V3a4_Chg_GameItem_StartEndImpl:playDeltaNumAnim(deltaNum)
	local numItem = #self._idleNumList > 0 and table.remove(self._idleNumList) or self:_create_V3a4_Chg_GameItem_DeltaNum()

	ti(self._usingNumList, numItem)

	if deltaNum > 0 then
		if not ("+" .. deltaNum) then
			local str = tostring(deltaNum)

			numItem:play(str)

			return numItem
		end
	end
end

function V3a4_Chg_GameItem_StartEndImpl:stopDeltaNumAnim(targetNumItem)
	if not targetNumItem then
		return
	end

	targetNumItem:stop()

	local found = false

	for i = #self._usingNumList, 1, -1 do
		if targetNumItem == self._usingNumList[i] then
			table.remove(self._usingNumList, i)

			found = true

			break
		end
	end

	if found then
		ti(self._idleNumList, targetNumItem)
	end
end

function V3a4_Chg_GameItem_StartEndImpl:playAnim(name, cb, cbObj)
	self._animator.enabled = true

	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a4_Chg_GameItem_StartEndImpl:playIdleAnim(cb, cbObj)
	self._animator.enabled = true

	self:playAnim(UIAnimationName.Idle, cb, cbObj)
end

function V3a4_Chg_GameItem_StartEndImpl:animatorPlayer()
	return self._animatorPlayer
end

function V3a4_Chg_GameItem_StartEndImpl:_create_V3a4_Chg_GameItem_DeltaNum()
	local go = gohelper.cloneInPlace(self._numGo, V3a4_Chg_GameItem_DeltaNum.__cname)
	local item = self:newObject(V3a4_Chg_GameItem_DeltaNum)

	item:init(go)

	return item
end

return V3a4_Chg_GameItem_StartEndImpl
