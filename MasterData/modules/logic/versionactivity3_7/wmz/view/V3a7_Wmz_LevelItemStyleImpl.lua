-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_LevelItemStyleImpl.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_LevelItemStyleImpl", package.seeall)

local V3a7_Wmz_LevelItemStyleImpl = class("V3a7_Wmz_LevelItemStyleImpl", RougeSimpleItemBase)

function V3a7_Wmz_LevelItemStyleImpl:ctor(...)
	self:__onInit()
	V3a7_Wmz_LevelItemStyleImpl.super.ctor(self, ...)
end

function V3a7_Wmz_LevelItemStyleImpl:_editableInitView()
	V3a7_Wmz_LevelItemStyleImpl.super._editableInitView(self)

	self._txt_StageName = gohelper.findChildText(self.viewGO, "Layout/txt_StageName")
	self._txt_StageNum = gohelper.findChildText(self.viewGO, "Layout/Num/txt_StageNum")
	self._goStar = gohelper.findChild(self.viewGO, "Star/go_Star")
	self._startAnim = self._goStar:GetComponent(gohelper.Type_Animation)
end

function V3a7_Wmz_LevelItemStyleImpl:onDestroyView()
	V3a7_Wmz_LevelItemStyleImpl.super.onDestroyView(self)
	self:__onDispose()
end

function V3a7_Wmz_LevelItemStyleImpl:setActive_goStar(isActive)
	gohelper.setActive(self._goStar, isActive)
end

function V3a7_Wmz_LevelItemStyleImpl:setActive_goLocked(isActive)
	gohelper.setActive(self._goLocked, isActive)
end

function V3a7_Wmz_LevelItemStyleImpl:setNum(num)
	self._txt_StageNum.text = num
end

function V3a7_Wmz_LevelItemStyleImpl:setName(name)
	self._txt_StageName.text = name
end

function V3a7_Wmz_LevelItemStyleImpl:playUnlock()
	return
end

function V3a7_Wmz_LevelItemStyleImpl:playIdle_Unlocked()
	return
end

function V3a7_Wmz_LevelItemStyleImpl:playIdle_Locked()
	return
end

function V3a7_Wmz_LevelItemStyleImpl:playIdle(isUnLocked)
	if isUnLocked then
		self:playIdle_Unlocked()
	else
		self:playIdle_Locked()
	end
end

function V3a7_Wmz_LevelItemStyleImpl:playStarAnim(isStop)
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

return V3a7_Wmz_LevelItemStyleImpl
