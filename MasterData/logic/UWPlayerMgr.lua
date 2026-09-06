-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UWPlayerMgr.lua

module("logic.extensions.uniqueworld.view.UWPlayerMgr", package.seeall)

local UWPlayerMgr = class("UWPlayerMgr", HLPlayerMgr)

function UWPlayerMgr:ctor()
	self._scrollerViewCtrl = HLScrollerViewCtrl.New()
	self._playerSpineCtrl = UniqueWorldSpineCtrl.New()
	self._curLocalPos = Vector3.New()
	self._boundingBox2D = BoundingBox2D.New()
end

function UWPlayerMgr:playDigMineAnim(param)
	self._playerSpineCtrl:playDigMineAnim(param)
end

function UWPlayerMgr:playPathMove(moveGo, posList, speedRatio, startCallBack, finishCallBack, stepStartHandle, stepFinishHandle)
	self:_playPathMoveAnim(moveGo, posList, speedRatio, startCallBack, finishCallBack, stepStartHandle, stepFinishHandle)
end

function UWPlayerMgr:_playPathMoveAnim(moveGo, posList, speedRatio, startHandle, finishHandle, stepStartHandle, stepFinishHandle)
	local function startCallback()
		self._playerSpineCtrl:playRunAnim()
		GameUtil.callBack(startHandle)
	end

	local function finishCallback()
		self._playerSpineCtrl:playDefaultAnim()
		GameUtil.callBack(finishHandle)
	end

	self:_killPathMoveSequence()

	local sequence = DG.Tweening.DOTween.Sequence()

	for stepIdx = 1, #posList do
		local nexPos = posList[stepIdx]

		if not posList[stepIdx - 1] then
			local lastPos = GameUtil.getLocalPos(moveGo)
			local distance = Vector3.Distance(lastPos, nexPos)
			local duration = Mathf.Clamp(distance / 300, 0.8, 5) * speedRatio

			local function stepStartCallback()
				self:setToward(nexPos)
				GameUtil.callBack(stepStartHandle, stepIdx)
			end

			local function stepFinishCallback()
				GameUtil.callBack(stepFinishHandle, stepIdx)
			end

			local tweener = moveGo.transform:DOLocalMove(nexPos, duration)

			tweener:SetEase(DG.Tweening.Ease.Linear)
			tweener:OnPlay(stepStartCallback)
			tweener:OnComplete(stepFinishCallback)
			sequence:Append(tweener)
		end
	end

	sequence:OnPlay(function()
		self._playerSpineCtrl:playRunAnim()
	end)
	sequence:OnPause(function()
		self._playerSpineCtrl:playDefaultAnim()
	end)
	sequence:OnStart(startCallback)
	sequence:OnComplete(finishCallback)

	self._pathMoveSequence = sequence
end

return UWPlayerMgr
