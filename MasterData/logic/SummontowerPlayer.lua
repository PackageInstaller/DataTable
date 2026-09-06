-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerPlayer.lua

module("logic.extensions.summontower.view.SummontowerPlayer", package.seeall)

local SummontowerPlayer = class("SummontowerPlayer")

function SummontowerPlayer:ctor(node)
	self._nodeParent = node
	self._currAnimState = nil
	self._isFlipX = false
	self._spineGo = nil
	self._skeletonGraphic = nil
end

function SummontowerPlayer:onEnter()
	return
end

function SummontowerPlayer:onExit()
	UnityTweens.TweenPosition.StopTween(self._nodeParent)

	if self._spineGo then
		goutil.destroy(self._spineGo)

		self._spineGo = nil
	end

	self._moveFinishedListener = nil
	self._moveFinishedListenerObj = nil

	self:resetAnimState()
end

function SummontowerPlayer:playAnim(state)
	if not force and self._currAnimState == state then
		return
	end

	self._currAnimState = state

	if self._skeletonGraphic then
		self._skeletonGraphic.startingAnimation = state

		self._skeletonGraphic.AnimationState:SetAnimation(0, state, true)
		self._skeletonGraphic:Update(0)
	end
end

function SummontowerPlayer:setDirection(isFlipX)
	self._isFlipX = isFlipX

	if self._skeletonGraphic and self._skeletonGraphic.Skeleton then
		self._skeletonGraphic.Skeleton.FlipX = isFlipX
	end
end

function SummontowerPlayer:setScale(scale)
	Framework.TransformUtil.SetLocalScale(self._nodeParent.transform, scale, scale, scale)
end

function SummontowerPlayer:addListener(listner, listnerObj)
	self._moveFinishedListener = listner
	self._moveFinishedListenerObj = listnerObj
end

function SummontowerPlayer:movetoGrid(row, col, parent, motion)
	self._nodeParent.transform:SetParent(parent.transform)

	self._gotoRow = row
	self._gotoCol = col

	if motion then
		local px, py, pz = Framework.TransformUtil.GetLocalPos(self._nodeParent.transform, 0, 0, 0)
		local tween = UnityTweens.TweenPosition.StartTween(self._nodeParent, Vector3.New(px, py, pz), Vector3.New(0, 0, 0), 0.3)

		if px ~= 0 then
			self:setDirection(px > 0)
		end

		tween:AddListener(self._onMoveToGridFinished, self)
		self:playAnim("run")
	else
		Framework.TransformUtil.SetLocalPos(self._nodeParent.transform, 0, 0, 0)
		self:_onMoveToGridFinished()
	end
end

function SummontowerPlayer:getGridPos()
	return self._currRow, self._curCol
end

function SummontowerPlayer:_onMoveToGridFinished()
	self._currRow = self._gotoRow
	self._curCol = self._gotoCol
	self._gotoRow = 0
	self._gotoCol = 0

	self:playAnim("idle")
	printInfo("_onMoveToGridFinished_onMoveToGridFinished", self._currRow, self._curCol)

	if self._moveFinishedListener then
		self._moveFinishedListener(self._moveFinishedListenerObj, self._currRow, self._curCol)
	end
end

function SummontowerPlayer:resetAnimState()
	self._currAnimState = nil
	self._isFlipX = false
	self._spineGo = nil
	self._skeletonGraphic = nil
end

function SummontowerPlayer:loadSpine(path, animName)
	local res = rescache:GetResourceNoLoadIfNotExists(path)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._spineGo = goutil.clone(mainAsset)

	if not self._spineGo then
		return
	end

	self._spineGo.transform:SetParent(self._nodeParent.transform)
	Framework.TransformUtil.SetLocalScale(self._spineGo.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self._spineGo.transform, 0, 0, 0)

	self._skeletonGraphic = self._spineGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if animName then
		self:playAnim(animName, true, true)
	else
		self:playAnim("idle", true, true)
	end
end

return SummontowerPlayer
