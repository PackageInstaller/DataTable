-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_LevelItemStyleImpl.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_LevelItemStyleImpl", package.seeall)

local V3a4_Chg_LevelItemStyleImpl = class("V3a4_Chg_LevelItemStyleImpl", RougeSimpleItemBase)

function V3a4_Chg_LevelItemStyleImpl:ctor(...)
	self:__onInit()
	V3a4_Chg_LevelItemStyleImpl.super.ctor(self, ...)
end

function V3a4_Chg_LevelItemStyleImpl:_editableInitView()
	V3a4_Chg_LevelItemStyleImpl.super._editableInitView(self)

	self._txt_StageName = gohelper.findChildText(self.viewGO, "txt_StageName")
	self._txt_StageNum = gohelper.findChildText(self.viewGO, "txt_StageNum")
	self._goStar = gohelper.findChild(self.viewGO, "Star/go_Star")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._startAnim = self._goStar:GetComponent(gohelper.Type_Animation)
end

function V3a4_Chg_LevelItemStyleImpl:onDestroyView()
	V3a4_Chg_LevelItemStyleImpl.super.onDestroyView(self)
	self:__onDispose()
end

function V3a4_Chg_LevelItemStyleImpl:setActive_goStar(isActive)
	gohelper.setActive(self._goStar, isActive)
end

function V3a4_Chg_LevelItemStyleImpl:setActive_goLocked(isActive)
	gohelper.setActive(self._goLocked, isActive)
end

function V3a4_Chg_LevelItemStyleImpl:setNum(num)
	self._txt_StageNum.text = num
end

function V3a4_Chg_LevelItemStyleImpl:setName(name)
	self._txt_StageName.text = name
end

function V3a4_Chg_LevelItemStyleImpl:playUnlock()
	self._anim:Play(UIAnimationName.Unlock, 0, 0)
end

function V3a4_Chg_LevelItemStyleImpl:playIdle_Unlocked()
	self._anim:Play(UIAnimationName.Unlock, 0, 1)
end

function V3a4_Chg_LevelItemStyleImpl:playIdle_Locked()
	self._anim:Play(UIAnimationName.Idle, 0, 0)
end

function V3a4_Chg_LevelItemStyleImpl:playIdle(isUnLocked)
	if isUnLocked then
		self:playIdle_Unlocked()
	else
		self:playIdle_Locked()
	end
end

function V3a4_Chg_LevelItemStyleImpl:playStarAnim(isStop)
	local animClip = self._startAnim.clip
	local clipName = animClip.name

	if isStop then
		self._startAnim:Stop(clipName)
		self._startAnim:Play(clipName)
		self._startAnim:Sample()
		self._startAnim:Stop(clipName)
	else
		self:setActive_goStar(true)
		self._startAnim:Play(clipName)
	end
end

return V3a4_Chg_LevelItemStyleImpl
