-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgDragEnd_UIFlyingWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgDragEnd_UIFlyingWork", package.seeall)

local ChgDragEnd_UIFlyingWork = class("ChgDragEnd_UIFlyingWork", GaoSiNiaoWorkBase)

function ChgDragEnd_UIFlyingWork.s_create(v3a4_Chg_UIFlying, itemA, itemB, emitCount)
	assert(v3a4_Chg_UIFlying)

	local work = ChgDragEnd_UIFlyingWork.New()
	local parentTrans = v3a4_Chg_UIFlying:parentTrans()
	local stX, stY = recthelper.rectToRelativeAnchorPos2(itemA:WPos(), parentTrans)
	local edX, edY = recthelper.rectToRelativeAnchorPos2(itemB:WPos(), parentTrans)
	local startPosition = Vector2.New(stX, stY)
	local endPosition = Vector2.New(edX, edY)

	v3a4_Chg_UIFlying:config(startPosition, endPosition, emitCount)

	work._item = v3a4_Chg_UIFlying

	return work
end

function ChgDragEnd_UIFlyingWork:onStart()
	self:clearWork()

	if not self._item then
		self:onSucc()

		return
	end

	self._item:SetAllFlyItemDoneCallback(self._onAllFlyItemDoneCallback, self)
	self._item:StartFlying()
	AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_hit)
end

function ChgDragEnd_UIFlyingWork:_onAllFlyItemDoneCallback()
	self:onSucc()
end

function ChgDragEnd_UIFlyingWork:clearWork()
	if self._item then
		self._item:clear()
	end
end

return ChgDragEnd_UIFlyingWork
