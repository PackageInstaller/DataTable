-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsWorldScoreEff.lua

module("logic.extensions.goddessglory.view.GuessPetsWorldScoreEff", package.seeall)

local GuessPetsWorldScoreEff = class("GuessPetsWorldScoreEff")

function GuessPetsWorldScoreEff:ctor(viewGO, pool)
	self._pool = pool
	self._viewGO = viewGO
end

function GuessPetsWorldScoreEff:playEffect(startNode, destNode)
	removetimer(self._autoHideHitEff, self)
	self:_buildEffect()
	self._effNode:SetActive(false)

	local worldPosStart = startNode.transform.position
	local worldPosDest = destNode.transform.position
	local dir = worldPosDest - worldPosStart

	dir:Normalize()

	local radius = math.rad(90)
	local cos = math.cos(radius)
	local sin = math.sin(radius)
	local rotateDir = Vector3.New(dir.x * cos - dir.y * sin, dir.x * sin + dir.y * cos, 0)

	rotateDir:Normalize()

	local length = Vector3.Distance(worldPosStart, worldPosDest)
	local rangeLength = UnityEngine.Random.Range(0.2, 0.8)
	local rangeDir = UnityEngine.Random.Range(-0.2, 0.1)
	local dirPos = Vector3.Lerp(worldPosStart, worldPosDest, rangeLength)
	local temp = rotateDir * rangeDir

	dirPos = dirPos + temp

	local bezier = UnityTweens.TweenBezier.StartTween(self._effNode, worldPosStart, worldPosDest, dirPos, dirPos, math.random(0.5, 0.8), UnityTweens.EaseType.easeInSine)

	bezier:AddListener(function()
		self._effNode:SetActive(false)
		self._effHitNode:SetActive(true)
		settimer(2, self._autoHideHitEff, self, false)
	end, nil)

	bezier.coordSpace = UnityTweens.CoordSpace.World

	self._effNode:SetActive(true)
	self._effHitNode:SetActive(false)

	self._effHitNode.transform.position = worldPosDest
end

function GuessPetsWorldScoreEff:_autoHideHitEff()
	self._effNode:SetActive(false)
	self._effHitNode:SetActive(false)
	self._pool:stopEffect(self)
end

function GuessPetsWorldScoreEff:clear()
	removetimer(self._autoHideHitEff, self)

	if not goutil.isNil(self._effNode) then
		UnityTweens.TweenBezier.StopTween(self._effNode)
		goutil.destroy(self._effNode)

		self._effNode = nil
	end

	if not goutil.isNil(self._effHitNode) then
		goutil.destroy(self._effHitNode)

		self._effHitNode = nil
	end
end

function GuessPetsWorldScoreEff:_buildEffect()
	if not self._effNode then
		local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self._viewGO)
		local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.progressTrailEff)

		self._effNode = goutil.clone(res:GetMainAsset())

		self._effNode.transform:SetParent(self._viewGO.transform, false)
		self._effNode:SetActive(false)
		GoUtil.SetSortingOrder(self._effNode, sortingOrder)
	end

	if not self._effHitNode then
		local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self._viewGO)
		local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.progressTrailHitEff)

		self._effHitNode = goutil.clone(res:GetMainAsset())

		self._effHitNode.transform:SetParent(self._viewGO.transform, false)
		self._effHitNode:SetActive(false)
		GoUtil.SetSortingOrder(self._effHitNode, sortingOrder)
	end
end

return GuessPetsWorldScoreEff
