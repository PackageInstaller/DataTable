-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HLPlayerMgr.lua

module("logic.extensions.holylight.view.HLPlayerMgr", package.seeall)

local HLPlayerMgr = class("HLPlayerMgr")

function HLPlayerMgr:ctor()
	self._scrollerViewCtrl = HLScrollerViewCtrl.New()
	self._playerSpineCtrl = HLPlayerSpineCtrl.New()
	self._curLocalPos = Vector3.New()
	self._boundingBox2D = BoundingBox2D.New()
end

function HLPlayerMgr:onEnter(view, mapScrollerRect, mapScrollerSize, playerCell)
	self._view = view
	self._playerCell = {}
	self._playerCell._mainGo = playerCell
	self._playerCell._spineRoot = goutil.findChild(playerCell, "spineRoot")
	self._playerCell._colliderBox = goutil.findChild(playerCell, "colliderBox")

	self._scrollerViewCtrl:onInit(mapScrollerRect)
	self._playerSpineCtrl:onInit(self._playerCell._spineRoot, self._view)
	self._scrollerViewCtrl:onSet(mapScrollerSize.x, mapScrollerSize.y)
end

function HLPlayerMgr:onExit()
	self:_killPathMoveSequence()
	self._playerSpineCtrl:onClear()
	self._scrollerViewCtrl:onClear()
end

function HLPlayerMgr:onDestroy()
	self._playerSpineCtrl = nil
	self._scrollerViewCtrl = nil
	self._curLocalPos = nil
	self._boundingBox2D = nil
end

function HLPlayerMgr:setToward(targetPos)
	local pos1 = self:getPlayerLocalPos()
	local pos2 = targetPos or pos1
	local disX = pos1.x - pos2.x

	if disX ~= 0 then
		GameUtil.setLocalScale(self._playerCell._mainGo, disX > 0 and -1 or 1, 1, 1)
	end
end

function HLPlayerMgr:setPlayerLocalPos(targetPos)
	GameUtil.setLocalPos(self._playerCell._mainGo, targetPos.x, targetPos.y, targetPos.z)
end

function HLPlayerMgr:getPlayerLocalPos()
	self._curLocalPos:Set(Framework.TransformUtil.GetLocalPos(self._playerCell._mainGo.transform, 0, 0, 0))

	return self._curLocalPos
end

function HLPlayerMgr:isIntersects(bounds)
	if bounds == nil then
		printError("错误碰撞")

		return
	end

	self._playerLocalPos = self:getPlayerLocalPos()
	self._colliderLocalPosX, self._colliderLocalPosY = Framework.TransformUtil.GetLocalPos(self._playerCell._colliderBox.transform, nil, nil, nil)

	self._boundingBox2D:setSize(self._playerCell._colliderBox.transform.sizeDelta.x, self._playerCell._colliderBox.transform.sizeDelta.y)
	self._boundingBox2D:setCenter(self._playerLocalPos.x + self._colliderLocalPosX, self._playerLocalPos.y + self._colliderLocalPosY)

	return self._boundingBox2D:intersects(bounds)
end

function HLPlayerMgr:playPathMove(moveGo, posList, speedRatio, startCallBack, finishCallBack, stepStartHandle, stepFinishHandle)
	local moveGoPos = GameUtil.getLocalPos(moveGo)

	local function startCallBackOfView()
		return
	end

	local function finishCallBackOfView()
		self:_playPathMoveAnim(moveGo, posList, speedRatio, startCallBack, finishCallBack, stepStartHandle, stepFinishHandle)
	end

	local tweenerOfView = self._scrollerViewCtrl:viewTo(moveGoPos, startCallBackOfView, finishCallBackOfView)
end

function HLPlayerMgr:_playPathMoveAnim(moveGo, posList, speedRatio, startHandle, finishHandle, stepStartHandle, stepFinishHandle)
	local function startCallback()
		self._playerSpineCtrl:playRunAnim()
		self._scrollerViewCtrl:startFollow(moveGo)
		GameUtil.callBack(startHandle)
	end

	local function finishCallback()
		self._playerSpineCtrl:playDefaultAnim()
		self._scrollerViewCtrl:stopFollow()
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

function HLPlayerMgr:_killPathMoveSequence()
	if self._pathMoveSequence then
		self._pathMoveSequence:Kill(true)

		self._pathMoveSequence = nil
	end
end

function HLPlayerMgr:resumePathMoveAnim()
	if self._pathMoveSequence then
		self._pathMoveSequence:Play()
	end
end

function HLPlayerMgr:pausePathMoveAnim()
	if self._pathMoveSequence then
		self._pathMoveSequence:Pause()
	end
end

function HLPlayerMgr:focusOnPlayer(moveGo, startHandle, finishHandle)
	local moveGoPos = GameUtil.getLocalPos(moveGo)
	local tweenerOfView = self._scrollerViewCtrl:viewTo(moveGoPos, startHandle, finishHandle)
end

return HLPlayerMgr
